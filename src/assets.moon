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
        @load_img("ship.png")

    @load_img: (name) =>
        @load_ass name, love.graphics.newImage name

    @load_ass: (name, a) =>
        assert @@assets[name] == nil, "Loading asset "..name.." twice!"
        @@assets[name] = a

    @get: (name) =>
        assert @@assets[name], "Invalid asset name "..name.."."
        @@assets[name]

{ :Assets }
