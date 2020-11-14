keyboard = love.keyboard
gfx = love.graphics

export class Fishing
    @target = 0.5
    @current = 0.5
    @score = 0
    @cursor_speed = 0.5
    @total_t = 0

    @difficulties = {
        { 0.1, 0.6 },
        { 0.075, 1.0 }
    }

    @bar_width = @difficulties[1][1]
    @bar_start = 0.5 - @bar_width
    @bar_end = 0.5 + @bar_width

    @sin_speed = @difficulties[1][2]

    @top_x = 250
    @top_y = 250
    @box_w = 250
    @box_h = 40

    @new_game: (difficulty = 1) =>
        @@current = 0.5
        @@total_t = 0
        @@score = 0

        @@bar_width = @@difficulties[difficulty][1]
        @@sin_speed = @@difficulties[difficulty][2]

        @@bar_start = 0.5 - @@bar_width
        @@bar_end = 0.5 + @@bar_width


    @update: (delta) =>
        if keyboard.isDown "1"
            @@new_game 1
        if keyboard.isDown "2"
            @@new_game 2

        @total_t += delta
        @@current += math.sin(3*@total_t) * random_real(delta / 2, delta) * @@sin_speed

        if keyboard.isDown "a"
            @@current -= @@cursor_speed * delta
        if keyboard.isDown "d"
            @@current += @@cursor_speed * delta

        if @@current < 0
            @@current = 0
        if @@current > 1
            @@current = 1

        if @@current >= @@bar_start and @@current <= @@bar_end
            @@score += 1
        elseif @@score > 0
            @@score -= 2

        print(@@score, @@current)

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

        -- line
        gfx.setColor 0, 0, 0
        current_middle = @@top_x + @@box_w * @@current
        gfx.rectangle "fill", current_middle - 8, @@top_y, 16, @@box_h

        -- score
        gfx.print @@score, 50, 50
