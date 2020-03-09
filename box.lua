Box = Entity:extend()

function Box:new(x, y)
  Box.super.new(self, x, y, "box.png")
  
  self.strength = 1
end