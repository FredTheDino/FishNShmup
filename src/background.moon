export scroll_speed = 500

gfx = love.graphics

export bg_particles = ->
    ps = gfx.newParticleSystem Assets\get "bg_cloud_1.png"
    ps\setParticleLifetime 10 --TODO calculate
    ps\setEmissionRate 20
    ps\setPosition gfx.getWidth! + 32, gfx.getHeight! / 2
    ps\setEmissionArea "uniform", 0, gfx.getHeight! / 2
    ps\setSpeed 100, 200
    ps\setDirection math.pi

    ps\start!

    ps

export class BGItem extends Entity
    new: (kind, depth) =>
        super!
        x = love.graphics.getWidth! + random_real 10, 100
        y = random_real 0, love.graphics.getHeight!
        @pos = Vec2 x, y
        @depth = depth
        if kind == "bg_part"
            @img = Assets\get kind .. "_" .. math.random(1, 5) .. ".png"

        if kind == "bg_cloud"
            @img = Assets\get kind .. "_" .. math.random(1, 4) .. ".png"

    draw: =>
        super\draw!
        gfx.draw @img, @pos.x, @pos.y, 0

    update: (delta) =>
        @pos = @pos\add Vec2(-scroll_speed, 0)\scale delta / @depth
        if @pos.x < -100
            @alive = false
