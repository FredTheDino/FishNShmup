class Vec2
    new: (x = 0, y = 0) =>
        @x = x
        @y = y

    add: (v) =>
        Vec2 @x + v.x, @y + v.y

    sub: (v) =>
        Vec2 @x - v.x, @y - v.y

    scale: (s) =>
        Vec2 @x * s, @y * s

    div: (s) =>
        Vec2 @x / s, @y / s

    length_squared: =>
        @x * @x + @y * @y

    length: =>
        math.sqrt @length_squared!

    normalized: =>
        @div @length!

{ :Vec2 }
