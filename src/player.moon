import Vec2 from require "util"
import Entity, World from require "world"

local Player

keyboard = love.keyboard

export class Shot extends Entity
    new: (pos, dir, vel, offset = 0) =>
        super!
        @radius = 10
        @lifetime = 200
        @pos = pos\add dir\scale offset + @radius
        @vel = dir\normalized!\scale(vel)
        --@acc = 0

    draw: (gfx) =>
        gfx.setColor 0, 0, 255
        gfx.circle "fill", @pos.x, @pos.y, @radius, 20

    update: (delta) =>
        @pos = @pos\add @vel\scale delta
        World\test_collision @
        @lifetime -= 1
        if @lifetime < 0
            @alive = false

    on_collision: (other) =>
        if other.player or other.enemy
            @alive = false
            other\damage(1)

export class Player extends Entity
    new: =>
        super!
        @player = true
        @pos = Vec2!
        @draw_offset = Vec2(48, -40)
        @speed = 256
        @shoottimer = 0
        @fire_rate = 0.2
        @health = 3
        @img = Assets\get "ship.png"

    draw: (gfx) =>
        gfx.setColor 255, 0, 0
        gfx.circle "fill", @pos.x, @pos.y, @radius, 20
        gfx.setColor 255, 255, 255
        gfx.draw @img, @pos.x + @draw_offset.x, @pos.y + @draw_offset.y, math.pi/2

    fire: =>
        if @shoottimer > 0
            return
        @shoottimer = @fire_rate
        World\add_entity Shot @pos, Vec2(1, 0), 500, @radius + 5

    damage: (dmg) =>
        @health -= dmg
        if @health < 0
            @alive = false

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

        @shoottimer -= delta
        if  keyboard.isDown "space"
            @fire!
            
        @pos = @pos\add(dpos\scale(delta * @speed))

        World\test_collision @

    on_collision: (other) =>
        if other.__class == Item
            other\on_collision

{ :Player, :Shot }
