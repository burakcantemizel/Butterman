SugarGirl = Entity:extend()

function SugarGirl:new(x,y)
HotBlock.super.new(self, x, y, "sugargirlleft.png")
  
  self.strength = 100
  self.weight = 0
end
