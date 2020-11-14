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
keyboard = love.keyboard

gone_fishing = false
prev_f = false

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
    if keyboard.isDown("f") and not prev_f
        prev_f = true
        gone_fishing = not gone_fishing
    if prev_f and not keyboard.isDown "f"
        prev_f = false
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
