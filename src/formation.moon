gfx = love.graphics

x_pos = -> gfx.getWidth! + 30

center_y = ->
    Vec2(x_pos!, gfx.getHeight! / 2)

top_third = ->
    Vec2(x_pos!, gfx.getHeight! / 3)

bot_third = ->
    Vec2(x_pos!, gfx.getHeight! * 2 / 3)

quarter = (n) ->
    -> Vec2(x_pos!, (n + 1) * gfx.getHeight! / 6)


formation_table = {
    {
        length: 200,
        spawn: {
            { ShootMissileItem, center_y, 0 },
        }
    },

    {
        length: 200,
        spawn: {
            { Pike, center_y, 0 },
            { Pike, center_y, 40 },
            { Pike, center_y, 80 },
        }
    },

    {
        length: 200,
        spawn: {
            { Pike, top_third, 0 },
            { Pike, center_y, 0 },
            { Pike, bot_third, 0 },
        }
    },

    {
        length: 200,
        spawn: {
            { Pike, top_third, 0 },
            { Pike, center_y, 0 },
            { Pike, bot_third, 0 },
            { Pike, top_third, 200 },
            { Pike, bot_third, 200 },
            { Pike, center_y, 100 },
            { FishingItem, center_y, 0 },
        }
    },

    {
        length: 200,
        spawn: {}
    },

    {
        length: 300,
        spawn: {
            { Salmon, center_y, 0 },
            { FishingItem, center_y, 100 },
        }
    },

    {
        length: 300,
        spawn: {
            { Salmon, top_third, 0 },
            { Salmon, bot_third, 0 },
        }
    },

    {
        length: 300,
        spawn: {
            { Pike, center_y, 0 },
            { Salmon, center_y, 100 },
            { Pike, center_y, 200 },
        }
    },

    {
        length: 300,
        spawn: {
            { Salmon, center_y, 100 },
            { Salmon, center_y, 150 },
            { Pike, bot_third, 0 },
            { Pike, top_third, 0 },
            { Pike, center_y, 0 },
            { FishingItem, center_y, 0 },
        }
    },

    {
        length: 300,
        spawn: {
            { Whale, center_y, 100 },
        }
    },

    {
        length: 300,
        spawn: {
            { Pike, center_y, 0 },
            { Pike, top_third, 0 },
            { Pike, bot_third, 0 },
            { Whale, top_third, 125 },
            { Whale, bot_third, 100 },
            { FishingItem, center_y, 0 },
        }
    },

    {
        length: 300,
        spawn: {}
    },

    {
        length: 300,
        spawn: {
            { Whale, center_y, 100 },
            { Salmon, bot_third, 0 },
            { Salmon, bot_third, 50 },
            { Salmon, bot_third, 100 },
            { Salmon, bot_third, 150 },
            { FishingItem, center_y, 0 },
        }
    },

    {
        length: 500,
        spawn: {
            { Pike, quarter(0), 0 },
            { Pike, quarter(1), 50 },
            { Pike, quarter(2), 100 },
            { Pike, quarter(3), 150 },
            { Pike, quarter(4), 200 },
            { Pike, quarter(3), 250 },
            { Pike, quarter(2), 300 },
            { Pike, quarter(1), 350 },
            { Pike, quarter(0), 400 },
        }
    },
        
    {
        length: 300,
        spawn: {
            { Whale, bot_third, 100 },
            { Salmon, top_third, 0 },
            { Salmon, top_third, 50 },
            { Salmon, top_third, 100 },
            { Salmon, top_third, 150 },
            { FishingItem, center_y, 0 },
        }
    },

    {
        length: 300,
        spawn: {
            { Eel, center_y, 0 },
            { Eel, center_y, 50 },
            { Eel, center_y, 100 },
            { Eel, center_y, 150 },
            { FishingItem, center_y, 250 },
        }
    },

    {
        length: 300,
        spawn: {
            { Whale, bot_third, 100 },
            { Eel, top_third, 0 },
        }
    },

    {
        length: 300,
        spawn: {
            { Whale, top_third, 0 },
            { Eel, center_y, 0 },

            { Whale, bot_third, 200 },
            { Eel, center_y, 200 },
        }
    },

    {
        length: 600,
        spawn: {
            { Pike, quarter(0), 0 },
            { Pike, quarter(1), 0 },
            { Pike, quarter(2), 0 },
            { Pike, quarter(3), 0 },
            { Pike, quarter(4), 0 },

            { FishingItem, center_y, 0 },

            { Pike, quarter(0), 100 },
            { Pike, quarter(1), 100 },
            { Pike, quarter(2), 100 },
            { Pike, quarter(3), 100 },
            { Pike, quarter(4), 100 },

            { Whale, top_third, 200 },
            { Eel, center_y, 200 },

            { Whale, bot_third, 300 },
            { Eel, center_y, 300 },
        }
    },


    {
        length: 400,
        spawn: {
            { Cod, center_y, 0 },
            { Cod, top_third, 50 },
            { Cod, bot_third, 100 },
        }
    },

    {
        length: 400,
        spawn: {
            { Whale, center_y, 0 },
            { Cod, top_third, 50 },
            { Cod, bot_third, 50 },
        }
    },

    {
        length: 400,
        spawn: {
            { Cod, top_third, 50 },
            { Cod, bot_third, 50 },

            { Eel, center_y, 100 },
            { Eel, center_y, 150 },
            { Eel, center_y, 200 },
            
            { Cod, top_third, 150 },
            { Cod, bot_third, 150 },
            { FishingItem, center_y, 0 },
        }
    },

    {
        length: 400,
        spawn: {
            { Pike, center_y, 0 },
            { Pike, center_y, 50 },
            { Flounder, center_y, 100 },
        }
    },

    {
        length: 400,
        spawn: {
            { Flounder, top_third, 50 },
            { Flounder, bot_third, 50 },
        }
    },

    {
        length: 400,
        spawn: {
            { Flounder, top_third, 50 },
            { Cod, center_y, 50 },
            { Flounder, bot_third, 50 },
        }
    },

    {
        length: 300,
        spawn: {
            { Pike, quarter(0), 0 },
            { Pike, quarter(1), 0 },
            { Pike, quarter(2), 0 },
            { Pike, quarter(3), 0 },
            { Pike, quarter(4), 0 },

            { FishingItem, center_y, 0 },
            { Pike, quarter(0), 100 },
            { Pike, quarter(1), 100 },
            { Pike, quarter(2), 100 },
            { Pike, quarter(3), 100 },
            { Pike, quarter(4), 100 },

            { Flounder, top_third, 50 },
            { Flounder, bot_third, 50 },
        }
    },

    {
        length: 300,
        spawn: {
            { Pike, quarter(0), 0 },
            { Pike, quarter(1), 0 },
            { Pike, quarter(2), 0 },
            { Pike, quarter(3), 0 },
            { Pike, quarter(4), 0 },

            { Pike, quarter(0), 100 },
            { Pike, quarter(1), 100 },
            { Pike, quarter(2), 100 },
            { Pike, quarter(3), 100 },
            { Pike, quarter(4), 100 },

            { Cod, top_third, 50 },
            { Cod, bot_third, 50 },
            { Cod, top_third, 150 },
            { Cod, bot_third, 150 },
        }
    },

    {
        length: 300,
        spawn: {
            { Perch, quarter(1), 0 },
            { Perch, quarter(3), 0 },

            { Perch, quarter(0), 150 },
            { Perch, quarter(2), 175 },
            { Perch, quarter(4), 150 },
        }
    },

    {
        length: 300,
        spawn: {
            { Perch, quarter(1), 150 },
            { Perch, quarter(3), 150 },

            { Pike, quarter(0), 0 },
            { Pike, quarter(1), 0 },
            { Pike, quarter(2), 0 },
            { Pike, quarter(3), 0 },
            { Pike, quarter(4), 0 },

            { Pike, quarter(0), 100 },
            { Pike, quarter(1), 100 },
            { Pike, quarter(2), 100 },
            { Pike, quarter(3), 100 },
            { Pike, quarter(4), 100 },
            { FishingItem, center_y, 0 },
        }
    },

    {
        length: 300,
        spawn: {
            { Cod, quarter(1), 150 },
            { Cod, quarter(3), 150 },

            { Pike, quarter(0), 0 },
            { Pike, quarter(1), 0 },
            { Pike, quarter(2), 0 },
            { Pike, quarter(3), 0 },
            { Pike, quarter(4), 0 },

            { Flounder, quarter(0), 100 },
            { Flounder, quarter(1), 100 },
            { Flounder, quarter(2), 100 },
            { Flounder, quarter(3), 100 },
            { Flounder, quarter(4), 100 },

            { FishingItem, center_y, 0 },
        }
    },

    {
        length: 300,
        spawn: {
            { Whale, quarter(0), 50 },
            { Whale, quarter(2), 75 },
            { Whale, quarter(4), 50 },

            { Pike, quarter(0), 0 },
            { Pike, quarter(1), 0 },
            { Pike, quarter(2), 0 },
            { Pike, quarter(3), 0 },
            { Pike, quarter(4), 0 },

            { FishingItem, center_y, 0 },
        }
    },

    {
        length: 700,
        spawn: {
            { Whale, quarter(0), 150 },
            { Whale, quarter(2), 175 },
            { Whale, quarter(4), 150 },

            { Perch, quarter(1), 175 },
            { Perch, quarter(3), 175 },

            { Perch, quarter(1), 175 },
            { Perch, quarter(3), 175 },

            { Cod, quarter(1), 100 },
            { Cod, quarter(3), 100 },

            { Salmon, quarter(0), 100 },
            { Salmon, quarter(1), 100 },
            { Salmon, quarter(2), 100 },
            { Salmon, quarter(3), 100 },
            { Salmon, quarter(4), 100 },

            { Eel, quarter(2), 50 },
            { Eel, quarter(3), 50 },

            { Pike, quarter(0), 0 },
            { Pike, quarter(1), 0 },
            { Pike, quarter(2), 0 },
            { Pike, quarter(3), 0 },
            { Pike, quarter(4), 0 },

            { FishingItem, center_y, 0 },
        }
    },


    { length: 500, spawn: {} }
}

current_formation = nil
last_formation = 0
left = 0
offset = 0

export start_formation = ->
    current_formation = nil
    last_formation = 31
    left = 0
    offset = 0

export update_spawner = (delta) ->
    if left <= 0
        last_formation += 1
        current_formation = formation_table[last_formation]
        if current_formation
            offset = 0
            left = current_formation.length

    if current_formation
        for spawn in *current_formation.spawn
            t = spawn[3]
            if offset <= t and offset + 60 * delta >= t
                fish = spawn[1]
                pos = spawn[2]!
                World\add_entity fish pos

        left -= 60 * delta
        offset += 60 * delta

export done_spawning_enemies = -> current_formation == nil and last_formation != 0
