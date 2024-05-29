local player = {}
Vector = require("libs.vector")
local anim8 = require("libs.anim8")

function player:load()
  self.image = love.graphics.newImage("assets/hero1.png")
  local grid = anim8.newGrid(16, 16, self.image:getWidth(), self.image:getHeight())
  self.anims = {
    idle_down = anim8.newAnimation(grid('1-3', 1), 0.1),
    idle_left = anim8.newAnimation(grid('1-3', 2), 0.1):flipH(),
    idle_right = anim8.newAnimation(grid('1-3', 2), 0.1),
    idle_up = anim8.newAnimation(grid('1-3', 3), 0.1),
    run_down = anim8.newAnimation(grid('1-4', 4), 0.1),
    run_left = anim8.newAnimation(grid('1-4', 5), 0.1):flipH(),
    run_right = anim8.newAnimation(grid('1-4', 5), 0.1),
    run_up = anim8.newAnimation(grid('1-4', 6), 0.1),
  }

  self.current_anim = self.anims['idle_down']

  self.vel = Vector(0, 0)
  self.speed = 120
  self.pos = Vector(300, 300)  -- Correctly initializing pos
  self.facing_left = false  -- Variable to track facing direction
end

function player:update(dt)
  self.current_anim:update(dt)

  -- Movement logic
  if love.keyboard.isDown("a") then
    self.vel.x = -self.speed * dt
    self.facing = 'left'
    self.current_anim = self.anims['run_left']
  elseif love.keyboard.isDown("d") then
    self.vel.x = self.speed * dt
    self.facing = 'right'
    self.current_anim = self.anims['run_right']
  else
    self.vel.x = 0
    if self.facing == 'left' then
      self.current_anim = self.anims['idle_left']
    elseif self.facing == 'right' then
      self.current_anim = self.anims['idle_right']
    end
  end

  if love.keyboard.isDown("w") then
    self.vel.y = -self.speed * dt
    self.facing = 'up'
    self.current_anim = self.anims['run_up']
  elseif love.keyboard.isDown("s") then
    self.vel.y = self.speed * dt
    self.facing = 'down'
    self.current_anim = self.anims['run_down']
  else
    self.vel.y = 0
    if self.facing == 'up' then
      self.current_anim = self.anims['idle_up']
    elseif self.facing == 'down' then
      self.current_anim = self.anims['idle_down']
    end
  end

  self.pos = self.pos + self.vel
end

function player:draw()
  self.current_anim:draw(self.image, self.pos.x, self.pos.y, nil, 2, 2)
end

return player

