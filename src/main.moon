require "assets"
require "util"

require "world"
require "entity"
require "shot"
require "player"
require "enemy"
require "item"
require "background"

gfx = love.graphics

love.load = (arg) ->
    Assets\load!
    World\add_entity Player!
    World\add_entity GenericPickupItem!
    gfx.setBackgroundColor 238 / 255, 223 / 255, 203 / 255

    -- --TODO something more like this?
    -- for i = 0, math.random(3, 10)
    --     World\add_entity BGItem "bg_part", 10

    -- for i = 0, math.random(3, 10)
    --     World\add_entity BGItem "bg_cloud", 10
    Background\add_bg_layer Background "bg_cloud_1.png", 1
    Background\add_bg_layer Background "bg_cloud_2.png", 1
    Background\add_bg_layer Background "bg_cloud_3.png", 1
    Background\add_bg_layer Background "bg_cloud_4.png", 1
    Background\add_bg_layer Background "bg_part_1.png"
    Background\add_bg_layer Background "bg_part_2.png"
    Background\add_bg_layer Background "bg_part_3.png"
    Background\add_bg_layer Background "bg_part_4.png"
    Background\add_bg_layer Background "bg_part_5.png"

next_spawn = 0
time_between_spawn = 4
love.update = (dt) ->
    next_spawn -= dt
    if next_spawn < 0
        next_spawn = time_between_spawn
        World\add_entity ShootingEnemy Vec2(love.graphics.getWidth!, 100), Vec2(-100, math.random(-100, 100))

    Background\update dt
    World\update dt

love.draw = ->
    t = love.timer.getTime!
    Background\draw!
    World\draw!
