export scroll_speed = 500

gfx = love.graphics

export class Background
    @bgs = {}

    new: (asset, rate, speed_min, speed_max, size) =>
        @ps = gfx.newParticleSystem Assets\get asset
        @ps\setParticleLifetime 40 --TODO calculate
        @ps\setEmissionRate rate
        --more to the right so particles with the same texture can spread out
        @ps\setPosition gfx.getWidth! + 64, gfx.getHeight! / 2
        @ps\setEmissionArea "uniform", 50, gfx.getHeight! / 2
        @ps\setSpeed speed_min, speed_max
        @ps\setDirection math.pi
        @ps\setSizes size

        @ps\start!
        for i = 0, math.random(1000, 2000) -- @ps\update 10 did not work
            @ps\update 0.01

    @add_bg_layer: (bg) =>
        table.insert @@bgs, bg

    update: (delta) =>
        @ps\update delta

    @update: (delta) =>
        for bg in *@@bgs
            bg\update delta

    draw: =>
        gfx.draw @ps

    @draw: =>
        for bg in *@@bgs
            bg\draw!
