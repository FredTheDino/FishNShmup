gfx = love.graphics
audio = love.audio

class Enemy extends Entity
    new: (pos) =>
        super!
        @enemy = true
        @pos = pos
        @vel = Vec2!
        @fire_rate = 0.2
        @shoottimer = 0
        @health = 3
        @color = { 1.0, 0.0, 1.0 }
        @shot_sound = audio.newSource Assets\get "pewpew.wav"

    fire_sound: =>
        @shot_sound\clone!\play!

    fire: =>
        @fire_sound!
        World\add_entity Shot @pos, Vec2(-1, 0), 500, @, @radius

    try_fire: =>
        if @shoottimer > 0
            return
        @shoottimer = @fire_rate
        @fire!

    damage: (dmg) =>
        @health -= dmg
        if @health < 0
            @alive = false

    landed_hit: =>
        Combo\reset!

    update: (delta) =>
        @pos = @pos\add @vel\scale delta
        @shoottimer -= delta
        @try_fire!

        if @pos.x < -@radius
            alive = false

        if @pos.y < -@radius
            alive = false

        if @pos.y - @radius > gfx.getHeight!
            alive = false

        World\test_collision @

        
    draw_centerd: (x, y, img_name, scale_x = 1, scale_y = 1) =>
        img = Assets\get img_name
        -- Height is width since we rotate...
        w, h = img\getPixelDimensions!
        px = x - h / 2
        py = y + w / 2
        gfx.draw img, @pos.x + px, @pos.y + py, -0.5 * math.pi, scale_x, scale_y

    anim: (offset = 1.0, scale = 5.0) =>
        scale * math.sin offset * love.timer.getTime!


-- Code for moving things
-- keyboard = love.keyboard
-- x = 0
-- y = 0
-- r = 0
--         if keyboard.isDown "a"
--             x += 1
--         if keyboard.isDown "d"
--             x -= 1
-- 
--         if keyboard.isDown "s"
--             y += 1
--         if keyboard.isDown "w"
--             y -= 1
-- 
--         if keyboard.isDown "q"
--             r += 1 * 0.1
--         if keyboard.isDown "e"
--             r -= 1 * 0.1
-- 
--         print(x, y, r / math.pi)

export class Pike extends Enemy
    new: (pos) =>
        super pos
        @vel = Vec2 -100, 0

    fire: =>

    draw: =>
        super\draw!
        @draw_centerd -10, 0, "ship_body_3"
        @draw_centerd 10 + @anim(0.5), 0, "ship_body_3"


export class Salmon extends Enemy
    new: (pos) =>
        super pos
        @vel = Vec2 -100, 0
        @radius = 10

    new: (pos) =>
        super pos

    update: (delta) =>
        super\update delta
        @vel = Vec2 -100, @anim 1.5, 100
        
    draw: =>
        super\draw!
        @draw_centerd 25, 0, "ship_back_3"
        @draw_centerd 0, 15, "ship_wing_1"
        @draw_centerd 0, -40, "ship_wing_1", -1, 1
        @draw_centerd 0, 0, "ship_body_1"
        @draw_centerd -5, 0, "ship_cockpit_1"


export class Whale extends Enemy
    new: (pos) =>
        super pos
        @vel = Vec2 -100, 0
        @ship_alt = math.random(1, 2)
    
    fire: =>
        @fire_sound!
        World\add_entity Shot @pos, Vec2(-2, 0), 500, @, @radius
        World\add_entity Shot @pos, Vec2(-2, -1), 500, @, @radius
        World\add_entity Shot @pos, Vec2(-2, 1), 500, @, @radius

    update: (delta) =>
        super\update delta
        @vel = Vec2 gfx.getWidth! * 2 / 3 - @pos.x, 0
        
    draw: =>
        super\draw!
        @draw_centerd @anim(1.5, 3) + 25, 0, "ship_back_1"
        @draw_centerd 0, 15, "ship_wing_2"
        @draw_centerd 0, -40, "ship_wing_2", -1, 1
        @draw_centerd 0, 0, "ship_body_2"
        @draw_centerd -5, 0, "ship_cockpit_3"

