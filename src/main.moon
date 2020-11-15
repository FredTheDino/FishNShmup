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

    State.main_music\play!

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

total_t = 0

update_main_menu = (dt) ->
    if keyboard.isDown "space"
        State\start_playing!

update_died = (dt) ->
    if not State.highscore or Combo.score > State.highscore
        State.highscore = Combo.score
    
    if keyboard.isDown "return"
        State.current = State.main_menu

update_fishing = (dt, total_t) -> Fishing\update dt, total_t

update_game = (dt) ->
    update_spawner dt
    if done_spawning_enemies!
        State.current = State.died

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
        update_fishing dt, total_t
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
