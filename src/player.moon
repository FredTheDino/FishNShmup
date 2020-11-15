keyboard = love.keyboard
gfx = love.graphics
audio = love.audio

export class Player extends Entity
    new: =>
        super!
        @player = true
        @pos = Vec2(gfx.getWidth!, gfx.getHeight!)\div 2
        @draw_offset = Vec2(48, -40)
        @speed = 256
        @shoottimer = 0
        @fire_rate = 0.2
        @health = 3
        @img = Assets\get "ship"
        @shield_img = Assets\get "shield"
        @shot_sfx = audio.newSource Assets\get "laser_sound.wav"
        @die_sfx = audio.newSource Assets\get "explosion_dead.wav"

        @engine_particles = gfx.newParticleSystem Assets\get "laser_2_part_1"
        @engine_particles\setColors 1.0, 1.0, 1.0, 1.0,
                                    1.0, 1.0, 1.0, 0.75,
                                    1.0, 1.0, 1.0, 0.0
        @engine_particles\setSizes 4.0, 4.5, 2.5, 2.0
        @engine_particles\setSpread 0.3
        @engine_particles\setDirection math.pi
        @engine_particles\setSpeed 300, 400
        @engine_particles\setParticleLifetime 0.3, 0.5
        @engine_particles\setEmissionRate 35
        @engine_particles\start!

        @engine_particles_smoke = gfx.newParticleSystem Assets\get "laser_2_part_1"
        @engine_particles_smoke\setSizes 4.0, 4.5, 8.5, 9.0
        @engine_particles_smoke\setColors 0.0, 0.0, 0.0, 0.5,
                                          0.0, 0.0, 0.0, 0.45,
                                          0.0, 0.0, 0.0, 0.0
        @engine_particles_smoke\setSpread 1
        @engine_particles_smoke\setDirection math.pi
        @engine_particles_smoke\setSpeed 100, 300
        @engine_particles_smoke\setParticleLifetime 0.6, 0.8
        @engine_particles_smoke\setEmissionRate 10
        @engine_particles_smoke\start!

        @shield = 1
        @shield_on = true
        @shield_flashing_cur_status = false
        @shield_recharge = 0.2 -- shield recharged per second
        @shield_damage_strength = 0.2 -- how much shield to lose per dmg

        @shield_bar_pos_dx = 0
        @shield_bar_pos_dy = -30
        @shield_bar_width = 80

        @vely = 0

    draw: =>
        super\draw!
        sheer = @vely * 0.2
        w, h = @img\getPixelDimensions!
        gfx.draw @img, @pos.x, @pos.y, math.pi/2, 1, 1, w / 2, h / 2, 0.0, sheer

        if @shield_on or @shield_flashing_cur_status
            gfx.setColor 1, 1, 1, 0.2 + @shield * 0.5
            gfx.draw @shield_img, @pos.x + @draw_offset.x - 2, @pos.y + @draw_offset.y - 3, math.pi/2
            gfx.setColor 0.5, 0.5, 1, 1
            gfx.rectangle "fill", @pos.x - 40, @pos.y + @draw_offset.y - 20, 80 * @shield, 10
        gfx.setColor 0, 0, 0
        gfx.rectangle "line", @pos.x - 40, @pos.y + @draw_offset.y - 20, 80, 10

        gfx.setColor 1.0, 1.0, 1.0
        gfx.draw @engine_particles_smoke
        gfx.draw @engine_particles

    on_collision: (e) =>
        if e.enemy
            @damage 1
            e\damage 1

    fire: =>
        if @shoottimer > 0
            return
        @shoottimer = @fire_rate
        World\add_entity Shot @pos, Vec2(1, @vely * 0.2), 500, @, @radius + 5
        @shot_sfx\clone!\play!

    damage: (dmg) =>
        if @shield_on
            @shield -= dmg * @shield_damage_strength
            if @shield < 0
                @shield_on = false
                @shield = 0
        else
            @health -= dmg
            if @health < 0
                @health = 0
                print("player died")
                @die_sfx\clone!\play!
                State.current = State.died

    landed_hit: =>
        Combo\increase 10

    update: (delta, total_time) =>
        @engine_particles_smoke\update delta
        @engine_particles\update delta
        dpos = Vec2!
        if keyboard.isDown "a"
            dpos.x += -1
        if keyboard.isDown "w"
            dpos.y += -1
        if keyboard.isDown "s"
            dpos.y += 1
        if keyboard.isDown "d"
            dpos.x += 1
        @vely = (@vely + dpos.y) * 0.5

        @shoottimer -= delta
        if keyboard.isDown "space"
            @fire!

        if @shield < 1
            @shield += @shield_recharge * delta
        if @shield > 1
            @shield = 1
        if not @shield_on and @shield > 0.66
            @shield_on = true
        if not @shield_on
            @shield_flashing_cur_status = (math.floor(total_time * 5)) % 2 == 0

        @pos = @pos\add dpos\scale delta * @speed
        @engine_particles_smoke\setPosition @pos.x - 35, @pos.y
        @engine_particles\setPosition @pos.x - 35, @pos.y

        World\test_collision @
