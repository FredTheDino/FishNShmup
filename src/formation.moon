gfx = love.graphics

x_pos = -> gfx.getWidth! + 20

center_y = ->
    Vec2(x_pos!, gfx.getHeight! / 2)

top_third = ->
    Vec2(x_pos!, gfx.getHeight! / 3)

bot_third = ->
    Vec2(x_pos!, gfx.getHeight! * 2 / 3)


formation_table = {
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
}

current_formation = nil
last_formation = 0
left = 0
offset = 0
export update_spawner = ->
    if left == 0
        last_formation += 1
        current_formation = formation_table[last_formation]
        if current_formation
            offset = 0
            left = current_formation.length

    if current_formation
        for spawn in *current_formation.spawn
            t = spawn[3]
            if t == offset
                fish = spawn[1]
                pos = spawn[2]!
                World\add_entity fish pos

        left -= 1
        offset += 1

export done_spawning_enemies = -> current_formation == nil and last_formation != 0
