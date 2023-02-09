
local entity = {}

local CONST = {
    types = { shoot ="shoot", enemie ="enemie", bonus ="bonus" },
    map = { x = 200, y = 0, w = 400, h = 600 },
    shoot = {},
    ennemies = {}
}

local imgMonstres = love.graphics.newImage("images/ennemy.png")
local imgShoot = love.graphics.newImage("images/projectiles.png")
local imgBonus = love.graphics.newImage("images/weapon.png")

local listeSprites = {}


function loadQuad()
    for i = 1, 19, 1 do
        CONST.ennemies[i] = {}
        CONST.ennemies[i].quad = {}
        for j = 1, 25 do
            CONST.ennemies[i].quad[j] = love.graphics.newQuad((i-1) * 16, (j-1) * 16, 16, 16, imgMonstres)
        end
    end

    CONST.shoot.quad = {}
    for i = 1, 8, 1 do
        for j = 1, 6 , 1 do
            CONST.shoot.quad[(i - 1) * 6 + j] = love.graphics.newQuad((i-1) * 8, (j-1) * 8, 8, 8, imgShoot)
        end
    end 
end

function spriteCollideHero(s, i)
    if s.type == CONST.types.shoot then
        -- Hero perd de la vie
        print("shoot")
    elseif s.type == CONST.types.enemie then
        -- Hero perd de la vie
        print("enemie")
    elseif s.type == CONST.types.bonus then
        -- Hero change arme
        print("bonus")
    end
    table.remove(listeSprites, i)
end

function outOfTheMap(s, i) 
    if s.x + s.w > CONST.map.x + CONST.map.w or s.x < CONST.map.x or s.y < CONST.map.y or s.y + s.h > CONST.map.y + CONST.map.h then
        table.remove(listeSprites,i) 
    end
end

function ennemiesShoot(s, i, dt)
    if s.type == CONST.types.enemie then
        s.shootReload = s.shootReload + 1 * dt
        if s.shootReload > s.shootDelay then
            s.shootReload = 0
            createShot(s.x,s.y,s.shootType, math.floor(math.random(48)))
        end
    end
end

function createEnemie(pX,pY,pName, pQuad)
    local newEnemie = { x = pX, y = pY, name = pName, type = CONST.types.enemie, quad = pQuad, 
    w = 16, h = 16, vx = 12, vy = 16, shootDelay = 5, shootReload = 0, shootType = CONST.shoot.down }
    table.insert(listeSprites, newEnemie)
end

function createShot(pX,pY,pName, pQuad)
    local newShoot = { x = pX,  y = pY, w = 16, h = 16, name = pName, type = CONST.types.shoot, vx = 0, vy = 45, quad = pQuad}
    table.insert(listeSprites, newShoot)
end

function createBonus(pX,pY,pName)
    local newBonus = {x = pX,y = pY,name = pName,type = CONST.types.bonus }
    table.insert(listeSprites, newBonus)
end

function colideRectRect(x1,y1,w1,h1,x2,y2,w2,h2)
    return x1 + w1 > x2 and x1 < x2 + w2 and y1 + h1 > y2 and y1 < y2 + h2
end

entity.load = function()
    loadQuad()
    
    local lvl = 5
end

entity.update = function(dt)

    if #listeSprites < 20 then
        createEnemie(math.random(200,600),math.random(0,600),math.floor(math.random(1,18)), math.floor(math.random(1,25)))
    end

    for i = #listeSprites, 1, -1 do
        local s = listeSprites[i]

        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt

        if colideRectRect(s.x, s.y, s.w, s.h, heros.x, heros.y, heros.l, heros.h) then
            print("collide")
            spriteCollideHero(s, i)
        end
        outOfTheMap(s, i)
        ennemiesShoot(s, i, dt)
    end
end

entity.draw = function()
    for i = #listeSprites, 1, -1 do
        local s = listeSprites[i]
        if s.type == CONST.types.enemie then
            love.graphics.draw(imgMonstres, CONST.ennemies[s.name].quad[s.quad], s.x, s.y)            
        elseif s.type == CONST.types.shoot then
            love.graphics.draw(imgShoot, CONST.shoot.quad[s.quad], s.x, s.y)            
        elseif s.type == CONST.types.bonus then
            love.graphics.draw(imgBonus, CONST.bonus[s.name].quad[s.quad], s.x, s.y)            
        end
    end
end

return entity

