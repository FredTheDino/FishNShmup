local Entity
Entity = require("world").Entity
local random_real
random_real = require("util").random_real
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self, gfx)
      gfx.setColor(0, 255, 255)
      return gfx.circle("fill", self.pos.x, self.pos.y, 10, 20)
    end,
    update = function(self, delta)
      self.pos = self.pos:add(self.dir:scale(delta * 100))
    end,
    on_collision = function(self)
      self.alive = false
      return print("item picked up")
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      _class_0.__parent.__init(self)
      self.pos = Vec2(600, 300)
      math.randomseed(os.time())
      self.dir = (Vec2(random_real(-1, -0.5), random_real(-1, 1))):normalized()
    end,
    __base = _base_0,
    __name = "Item",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Item = _class_0
end
return {
  Item = Item
}
