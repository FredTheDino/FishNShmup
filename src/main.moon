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
require "state"

gfx = love.graphics
keyboard = love.keyboard

love.load = (arg) ->
    Assets\load!
    Fishing\load!
    Combo\reset!
    World\add_entity Player!
    World\add_entity FishingItem!
    gfx.setBackgroundColor 238 / 255, 223 / 255, 203 / 255
    World\add_entity Perch Vec2(gfx.getWidth! * 2, gfx.getHeight!)\div(2)

    for i = 1, 4
        Background\add_bg_layer Background "bg_cloud_"..i,
                                           1.2,
                                           700,
                                           1200,
                                           1.8
    for i = 1, 5
        Background\add_bg_layer Background "bg_part_"..i,
                                           1.2,
                                           120,
                                           120,
                                           1.0

total_t = 0
prev_f = false --TODO framework?

update_main_menu = (dt) ->
    if keyboard.isDown "return"
        State.current = State.playing

update_died = (dt) ->
    if keyboard.isDown "return"
        print("Restarting") --TODO

update_fishing = (dt) -> Fishing\update dt

next_spawn = 0
time_between_spawn = 4
update_game = (dt) ->
    next_spawn -= dt
    if next_spawn < 0
        next_spawn = time_between_spawn
        World\add_entity Perch Vec2(love.graphics.getWidth!, 100), Vec2(-100, math.random(-100, 100))
    Background\update dt
    World\update dt, total_t
    Combo\update dt

love.update = (dt) ->
    total_t += dt
    State\update_transition dt
    if State.current == State.main_menu
        update_main_menu dt
    elseif State.current == State.died
        update_died dt
    elseif State.current == State.fishing
        update_fishing dt
    elseif State.current == State.playing
        update_game dt

love.draw = ->
    if State.current == State.main_menu
        State\draw_main_menu!
    elseif State.current == State.died
        State\draw_died!
    elseif State.current == State.playing
        Background\draw!
        World\draw!
        Combo\draw!
    elseif State.current == State.fishing
        Fishing\draw!
    else
        print("Invalid state", State.current)
    State\draw_transition!
