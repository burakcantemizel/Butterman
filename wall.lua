Wall = Entity:extend()

function Wall:new(x,y)
  Wall.super.new(self, x, y, "wall.png")
  
  self.strength = 100
  self.weight = 0
end

--[[
function Wall:collide(e, direction)
  Wall.super.collide(self,e,direction)
  print("test")
  if direction == "top" then
    love.graphics.print("okey",100,100)
    love.graphics.line(self.x - self.width/2, -50 +self.y - self.height/2, self.x + self.width/2, -50 +self.y - self.height/2 )
  end
end
--]]