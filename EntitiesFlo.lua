local EntitiesFlo = {}

local CONST = {
    type = {ennemy = "ennemy", shoot = "shoot", bonus = "bonus"},
    map = {x = 200, y = 0, w = 400, h = 600},
    ennemy = {},
    shoot = {},
    bonus = {}
}


local imgEnnemy = love.graphics.newImage("images/flo/ennemy.png")
local imgShoot = love.graphics.newImage("images/flo/shoot.png")
local imgBonus = love.graphics.newImage("images/flo/bonus.png")

local listSprites = {}



-- chargement des quad : hero/ennemy/shoot/bonus
function loadQuad()
    --ennemy
    for i = 1, 19, 1 do
        CONST.ennemy[i] = {}
        CONST.ennemy[i].quad = {}
        for j = 1, 25 do
            CONST.ennemy[i].quad[j] = love.graphics.newQuad((i-1) * 16, (j-1) * 16, 16, 16, imgEnnemy)
        end
    end
    --shoot
    CONST.shoot.quad = {}
    for i = 1, 8, 1 do
        for j = 1, 6 , 1 do
            CONST.shoot.quad[(i - 1) * 6 + j] = love.graphics.newQuad((i-1) * 8, (j-1) * 8, 8, 8, imgShoot)
        end
    end 
    --bonus
    CONST.bonus.quad = {}
    for i = 1, 6, 1 do
        for j = 1, 6, 1 do
            CONST.bonus.quad[(i - 1) * 6 + j] = love.graphics.newQuad((i-1) * 32, (j-1) * 32, 32, 32, imgBonus)
        end
    end
end

function spriteCollideHero(s, i)
    if s.type == CONST.type.ennemy then
        -- Hero perd de la vie
        print("ennemy")
    elseif s.type == CONST.type.shoot then
        -- Hero perd de la vie
        print("shoot")
    elseif s.type == CONST.type.bonus then
        -- Hero change arme
        print("bonus")
    end
    table.remove(listSprites, i)
end

function outOfTheMap(s, i)
    if s.x + s.w > CONST.map.x + CONST.map.w or s.x < CONST.map.x or s.y < CONST.map.y or s.y + s.h > CONST.map.y + CONST.map.h then
        table.remove(listSprites,i)
    end
end

function ennemyShoot(s, i, dt)
    if s.type == CONST.type.ennemy then
        s.shootReload = s.shootReload + 1 * dt
        if s.shootReload > s.shootDelay then
            s.shootReload = 0
            createShoot(s.x+2,s.y,s.shootType, math.floor(math.random(48)))
        end
    end
end

function heroShoot(s, i)
    createShoot(s.x+2,s.y,s.shootType, math.floor(math.random(48)))
end

function createEnnemy(pX, pY, pName, pQuad)
    local newEnnemy = {x = pX, y = pY, name = pName, type = CONST.type.ennemy, quad = pQuad,
    w = 16, h = 16, vx = 10, vy = 10, shootDelay = 2, shootReload = 0, shootType = CONST.shoot.down}
    table.insert(listSprites, newEnnemy)
end

function createShoot(pX, pY, pName, pQuad)
    local newShoot = {x = pX, y = pY, name = pName, type = CONST.type.shoot, quad = pQuad,
    w = 16, h = 16, vx = 0, vy = 30}
    table.insert(listSprites, newShoot)
end


function createBonus(pX, pY, pName, pQuad)
    local newBonus = {x = pX, y = pY, name = pName, type = CONST.type.bonus, quad = pQuad,
    w = 32, h = 32, vx = -16, vy = 16}
    table.insert(listSprites, newBonus)
end


------UTILITY FUNCTIONS------
function colideRectRect(x1,y1,w1,h1,x2,y2,w2,h2)
    return x1 + w1 > x2 and x1 < x2 + w2 and y1 + h1 > y2 and y1 < y2 + h2
end


------BOUCLE DE JEU------

EntitiesFlo.load = function()
    loadQuad()
end


EntitiesFlo.update = function(dt)

    if #listSprites < 20 then
        --createShoot(math.random(200,600),math.random(0,600),math.floor(math.random(1,18)), math.floor(math.random(1,25)))
        createEnnemy(math.random(200,600),math.random(0,600),math.floor(math.random(1,18)), math.floor(math.random(1,25)))
        createBonus(math.random(200,600),math.random(0,600),math.floor(math.random(1,18)), math.floor(math.random(1,25)))
    end

    for i = #listSprites, 1, -1 do
        local s = listSprites[i]
        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt

        if colideRectRect(s.x, s.y, s.w, s.h, hero.x, hero.y, hero.w, hero.h) then
            print("collide")
            spriteCollideHero(s, i)
        end
    
    outOfTheMap(s, i)
    ennemyShoot(s, i, dt)
    end
end

EntitiesFlo.draw = function()
    for i = #listSprites, 1, -1 do
        local s = listSprites[i]
        --ennemy  
        if s.type == CONST.type.ennemy then
            love.graphics.draw(imgEnnemy, CONST.ennemy[s.name].quad[s.quad], s.x, s.y)
        --shoot
        elseif s.type == CONST.type.shoot then
            love.graphics.draw(imgShoot, CONST.shoot.quad[s.quad], s.x, s.y,0 ,1.5 , 1.5)
        --bonus 
        elseif s.type == CONST.type.bonus then
            love.graphics.draw(imgBonus, CONST.bonus.quad[s.quad], s.x, s.y)
        end
    end
end

EntitiesFlo.keypressed = function(key)
    if key == "space" then
        print("tir")
        for i = #listSprites, 1, -1 do
            local s = listSprites[i]
                heroShoot(s)
        end
    end
end


return EntitiesFlo