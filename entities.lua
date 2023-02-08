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
    currentLevel = 40


    ennemyTexturePack = love.graphics.newImage("images/ennemy.png")
    neutralTexturePack = love.graphics.newImage("images/neutral.png")
    weaponTexturePack = love.graphics.newImage("images/weapon.png")
    projectileTexturePack = love.graphics.newImage("images/projectiles.png")
    ennemiesProperties= {
                            {

                            }

    }
    weaponsProperties = {
                            {
                            Name = "Gauss Canon",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = false,
                            FireQty = math.floor((currentLevel - 1) / 5) + 1, --hp range from 1 to 10),
                            FireAngle = 0,
                            FireSpread = 0,
                            FireCooldown = 0,
                            FireDelay = 0,
                            Cooldown = 1,
                            ProjSpeed = 600,
                            Energy = 1,
                            ShieldDmg = 5,
                            HullDmg = 0,
                            Quad = love.graphics.newQuad(0, 32, 32, 32, 192, 192),
                            QuadProj = love.graphics.newQuad(24, 32, 8, 8, 48, 80)
                            },
                            {
                            Name = "Gatling Gun",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = false,
                            FireQty = 40,
                            FireAngle = 0,
                            FireSpread = 0,
                            FireCooldown = 0.05,
                            FireDelay = 1,
                            Cooldown = 1,
                            ProjSpeed = 400,
                            Energy = 1,
                            ShieldDmg = 1,
                            HullDmg = 1,
                            Quad = love.graphics.newQuad(128, 64, 32, 32, 192, 192),
                            QuadProj = love.graphics.newQuad(16, 0, 8, 8, 48, 80)
                            },
                            {
                            Name = "Laser Canon",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = false,
                            FireQty = 1,
                            FireAngle = 0,
                            FireSpread = 0,
                            FireCooldown = 0,
                            FireDelay = 0,
                            Cooldown = 0.25,
                            ProjSpeed = 400,
                            Energy = 1,
                            ShieldDmg = 1,
                            HullDmg = 0,
                            Quad = love.graphics.newQuad(64, 64, 32, 32, 192, 192),
                            QuadProj = love.graphics.newQuad(0, 16, 8, 8, 48, 80)
                            },
                            {
                            Name = "Torpedo",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = false,
                            FireQty = 1,
                            FireAngle = 0,
                            FireSpread = 0,
                            FireCooldown = 0,
                            FireDelay = 0,
                            Cooldown = 2,
                            ProjSpeed = 200,
                            Energy = 1,
                            ShieldDmg = 5,
                            HullDmg = 1,
                            Quad = love.graphics.newQuad(0, 128, 32, 32, 192, 192),
                            QuadProj = love.graphics.newQuad(40, 16, 8, 8, 48, 80)
                            
                            },
                            {
                            Name = "Plasma Gun",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = false,
                            FireQty = 3,
                            FireAngle = 0,
                            FireSpread = 0,
                            FireCooldown = 0.1,
                            FireDelay = 0,
                            Cooldown = 0.5,
                            ProjSpeed = 1,
                            Energy = 1,
                            ShieldDmg = 1,
                            HullDmg = 1,
                            Quad = love.graphics.newQuad(32, 160, 32, 32, 192, 192),
                            QuadProj = love.graphics.newQuad(16, 16, 8, 8, 48, 80)
                            },
                            {
                            Name = "Nova Gun",
                            Rarity = 1,
                            Proj = true,
                            Beam = false,
                            Homing = false,
                            FireQty = 16,
                            FireAngle = 360,
                            FireSpread = 0,
                            FireCooldown = 0,
                            FireDelay = 0,
                            Cooldown = 1,
                            ProjSpeed = 100,
                            Energy = 1,
                            ShieldDmg = 1,
                            HullDmg = 1,
                            Quad = love.graphics.newQuad(96, 96, 32, 32, 192, 192),
                            QuadProj = love.graphics.newQuad(40, 0, 8, 8, 48, 80)
                            }
                        }
end

