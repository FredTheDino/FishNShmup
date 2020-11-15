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
        @img = nil
        @img_offset = Vec2 0, 0
        @img_scale = 1

    update: (delta) =>
        @pos = @pos\add @dir\scale delta*100

    draw: =>
        super\draw!
        gfx.draw @img, @pos.x + @img_offset.x, @pos.y + @img_offset.y, 0, @img_scale, @img_scale

    on_collision: =>

export class FishingItem extends Item
    new: =>
        super!
        @radius = 20
        @img = Assets\get "rod"
        @img_offset = Vec2 -20, -20

    on_collision: (other) =>
        if other.player
            @alive = false
            Fishing\new_game!
            State\reset_transition!
            State.main_music\pause!
            State.fishing_music\play!
            State.current = State.fishing

export class ShootSpeedItem extends Item
    new: =>
        super!
        @radius = 20
        @img = Assets\get "fish_3"
        @img_scale = 1.8
        @img_offset = Vec2 -18, -18

    on_collision: (other) =>
        if other.player
            @alive = false
            other\increase_shoot_speed!
