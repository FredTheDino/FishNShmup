export scroll_speed = 500

gfx = love.graphics

export class Background
    @bgs = {}

    new: (asset, rate = 0.5) =>
        @ps = gfx.newParticleSystem Assets\get asset
        @ps\setParticleLifetime 10 --TODO calculate
        @ps\setEmissionRate rate
        --more to the right so particles with the same texture can spread out
        @ps\setPosition gfx.getWidth! + 48, gfx.getHeight! / 2
        @ps\setEmissionArea "uniform", 0, gfx.getHeight! / 2
        @ps\setSpeed 60, 180
        @ps\setDirection math.pi

        @ps\start!

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
