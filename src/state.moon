gfx = love.graphics
audio = love.audio

export class State
    @main_menu = 0
    @died = 1
    @playing = 2
    @fishing = 3
    @trans_total = 0.15
    @trans_cur = 0
    @muted = false

    @current = @main_menu

    @load: =>
        @@main_music = audio.newSource Assets\get "retro-funk.mp3"
        @@main_music\setLooping true
        @@fishing_music = audio.newSource Assets\get "fishing.mp3"

    @set_mute: =>
        @@main_music\setVolume 0.0
        @@fishing_music\setVolume 0.0

    @set_unmute: =>
        @@main_music\setVolume 0.5
        @@fishing_music\setVolume 0.8

    @draw_main_menu: =>
        gfx.print "FishNShips", 50, 50
    @draw_died: =>
        gfx.print "ya ded", 50, 50

    @reset_transition: (force = false) =>
        if @@trans_cur == 0 or force
            @@trans_cur = @@trans_total + 0.05

    @update_transition: (delta) =>
        if @@trans_cur > 0
            @@trans_cur -= delta
            if @@trans_cur < 0
                @@trans_cur == 0

    @draw_transition: =>
        pos_x = gfx.getWidth! * (@@trans_cur / @@trans_total)
        gfx.setColor 1.0, 1.0, 1.0, 0.4
        gfx.polygon "fill", pos_x, -10,
                            pos_x-300, -10,
                            pos_x-300-100, gfx.getHeight!+10,
                            pos_x-100, gfx.getHeight!+10
        gfx.setColor 1.0, 1.0, 1.0, 1.0

    @toggle_mute: =>
        @@muted = not @@muted
        if @@muted
            @set_mute!
        else
            @set_unmute!
