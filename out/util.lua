do
  local _class_0
  local _base_0 = {
    add = function(self, v)
      return Vec2(self.x + v.x, self.y + v.y)
    end,
    sub = function(self, v)
      return Vec2(self.x - v.x, self.y - v.y)
    end,
    scale = function(self, s)
      return Vec2(self.x * s, self.y * s)
    end,
    div = function(self, s)
      return Vec2(self.x / s, self.y / s)
    end,
    length_squared = function(self)
      return self.x * self.x + self.y * self.y
    end,
    length = function(self)
      return math.sqrt(self:length_squared())
    end,
    normalized = function(self)
      return self:div(self:length())
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y)
      if x == nil then
        x = 0
      end
      if y == nil then
        y = 0
      end
      self.x = x
      self.y = y
    end,
    __base = _base_0,
    __name = "Vec2"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Vec2 = _class_0
end
overlap = function(xa, ya, ra, xb, yb, ca)
  return overlap_v(Vec2(xa, ya), ra, Vec2(xb, yb), ca)
end
overlap_v = function(ca, ra, cb, rb)
  local dist = (ca:sub(cb)):length_squared()
  local radi = (ra + rb) * (ra + rb)
  return dist <= radi
end
random_real = function(lo, hi)
  return (hi - lo) * math.random() + lo
end
return {
  Vec2 = Vec2,
  overlap = overlap,
  overlap_v = overlap_v,
  random_real = random_real
}
