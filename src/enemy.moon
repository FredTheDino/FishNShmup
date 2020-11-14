gfx = love.graphics

class Enemy extends Entity
    new: (pos, vel) =>
        super!
        @enemy = true
        @pos = pos
        @vel = vel
        @fire_rate = 0.2
        @shoottimer = 0
        @health = 3

    fire: =>

    damage: (dmg) =>
        @health -= dmg
        if @health < 0
            @alive = false

    draw: =>
        gfx.setColor 255, 0, 255
        gfx.circle "fill", @pos.x, @pos.y, @radius, 20

    update: (delta) =>
        @pos = @pos\add @vel\scale delta
        @shoottimer -= delta
        @fire!

export class ShootingEnemy extends Enemy
    fire: =>
        if @shoottimer > 0
            return
        @shoottimer = @fire_rate
        World\add_entity Shot @pos, Vec2(-1, 0), 500, false, @radius + 5
