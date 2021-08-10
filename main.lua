local key_event = require "keyevent"
local restart_event = require "restart_event"
local checkCollision = require "checkCollision"
local player = {}
local enemys = {}
local foods = {}
local projectiles = {}
local time = 0
local score = 0

local gameover = false

local can_make_projectile = 0

function init()
    player.x = 500 / 2 - 15
    player.y = 500 - 30
    player.width = player_img:getWidth()
    player.height = player_img:getHeight()
    player.speed = 100
    enemys = {}
    foods = {}
    projectiles = {}
    time = 0
    score = 0
    gameover = false
    bgaudio = love.audio.newSource("assets/bg.mp3", "static")
    love.audio.play(bgaudio)
    scoreText:set(score)
end

function make_a_enemy()
    local enemy = {}
    enemy.x = math.random(100, 500)
    enemy.y = 0
    enemy.width = enemy_img:getWidth()
    enemy.height = enemy_img:getHeight()
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
    can_make_projectile = can_make_projectile - 1
    if can_make_projectile <= 0 then
        can_make_projectile = 10
        local projectile = {}
        projectile.width = projectile_img:getWidth()
        projectile.height = projectile_img:getHeight()
        projectile.x = player.x + player.width / 2 - projectile.width / 2
        projectile.y = player.y
        projectile.speed = 600
        table.insert(projectiles, projectile)
    end

end

function love.load()
    local font = love.graphics.newFont(100, "mono", 10)
    gameoverText = love.graphics.newText(font, "Game Over")
    local fontScore = love.graphics.newFont(20, "mono", 10)
    scoreText = love.graphics.newText(fontScore, score)
    player_img = love.graphics.newImage("assets/player.png")
    enemy_img = love.graphics.newImage("assets/enemy.png")
    projectile_img = love.graphics.newImage("assets/projectile.png")
    init()
end

function love.update(dt)
    if gameover == false then
        time = time + 1

        if time % 100 == 0 then make_a_enemy() end
        -- if time % 300 == 0 then make_a_food() end

        for i, v in ipairs(enemys) do
            v.y = v.y + 100 * dt
            if checkCollision(player, v, 20, 30, 10, 10) then
                gameover = true
            end
        end
        for i, v in ipairs(foods) do v.y = v.y + 100 * dt end
        for i, v in ipairs(projectiles) do
            v.y = v.y - v.speed * dt
            for ii, vv in ipairs(enemys) do
                if checkCollision(v, vv, 5, 20, 0, 0) then
                    table.remove(projectiles, i)
                    table.remove(enemys, ii)
                    score = score + 1
                    scoreText:set(score)
                end
            end
        end

        key_event(player, dt, make_a_projectile)
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
    love.graphics.draw(player_img, player.x, player.y)
    for i, v in ipairs(enemys) do love.graphics.draw(enemy_img, v.x, v.y) end
    -- for i, v in ipairs(foods) do
    --     love.graphics.setColor(50, 200, 50)
    --     love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    -- end
    for i, v in ipairs(projectiles) do
        love.graphics.draw(projectile_img, v.x, v.y)
    end

    love.graphics.draw(scoreText, 20, 20)

    if gameover == true then love.graphics.draw(gameoverText, 100, 100) end
end
