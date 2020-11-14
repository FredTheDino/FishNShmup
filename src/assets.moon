export class Assets
    @assets = {}

    @load: =>
        @load_img("ship.png")

    @load_img: (name) =>
        @load_ass name, love.graphics.newImage "ship.png"

    @load_ass: (name, a) =>
        @@assets[name] = a

    @get: (name) =>
        assert @@assets[name], "Invalid asset name "..name.."."
        @@assets[name]

{ :Assets }
