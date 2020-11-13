local overlap_v
overlap_v = require("util").overlap_v
local keyboard = love.keyboard
local gfx = love.graphics
local entity_overlap
entity_overlap = function(a, b)
  return overlap_v(a.pos, a.radius, b.pos, b.radius)
end
do
  local _class_0
  local _base_0 = {
    draw = function(self, gfx)
      gfx.setColor(0, 255, 0)
      return gfx.circle("fill", self.pos.x, self.pos.y, 20, 20)
    end,
    update = function(self, delta)
      if keyboard.isDown("f") then
        print("F")
        self.alive = false
      end
    end,
    on_collision = function(self, other) end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.pos = Vec2(200, 200)
      self.radius = 32
      self.alive = true
    end,
    __base = _base_0,
    __name = "Entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Entity = _class_0
end
do
  local _class_0
  local _base_0 = { }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "World"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.entities = { }
  self.draw = function(self, gfx)
    local _list_0 = self.__class.entities
    for _index_0 = 1, #_list_0 do
      local e = _list_0[_index_0]
      if e.alive then
        e:draw(gfx)
      end
    end
  end
  self.update = function(self, delta)
    local _list_0 = self.__class.entities
    for _index_0 = 1, #_list_0 do
      local e = _list_0[_index_0]
      if e.alive then
        e:update(delta)
      end
    end
    return self.__class:filter_alive()
  end
  self.filter_alive = function(self)
    do
      local _accum_0 = { }
      local _len_0 = 1
      local _list_0 = self.__class.entities
      for _index_0 = 1, #_list_0 do
        local e = _list_0[_index_0]
        if e.alive then
          _accum_0[_len_0] = e
          _len_0 = _len_0 + 1
        end
      end
      self.__class.entities = _accum_0
    end
  end
  self.add_entity = function(self, e)
    return table.insert(self.__class.entities, e)
  end
  self.test_collision = function(self, a)
    local _list_0 = self.__class.entities
    for _index_0 = 1, #_list_0 do
      local _continue_0 = false
      repeat
        local b = _list_0[_index_0]
        if a == b then
          _continue_0 = true
          break
        end
        if entity_overlap(a, b) then
          a:on_collision(b)
          b:on_collision(a)
        end
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    return self.__class:filter_alive()
  end
  World = _class_0
end
return {
  Entity = Entity,
  World = World
}
