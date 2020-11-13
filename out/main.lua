local Vec2
Vec2 = require("util").Vec2
love.load = function(arg) end
love.update = function(dt)
  return print("hej")
end
love.draw = function()
  return love.graphics.rectangle("fill", 10, 10, 100, 100)
end
