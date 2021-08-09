local key_event = require "keyevent"
local player = {}

function love.load()
  player.x = 0
  player.y = 0
  player.weight = 30
  player.height = 30
  player.speed = 100
end

function love.update(dt)
  key_event(player, dt)
end

function love.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.weight, player.height)
end