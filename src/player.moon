import Vec2 from require "util"
import Entity, World from require "world"

local Player

keyboard = love.keyboard

export class Shot extends Entity
    new: (pos, dir, vel) =>
        super!
        @pos = pos
        @vel = dir\normalized!\scale(vel)
        @radius = 10
        --@acc = 0

    draw: (gfx) =>
        gfx.setColor 0, 0, 255
        gfx.circle "fill", @pos.x, @pos.y, @radius, 20

    update: (delta) =>
        @pos = @pos\add @vel\scale delta
        World\test_collision @

    on_collision: (other) =>
        if other.__class == Player
            print "hit player"
        if other.__class == Entity
            other.alive = false

export class Player extends Entity
    new: =>
        super!
        @pos = Vec2!
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
        if keyboard.isDown "space"
            World\add_entity Shot @pos, Vec2(1, 0), 300
        @pos = @pos\add(dpos\scale(delta * @speed))

{ :Player }
