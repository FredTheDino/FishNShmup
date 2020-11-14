keyboard = love.keyboard
gfx = love.graphics

export class Fishing
    @target = 0.5
    @current = 0.5
    @cursor_speed = 0.5
    @total_t = 0

    @bar_width = 0.05
    @bar_start = 0.5 - @bar_width
    @bar_end = 0.5 + @bar_width

    @top_x = 250
    @top_y = 250
    @box_w = 250
    @box_h = 40

    @update: (delta) =>
        @total_t += delta
        @@current += math.sin(2*@total_t) * random_real(0, delta)

        if keyboard.isDown "a"
            @@current -= @@cursor_speed * delta
        if keyboard.isDown "d"
            @@current += @@cursor_speed * delta

        if @@current < 0
            @@current = 0
        if @@current > 1
            @@current = 1

        print(@@current)

    @draw: =>
        -- left outer
        gfx.setColor 255, 0, 0
        gfx.rectangle "fill", @@top_x, @@top_y, @@box_w * @@bar_start, @@box_h

        -- middle
        gfx.setColor 0, 150, 0
        gfx.rectangle "fill", @@top_x + @@box_w * @@bar_start, @@top_y, @@box_w * @@bar_end, @@box_h

        -- right outer
        gfx.setColor 255, 0, 0
        gfx.rectangle "fill", @@top_x + @@box_w * @@bar_end, @@top_y, @@box_w * @@bar_start, @@box_h

        -- outer box
        gfx.setColor 0, 0, 0
        gfx.rectangle "line", @@top_x, @@top_y, @@box_w, @@box_h
