local key_event = require "keyevent"
local player = {}
local enemys = {}
local foods = {}
local projectiles={}
local time = 0


function make_a_enemy()
  local enemy = {}
  enemy.x = math.random(100, 500)
  enemy.y = 0
  enemy.width = 50
  enemy.height = 50
  table.insert(enemys, enemy)
end

function make_a_food()
  local food = {}
  food.x = math.random(100, 500)
  food.y = 0
  food.width = 50
  food.height = 50
  table.insert(foods, food)
end

function make_a_projectile()
  local projectile = {}
  projectile.x = player.x + player.width/2 - 5
  projectile.y = player.y
  projectile.width = 10
  projectile.height = 10
  projectile.speed = 300
  table.insert(projectiles, projectile)
end

function love.load()
  player.x = 500/2 - 15
  player.y = 500 - 30
  player.width = 30
  player.height = 30
  player.speed = 100
end

function love.update(dt)
  time = time + 1
  
  if time % 100 == 0 then
    make_a_enemy()
  end
  if time % 300 == 0 then
    make_a_food()
  end
  
  key_event(player, dt ,make_a_projectile)
  for i,v in ipairs(enemys) do
    print(i, v)
    v.y = v.y + 100 * dt
  end
  for i,v in ipairs(foods) do
    print(i, v)
    v.y = v.y + 100 * dt
  end
  for i,v in ipairs(projectiles) do
    print(i, v)
    v.y = v.y - v.speed * dt
  end
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  for i,v in ipairs(enemys) do
    print(i, v)
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
  end
  for i,v in ipairs(foods) do
    print(i, v)
    love.graphics.setColor(50, 200, 50)
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
  end
  for i,v in ipairs(projectiles) do
    print(i, v)
    love.graphics.setColor(50, 200, 50)
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
  end
end