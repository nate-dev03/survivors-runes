local lg = love.graphics
local Camera = require("libs.camera")
local player = require('player')
local inventory = require('inventory')

GameState = {
  PLAYING=1, PAUSE=2
}

function love.load()
  lg.setDefaultFilter("nearest", "nearest")
  player:load()

  _G.globalScaleFactor = 2

  _G.runes = {
    heal = lg.newImage("assets/heart-rune.png"),
    lighting = lg.newImage("assets/lighting-rune.png"),
    protection = lg.newImage("assets/protection-rune.png"),
  }

  _G.pedestal = lg.newImage('assets/rune-holder.png')

  _G.camera = Camera(player.pos.x, player.pos.y, 2) -- Adjusted to use player.pos.x and player.pos.y

  inventory:load()
  _G.inv_drawn = false

  inventory:add_item(_G.runes['heal'])
end

function love.update(dt)

  player:update(dt)

  local dx = player.pos.x - camera.x
  local dy = player.pos.y - camera.y
  camera:move(dx / 2, dy / 2)
end

function love.keypressed(key)
  if key == "f" then
    _G.inv_drawn = not _G.inv_drawn  -- Toggle inventory visibility
  end
end

function love.wheelmoved(x, y)
  if y > 0 and camera.scale < 3.0 then
    camera:zoom(1.3)
  elseif y < 0 and camera.scale > 0.1 then
    camera:zoom(0.9)
  end
end


function love.draw()
  lg.setBackgroundColor(love.math.colorFromBytes(155, 155, 155))

  camera:attach()

  lg.draw(pedestal, 100, 107, 0, globalScaleFactor, globalScaleFactor)
--lg.draw(runes.heal, 103, 106, 0, globalScaleFactor, globalScaleFactor) -- Explicitly setting rotation to 0

  lg.draw(pedestal, 150, 107, 0, globalScaleFactor, globalScaleFactor)
 -- lg.draw(runes.protection, 153, 106, 0, globalScaleFactor, globalScaleFactor) -- Explicitly setting rotation to 0

  player:draw()

  camera:detach()

  if inv_drawn then
    inventory:draw()
  end
end

