function love.load()
  x = 0
  y = 0
end

function love.update(dt)
  if love.keyboard.isDown("d") then
    x = x + 100 * dt
  end
  if love.keyboard.isDown("a") then
    x = x - 100 * dt
  end
  if love.keyboard.isDown("w") then
    y = y - 100 * dt
  end
  if love.keyboard.isDown("s") then
    y = y + 100 * dt
  end
end

function love.draw()
    love.graphics.rectangle("fill", x, y, 30, 30)
end