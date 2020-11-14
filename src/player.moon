keyboard = love.keyboard
gfx = love.graphics

export class Player extends Entity
    new: =>
        super!
        @player = true
        @pos = Vec2!
        @draw_offset = Vec2(48, -40)
        @speed = 256
        @shoottimer = 0
        @fire_rate = 0.2
        @health = 10
        @img = Assets\get "ship.png"
        @shield_img = Assets\get "shield.png"

        @engine_particles = gfx.newParticleSystem Assets\get "tmp_engine.png"
        @engine_particles\setParticleLifetime 1, 2
        @engine_particles\setEmissionRate 5
        @engine_particles\start!

        @shield = 1
        @shield_on = true
        @shield_recharge = 0.3 -- shield recharged per second
        @shield_damage_strength = 0.1 -- how much shield to lose per dmg

    draw: =>
        super\draw!
        gfx.draw @img, @pos.x + @draw_offset.x, @pos.y + @draw_offset.y, math.pi/2

        --TODO draw bar
        gfx.setColor 255, 255, 255, @shield * 0.7
        gfx.draw @shield_img, @pos.x + @draw_offset.x, @pos.y + @draw_offset.y, math.pi/2

        gfx.setColor 255, 255, 255, 1
        gfx.draw @engine_particles

    fire: =>
        if @shoottimer > 0
            return
        @shoottimer = @fire_rate
        World\add_entity Shot @pos, Vec2(1, 0), 500, @, @radius + 5

    damage: (dmg) =>
        if @shield_on
            @shield -= dmg * @shield_damage_strength
            if @shield < 0
                @shield_on = false
        else
            @health -= dmg
            if @health < 0
                @health = 0
                print("player died")
                --@alive = false

    landed_hit: =>
        Combo\increase 10

    update: (delta) =>
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

        @shoottimer -= delta
        if keyboard.isDown "space"
            @fire!

        if @shield < 1
            @shield += @shield_recharge * delta
        if @shield > 1
            @shield = 1
            @shield_on = true

        @pos = @pos\add dpos\scale delta * @speed
        @engine_particles\setPosition @pos.x, @pos.y

        World\test_collision @
