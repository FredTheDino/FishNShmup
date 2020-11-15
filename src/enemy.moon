gfx = love.graphics
audio = love.audio

class Enemy extends Entity
    new: (pos, vel) =>
        super!
        @enemy = true
        @pos = pos
        @vel = vel
        @fire_rate = 0.2
        @shoottimer = 0
        @health = 3
        @color = { 1.0, 0.0, 1.0 }
        @shot_sound = audio.newSource Assets\get "pewpew.wav"

    fire: =>
        if @shoottimer > 0
            return
        @shot_sound\clone!\play! --TODO lower sound when out of screen

    damage: (dmg) =>
        @health -= dmg
        if @health < 0
            @alive = false

    landed_hit: =>
        Combo\reset!

    update: (delta) =>
        @pos = @pos\add @vel\scale delta
        @shoottimer -= delta
        @fire!

        if @pos.x < -@radius
            alive = false

        if @pos.y < -@radius
            alive = false

        if @pos.y - @radius > gfx.getHeight!
            alive = false

        World\test_collision @

export class ShootingEnemy extends Enemy
    fire: =>
        super\fire!
        if @shoottimer > 0
            return
        @shoottimer = @fire_rate
        World\add_entity Shot @pos, Vec2(-1, 0), 500, @, @radius + 5
