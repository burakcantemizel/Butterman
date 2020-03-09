local Lib = require 'light'
local light_world = Lib.World.new()
local light


function love.load()
  --light = light_world:add(200, 200, 200, 1, 0, 0)
  
  Object = require("classic")
  require("entity")
  require("player")
  require("wall")
  require("box")
  require("hotblock")
  require("maps")
  require("lights")
  require("lightbulb")
  require("sugargirl")
  
  player = Player(128,128)
  
  objects = {}
  table.insert(objects, player)
  
  walls = {}
  
  butters = {}
  lightbulbs = {}
  
  camShakeDuration = 0
  
  --light = light_world:add(480,600,400,1,1,1)
  --light.x = 1280/4
  --light.y = 640/3
  for i,v in ipairs(map1) do
    for j,w in ipairs(v) do
      if w == 1 then
        table.insert(walls,Wall(32+(j-1)*64,32+(i-1)*64))
      elseif w == 2 then
        table.insert(objects,Box(32+(j-1)*64, 32+(i-1)*64))
      elseif w == 3 then
        table.insert(walls,HotBlock(32+(j-1)*64, 32+(i-1)*64))
        light = light_world:add(1280,640,250,1,0,0)
        light.x = 32+(j-1)*64
        light.y = 32+(i-1)*64
      elseif w == 4 then
        table.insert(lightbulbs,LightBulb(32+(j-1)*64,32+(i-1)*64))
        light = light_world:add(1280,640,200,1,1,1)
        light.x = 32+(j-1)*64
        light.y = 32+(i-1)*64
      elseif w == 5 then
        table.insert(walls,SugarGirl(32+(j-1)*64, 32+(i-1)*64))
      end
    end
  end

end

function love.update(dt)
  --light.x, light.y = love.mouse.getPosition()
  
  if camShakeDuration > 0 then
    camShakeDuration = camShakeDuration - dt
  end
  
  if player:isMoved() then
    player:beSmall(0.05)
  end
  
  for i,v in ipairs(objects) do
     v:update(dt)
  end
  
  for i,v in ipairs(walls) do
    v:update(dt)
  end
  
  local loop = true
  local limit = 0
  
  while loop do
    loop = false
    limit = limit + 1
    
    if limit > 100 then
      break
    end
  
    for i=1,#objects-1 do
      for j=i+1,#objects do
        local collision = objects[i]:resolveCollision(objects[j])
        if collision then
          loop = true
        end
      end
    end
    
    for i,wall in ipairs(walls) do
      for j,object in ipairs(objects) do
        local collision = object:resolveCollision(wall)
        if collision then
          loop = true
        end
      end
    end
    
    
    end
  
  if player.width < 10 then
    light_world:clear()
    love.load()
  end
  
end

function love.draw()
  
  --love.graphics.translate(-player.x+1280/2,-player.y+640/2)
  light_world:begin()
  
  if camShakeDuration > 0 then
    love.graphics.translate(love.math.random(-5,5), love.math.random(-5,5))
  end
  
  love.graphics.setBackgroundColor(0.2,0.2,0.2)
  
  for i,v in ipairs(objects) do
    v:draw()
  end
  
  for i,v in ipairs(walls) do
    v:draw()
  end
  
  for i,v in ipairs(lightbulbs) do
    v:draw()
  end
  
  for i,v in ipairs(butters) do
    love.graphics.setColor(1,1,0)
    love.graphics.line(v.x1,v.y1,v.x2,v.y2)
    love.graphics.setColor(1,1,1)
  end
  
    
  --gui
  drawGui()
  
  light_world:finish()
end

function love.keypressed(key)
  if key == "up" then
    player:jump()
  end
  
  if key == "down" then
    --player:beSmall(1)
  end
end


function drawGui()
  love.graphics.setColor(1,1,1)
  love.graphics.print("'A' ve 'D' tuşları ile hareket et ve 'W' ile zıpla.", 185, 300)
  love.graphics.print("Sen bir margarinsin ve hareket ettikçe erirsin!",180, 320)
end

