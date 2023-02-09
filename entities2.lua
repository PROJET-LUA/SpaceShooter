local entities2 = {}

local CONST = {
    map = {x = 200, y = 0, w = 400, h = 600},
    type = {hero = "hero", ennemy = "ennemy", neutral = "neutral", projectile = "projectile", bonus = "bonus"},
    hero = {},
    ennemy = {},
    neutral = {},
    projectile = {}
}

local imgHero = love.graphics.newImage("images/ro/heros.png")
local imgEnnemy = love.graphics.newImage("images/ro/ennemy.png")
local imgNeutral = love.graphics.newImage("images/ro/neutral.png")
local imgBonus = love.graphics.newImage("images/ro/weapon.png")
local imgProjectile = love.graphics.newImage("images/ro/projectiles.png")

function loadQuad()
    for i = 1, 5, 1 do
        CONST.hero[i] = {}
        CONST.hero[i].quad = {}
        for j = 1, 3, 1 do
            CONST.hero[i].quad[j] = {}
            CONST.hero[i].quad[j] = love.graphics.newQuad((j-1)*8, (i-1)*8, 8, 8, imgHero)
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
        CONST.neutral.quad[i] = love.graphics.newQuad(0,(i-1)*16,16,16,imgNeutral)
    end

    CONST.bonus.quad = {}
    for i = 1, 6, 1 do
        for j = 1, 5, 1 do
            CONST.bonus.quad[(i-1)*5 + j] = love.graphics.newQuad((i-1)*32, (j-1)*32, 32, 32, imgBonus)
        end
    end

    CONST.projectile.quad = {}
    for i = 1, 8, 1 do
        for j = 1, 6, 1 do
            CONST.projectile.quad[(i-1)*6+j] = love.graphics.newQuad((i-1)*8, (j-1)*8, 8, 8, imgProjectile)
        end
    end

end






entities2.load = function()

end

entities2.update = function()

end

entities2.draw = function()

end

return entities2