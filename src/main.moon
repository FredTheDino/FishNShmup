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
require "formation"

gfx = love.graphics
keyboard = love.keyboard

love.load = (arg) ->
    Assets\load!
    State\load!
    Fishing\load!
    Combo\reset!
    World\add_entity Player!
    World\add_entity FishingItem!
    gfx.setBackgroundColor 238 / 255, 223 / 255, 203 / 255

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

    State.main_music\play!

total_t = 0

update_main_menu = (dt) ->
    if keyboard.isDown "return"
        State.current = State.playing

update_died = (dt) ->
    if keyboard.isDown "return"
        print("Restarting") --TODO

update_fishing = (dt) -> Fishing\update dt

update_game = (dt) ->
    if done_spawning_enemies!
        1 + 1 -- We are done spawning, so winning is possible
    update_spawner!

    Background\update dt
    World\update dt, total_t
    Combo\update dt

prev_m_press = false --TODO framework?
love.update = (dt) ->
    total_t += dt
    State\update_transition dt

    if keyboard.isDown"m" and not prev_m_press
        State\toggle_mute!
    prev_m_press = keyboard.isDown "m"

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
