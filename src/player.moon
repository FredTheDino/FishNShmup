import Vec2 from require "util"
import Entity, World from require "world"

keyboard = love.keyboard
gfx = love.graphics

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

export class Player extends Entity
    new: =>
        super!
        @player = true
        @pos = Vec2!
        @draw_offset = Vec2(48, -40)
        @speed = 256
        @shoottimer = 0
        @fire_rate = 0.2
        @health = 3
        @img = Assets\get "ship.png"

        @engine_particles = gfx.newParticleSystem Assets\get "tmp_engine.png"
        @engine_particles\setParticleLifetime 1, 2
        @engine_particles\setEmissionRate 5
        @engine_particles\start!

    draw: =>
        gfx.setColor 255, 0, 0
        gfx.circle "fill", @pos.x, @pos.y, @radius, 20
        gfx.setColor 255, 255, 255
        gfx.draw @img, @pos.x + @draw_offset.x, @pos.y + @draw_offset.y, math.pi/2
        gfx.draw @engine_particles

    fire: =>
        if @shoottimer > 0
            return
        @shoottimer = @fire_rate
        World\add_entity Shot @pos, Vec2(1, 0), 500, true, @radius + 5

    damage: (dmg) =>
        @health -= dmg
        if @health < 0
            @alive = false

    update: (delta) =>
        @engine_particles\update delta
        dpos = Vec2!
        if keyboard.isDown "a"
            dpos.x += -1
        if keyboard.isDown "w"
            dpos.y += -1
        if keyboard.isDown "s"
            dpos.y += 1
        if keyboard.isDown "d"
            dpos.x += 1

        @shoottimer -= delta
        if keyboard.isDown "space"
            @fire!
            
        @pos = @pos\add(dpos\scale(delta * @speed))
        @engine_particles\setPosition @pos.x, @pos.y

        World\test_collision @

    on_collision: (other) =>
        if other.__class == Item
            other\on_collision

{ :Player, :Shot }
