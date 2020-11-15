gfx = love.graphics

class Item extends Entity
    new: =>
        super!
        @item = true
        @radius = 10
        @pos = Vec2 600, 300
        math.randomseed(os.time())
        @dir = (Vec2 random_real(-1, -0.5), random_real(-1, 1))\normalized!
        @color = { 0, 1.0, 1.0 }

    update: (delta) =>
        @pos = @pos\add @dir\scale delta*100

    draw: =>
        super\draw!
        gfx.draw @img, @pos.x - 20, @pos.y - 20

    on_collision: =>

export class FishingItem extends Item
    new: =>
        super!
        @radius = 20
        @img = Assets\get "rod.png"

    on_collision: (other) =>
        if other.player
            @alive = false
            Fishing\new_game!
            World.gone_fishing = true
