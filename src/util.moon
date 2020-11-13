export *

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

overlap = (xa, ya, ra, xb, yb, ca) ->
    overlap_v Vec2(xa, ya), ra, Vec2(xb, yb), ca

overlap_v = (ca, ra, cb, rb) ->
    dist = (ca\sub cb)\length_squared!
    radi = (ra + rb) * (ra + rb)
    dist <= radi

{ :Vec2, :overlap, :overlap_v }
