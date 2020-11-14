do
  local _class_0
  local _base_0 = { }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "Assets"
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
  self.assets = { }
  self.load = function(self)
    return self:load_img("ship.png")
  end
  self.load_img = function(self, name)
    return self:load_ass(name, love.graphics.newImage("ship.png"))
  end
  self.load_ass = function(self, name, a)
    self.__class.assets[name] = a
  end
  self.get = function(self, name)
    assert(self.__class.assets[name], "Invalid asset name " .. name .. ".")
    return self.__class.assets[name]
  end
  Assets = _class_0
end
return {
  Assets = Assets
}