export class Eel extends Enemy
    new: (pos) =>
        super pos
        @vel = Vec2 -100, 0
        @ship_alt = math.random(1, 2)
        @fire_rate = 1

    update: (delta) =>
        super\update delta
        delta_pos = World.player.pos\sub @pos
        speed = math.min 100, delta_pos\length!
        @vel = delta_pos\normalized!\scale speed
        
    draw: =>
        super\draw!
        @draw_centerd @anim(0.5, 3) + 15, 0, "ship_back_2"
        @draw_centerd -10, 15, "ship_wing_3"
        @draw_centerd -10, -40, "ship_wing_3", -1, 1
        @draw_centerd 0, 0, "ship_body_3"
        @draw_centerd -5, 0, "ship_cockpit_2"

export class Cod extends Enemy
    new: (pos) =>
        super pos
        @vel = Vec2 -100, 0
        @ship_alt = math.random(1, 2)
        @fire_rate = 2.0
        @burst = 0
        @burst_size = 3
        @burst_spacing = 0.0

    fire: =>
        @fire_sound!
        World\add_entity Shot @pos, Vec2(-1, random_real(-1, 1)), 500, @, @radius

    try_fire: =>
        super\fire!
        if @shoottimer > 0
            return
        if @burst == 0
            @burst = @burst_size

        if @burst == 1
            @shoottimer = @fire_rate
        else
            @shoottimer = @burst_spacing
        @burst -= 1

        @fire!

    update: (delta) =>
        super\update delta
        delta_pos = World.player.pos\sub @pos
        speed = math.min 100, delta_pos\length!
        vert_vel = delta_pos\normalized!\scale speed
        @vel = Vec2 gfx.getWidth! * 2 / 3 - @pos.x, vert_vel.y
        
    draw: =>
        super\draw!
        if @ship_alt == 1
            @draw_centerd 0, 0, "ship_back_2"
            @draw_centerd 0, 0, "ship_body_1"
            @draw_centerd 0, 15, "ship_wing_3"
            @draw_centerd 0, -40, "ship_wing_3", -1, 1
        else
            @draw_centerd 10 + @anim(0.5, 3.0), 0, "ship_back_1"
            @draw_centerd 0, 0, "ship_body_3"
            @draw_centerd 0, 15, "ship_wing_3"
            @draw_centerd 0, -40, "ship_wing_3", -1, 1

export class Flounder extends Enemy
    new: (pos) =>
        super pos
        @vel = Vec2 -100, 0

    fire: =>
        @fire_sound!
        World\add_entity Shot @pos, Vec2(0, -1), 500, @, @radius
        World\add_entity Shot @pos, Vec2(0, 1), 500, @, @radius

    draw: =>
        super\draw!
        @draw_centerd 22 + @anim(0.5), 0, "ship_back_2"
        @draw_centerd  2 + @anim!, 0, "ship_back_2"
        @draw_centerd  0, 0, "ship_body_2"
        @draw_centerd -4, 0, "ship_cockpit_2"

export class Perch extends Enemy
    new: (pos) =>
        super pos

    fire: =>
        @fire_sound!
        delta_pos = World.player.pos\sub @pos
        World\add_entity Shot @pos, delta_pos, 500, @, @radius

    update: (delta) =>
        super\update delta
        @vel = Vec2 -100, @anim 1.5, 100

    draw: =>
        super\draw!
        -- Ship
        @draw_centerd -10, 0, "ship_body_2"
        @draw_centerd 10 + @anim(0.5), 0, "ship_body_3"


-- Laser if we have time! :D
-- export class Tuna extends Enemy
--     new: (pos) =>
--         super pos
-- 
--     draw: =>
--         super\draw!
--         -- Ship
--         @draw_centerd @anim!, 0, "ship_back_2"
--         @draw_centerd 0, 0, "ship_body_2"
--         @draw_centerd 10, 0, "ship_body_3"
 
