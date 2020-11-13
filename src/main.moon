import Vec2, overlap, overlap_v from require "util"
import Player from require "player"

gfx = love.graphics

player = Player!

class Circle
    new: (x, y, r) =>
        @pos = Vec2(x, y)
        @r = r

    overlap: (cb) =>
        overlap_v @pos, @r, cb.pos, cb.r

    draw: (r, g, b) =>
        gfx.setColor r, g, b
        gfx.circle "fill", @pos.x, @pos.y, @r, 20


love.load = (arg) ->

love.update = (dt) ->
    player\update dt


love.draw = () ->
    t = love.timer.getTime!
    a = Circle 100, 100, math.sin(t) * 30
    b = Circle 120, 100, math.sin(t) * 30
    player\draw gfx

    if a\overlap b
        a\draw 100, 0, 0
        b\draw 100, 0, 0
    else
        a\draw 0, 100, 100
        b\draw 100, 0, 100

