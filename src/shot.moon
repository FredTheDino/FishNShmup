gfx = love.graphics

class HitEffect extends Entity
    new: (x, y, asset, rate, updates = 1) =>
        super!
        @particles = gfx.newParticleSystem Assets\get asset
        @particles\setPosition x, y
        @particles\setColors 1.0, 1.0, 1.0, 0.2,
                             1.0, 1.0, 1.0, 0.2,
                             0.0, 0.0, 1.0, 0.0

        @particles\setSizes 4.0, 4.5
        @particles\setDirection 0
        @particles\setSpeed 0, 50
        @particles\setParticleLifetime 0.6, 0.8

        @particles\setSpread math.pi * 2
        @particles\setEmissionRate rate
        @particles\update updates
        @particles\setEmissionRate 0
        @lifetime = 2.0

    update: (delta) =>
        @lifetime -= delta
        if @lifetime < 0
            @alive = false
        if @pos.x < -@radius
            @alive = false
        if @pos.x > gfx.getWidth! + @radius
            @alive = false
        @particles\update delta

    draw: =>
        gfx.draw @particles
        
export class Shot extends Entity
    new: (pos, dir, vel, owner, offset = 0) =>
        super!
        @radius = 10
        @lifetime = 100
        dir = dir\normalized!
        @pos = pos\add dir\scale offset + @radius
        @vel = dir\scale(vel)
        @owner = owner
        @damage = 1
        @color = { 0, 0, 1.0 }
        if owner.player
            @img = Assets\get "bullet_1"
        else
            @img = Assets\get "bullet_5"
        @img_angle = math.pi

    update: (delta) =>
        @pos = @pos\add @vel\scale delta
        @lifetime -= 60 * delta
        if @lifetime < 0
            @alive = false

    draw: =>
        super\draw!
        w, h = @img\getPixelDimensions!
        angle = @img_angle
        if @vel.x > 0
            angle -= math.pi
        if @owner.enemy
            gfx.draw @img, @pos.x, @pos.y, angle, 1.5, 1.5, w / 2, h / 2
        else
            gfx.draw @img, @pos.x, @pos.y, angle, 2, 2, w / 2, h / 2

    on_collision: (other) =>
        if (other.player and not @owner.player) or (other.enemy and not @owner.enemy)
            @owner\landed_hit!
            @alive = false
            other\damage(@damage)
            if other.player
                World\add_entity HitEffect @pos.x, @pos.y, "laser_1_part_1", 20
            else
                if @missile
                    World\add_entity HitEffect @pos.x, @pos.y, "dmg_part_2", 5, 10
                    World\add_entity HitEffect @pos.x, @pos.y, "dmg_part_1", 10, 10
                World\add_entity HitEffect @pos.x, @pos.y, "dmg_part_2", 5
                World\add_entity HitEffect @pos.x, @pos.y, "dmg_part_1", 10

export class Missile extends Shot
    new: (pos, dir, vel, owner, offset = 0) =>
        super pos, dir, vel, owner, offset
        @damage = 5
        @img = Assets\get "missile"
        @img_angle = -math.pi / 2
        @missile = true --for drawing more particles
