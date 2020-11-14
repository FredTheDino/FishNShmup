local Entity, World
do
  local _obj_0 = require("world")
  Entity, World = _obj_0.Entity, _obj_0.World
end
scroll_speed = 10
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self, gfx)
      gfx.circle("line", self.pos.x, self.pos.y, self.radius, 20)
      return gfx.aslkdja
    end,
    update = function(self, delta)
      self.pos = self.pos:add(Vec2(-scroll_speed, 0):scale(delta / self.depth))
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, kind, pos, depth)
      _class_0.__parent.__init(self)
      self.pos = pos
      self.depth = depth
      self.kind = kind
    end,
    __base = _base_0,
    __name = "BGItem",
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
  BGItem = _class_0
end
