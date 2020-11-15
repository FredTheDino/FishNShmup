gfx = love.graphics
audio = love.audio

draw_centerd = (img_name, y = 0, size = 1) ->
    img = Assets\get img_name
    w, h = img\getPixelDimensions!
    gfx.draw img, (gfx.getWidth! - w * size) / 2, (y + gfx.getHeight! - h * size) / 2, 0, size

export class State
    @main_menu = 0
    @died = 1
    @playing = 2
    @fishing = 3
    @trans_total = 0.15
    @trans_cur = 0
    @muted = false

    @current = @main_menu
    @highscore = nil

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
        draw_centerd "logo", -100, 2
        -- TODO(ed): Press space to start
        draw_centerd "press_space"

        if @highscore
            gfx.setColor 0, 0, 0
            gfx.printf "Highscore: " .. @highscore,
                       gfx.getWidth! / 2 - 250,
                       gfx.getHeight! / 2 + 100,
                       500, "center"

    @start_playing: =>
        State.current = State.playing
        Combo\reset_start!
        World\reset!
        World\add_entity Player!

    @draw_died: =>
        gfx.setColor 0, 0, 0
        gfx.printf "GAME OVER",
                   gfx.getWidth! / 2 - 250 * 2,
                   gfx.getHeight! / 2 - 100,
                   500, "center", 0, 2, 2

        gfx.printf "Score: " .. Combo.score,
                   gfx.getWidth! / 2 - 250,
                   gfx.getHeight! / 2 + 100,
                   500, "center"


        gfx.printf "Press enter to continue",
                   gfx.getWidth! / 2 - 250,
                   gfx.getHeight! / 2,
                   500, "center"

        if Combo.score == @highscore
            gfx.printf "NEW HIGHSCORE!",
                       gfx.getWidth! / 2 - 250,
                       gfx.getHeight! / 2 + 125,
                       500, "center"

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
