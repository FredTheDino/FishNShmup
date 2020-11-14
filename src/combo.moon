gfx = love.graphics

export class Combo
    @score = 0
    @time_to_streak = 5.0

    @increase: (score) =>
        @timer = @time_to_streak
        @combo += 1
        @current_combo_stage += 1
        if @current_combo_stage > @multiplier * 5
            @multiplier += 0.5
            @current_combo_stage = 0
        @score += score * @multiplier

    @reset: =>
        @combo = 0
        @current_combo_stage = 0
        @multiplier = 1
        @timer = 0

    @update: (delta) =>
        @timer -= delta
        if @timer < 0
            @reset!

    @draw: =>
        radius = 40
        x = -10 + radius
        y = -10 + radius
        time_left = math.max(0, @timer) / @time_to_streak
        gfx.setLineStyle "smooth"
        gfx.setLineWidth 5
        gfx.setColor 1.0, 1.0, 1.0, 0.5
        gfx.circle "fill", x, y, radius * time_left, 20
        gfx.circle "fill", x, y, radius * 0.75, 20
        gfx.setLineWidth 1

        gfx.setColor 0.0, 0.0, 0.0
        gfx.printf ""..@score, x - 47.5, y - 10, 100, "center"
        gfx.printf "X"..@multiplier, x - 47.5, y + 20, 100, "center"
        --gfx.printf "Combo"..@combo, x, y + 20, 100, "center"
        gfx.setColor 1.0, 1.0, 1.0
