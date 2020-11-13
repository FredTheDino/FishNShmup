import Vec2 from require "util"
import Entity from require "world"

keyboard = love.keyboard

export class Player extends Entity
    new: =>
        super!
        @pos = Vec2!
        @radius = 32
        @speed = 256

    draw: (gfx) =>
        gfx.setColor 255, 0, 0
        gfx.circle "fill", @pos.x, @pos.y, @radius, 20

    update: (delta) =>
        dpos = Vec2!
        if keyboard.isDown "a"
            dpos.x += -1
        if keyboard.isDown "w"
            dpos.y += -1
        if keyboard.isDown "s"
            dpos.y += 1
        if keyboard.isDown "d"
            dpos.x += 1
        @pos = @pos\add(dpos\scale(delta * @speed))

{ :Player }
