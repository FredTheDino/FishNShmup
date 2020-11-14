keyboard = love.keyboard
gfx = love.graphics

export class Fishing
    @target = 0.5
    @current = 0.5
    @cursor_speed = 0.5
    @total_t = 0

    @update: (delta) =>
        @total_t += delta
        @@current += math.sin(@total_t) * delta * random_real(0, 1)

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
