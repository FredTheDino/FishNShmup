import overlap_v from require "util"

keyboard = love.keyboard
gfx = love.graphics

entity_overlap = (a, b) ->
    overlap_v a.pos, a.radius, b.pos, b.radius

export class Entity
    new: =>
        @pos = Vec2 200, 200
        @radius = 32
        @alive = true

    draw: (gfx) =>
        gfx.setColor 0, 255, 0
        gfx.circle "fill", @pos.x, @pos.y, 20, 20

    update: (delta) =>
        if keyboard.isDown "f"
            print("F")
            @alive = false

    on_collision: (other) =>

export class World
    @entities = {}

    @draw: (gfx) =>
        for e in *@@entities
            e\draw gfx

    @update: (delta) =>
        for e in *@@entities
            e\update delta
        @@\filter_alive!

    @filter_alive: =>
        @@entities = [e for e in *@@entities when e.alive]

    @add_entity: (e) =>
        table.insert @@entities, e

    @test_collision: (a) =>
        for b in *@@entities
            if entity_overlap a, b
                a\on_collision b
                b\on_collision a
        @@\filter_alive!

{ :Entity, :World }
