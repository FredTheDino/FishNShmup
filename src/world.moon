keyboard = love.keyboard
gfx = love.graphics

entity_overlap = (a, b) ->
    overlap_v a.pos, a.radius, b.pos, b.radius

export class Entity
    new: =>
        @pos = Vec2 200, 200
        @radius = 32
        @alive = true
        @color = { 255, 0, 0 }

    draw: =>
        gfx.setColor @color[1], @color[2], @color[3]
        gfx.circle "line", @pos.x, @pos.y, @radius, 20
        gfx.setColor 255, 255, 255

    update: (delta) =>

    on_collision: (other) =>

export class World
    @entities = {}

    @draw: =>
        for e in *@@entities
            if e.alive
                e\draw!

    @update: (delta) =>
        for e in *@@entities
            if e.alive
                e\update delta
        @@\filter_alive!

    @filter_alive: =>
        @@entities = [e for e in *@@entities when e.alive]

    @add_entity: (e) =>
        table.insert @@entities, e

    @test_collision: (a) =>
        for b in *@@entities
            if a == b
                continue
            if entity_overlap a, b
                a\on_collision b
                b\on_collision a
        @@\filter_alive!
