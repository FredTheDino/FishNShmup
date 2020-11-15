gfx = love.graphics

export class State
    @main_menu = 0
    @died = 1
    @playing = 2
    @fishing = 3
    @trans_total = 0.15
    @trans_cur = 0

    @current = @main_menu

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
