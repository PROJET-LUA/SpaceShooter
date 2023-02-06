local Game = {}

local myEntities = require("entities")

function Game.Load()
    myEntities.Load()
end

function Game.Update(dt)
    myEntities.CreateEntity(dt)
    myEntities.Update(dt)
end

function Game.Draw()
    myEntities.Draw()
end
return Game
