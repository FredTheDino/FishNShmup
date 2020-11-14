local Vec2
Vec2 = require("util").Vec2
local Entity, World
do
  local _obj_0 = require("world")
  Entity, World = _obj_0.Entity, _obj_0.World
end
local Player
local Enemy
local keyboard = love.keyboard
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self, gfx)
      gfx.setColor(0, 0, 255)
      return gfx.circle("fill", self.pos.x, self.pos.y, self.radius, 20)
    end,
    update = function(self, delta)
      self.pos = self.pos:add(self.vel:scale(delta))
      World:test_collision(self)
      self.lifetime = self.lifetime - 1
      if self.lifetime < 0 then
        self.alive = false
      end
    end,
    on_collision = function(self, other)
      self.alive = false
      if other.__class == Player then
        other.alive = false
      end
      if other.__class == Enemy then
        other.alive = false
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, pos, dir, vel, offset)
      if offset == nil then
        offset = 0
      end
      _class_0.__parent.__init(self)
      self.radius = 10
      self.lifetime = 200
      self.pos = pos:add(dir:scale(offset + self.radius))
      self.vel = dir:normalized():scale(vel)
    end,
    __base = _base_0,
    __name = "Shot",
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
  Shot = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self, gfx)
      gfx.setColor(255, 0, 0)
      return gfx.circle("fill", self.pos.x, self.pos.y, self.radius, 20)
    end,
    fire = function(self)
      self.shoottimer = self.fire_rate
      return World:add_entity(Shot(self.pos, Vec2(1, 0), 500, self.radius + 5))
    end,
    update = function(self, delta)
      local dpos = Vec2()
      if keyboard.isDown("a") then
        dpos.x = dpos.x + -1
      end
      if keyboard.isDown("w") then
        dpos.y = dpos.y + -1
      end
      if keyboard.isDown("s") then
        dpos.y = dpos.y + 1
      end
      if keyboard.isDown("d") then
        dpos.x = dpos.x + 1
      end
      self.shoottimer = self.shoottimer - delta
      if self.shoottimer < 0 and keyboard.isDown("space") then
        self:fire()
      end
      self.pos = self.pos:add(dpos:scale(delta * self.speed))
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      _class_0.__parent.__init(self)
      self.pos = Vec2()
      self.speed = 256
      self.shoottimer = 0
      self.fire_rate = 0.2
    end,
    __base = _base_0,
    __name = "Player",
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
  Player = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self, gfx)
      gfx.setColor(255, 0, 255)
      return gfx.circle("fill", self.pos.x, self.pos.y, self.radius, 20)
    end,
    update = function(self, delta)
      self.pos = self.pos:add(self.vel:scale(delta))
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, pos, vel)
      _class_0.__parent.__init(self)
      self.pos = pos
      self.vel = vel
    end,
    __base = _base_0,
    __name = "Enemy",
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
  Enemy = _class_0
end
return {
  Player = Player,
  Enemy = Enemy
}