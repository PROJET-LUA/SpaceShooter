local Entities = {}

function Entities.Load()
    --screenNoPlayLeft = 200 --variable definissant la zone non jouable a gauche en pixels
    --screenNoPlayRight = 200 --variable definissant la zone non jouable a droite en pixels
    --screenNoPlayTop = 0 --variable definissant la zone non jouable en haut en pixels
    --screenNoPlayRight= 0 --variable definissant la zone non jouable en bas en pixels
    screenX = 800
    screenY = 600
    sideScreenSize = 200

    ennemyTypes = 19 --nombre d'entité differentes et de textures pour l'array
    bossTypes = 6 --nombre d'entité differentes et de textures pour l'array
    neutralTypes = 5 --nombre d'entité differentes et de textures pour l'array
    bonusTypes = 6 --nombre d'entité differentes et de textures pour l'array

    createEntityTimer = 0 --timer pour creer une entite: ne pas changer
    ennemiesPerSecond = 1 --nombre d'entites par seconde
    ennemyRatio = 3
    neutralRatio = 6
    bonusRatio = 1
    totalRatio = ennemyRatio + neutralRatio + bonusRatio



    ennemies = {}
    neutrals = {}
    bonuses = {}
    bosses = {}
    currentLevel = 1


    ennemyTexturePack = love.graphics.newImage("images/ennemy.png")
    neutralTexturePack = love.graphics.newImage("images/neutral.png")
    weaponTexturePack = love.graphics.newImage("images/weapon.png")
    weaponsProperties = {
                            {
                            Name = "Gauss Canon",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = false,
                            FireQty = {1, 1, 1},
                            FireAngle = {0, 0, 0},
                            FireBurst = {1, 1, 1},
                            Cooldown = {1, 1, 1},
                            ProjSpeed = {200, 300, 400},
                            Energy = {10, 10, 10},
                            ShieldDmg = {0, 0, 0},
                            HullDmg = {5, 7, 10},
                            Sprite = love.graphics.newQuad(0, 32, 32, 32, 192, 192)
                            },
                            {
                            Name = "Gatling Gun",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = false,
                            FireQty = {3, 3, 3},
                            FireAngle = {0, 0, 0},
                            FireBurst = {1, 2, 3},
                            Cooldown = {1, 1, 1},
                            ProjSpeed = {200, 200, 200},
                            Energy = {1, 1, 1},
                            ShieldDmg = {1, 1, 1},
                            HullDmg = {0, 0, 0},
                            Sprite = love.graphics.newQuad(128, 64, 32, 32, 192, 192)
                            },
                            {
                            Name = "Laser Canon",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = false,
                            FireQty = {1, 1, 1},
                            FireAngle = {0, 0, 0},
                            FireBurst = {1, 2, 3},
                            Cooldown = {1, 1, 1},
                            ProjSpeed = {600, 600, 600},
                            Energy = {1, 1, 1},
                            ShieldDmg = {1, 1, 1},
                            HullDmg = {0, 0, 0},
                            Sprite = love.graphics.newQuad(64, 64, 32, 32, 192, 192)
                            },
                            {
                            Name = "Torpedo",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = false,
                            FireQty = {1, 1, 2},
                            FireAngle = {0, 0, 0},
                            FireBurst = {1, 2, 2},
                            Cooldown = {1, 1, 1},
                            ProjSpeed = {100, 100, 100},
                            Energy = {1, 1, 1},
                            ShieldDmg = {0, 0, 0},
                            HullDmg = {3, 3, 3},
                            Sprite = love.graphics.newQuad(0, 128, 32, 32, 192, 192)
                            },
                            {
                            Name = "Deathray",
                            Rarity = 1,
                            Proj = false,
                            Beam = true,
                            Homing = false,
                            FireQty = {1, 1, 1},
                            FireAngle = {0, 0, 0},
                            FireBurst = {1, 1, 1},
                            Cooldown = {1, 1, 1},
                            ProjSpeed = {0, 0, 0},
                            Energy = {1, 1, 1},
                            ShieldDmg = {1, 2, 3},
                            HullDmg = {0, 0, 0},
                            Sprite = love.graphics.newQuad(32, 160, 32, 32, 192, 192)
                            },
                            {
                            Name = "Guided Missile",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = true,
                            FireQty = {1, 2, 2},
                            FireAngle = {0, 0, 0},
                            FireBurst = {1, 1, 32},
                            Cooldown = {1, 1, 1},
                            ProjSpeed = {100, 100, 100},
                            Energy = {2, 2, 2},
                            ShieldDmg = {0, 0, 0},
                            HullDmg = {5, 5, 5},
                            Sprite = love.graphics.newQuad(96, 96, 32, 32, 192, 192)
                            }
                        }
