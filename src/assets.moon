export class Assets
    @assets = {}

    @load: =>
        @load_img("bg_cloud_1.png")
        @load_img("bg_cloud_2.png")
        @load_img("bg_cloud_3.png")
        @load_img("bg_cloud_4.png")
        @load_img("bg_part_1.png")
        @load_img("bg_part_2.png")
        @load_img("bg_part_3.png")
        @load_img("bg_part_4.png")
        @load_img("bg_part_5.png")
        @load_img("bullet_1.png")
        @load_img("bullet_2.png")
        @load_img("bullet_3.png")
        @load_img("bullet_4.png")
        @load_img("bullet_5.png")
        @load_img("dmg_part_1.png")
        @load_img("dmg_part_2.png")
        @load_img("dmg_part_3.png")
        @load_img("dmg_part_4.png")
        @load_img("dmg_part_5.png")
        @load_img("float.png")
        @load_img("laser_1.png")
        @load_img("laser_1_part_1.png")
        @load_img("laser_1_part_2.png")
        @load_img("laser_1_part_3.png")
        @load_img("laser_1_part_4.png")
        @load_img("laser_2.png")
        @load_img("laser_2_part_1.png")
        @load_img("laser_2_part_2.png")
        @load_img("laser_2_part_3.png")
        @load_img("laser_2_part_4.png")
        @load_img("missile.png")
        @load_img("rod.png")
        @load_img("shield.png")
        @load_img("ship.png")
        @load_img("ship_back_1.png")
        @load_img("ship_back_2.png")
        @load_img("ship_back_3.png")
        @load_img("ship_body_1.png")
        @load_img("ship_body_2.png")
        @load_img("ship_body_3.png")
        @load_img("ship_cockpit_1.png")
        @load_img("ship_cockpit_2.png")
        @load_img("ship_cockpit_3.png")
        @load_img("ship_wing_1.png")
        @load_img("ship_wing_2.png")
        @load_img("ship_wing_3.png")
        @load_img("tmp_engine.png")
        @load_img("water_bg.png")
        @load_img("water_part_1.png")
        @load_img("water_part_2.png")
        @load_img("water_part_3.png")

        -- TODO(ed): Load this stuff
        -- @load_sfx("laser_sound.wav")

        larger_font = love.graphics.newFont 20
        love.graphics.setFont larger_font

    @load_img: (name) =>
        img = love.graphics.newImage name
        img\setFilter "nearest", "nearest"
        @load_ass name, img

    @load_ass: (name, a) =>
        assert @@assets[name] == nil, "Loading asset "..name.." twice!"
        @@assets[name] = a

    @get: (name) =>
        assert @@assets[name], "Invalid asset name "..name.."."
        @@assets[name]
