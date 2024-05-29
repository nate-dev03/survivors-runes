local inventory = {}

function inventory:load()
  self.slot_img = love.graphics.newImage("assets/inv-slot.png")
  self.slot_width = 3
  self.slot_height = 3
  self.sep = 500
  self.items = {
    love.graphics.newImage("assets/heart-rune.png"),
  }
end

function inventory:update(dt)
end

function inventory:add_item(item)
  table.insert(self.items, item)
end

function inventory:draw()
  for i=1,self.slot_width do
    for j=1,self.slot_height do
      love.graphics.draw(self.slot_img, i*64+10, j*64, nil, 3, 3)
    end
  end
  for k, item in ipairs(self.items) do
    love.graphics.draw(item, 1*64+20, 1*64+10, nil, 3, 3)
  end
end

return inventory
