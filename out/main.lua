local Vec2, overlap, overlap_v
do
  local _obj_0 = require("util")
  Vec2, overlap, overlap_v = _obj_0.Vec2, _obj_0.overlap, _obj_0.overlap_v
end
local Player
Player = require("player").Player
gfx = love.graphics
local player = Player()
local Circle
do
  local _class_0
  local _base_0 = {
    overlap = function(self, cb)
      return overlap_v(self.pos, self.r, cb.pos, cb.r)
    end,
    draw = function(self, r, g, b)
      gfx.setColor(r, g, b)
      return gfx.circle("fill", self.pos.x, self.pos.y, self.r, 20)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, r)
      self.pos = Vec2(x, y)
      self.r = r
    end,
    __base = _base_0,
    __name = "Circle"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Circle = _class_0
end
love.load = function(arg) end
love.update = function(dt)
  return player:update(dt)
end
love.draw = function()
  local t = love.timer.getTime()
  local a = Circle(100, 100, math.sin(t) * 30)
  local b = Circle(120, 100, math.sin(t) * 30)
  player:draw(gfx)
  if a:overlap(b) then
    a:draw(100, 0, 0)
    return b:draw(100, 0, 0)
  else
    a:draw(0, 100, 100)
    return b:draw(100, 0, 100)
  end
end