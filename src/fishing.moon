keyboard = love.keyboard
gfx = love.graphics

target_score = 750

x_pos = -> gfx.getWidth! + 30

center_y = ->
    Vec2(x_pos!, gfx.getHeight! / 2)

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

    @box_w = 250
    @box_h = 32
    @box = Vec2((gfx.getWidth! - @box_w) / 2, gfx.getHeight! / 4)

    -- call @load
    @ship_img = nil
    @rod_img = nil
    @float_img = nil
    @water_tile = nil

    @water_t = 0

    --TODO animate towards
    --TODO y-variance
    @ship_base = Vec2 600, 300
    @ship_target = @ship_base
    @ship_draw_offset = Vec2 48, -40
    @ship_speed = 50

    @float_base = Vec2 300, 300

    -- bad variable names
    -- call @update_bezier
    @rod_target = nil
    @float_target = nil
    @line_curve = nil

    @load: =>
        @@ship_img = Assets\get "ship"
        @@rod_img = Assets\get "rod"
        @@float_img = Assets\get "float"
        @@water_tile = Assets\get "water_bg"

        @@update_bezier 0

    @new_game: (difficulty = 1) =>
        @@current = 0.5
        @@total_t = 0
        @@score = 100

        @@bar_width = @@difficulties[difficulty][1]
        @@sin_speed = @@difficulties[difficulty][2]

        @@bar_start = 0.5 - @@bar_width
        @@bar_end = 0.5 + @@bar_width

    @end_game: =>
        State.fishing_music\stop!
        State.main_music\play!
        State\reset_transition!
        State.current = State.playing

    @noise = 0
    @update: (delta, total_t) =>

        if keyboard.isDown "1"
            @@new_game 1
        if keyboard.isDown "2"
            @@new_game 2

        @@total_t += delta
        @noise = (@noise + random_real(-1, 1)) * 0.5
        @@current += math.sin(3*@total_t + @noise) * random_real(delta / 2, delta) * @@sin_speed
        @@water_t = (@@water_t + 2 * delta) % 1

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

        if @@score == 0
            @@end_game!
        if @@score > target_score
            World\add_entity random_item! center_y!
            @@end_game!

        @@ship_target = @@ship_base\add Vec2 50 * @@current, 0

        dpos = Vec2!
        if keyboard.isDown "a"
            dpos.x += -1
        if keyboard.isDown "w"
            dpos.y += -1
        if keyboard.isDown "s"
            dpos.y += 1
        if keyboard.isDown "d"
            dpos.x += 1
        @@ship_target = @@ship_target\add dpos\scale delta * @@ship_speed

        @@update_bezier total_t

    @update_bezier: (total_t) =>
        @@rod_target = Vec2 @@ship_target.x + @@ship_draw_offset.x - 115,
                            @@ship_target.y + @@ship_draw_offset.y - 35

        @@float_target = @@float_base\add Vec2 0, math.sin(3 * total_t) * 8

        if not @@line_curve
            @@line_curve = love.math.newBezierCurve @@rod_target.x, @@rod_target.y,
                                                    450, 300,
                                                    @@float_target.x + 8, @@float_target.y
        else
            @@line_curve\setControlPoint 1, @@rod_target.x, @@rod_target.y
            @@line_curve\setControlPoint 3, @@float_target.x + 8, @@float_target.y

    @draw: =>
        gfx.setColor 1.0, 1.0, 1.0, 1.0

        -- water background
        w = @@water_tile\getWidth!
        h = @@water_tile\getHeight!
        scale = 2
        for y = 0, 3
            for x = 0, 5
                gfx.draw @@water_tile, w*x*scale - w*@@water_t*scale, h*y*scale, 0, scale, scale


        -- left outer
        gfx.setColor 1.0, 0.0, 0.0
        gfx.rectangle "fill", @@box.x, @@box.y, @@box_w * @@bar_start, @@box_h

        -- middle
        gfx.setColor 0.0, 0.8, 0.0
        gfx.rectangle "fill", @@box.x + @@box_w * @@bar_start, @@box.y, @@box_w * @@bar_end, @@box_h

        -- right outer
        gfx.setColor 1.0, 0.0, 0.0
        gfx.rectangle "fill", @@box.x + @@box_w * @@bar_end, @@box.y, @@box_w * @@bar_start, @@box_h

        -- outer box
        gfx.setColor 0.0, 0.0, 0.0
        gfx.rectangle "line", @@box.x, @@box.y, @@box_w, @@box_h

        -- line
        gfx.setColor 0.0, 0.0, 0.0
        current_middle = @@box.x + @@box_w * @@current
        gfx.rectangle "fill", current_middle - 8, @@box.y, 16, @@box_h

        -- score
        gfx.print @@score, 50, 50

        gfx.setColor 1.0, 1.0, 1.0

        -- rod
        gfx.draw @@rod_img,
                 @@ship_target.x + @@ship_draw_offset.x - 115,
                 @@ship_target.y + @@ship_draw_offset.y - 35,
                 0,
                 1.8,
                 1.8

        -- float
        gfx.draw @@float_img,
                 @@float_target.x,
                 @@float_target.y,
                 0,
                 1.5,
                 1.5

        -- fishing_line
        gfx.setLineWidth 3
        --gfx.setColor 0.9, 0.9, 0.9 TODO
        gfx.line @@line_curve\render 5
        gfx.setLineWidth 1

        -- player model
        gfx.draw @@ship_img,
                 @@ship_target.x + @@ship_draw_offset.x,
                 @@ship_target.y + @@ship_draw_offset.y,
                 math.pi/2
