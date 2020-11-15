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

total_t = 0
prev_f = false --TODO framework?

next_spawn = 0
time_between_spawn = 4
love.update = (dt) ->
    total_t += dt
    if State.current == State.main_menu
        if keyboard.isDown "return"
            State.current = State.playing
    elseif State.current == State.died
        if keyboard.isDown "return"
            print("Restarting") --TODO
    elseif State.current == State.playing or State.current == State.fishing
        if not prev_f and keyboard.isDown "f"
            prev_f = true
            World.gone_fishing = not World.gone_fishing
        if prev_f and not keyboard.isDown "f"
            prev_f = false
        if State.current == State.fishing
            Fishing\update dt
        else
            next_spawn -= dt
            if next_spawn < 0
                next_spawn = time_between_spawn
                World\add_entity ShootingEnemy Vec2(love.graphics.getWidth!, 100), Vec2(-100, math.random(-100, 100))

            Background\update dt
            World\update dt, total_t
            Combo\update dt

love.draw = ->
    if State.current == State.main_menu
        State\draw_main_menu!
    elseif State.current == State.died
        State\draw_died!
    elseif State.playing
        Background\draw!
        World\draw!
        Combo\draw!
    elseif State.current == State.fishing
        Fishing\draw!
    else
        print("Invalid state", State.current)
