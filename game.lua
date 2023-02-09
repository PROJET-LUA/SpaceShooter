local Game = {}

-- local myEntities = require("entities")
--local myEntities = require("entity")
local myEntities = require("EntitiesFlo")
--local hero = require("heros")
local backGround = require("backGround")
local hero = require("hero")

function Game.Load()

    -- myEntities.Load()
    myEntities.load()
    backGround.load()
    hero.load()
end

function Game.Update(dt)
        -- myEntities.CreateEntity(dt)
        -- myEntities.Update(dt)
    myEntities.update(dt)
    backGround.update(dt)
    hero.update(dt)
end

function Game.Draw()
    myEntities.draw()
    backGround.draw()
    hero.draw()
end

-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function Game.keypressed(key)
    --heros.keypressed(key)
    myEntities.keypressed(key)
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function Game.mousepressed()
end

return Game