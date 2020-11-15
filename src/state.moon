gfx = love.graphics

export class State
    @main_menu = 0
    @died = 1
    @playing = 2
    @fishing = 3

    @current = @main_menu

    @draw_main_menu: =>
        gfx.print "FishNShips", 50, 50
    @draw_died: =>
        gfx.print "ya ded", 50, 50
