local Entities = {}

function Entities.Load()
    screenNoPlayLeft = 100 --variable definissant la zone non jouable a gauche en pixels
    screenNoPlayRight = 100 --variable definissant la zone non jouable a droite en pixels
    screenNoPlayTop = 0 --variable definissant la zone non jouable en haut en pixels
    screenNoPlayRight= 0 --variable definissant la zone non jouable en bas en pixels
    ennemyTypes = 19 --nombre d'entité differentes et de textures pour l'array
    bossTypes = 6 --nombre d'entité differentes et de textures pour l'array
    neutralTypes = 5 --nombre d'entité differentes et de textures pour l'array
    bonusTypes = 5 --nombre d'entité differentes et de textures pour l'array
    createEntityTimer = 0
    ennemiesPerSecond = 5
    ennemies = {}
    neutrals = {}
    bonuses = {}
    bosses = {}
    currentLevel = 1
    screenX = love.graphics.getWidth()
    screenY = love.graphics.getHeight()
end

function Entities.CreateEntity(dt)
    createEntityTimer = createEntityTimer + dt
    if createEntityTimer * ennemiesPerSecond >= 1 then -- create a new enemy every 1 second
        local entityType = math.random(1, 2)
        if entityType == 1 then -- si une entite est generee, executer ce code
            local ennemy = {}
            ennemy.Width = 16 --largeur d'une entite en fonction de ennemyTypes--
            ennemy.Height = 16 --hauteur d'une entite en fonction de ennemyTypes--
            ennemy.CoordX = math.random((screenNoPlayLeft + 1), ((screenX - screenNoPlayRight) - ennemy.Width))
            ennemy.CoordY = 1
            ennemy.Type = math.random(1, ennemyTypes)
            ennemy.Level = math.floor((currentLevel + 1) / 2 )
            ennemy.Speed = 0.96 + currentLevel / 50 * 2
            ennemy.LifeMax = math.floor(currentLevel / 10)
            local lastEntityIndex = #ennemies
            ennemies[lastEntityIndex + 1] = ennemy
        elseif entityType == 2 then
            local neutral = {}
            neutral.Width = 16 --largeur d'une entite en fonction de neutralTypes--
            neutral.Height = 16 --hauteur d'une entite en fonction de neutralTypes--
            neutral.CoordX = math.random((screenNoPlayLeft + 1), ((screenX - screenNoPlayRight) - neutral.Width))
            neutral.CoordY = 1
            neutral.Type = math.random(1, neutralTypes)
            neutral.Level = math.floor((currentLevel + 1) / 2 )
            neutral.Speed = 0.96 + currentLevel / 50 * 2
            local lastEntityIndex = #neutrals
            neutrals[lastEntityIndex + 1] = neutral
        elseif entityType == 3 then
            local bonus = {}
            bonus.Width = 8 --largeur d'une entite en fonction de bonusTypes--
            bonus.Height = 8 --hauteur d'une entite en fonction de bonusTypes--
            bonus.CoordX = math.random((screenNoPlayLeft + 1), ((screenX - screenNoPlayRight) - bonus.Width))
            bonus.CoordY = 1
            bonus.Type = math.random(0, bonusTypes)
            local lastBonusIndex = #bonuses
            bonuses[lastBonusIndex + 1] = bonus
        elseif entityType == 4 then
            local boss = {}
            boss.Width = 16 --largeur d'une entite en fonction de bossTypes--
            boss.Height = 16 --hauteur d'une entite en fonction de bossTypes--
            boss.CoordX = math.random((screenNoPlayLeft + 1), ((screenX - screenNoPlayRight) - boss.Width))
            boss.CoordY = 1
            boss.Type = math.random(1, bossTypes)
            local lastBossIndex = #bosses
            bosses[lastBossIndex + 1] = boss
        else
        end
        createEntityTimer = 0
    else
    end
end

function Entities.Update(dt)
    for i = #ennemies, 1, -1 do
        if ennemies[i].CoordY >= screenY then
            table.remove(ennemies, i)
        else
            ennemies[i].CoordY = ennemies[i].CoordY + ennemies[i].Speed * dt * 50
        end
    end
    for i = #neutrals, 1, -1 do
        if neutrals[i].CoordY == screenY then
            table.remove(neutrals, i)
        else
            neutrals[i].CoordY = neutrals[i].CoordY + neutrals[i].Speed * dt * 25
        end
    end
    for i = #bonuses, 1, -1 do
        if bonuses[i].CoordY == screenY then
            table.remove(bonuses, i)
        else
            bonuses[i].CoordY = bonuses[i].CoordY + bonuses[i].Speed * dt * 50
        end
    end
    for i = #bosses, 1, -1 do
        if bosses[i].CoordY == screenY then
            table.remove(bosses, i)
        else
            bosses[i].CoordY = bosses[i].CoordY + (bosses[i].Speed + 50) * dt
        end
    end
end

function Entities.Draw()
    local ennemyTexturePack = love.graphics.newImage("images/ennemy.png")
    local neutralTexturePack = love.graphics.newImage("images/neutral.png")
    for i = 1, #ennemies do
        local currentEntity = ennemies[i]
        local entityQuad = love.graphics.newQuad((currentEntity.Type - 1) * 16, (currentEntity.Level - 1)*16, 16, 16, 304, 400)
        love.graphics.draw(ennemyTexturePack, entityQuad, currentEntity.CoordX, currentEntity.CoordY, 0, 1, 1)
    end
    for i = 1, #neutrals do
        local currentEntity = neutrals[i]
        local entityQuad = love.graphics.newQuad(0, (currentEntity.Type - 1)*16, 16, 16, 16, 80)
        love.graphics.draw(neutralTexturePack, entityQuad, currentEntity.CoordX, currentEntity.CoordY, 0, 1, 1)
    end
end


return Entities