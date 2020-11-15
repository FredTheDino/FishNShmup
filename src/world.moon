keyboard = love.keyboard
gfx = love.graphics

entity_overlap = (a, b) ->
    overlap_v a.pos, a.radius, b.pos, b.radius

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
        if e.player
            @player = e
        table.insert @@entities, e

    @test_collision: (a) =>
        for b in *@@entities
            if a == b
                continue
            if entity_overlap a, b
                a\on_collision b
                b\on_collision a
        @@\filter_alive!
