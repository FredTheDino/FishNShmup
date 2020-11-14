local Shot
Shot = require("player").Shot
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    fire = function(self) end,
    damage = function(self, dmg)
      self.health = self.health - dmg
      if self.health < 0 then
        self.alive = false
      end
    end,
    draw = function(self, gfx)
      gfx.setColor(255, 0, 255)
      return gfx.circle("fill", self.pos.x, self.pos.y, self.radius, 20)
    end,
    update = function(self, delta)
      self.pos = self.pos:add(self.vel:scale(delta))
      self.shoottimer = self.shoottimer - delta
      return self:fire()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, pos, vel)
      _class_0.__parent.__init(self)
      self.pos = pos
      self.vel = vel
      self.fire_rate = 0.2
      self.shoottimer = 0
      self.health = 3
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
do
  local _class_0
  local _parent_0 = Enemy
  local _base_0 = {
    fire = function(self)
      if self.shoottimer > 0 then
        return 
      end
      self.shoottimer = self.fire_rate
      return World:add_entity(Shot(self.pos, Vec2(-1, 0), 500, self.radius + 5))
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "ShootingEnemy",
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
  ShootingEnemy = _class_0
end
return {
  ShootingEnemy = ShootingEnemy
}
