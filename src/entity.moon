gfx = love.graphics

export class Entity
    new: =>
        @pos = Vec2!
        @radius = 32
        @alive = true
        @color = { 255, 0, 0 }

    draw: =>
        gfx.setColor @color[1], @color[2], @color[3]
        gfx.circle "line", @pos.x, @pos.y, @radius, 20
        gfx.setColor 255, 255, 255

    update: (delta) =>

    on_collision: (other) =>
