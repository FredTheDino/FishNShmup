import Entity, World from require "world"

export scroll_speed = 10

export class BGItem extends Entity
    new: (kind, pos, depth) =>
        super!
        @pos = pos
        @depth = depth
        @kind = kind

    draw: (gfx) =>
        gfx.circle "line", @pos.x, @pos.y, @radius, 20
        gfx.aslkdja

    update: (delta) =>
        @pos = @pos\add Vec2(-scroll_speed, 0)\scale delta / @depth


