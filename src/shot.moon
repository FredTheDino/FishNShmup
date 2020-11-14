export class Shot extends Entity
    new: (pos, dir, vel, friendly, offset = 0) =>
        super!
        @radius = 10
        @lifetime = 200
        @pos = pos\add dir\scale offset + @radius
        @vel = dir\normalized!\scale(vel)
        @friendly = friendly
        --@acc = 0

    draw: (gfx) =>
        gfx.setColor 0, 0, 255
        gfx.circle "fill", @pos.x, @pos.y, @radius, 20

    update: (delta) =>
        @pos = @pos\add @vel\scale delta
        World\test_collision @
        @lifetime -= 1
        if @lifetime < 0
            @alive = false

    on_collision: (other) =>
        if (other.player and not @friendly) or (other.enemy and @friendly)
            @alive = false
            other\damage(1)
