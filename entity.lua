Entity = Object:extend()

function Entity:new(x, y, image_path)
  self.x = x
  self.y = y
  self.image = love.graphics.newImage(image_path)
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  
  self.last = {}
  self.last.x = self.x
  self.last.y = self.y
  
  
  self.strength = 0
  self.tempStrength = 0
  
  self.gravity = 0
  self.weight = 400
end

function Entity:update(dt)
  self.last.x = self.x
  self.last.y = self.y
  
  self.tempStrength = self.strength
  
  self.gravity = self.gravity + self.weight * dt
  self.y = self.y + self.gravity * dt
end

function Entity:draw()
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.width/2, self.height/2)
end

function Entity:checkCollision(e)
  return self.x + self.width/2 > e.x - e.width/2
  and self.x - self.width/2 < e.x + e.width/2
  and self.y + self.height/2 > e.y - e.height/2
  and self.y - self.height/2 < e.y + e.height/2
end

function Entity:wasVerticallyAligned(e)
  return self.last.y - self.height/2 < e.last.y + e.height/2
  and self.last.y + self.height/2 > e.last.y - e.height/2
end

function Entity:wasHorizontallyAligned(e)
  return self.last.x - self.width/2 < e.last.x + e.width/2
  and self.last.x + self.width/2 > e.last.x - e.width/2
end

function Entity:resolveCollision(e)
  
  if self.tempStrength > e.tempStrength then
    return e:resolveCollision(self)
  end
  
  if self:checkCollision(e) then
    self.tempStrength = e.tempStrength
    
      if self:wasVerticallyAligned(e) then
        if self.x < e.x then
          self:collide(e,"right")
        else
          self:collide(e,"left")
        end
      elseif self:wasHorizontallyAligned(e) then
        if self.y < e.y then
          self:collide(e,"bottom")
        else
          self:collide(e,"top")
        end
      end
      
      return true
  end
    
    return false
end

function Entity:collide(e, direction)
  if direction == "right" then
    local pushback = self.x + self.width/2 - (e.x - e.width/2)
          self.x = self.x - pushback
  elseif direction == "left" then
    local pushback = e.x + e.width/2 - (self.x - self.width/2)
          self.x = self.x + pushback
  elseif direction == "bottom" then
    self.gravity = 0
    local pushback = self.y + self.height/2 - (e.y - e.height/2)
          self.y = self.y - pushback
          
  elseif direction == "top" then
    local pushback = e.y + e.height/2 - (self.y - self.height/2)
          self.y = self.y + pushback
  end
end