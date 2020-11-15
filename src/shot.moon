gfx = love.graphics

export class Shot extends Entity
    new: (pos, dir, vel, owner, offset = 0) =>
        super!
        @radius = 10
        @lifetime = 100
        dir = dir\normalized!
        @pos = pos\add dir\scale offset + @radius
        @vel = dir\scale(vel)
        @owner = owner
        @color = { 0, 0, 1.0 }
        if owner.player
            @img = Assets\get "bullet_1"
            @particles = gfx.newParticleSystem Assets\get "laser_2_part_1"
            @particles\setSizes 4.0, 4.5, 8.5, 9.0
            @particles\setColors 1.0, 1.0, 1.0, 0.2,
                                 1.0, 1.0, 1.0, 0.2,
                                 1.0, 1.0, 1.0, 0.0

            @particles\setSpeed 0, 50
            @particles\setParticleLifetime 0.6, 0.8
            @particles\setEmissionRate 10
        else
            @img = Assets\get "bullet_5"
            @particles = gfx.newParticleSystem Assets\get "laser_1_part_1"
            @particles\setColors 1.0, 1.0, 1.0, 0.2,
                                 1.0, 1.0, 1.0, 0.2,
                                 1.0, 1.0, 1.0, 0.0

            @particles\setSizes 4.0, 4.5, 2.5, 2.0
            @particles\setDirection 0
            @particles\setSpeed 0, 50
            @particles\setParticleLifetime 0.6, 0.8

            @particles\setSpread math.pi * 2
            @particles\setEmissionRate 10
            @particles\setPosition @pos.x, @pos.y
            @particles\update 1

        @particles\setSpread 0.3
        @particles\setEmissionRate 10

        @particles\start!

    update: (delta) =>
        @particles\setPosition @pos.x, @pos.y
        @particles\update delta
        @pos = @pos\add @vel\scale delta
        @lifetime -= 1
        if @lifetime < 0
            @alive = false

    draw: =>
        super\draw!
        gfx.draw @particles
        w, h = @img\getPixelDimensions!
        angle = math.pi
        if @vel.x > 0
            angle = 0
        if @owner.enemy
            gfx.draw @img, @pos.x, @pos.y, angle, 1.5, 1.5, w / 2, h / 2
        else
            gfx.draw @img, @pos.x, @pos.y, angle, 2, 2, w / 2, h / 2

    on_collision: (other) =>
        if (other.player and not @owner.player) or (other.enemy and not @owner.enemy)
            @owner\landed_hit!
            @alive = false
            other\damage(1)
