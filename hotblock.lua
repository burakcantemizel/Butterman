HotBlock = Entity:extend()

function HotBlock:new(x, y)
  HotBlock.super.new(self, x, y, "hotblock.png")
  
  self.strength = 100
  self.weight = 0
end