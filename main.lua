local key_event = require "keyevent"
local restart_event = require "restart_event"
local checkCollision = require "checkCollision"
local player = {}
local enemys = {}
local foods = {}
local projectiles={}
local time = 0

local gameover = false

function init()
  player.x = 500/2 - 15
  player.y = 500 - 30
  player.width = 30
  player.height = 30
  player.speed = 100
  enemys = {}
  foods = {}
  projectiles={}
  time = 0
  gameover = false
end

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
  init()
  local font = love.graphics.newFont(100, "mono", 10)
  gameoverText = love.graphics.newText(font, "Game Over")
end

function love.update(dt)
  if gameover == false then
    time = time + 1
    
    if time % 100 == 0 then
      make_a_enemy()
    end
    if time % 300 == 0 then
      make_a_food()
    end
    
    for i,v in ipairs(enemys) do
      v.y = v.y + 100 * dt
      if checkCollision(player,v) then
        gameover = true
      end
    end
    for i,v in ipairs(foods) do
      v.y = v.y + 100 * dt
    end
    for i,v in ipairs(projectiles) do
      v.y = v.y - v.speed * dt
      for ii,vv in ipairs(enemys) do
        if checkCollision(v,vv) then
          table.remove(projectiles,i)
          table.remove(enemys,ii)
        end
      end
    end
    
    key_event(player, dt ,make_a_projectile)
  end
  
  if gameover == true then
    if restart_event then
      print(restart_event)
    else
      print('nil')
    end
    restart_event(init)
  end
  
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  for i,v in ipairs(enemys) do
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
  end
  for i,v in ipairs(foods) do
    love.graphics.setColor(50, 200, 50)
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
  end
  for i,v in ipairs(projectiles) do
    love.graphics.setColor(50, 200, 50)
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
  end
  
  if gameover == true then
    love.graphics.draw(gameoverText, 100, 100)
  end
end