function Entities.CreateEntity(dt)
    createEntityTimer = createEntityTimer + dt
    if createEntityTimer * ennemiesPerSecond >= 1 then -- create a new enemy every 1 second
        local entityType = math.random(1, totalRatio)
        if entityType <= ennemyRatio then -- si une entite est generee, executer ce code
            local ennemy = {}
            ennemy.Width = 32 --largeur d'une entite en fonction de ennemyTypes--
            ennemy.Height = 32 --hauteur d'une entite en fonction de ennemyTypes--
            ennemy.CoordX = math.random((sideScreenSize + 1), (screenX - sideScreenSize - ennemy.Width))
            ennemy.CoordY = 1
            ennemy.Type = math.random(1, ennemyTypes)
            ennemy.Level = math.floor((currentLevel + 1) / 2 )
            ennemy.Speed = (0.96 + currentLevel / 50 * 2) * 1.00
            ennemy.LifeMax = math.floor((currentLevel - 1) / 5) + 1 --hp range from 1 to 10)
            ennemy.Life = ennemy.LifeMax
            ennemy.Quad = love.graphics.newQuad((ennemy.Type - 1) * 16, (ennemy.Level - 1)*16, 16, 16, 304, 400)
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
            neutral.Quad = love.graphics.newQuad(0, (neutral.Type - 1)*16, 16, 16, 16, 80)
            local lastEntityIndex = #neutrals
            neutrals[lastEntityIndex + 1] = neutral
        else
            local bonus = {}
            bonus.Width = 32 --largeur d'une entite en fonction de bonusTypes--
            bonus.Height = 32 --hauteur d'une entite en fonction de bonusTypes--
            bonus.CoordX = math.random((sideScreenSize + 1), (screenX - sideScreenSize - bonus.Width))
            bonus.CoordY = 1
            bonus.Type = math.random(1, bonusTypes)
            bonus.Level = math.floor((currentLevel + 1) / 2 )
            bonus.Speed = (0.96 + currentLevel / 50 * 2) * 0.5
            bonus.LifeMax = 1
            bonus.Life = bonus.LifeMax
            bonus.Quad = weaponsProperties[bonus.Type].Quad
            local lastEntityIndex = #bonuses
            bonuses[lastEntityIndex + 1] = bonus
        end
        createEntityTimer = 0
    else
    end
end

function Entities.Collide(quad1, quad2)
    if  (quad1.CoordX + quad1.Width) >= (quad2.x - quad2.Width/2) and quad1.CoordX <= (quad2.x - quad2.Width/2 + quad2.Width) and
        (quad1.CoordY + quad1.Height) >= (quad2.y - quad2.Height/2) and quad1.CoordY <= (quad2.y - quad2.Height/2 + quad2.Height) then
        return true
    else
        return false
    end
end

function Entities.Update(dt)
    for i = #ennemies, 1, -1 do
        if ennemies[i].CoordY >= screenY then
            table.remove(ennemies, i)
        elseif Entities.Collide(ennemies[i], heros) then
            table.remove(ennemies, i)
            print("BOOM!")
        else
            ennemies[i].CoordY = ennemies[i].CoordY + ennemies[i].Speed * dt * 50
        end
    end
    for i = #neutrals, 1, -1 do
        if neutrals[i].CoordY >= screenY then
            table.remove(neutrals, i)
        elseif Entities.Collide(neutrals[i], heros) then
            table.remove(neutrals, i)
            print("BOOM!")
        else
            neutrals[i].CoordY = neutrals[i].CoordY + neutrals[i].Speed * dt * 50
        end
    end
    for i = #bonuses, 1, -1 do
        if bonuses[i].CoordY >= screenY then
            table.remove(bonuses, i)
        elseif Entities.Collide(bonuses[i], heros) then
            table.remove(bonuses, i)
            print("BOOM!")
        else
            bonuses[i].CoordY = bonuses[i].CoordY + bonuses[i].Speed * dt * 50
        end
    end

    --for i = #bosses, 1, -1 do
    --    if bosses[i].CoordY == screenY then
    --        table.remove(bosses, i)
    --    else
    --        bosses[i].CoordY = bosses[i].CoordY + (bosses[i].Speed + 50) * dt
    --    end
    --end
end

function Entities.Draw()
    for i = 1, #ennemies do
        local currentEntity = ennemies[i]
        love.graphics.draw(ennemyTexturePack, currentEntity.Quad, currentEntity.CoordX, currentEntity.CoordY, 0, 2, 2)
    end
    for i = 1, #neutrals do
        local currentEntity = neutrals[i]
        love.graphics.draw(neutralTexturePack, currentEntity.Quad, currentEntity.CoordX, currentEntity.CoordY, 0, 1, 1)
    end
    for i = 1, #bonuses do
        local currentEntity = bonuses[i]
        love.graphics.draw(weaponTexturePack, currentEntity.Quad, currentEntity.CoordX, currentEntity.CoordY, 0, 1, 1)
    end
end


return Entities