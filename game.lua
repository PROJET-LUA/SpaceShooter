local Game = {}

--ennemiesPerSecond = 1 --nombre d'entites par seconde
--ennemyRatio = 0
--neutralRatio = 0
--bonusRatio = 1


local myEntities = require("entities")
local heros = require("heros")
local backGround = require("backGround")

function Game.Load()
    myEntities.Load()
    backGround.load()
    heros.load()
end

function Game.Update(dt)
    myEntities.CreateEntity(dt)
    myEntities.Update(dt)
    backGround.update(dt)
    heros.update(dt)
end

function Game.Draw()
    myEntities.Draw()
    backGround.draw()
    heros.draw()
end

-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function Game.keypressed(key)
    heros.keypressed(key)
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function Game.mousepressed()
end

return Game