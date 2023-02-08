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
    ennemiesPerSecond = 0.5 --nombre d'entites par seconde
    ennemyRatio = 9
    neutralRatio = 0
    bonusRatio = 0
    totalRatio = ennemyRatio + neutralRatio + bonusRatio



    ennemies = {}
    neutrals = {}
    bonuses = {}
    bosses = {}
    ennemiesProjectiles = {}
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
                            FireQty = 1,
                            FireSpread = 0,
                            FireCooldown = 0,
                            FireDelay = 0,
                            Cooldown = 1,
                            Speed = 100,
                            RangeMin = 0,
                            RangeMax = 2000,
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
                            FireQty = 10,
                            FireSpread = 0,
                            FireCooldown = 0.1,
                            FireDelay = 1,
                            Cooldown = 3,
                            Speed = 300,
                            RangeMin = 0,
                            RangeMax = 2000,
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
                            FireSpread = 0,
                            FireCooldown = 0,
                            FireDelay = 0,
                            Cooldown = 0.5,
                            Speed = 400,
                            RangeMin = 0,
                            RangeMax = 2000,
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
                            FireSpread = 0,
                            FireCooldown = 0,
                            FireDelay = 0,
                            Cooldown = 2,
                            Speed = 200,
                            RangeMin = 0,
                            RangeMax = 2000,
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
                            FireSpread = 0,
                            FireCooldown = 0.25,
                            FireDelay = 0,
                            Cooldown = 2,
                            Speed = 1,
                            RangeMin = 0,
                            RangeMax = 2000,
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
                            FireSpread = 360,
                            FireCooldown = 0.017,
                            FireDelay = 0,
                            Cooldown = 2,
                            Speed = 100,
                            RangeMin = 0,
                            RangeMax = 2000,
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
            ennemy.Speed = 1
            ennemy.LifeMax = math.floor((currentLevel - 1) / 5) + 1 --hp range from 1 to 10)
            ennemy.Life = ennemy.LifeMax
            ennemy.Quad = love.graphics.newQuad((ennemy.Type - 1) * 16, (ennemy.Level - 1)*16, 16, 16, 304, 400)
            ennemy.WeaponIndex = 1 --math.random(1, 6) --attribue un indice pour la table d'arme de 1 a 6
            ennemy.FireQty = 0
            ennemy.Cooldown = 0
            ennemy.FireDelay = 0
            ennemy.FireCooldown = 0
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
            neutral.Speed = 1
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
            bonus.Speed = 1
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

--- Fonction determinant si un ennemi peut tirer en fonction des parametres des armes
function Entities.Fire(dt, ennemyIndex)
    ennemies[ennemyIndex].Cooldown = ennemies[ennemyIndex].Cooldown + dt
    if weaponsProperties[ennemies[ennemyIndex].WeaponIndex].FireDelay > 0 then
        ennemies[ennemyIndex].FireDelay = ennemies[ennemyIndex].FireDelay + dt
    end
    if weaponsProperties[ennemies[ennemyIndex].WeaponIndex].FireCooldown > 0 then
        ennemies[ennemyIndex].FireCooldown = ennemies[ennemyIndex].FireCooldown + dt
    end
    if ennemies[ennemyIndex].Cooldown >= weaponsProperties[ennemies[ennemyIndex].WeaponIndex].Cooldown then
        if ennemies[ennemyIndex].FireDelay >= weaponsProperties[ennemies[ennemyIndex].WeaponIndex].FireDelay then
            if ennemies[ennemyIndex].FireCooldown >= weaponsProperties[ennemies[ennemyIndex].WeaponIndex].FireCooldown then
                if ennemies[ennemyIndex].FireQty > 0 then
                    
                    Entities.CreateProjectile(ennemyIndex, ennemies[ennemyIndex].FireQty)
                    ennemies[ennemyIndex].FireQty = ennemies[ennemyIndex].FireQty - 1
                    ennemies[ennemyIndex].FireCooldown = 0
                else
                    ennemies[ennemyIndex].FireQty = weaponsProperties[ennemies[ennemyIndex].WeaponIndex].FireQty
                    ennemies[ennemyIndex].FireDelay = weaponsProperties[ennemies[ennemyIndex].WeaponIndex].FireDelay
                    ennemies[ennemyIndex].Cooldown = 0
                end
            end
        end    
    end
end

function Entities.CreateProjectile(ennemyIndex, projectileNumber)
    local ennemyProjectile = {}
    ennemyProjectile = weaponsProperties[ennemies[ennemyIndex].WeaponIndex]
    ennemyProjectile.Width = 16
    ennemyProjectile.Height = 16
    ennemyProjectile.FireAngle = ennemyProjectile.FireSpread / (projectileNumber / ennemyProjectile.FireQty)
    ennemyProjectile.CoordX = ennemies[ennemyIndex].CoordX + ennemies[ennemyIndex].Width / 2 - ennemyProjectile.Width / 2
    ennemyProjectile.CoordY = ennemies[ennemyIndex].CoordY + ennemies[ennemyIndex].Height
    local lastProjectileIndex = #ennemiesProjectiles
    ennemiesProjectiles[lastProjectileIndex + 1] = ennemyProjectile
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
            print("ennemi", i, " hors ecran")
            table.remove(ennemies, i)
        elseif Entities.Collide(ennemies[i], heros) then
            table.remove(ennemies, i)
            print("BOOM!")
        else
            Entities.Fire(dt, i)
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
            neutrals[i].CoordY = neutrals[i].CoordY + neutrals[i].Speed * dt * 12.5
        end
    end
    for i = #bonuses, 1, -1 do
        if bonuses[i].CoordY >= screenY then
            table.remove(bonuses, i)
        elseif Entities.Collide(bonuses[i], heros) then
            table.remove(bonuses, i)
            print("BOOM!")
        else
            bonuses[i].CoordY = bonuses[i].CoordY + bonuses[i].Speed * dt * 12.5
        end
    end
    for i = #ennemiesProjectiles, 1, -1 do
        if ennemiesProjectiles[i].CoordY >= screenY then
            print("projectile #", i, " hors ecran")
            table.remove(ennemiesProjectiles, i)
        elseif Entities.Collide(ennemiesProjectiles[i], heros) then
            table.remove(ennemiesProjectiles, i)
            print("BOOM!")
        else
            ennemiesProjectiles[i].CoordX = ennemiesProjectiles[i].CoordX + (1 - math.cos(ennemiesProjectiles[i].FireAngle * math.pi / 180)) * ennemiesProjectiles[i].Speed * dt --
            ennemiesProjectiles[i].CoordY = ennemiesProjectiles[i].CoordY + (1 - math.sin(ennemiesProjectiles[i].FireAngle * math.pi / 180)) * ennemiesProjectiles[i].Speed * dt --
        end
    end
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
    for i = 1, #ennemiesProjectiles do
        local currentEntity = ennemiesProjectiles[i]
        love.graphics.draw(projectileTexturePack, currentEntity.QuadProj, currentEntity.CoordX, currentEntity.CoordY, 0, 1, 1)
    end
end

return Entities