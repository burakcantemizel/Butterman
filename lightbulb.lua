LightBulb = Object:extend()

function LightBulb:new(x,y)
  self.x = x
  self.y = y
  self.image = love.graphics.newImage("lightbulb.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function LightBulb:draw()
    love.graphics.draw(self.image, self.x, self.y,0,1,1,self.width/2,self.height/2)
end