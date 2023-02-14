local entities2 = {}

local CONST = {
    map = {x = 200, y = 0, w = 400, h = 600, lvl = 1},
    type = {player = "player", ennemy = "ennemy", neutral = "neutral", bonus = "bonus", projectile = "projectile"},
    player = {},
    ennemy = {},
    neutral = {},
    bonus = {},
    projectile = {},
    entityRatio = {ennemy = 1, neutral = 1, bonus = 1},
    ennemyPerSec = 1
}

local imgPlayer = love.graphics.newImage("images/ro/player.png")
local imgEnnemy = love.graphics.newImage("images/ro/ennemy.png")
local imgNeutral = love.graphics.newImage("images/ro/neutral.png")
local imgBonus = love.graphics.newImage("images/ro/weapon.png")
local imgProjectile = love.graphics.newImage("images/ro/projectiles.png")

local player = {}
local ennemyList = {}
local neutralList = {}
local bonusList = {}
local projectileList = {}

local createEnnemyTimer = 0
local ennemyFireTimer = 1

player.x = 400
player.y = 300


function loadQuad()
    for i = 1, 5, 1 do
        CONST.player[i] = {}
        CONST.player[i].quad = {}
        for j = 1, 3, 1 do
            CONST.player[i].quad[j] = {}
            CONST.player[i].quad[j] = love.graphics.newQuad((j-1)*8, (i-1)*8, 8, 8, imgPlayer)
        end
    end

    for i = 1, 19, 1 do
        CONST.ennemy[i] = {}
        CONST.ennemy[i].quad = {}
        for j = 1, 25 do
            CONST.ennemy[i].quad[j] = love.graphics.newQuad((i-1)*16, (j-1)*16, 16, 16, imgEnnemy)
        end
    end

    CONST.neutral.quad = {}
    for i = 1, 5, 1 do
        CONST.neutral.quad[i] = love.graphics.newQuad(0*16,(i-1)*16, 16, 16, imgNeutral)
    end

    CONST.bonus.quad = {}
    for i = 1, 6, 1 do
        for j = 1, 5, 1 do
            CONST.bonus.quad[(i-1)*5 + j] = love.graphics.newQuad((i-1)*21, (j-1)*20, 21, 20, imgBonus)
        end
    end

    CONST.projectile.quad = {}
    for i = 1, 8, 1 do
        for j = 1, 6, 1 do
            CONST.projectile.quad[(i-1)*6+j] = love.graphics.newQuad((i-1)*8, (j-1)*8, 8, 8, imgProjectile)
        end
    end

end

function createEnnemy(pName, pQuad, pX, pY, pLvl)
    local newEnnemy = {name = pName, side = "gameSide", quad = pQuad, x = pX, y = pY, w = CONST.ennemy.w, h = CONST.ennemy.h, lvl = math.floor((pLvl+1)/2), weapon = math.random(1, #weapons)}
    table.insert(ennemyList, newEnnemy)
end

function createNeutral(pName, pQuad, pX, pY, pLvl)
    local newNeutral = {name = pName, side = "gameSide", quad = pQuad, x = pX, y = pY, w = CONST.neutral.w, h = CONST.neutral.h, lvl = pLvl}
    table.insert(neutralList, newNeutral)
end

function createBonus(pName, pQuad, pX, pY, pLvl)
    local newBonus = {name = pName, side = "gameSide", quad = pQuad, x = pX, y = pY, w = CONST.bonus.w, h = CONST.bonus.h, lvl = 1, lvl = pLvl}
    table.insert(bonusList, newBonus)
end

function createProjectile(pName, pSide, pQuad, pX, pY, pDX, pDY, pWeapon)
    local newProjectile = {name = pName, side = pSide, quad = pQuad, x = pX, y = pY, w = CONST.projectile.w, h = CONST.projectile.h, dX = pDX, dY = pDY, weapon = pWeapon }
    table.insert(projectileList, newProjectile)
end

function ennemyFire(pName)

end

function collideEntities(side1,x1,y1,w1,h1,side2,x2,y2,w2,h2)
    return side1 ~= side2 and x1 + w1 > x2 and x1 < x2 + w2 and y1 + h1 > y2 and y1 < y2 + h2
end

---

entities2.load = function()
    loadQuad()
    player.x = 400
    player.y = 500
    player.w = 8
    player.h = 8
    player.quad = CONST.player[1].quad[2]

end

entities2.update = function(dt)
    createEnnemyTimer = createEnnemyTimer + dt
    if createEnnemyTimer >= 1 then
        createEnnemy()
    end

    for i = #ennemyList, 1, -1 do
        local s = ennemyList[i]
        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt
        if collideEntities(s.side, s.x, s.y, s.w, s.h, player.side, player.x, player.y, player.l, player.h) then
            print("collide")
            table.remove(ennemyList, i)
        end
        if s.x + s.w > CONST.map.x + CONST.map.w or s.x < CONST.map.x or s.y < CONST.map.y or s.y + s.h > CONST.map.y + CONST.map.h then
            table.remove(ennemyList, i)
        end
        ennemyFire(s, i)
    end
    for i = #neutralList, 1, -1 do
        local s = neutralList[i]
        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt
        if collideEntities(s.side, s.x, s.y, s.w, s.h, player.side, player.x, player.y, player.l, player.h) then
            print("collide")
            table.remove(neutralList, i)
        end
        if s.x + s.w > CONST.map.x + CONST.map.w or s.x < CONST.map.x or s.y < CONST.map.y or s.y + s.h > CONST.map.y + CONST.map.h then
            table.remove(neutralList, i)
        end
    end
    for i = #bonusList, 1, -1 do
        local s = bonusList[i]
        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt
        if collideEntities(s.side, s.x, s.y, s.w, s.h, player.side, player.x, player.y, player.l, player.h) then
            print("collide")
            table.remove(bonusList, i)
        end
        if s.x + s.w > CONST.map.x + CONST.map.w or s.x < CONST.map.x or s.y < CONST.map.y or s.y + s.h > CONST.map.y + CONST.map.h then
            table.remove(bonusList, i)
        end
    end
    for i = #projectileList, 1, -1 do
        local s = projectileList[i]
        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt
        if collideEntities(s.side, s.x, s.y, s.w, s.h, player.side, player.x, player.y, player.l, player.h) then
            print("HIT!")
            table.remove(projectileList, i)
        end
        if s.x + s.w > CONST.map.x + CONST.map.w or s.x < CONST.map.x or s.y < CONST.map.y or s.y + s.h > CONST.map.y + CONST.map.h then
            table.remove(projectileList, i)
        end
    end
end

entities2.draw = function(dt)
    love.graphics.draw(imgPlayer, player.quad, player.x, player.y)
    for i = #ennemyList, 1, -1 do
        local s = ennemyList[i]
        love.graphics.draw(imgEnnemy, CONST.ennemy[s.name].quad[s.quad], s.x, s.y)
    end
    for i = #neutralList, 1, -1 do
        local s = neutralList[i]
        love.graphics.draw(imgNeutral, CONST.neutral[s.name].quad[s.quad], s.x, s.y)
    end
    for i = #bonusList, 1, -1 do
        local s = bonusList[i]
        love.graphics.draw(imgBonus, CONST.bonus[s.name].quad[s.quad], s.x, s.y)
    end
    for i = #projectileList, 1, -1 do
        local s = projectileList[i]
        love.graphics.draw(imgProjectile, CONST.projectile[s.name].quad[s.quad], s.x, s.y)
    end
end

return entities2