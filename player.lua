Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, "playerright.png")
  self.image2 = love.graphics.newImage("playerleft.png")
  self.acceleration = 10
  self.speed = 0
  self.horizontalDirection = 1
  self.strength = 10
  
  self.canJump = false
  self.size = 1.0
end

function Player:update(dt)
  Player.super.update(self, dt)
  self:move(dt)
  
  if self.last.y ~= self.y then
    self.canJump = false
    
    if self.last.x ~= self.x then
      
    end
    
  end
end


function Player:draw()
  
  
  love.graphics.push()
    love.graphics.translate(-self.width/2,-self.height/2)
    if self.horizontalDirection == 1 then
    love.graphics.draw(self.image, self.x, self.y, 0, self.width / 64, self.height / 128, 0, 0)
    elseif self.horizontalDirection == -1 then
    love.graphics.draw(self.image2, self.x, self.y, 0, self.width / 64 , self.height / 128, 0, 0)
    end
  love.graphics.pop()
  
  
  --love.graphics.rectangle("line", self.x - self.width/2, self.y - self.height/2, self.width, self.height)
end


function Player:move(dt)
  if love.keyboard.isDown("left") then
    --self.x = self.x - self.speed * dt
    self.acceleration = self.acceleration + 15
    self.horizontalDirection = -1
  elseif love.keyboard.isDown("right") then
    --self.x = self.x + self.speed * dt
    self.acceleration = self.acceleration + 15
    self.horizontalDirection = 1
  end
    
    --print(self.acceleration)
    self.acceleration = self.acceleration - 2
    if self.acceleration <= 0 then
      self.acceleration = 0
    elseif self.acceleration >= 200 then
      self.acceleration = 200
    end
  self.speed = self.acceleration
  self.x = self.x + self.horizontalDirection *self.speed * dt
end

function Player:jump()
  if self.canJump then
    self.gravity = -300
    self.canJump = false
  end
end

function Player:collide(e,direction)
  Player.super.collide(self, e, direction)
  
  if direction == "bottom" then
    self.canJump = true
    
    --love.graphics.setColor(1,1,0)
    --love.graphics.line(e.x - e.width/2, e.y - e.height/2, e.x + e.width/2, e.y - e.height/2)
    
    if e:is(Wall) then
    local butter = {}
    butter.x1 = e.x - e.width/2
    butter.x2 = e.x + e.width/2
    butter.y1 = e.y - e.height/2
    butter.y2 = e.y - e.height/2
    table.insert(butters, butter)
    end
    
  end

  if e:is(HotBlock) then
      self:beSmall(2)
      camShakeDuration = 0.3
  end
  
  
end


function Player:beSmall(pscaleFactor)
  --self.x self.y tutacak o anki self.x ve self.y last olcak yenilerini hesaplayacak
  self.last.x = self.x
  self.last.y = self.y
  
  self.x = self.x
  local scaleFactor = pscaleFactor
  local tempHeight = self.height
  local tempWidth = self.width
  self.width = self.width - scaleFactor
  self.height = self.height - (scaleFactor *2)
  --self.y = self.y + tempHeight/4
  --self.x = self.x + tempWidth/4
  --self.y = self.y + (2 * self.height/2)
end

function Player:isMoved()
  if love.keyboard.isDown("left") or love.keyboard.isDown("right") then
    return true
  else
    return false
  end
end