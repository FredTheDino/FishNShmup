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
        @health = 3
        @img = Assets\get "ship"

        @engine_particles = gfx.newParticleSystem Assets\get "tmp_engine"
        @engine_particles\setParticleLifetime 1, 2
        @engine_particles\setEmissionRate 5
        @engine_particles\start!

    draw: =>
        super\draw!
        gfx.draw @img, @pos.x + @draw_offset.x, @pos.y + @draw_offset.y, math.pi/2
        gfx.draw @engine_particles

    fire: =>
        if @shoottimer > 0
            return
        @shoottimer = @fire_rate
        World\add_entity Shot @pos, Vec2(1, 0), 500, @, @radius + 5

    damage: (dmg) =>
        @health -= dmg
        if @health < 0
            @alive = false

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
            
        @pos = @pos\add dpos\scale delta * @speed
        @engine_particles\setPosition @pos.x, @pos.y

        World\test_collision @
