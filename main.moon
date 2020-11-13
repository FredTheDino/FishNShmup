import Vec2 from require "util"

love.load = (arg) ->

love.update = (dt) ->
    print "hej"

love.draw = () ->
    love.graphics.rectangle "fill", 10, 10, 100, 100
