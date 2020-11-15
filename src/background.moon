export scroll_speed = 500

gfx = love.graphics

--TODO particle system instead
export class BGItem extends Entity
    new: (kind, depth) =>
        super!
        x = love.graphics.getWidth! + random_real 10, 100
        y = random_real 0, love.graphics.getHeight!
        @pos = Vec2 x, y
        @depth = depth
        if kind == "bg_part"
            @img = Assets\get kind .. "_" .. math.random(1, 5)

        if kind == "bg_cloud"
            @img = Assets\get kind .. "_" .. math.random(1, 4)

    draw: =>
        gfx.setColor 1.0, 1.0, 1.0
        gfx.draw @img, @pos.x, @pos.y, 0
        --gfx.circle "fill", @pos.x, @pos.y, 10, 20

    update: (delta) =>
        @pos = @pos\add Vec2(-scroll_speed, 0)\scale delta / @depth
        if @pos.x < -100
            @alive = false
