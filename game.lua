local Game = {}

local myJson = require("pseudojson")
local myEntities = require("entities2")
local backGround = require("backGround")

function Game.Load()
    myEntities.load()
    backGround.load()
end

function Game.Update(dt)
    myEntities.update(dt)
    backGround.update(dt)
end

function Game.Draw()
    myEntities.draw()
    backGround.draw()
end

-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function Game.keypressed(key)
    --heros.keypressed(key)
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function Game.mousepressed()
end

return Game