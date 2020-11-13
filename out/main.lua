local add
add = require("other").add
love.load = function(arg) end
love.update = function(dt)
  return print(add(1, 2))
end
love.draw = function()
  return love.graphics.rectangle("fill", 10, 10, 100, 100)
end
