export class Assets
    @assets = {}

    @load: =>
        @load_img("bg_cloud_1")
        @load_img("bg_cloud_2")
        @load_img("bg_cloud_3")
        @load_img("bg_cloud_4")
        @load_img("bg_part_1")
        @load_img("bg_part_2")
        @load_img("bg_part_3")
        @load_img("bg_part_4")
        @load_img("bg_part_5")
        @load_img("bullet_1")
        @load_img("bullet_2")
        @load_img("bullet_3")
        @load_img("bullet_4")
        @load_img("bullet_5")
        @load_img("dmg_part_1")
        @load_img("dmg_part_2")
        @load_img("dmg_part_3")
        @load_img("dmg_part_4")
        @load_img("dmg_part_5")
        @load_img("float")
        @load_img("laser_1")
        @load_img("laser_1_part_1")
        @load_img("laser_1_part_2")
        @load_img("laser_1_part_3")
        @load_img("laser_1_part_4")
        @load_img("laser_2")
        @load_img("laser_2_part_1")
        @load_img("laser_2_part_2")
        @load_img("laser_2_part_3")
        @load_img("laser_2_part_4")
        @load_img("missile")
        @load_img("rod")
        @load_img("shield")
        @load_img("ship")
        @load_img("ship_back_1")
        @load_img("ship_back_2")
        @load_img("ship_back_3")
        @load_img("ship_body_1")
        @load_img("ship_body_2")
        @load_img("ship_body_3")
        @load_img("ship_cockpit_1")
        @load_img("ship_cockpit_2")
        @load_img("ship_cockpit_3")
        @load_img("ship_wing_1")
        @load_img("ship_wing_2")
        @load_img("ship_wing_3")
        @load_img("tmp_engine")
        @load_img("water_bg")
        @load_img("water_part_1")
        @load_img("water_part_2")
        @load_img("water_part_3")

        @load_sound("laser_sound.wav") --friendly
        @load_sound("pewpew.wav") --enemy

        larger_font = love.graphics.newFont 20
        love.graphics.setFont larger_font

    @load_img: (name) =>
        img = love.graphics.newImage name..".png"
        img\setFilter "nearest", "nearest"
        @load_ass name, img

    @load_sound: (name) =>
        sound = love.sound.newSoundData name
        @load_ass name, sound

    @load_ass: (name, a) =>
        assert @@assets[name] == nil, "Loading asset "..name.." twice!"
        @@assets[name] = a

    @get: (name) =>
        assert @@assets[name], "Invalid asset name "..name.."."
        @@assets[name]
