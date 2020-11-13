import add from require "other"

love.load = (arg) ->

love.update = (dt) ->
    print add 1, 2

love.draw = () ->
    love.graphics.rectangle "fill", 10, 10, 100, 100
