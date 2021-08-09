function love.load()
  x = 0
end

function love.update(dt)
  x = x + 100 * dt
end

function love.draw()
    love.graphics.rectangle("fill", x,10,30,30)
end