class Item extends Entity
    new: =>
        super!
        @pos = Vec2 600, 300
        math.randomseed(os.time())
        @dir = (Vec2 random_real(-1, -0.5), random_real(-1, 1))\normalized!

    draw: (gfx) =>
        gfx.setColor 0, 255, 255
        gfx.circle "fill", @pos.x, @pos.y, 10, 20

    update: (delta) =>
        @pos = @pos\add @dir\scale delta*100

    on_collision: =>

export class GenericPickupItem extends Item
    on_collision: (other) =>
        if other.player
            @alive = false
            print("item picked up")
