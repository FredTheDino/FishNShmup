import Vec2, overlap, overlap_v from require "util"
import Player from require "player"
import ShootingEnemy from require "enemy"
import Entity, World from require "world"
import GenericPickupItem from require "item"

gfx = love.graphics

class Circle
    new: (x, y, r) =>
        @pos = Vec2(x, y)
        @r = r

    draw: (r, g, b) =>
        gfx.setColor r, g, b
        gfx.circle "fill", @pos.x, @pos.y, @r, 20


love.load = (arg) ->
    World\add_entity Entity!
    World\add_entity Player!
    World\add_entity GenericPickupItem!

next_spawn = 0
time_between_spawn = 4
love.update = (dt) ->
    next_spawn -= dt
    if next_spawn < 0
        next_spawn = time_between_spawn
        World\add_entity ShootingEnemy Vec2(love.graphics.getWidth!, 100), Vec2(-100, math.random(-100, 100))

    World\update dt


love.draw = () ->
    t = love.timer.getTime!
    a = Circle 100, 100, math.sin(t) * 30
    b = Circle 120, 100, math.sin(t) * 30
    World\draw gfx
