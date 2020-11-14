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
        time_left = math.max(0, @timer) / @time_to_streak
        print @score, @combo, @multiplier, time_left
