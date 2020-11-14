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

    on_collision: =>

export class GenericPickupItem extends Item
    on_collision: (other) =>
        if other.player
            @alive = false
            print("item picked up")
            World.gone_fishing = true
