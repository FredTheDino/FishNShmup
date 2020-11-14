import Assets from require "assets"
import Vec2, overlap, overlap_v from require "util"
import Player from require "player"
import ShootingEnemy from require "enemy"
import Entity, World from require "world"
import GenericPickupItem from require "item"
import BGItem from require "background"

gfx = love.graphics

bg_timer = 0.0
bg_timer_lo = 0.2
bg_timer_hi = 5.0
spawn_background = (delta) ->
    bg_timer -= delta
    if bg_timer < 0
        bg_timer = random_real bg_timer_lo, bg_timer_hi
        for i = 0, math.random(3, 10)
            World\add_entity BGItem "bg_part", 10

        for i = 0, math.random(3, 10)
            World\add_entity BGItem "bg_cloud", 10

love.load = (arg) ->
    Assets\load!
    World\add_entity Entity!
    World\add_entity Player!
    World\add_entity GenericPickupItem!
    gfx.setBackgroundColor 238 / 255, 223 / 255, 203 / 255

next_spawn = 0
time_between_spawn = 4
love.update = (dt) ->
    next_spawn -= dt
    if next_spawn < 0
        next_spawn = time_between_spawn
        World\add_entity ShootingEnemy Vec2(love.graphics.getWidth!, 100), Vec2(-100, math.random(-100, 100))
    spawn_background dt
        
    World\update dt


love.draw = () ->
    t = love.timer.getTime!
    World\draw gfx
