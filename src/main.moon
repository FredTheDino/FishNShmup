require "assets"
require "util"

require "world"
require "entity"
require "combo"
require "shot"
require "player"
require "enemy"
require "item"
require "background"

require "fishing"

gfx = love.graphics
gone_fishing = true

love.load = (arg) ->
    Assets\load!
    Combo\reset!
    World\add_entity Player!
    World\add_entity GenericPickupItem!
    gfx.setBackgroundColor 238 / 255, 223 / 255, 203 / 255

    for i = 1, 4
        Background\add_bg_layer Background "bg_cloud_"..i..".png",
                                           1.2,
                                           700,
                                           1200,
                                           1.8
    for i = 1, 5
        Background\add_bg_layer Background "bg_part_"..i..".png",
                                           1.2,
                                           120,
                                           120,
                                           1.0

next_spawn = 0
time_between_spawn = 4
love.update = (dt) ->
    if gone_fishing
        Fishing\update dt
    else
        next_spawn -= dt
        if next_spawn < 0
            next_spawn = time_between_spawn
            World\add_entity ShootingEnemy Vec2(love.graphics.getWidth!, 100), Vec2(-100, math.random(-100, 100))

        Background\update dt
        World\update dt
        Combo\update dt

love.draw = ->
    t = love.timer.getTime!
    if gone_fishing
        Fishing\draw!
    else
        Background\draw!
        World\draw!
        Combo\draw!
