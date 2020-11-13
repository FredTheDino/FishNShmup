import Vec2, overlap, overlap_v from require "util"
import Player from require "player"
import Entity, World from require "world"

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

love.update = (dt) ->
    World\update dt


love.draw = () ->
    t = love.timer.getTime!
    a = Circle 100, 100, math.sin(t) * 30
    b = Circle 120, 100, math.sin(t) * 30
    World\draw gfx