end

function Entities.CreateEntity(dt)
    createEntityTimer = createEntityTimer + dt
    if createEntityTimer * ennemiesPerSecond >= 1 then -- create a new enemy every 1 second
        local entityType = math.random(1, totalRatio)
        if entityType <= ennemyRatio then -- si une entite est generee, executer ce code
            local ennemy = {}
            ennemy.Width = 16 --largeur d'une entite en fonction de ennemyTypes--
            ennemy.Height = 16 --hauteur d'une entite en fonction de ennemyTypes--
            ennemy.CoordX = math.random((sideScreenSize + 1), (screenX - sideScreenSize - ennemy.Width))
            ennemy.CoordY = 1
            ennemy.Type = math.random(1, ennemyTypes)
            ennemy.Level = math.floor((currentLevel + 1) / 2 )
            ennemy.Speed = (0.96 + currentLevel / 50 * 2) * 1.00
            ennemy.LifeMax = math.floor((currentLevel - 1) / 5) + 1 --hp range from 1 to 10)
            ennemy.Life = ennemy.LifeMax
            local lastEntityIndex = #ennemies
            ennemies[lastEntityIndex + 1] = ennemy
        elseif entityType > ennemyRatio and entityType <= ennemyRatio + neutralRatio then
            local neutral = {}
            neutral.Width = 16 --largeur d'une entite en fonction de neutralTypes--
            neutral.Height = 16 --hauteur d'une entite en fonction de neutralTypes--
            neutral.CoordX = math.random((sideScreenSize + 1), (screenX - sideScreenSize - neutral.Width))
            neutral.CoordY = 1
            neutral.Type = math.random(1, neutralTypes)
            neutral.Level = math.floor((currentLevel + 1) / 2 )
            neutral.Speed = (0.96 + currentLevel / 50 * 2) * 0.5
            neutral.LifeMax = neutral.Type
            neutral.Life = neutral.LifeMax 
            local lastEntityIndex = #neutrals
            neutrals[lastEntityIndex + 1] = neutral
        else
            local bonus = {}
            bonus.Width = 16 --largeur d'une entite en fonction de bonusTypes--
            bonus.Height = 16 --hauteur d'une entite en fonction de bonusTypes--
            bonus.CoordX = math.random((sideScreenSize + 1), (screenX - sideScreenSize - bonus.Width))
            bonus.CoordY = 1
            bonus.Type = math.random(1, bonusTypes)
            bonus.Level = math.floor((currentLevel + 1) / 2 )
            bonus.Speed = (0.96 + currentLevel / 50 * 2) * 0.5
            bonus.LifeMax = 1
            bonus.Life = bonus.LifeMax
            local lastEntityIndex = #bonuses
            bonuses[lastEntityIndex + 1] = bonus
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
            neutrals[i].CoordY = neutrals[i].CoordY + neutrals[i].Speed * dt * 50
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
    for i = 1, #ennemies do
        local currentEntity = ennemies[i]
        local entityQuad = love.graphics.newQuad((currentEntity.Type - 1) * 16, (currentEntity.Level - 1)*16, 16, 16, 304, 400)
        love.graphics.draw(ennemyTexturePack, entityQuad, currentEntity.CoordX, currentEntity.CoordY, 0, 2, 2)
    end
    for i = 1, #neutrals do
        local currentEntity = neutrals[i]
        local entityQuad = love.graphics.newQuad(0, (currentEntity.Type - 1)*16, 16, 16, 16, 80)
        love.graphics.draw(neutralTexturePack, entityQuad, currentEntity.CoordX, currentEntity.CoordY, 0, 1, 1)
    end
    for i = 1, #bonuses do
        local currentEntity = bonuses[i]
        love.graphics.draw(weaponTexturePack, weaponsProperties[currentEntity.Type].Sprite, currentEntity.CoordX, currentEntity.CoordY, 0, 1, 1)
    end
end


return Entities