hero = {}
hero.x = 400+8
hero.y = 550
hero.w = 16
hero.h = 16
hero.speed = 100
hero.shootDelay = 2
hero.shootReload = 0
shoot = {}



local imgHero = love.graphics.newImage("images/flo/hero.png")
local imgShoot = love.graphics.newImage("images/flo/shoot.png")

local listShoot = {}

function loadQuad2()
    --hero
    hero.quad = {}
    for i = 1, 2, 1 do
        for j = 1, 3 , 1 do
            hero.quad[(i - 1) * 3 + j] = love.graphics.newQuad((i-1) * 16, (j-1) * 16, 16, 16, imgHero)
        end
    end 
    --shoot
    shoot.quad = {}
    for i = 1, 8, 1 do
        for j = 1, 6 , 1 do
            shoot.quad[(i - 1) * 6 + j] = love.graphics.newQuad((i-1) * 8, (j-1) * 8, 8, 8, imgShoot)
        end
    end 
end

function moveHero(dt)
    if love.keyboard.isDown("right") and hero.x < 600 - hero.w  then
        hero.x = hero.x + (hero.speed * dt)
    end
    if love.keyboard.isDown("left") and hero.x > 200 then
        hero.x = hero.x - (hero.speed * dt)

    end
    if love.keyboard.isDown("up") and hero.y > 0 then
        hero.y = hero.y - (hero.speed * dt)

    end
    if love.keyboard.isDown("down") and hero.y < 600 - hero.h then
        hero.y = hero.y + (hero.speed * dt)

    end
end

function heroShoot(dt)
    if love.keyboard.isDown("space") then
        createShoot2(math.floor(math.random(48)))
    end
end

function createShoot2(pQuad)
    local newShoot = {x = hero.x + hero.w, y = hero.y, quad = pQuad,
    w = 8, h = 8, vx = 0, vy = -30}
    table.insert(listShoot, newShoot)
end

hero.load = function()
    loadQuad2()
end

hero.update = function(dt)
    moveHero(dt)
    
    for i = #listShoot, 1, -1 do
        local s = listShoot[i]
        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt
    end
    heroShoot(dt)
end

hero.draw = function()
    for i = #listShoot, 1, -1 do
        local s = listShoot[i]
        love.graphics.draw(imgShoot, shoot.quad[s.quad], s.x, s.y, 0, 1, 1, 8, 8)
    end
    love.graphics.draw(imgHero, hero.quad[3], hero.x, hero.y, math.rad(180),1,1,16,16)
end


return hero