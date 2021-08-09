local player = {}

function love.load()
  player.x = 0
  player.y = 0
  player.weight = 30
  player.height = 30
  player.speed = 100
end

function love.update(dt)
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("w") then
    player.y = player.y - player.speed * dt
  end
  if love.keyboard.isDown("s") then
    player.y = player.y + player.speed * dt
  end
end

function love.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.weight, player.height)
end