gfx = love.graphics

export class Shot extends Entity
    new: (pos, dir, vel, owner, offset = 0) =>
        super!
        @radius = 10
        @lifetime = 100
        dir = dir\normalized!
        @pos = pos\add dir\scale offset + @radius
        @vel = dir\scale(vel)
        @owner = owner
        @color = { 0, 0, 1.0 }

    update: (delta) =>
        @pos = @pos\add @vel\scale delta
        @lifetime -= 1
        if @lifetime < 0
            @alive = false

    on_collision: (other) =>
        if (other.player and not @owner.player) or (other.enemy and not @owner.enemy)
            @owner\landed_hit!
            @alive = false
            other\damage(1)
