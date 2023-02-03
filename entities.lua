local Entities = {}

function Entities.Load()
    screenNoPlayLeft = 100 --variable definissant la zone non jouable a gauche en pixels
    screenNoPlayRight = 100 --variable definissant la zone non jouable a droite en pixels
    screenNoPlayTop = 0 --variable definissant la zone non jouable en haut en pixels
    screenNoPlayRight= 0 --variable definissant la zone non jouable en bas en pixels
    ennemyTypes = 19 --nombre de types d'ennemis et de textures
    bossTypes = 6
    neutralTypes = 5 --nombre de types d'ennemis et de textures
    bonusTypes = 5 --nombre de types d'ennemis et de textures
    createEntityTimer = 0
    ennemiesPerSecond = 5
    ennemies = {}
    neutrals = {}
    bonuses = {}
    bosses = {}
    currentLevel = 1
    screenX = love.graphics.getWidth()
end

function Entities.CreateEntity(dt)
    createEntityTimer = createEntityTimer + dt
    if createEntityTimer * ennemiesPerSecond >= 1 then -- create a new enemy every 1 second
        local entityType = math.random(1, 1)
        if entityType == 1 then -- si une entite est generee, executer ce code
            local ennemy = {}
            ennemy.Width = 16 --largeur d'une entite en fonction de ennemyTypes--
            ennemy.Height = 16 --hauteur d'une entite en fonction de ennemyTypes--
            ennemy.CoordX = math.random((screenNoPlayLeft + 1), ((screenX - screenNoPlayRight) - ennemy.Width))
            ennemy.CoordY = 1
            ennemy.Type = math.random(1, ennemyTypes)
            ennemy.Level = math.floor((currentLevel + 1) / 2 )
            ennemy.Speed = currentLevel
            local lastEnnemyIndex = #ennemies
            ennemies[lastEnnemyIndex + 1] = ennemy
        elseif entityType == 2 then
            local neutral = {}
            neutral.Width = 8 --largeur d'une entite en fonction de neutralTypes--
            neutral.Height = 8 --hauteur d'une entite en fonction de neutralTypes--
            neutral.CoordX = math.random((screenNoPlayLeft + 1), ((screenX - screenNoPlayRight) - neutral.Width))
            neutral.CoordY = 1
            neutral.Type = math.random(0, neutralTypes)
            local lastNeutralIndex = #neutrals
            neutrals[lastNeutralIndex + 1] = neutral
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
    for i = 1, #ennemies do
        ennemies[i].CoordY = ennemies[i].CoordY + (ennemies[i].Speed + 50) * dt
    end
    for i = 1, #neutrals do
        neutrals[i].CoordY = neutrals[i].CoordY + (neutrals[i].Speed + 50) * dt
    end
    for i = 1, #bonuses do
        bonuses[i].CoordY = bonuses[i].CoordY + (bonuses[i].Speed + 50) * dt
    end
    for i = 1, #bosses do
        bosses[i].CoordY = bosses[i].CoordY + (bosses[i].Speed + 50) * dt
    end
end

function Entities.Draw()
    local ennemyTexturePack = love.graphics.newImage("images/ennemy.png")
    local bossTexturePack = love.graphics.newImage("images/boss.png")
    for i = 1, #ennemies do
        local currentEnnemy = ennemies[i]
        local ennemyQuad = love.graphics.newQuad((currentEnnemy.Type - 1) * 16, (currentEnnemy.Level - 1)*16, 16, 16, 304, 400)
        love.graphics.draw(ennemyTexturePack, ennemyQuad, currentEnnemy.CoordX, currentEnnemy.CoordY, 0, 1, 1)
    end
    for i = 1, #bosses do
        local currentBoss = bosses[i]
        local bossQuad = love.graphics.newQuad(0, (currentBoss.Type - 1)*16, 16, 16, 16, 96)
        love.graphics.draw(bossTexturePack, bossQuad, currentBoss.CoordX, currentBoss.CoordY, 0, 1.5, 1.5)
    end
end


return Entities