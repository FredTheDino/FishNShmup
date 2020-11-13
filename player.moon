import Vec2 from require "util"

export class Player
    new: =>
        @pos = Vec2!
        @radius = 32

    draw: (gfx) =>
        gfx.setColor 255, 0, 0
        gfx.circle "fill", @pos.x, @pos.y, @radius, 20

    update: (delta) =>
        @pos = @pos\add(Vec2(1, 1))

{ :Player }
