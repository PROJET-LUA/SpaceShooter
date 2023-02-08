------VARIABLE------

--constante
SPEED = 100 -- Permet de changer la vitesse du hero


------TABLEAU------
heros = {}







--liste d'éléments
listeSprites = {}
listeTirs = {}


local herosImage = love.graphics.newImage("images/heros.png")
local imgTir = love.graphics.newImage("images/laser1.png")
local sonShoot = love.audio.newSource("sons/shoot.wav", "static")



------FONCTION LOAD------
------FONCTION UPDATE------
------FONCTION DRAW------
------FONCTION KEYPRESSED------

------FONCTION MOUSEPRESSED------
------FONCTION UTILE------

function collideTir(tableprojectil, tableentites)
    if (tableentites.CoordX + tableentites.Width) >= (tableprojectil.x) and tableentites.CoordX <= (tableprojectil.x) and
    (tableentites.CoordY + tableentites.Height) >= (tableprojectil.y) and tableentites.CoordY <= (tableprojectil.y) then
        return true
    else return false
    end
end
-----LOAD----- : ACTION DU JEU AU DEMARAGE
function heros.load()

    -- definir larg et haut suivant la taille de l'écrant
    larg = 800
    haut = 600

    -- definir heros pour créé un listeSprites suivant larg et haut
        heros.l = herosImage:getWidth()
        heros.h = herosImage:getHeight()
        heros.x = larg/2
        heros.y = haut - (heros.h*2)
        heros.supr = false
        heros.quad = love.graphics.newQuad(0, 0, 29, 25, 29, 25)

    heros.Width = herosImage:getWidth()
    heros.Height = herosImage:getHeight()
end


-----UPDATE----- : ACTION DU JEU A CHAQUE FRAME  
function heros.update(dt)
    local n
    -- pour chaque listeTirs, on fait quelque chose après...
    for n = #listeTirs, 1, -1 do
        local tir = listeTirs[n]
        tir.x = tir.x + tir.vx
        tir.y = tir.y + tir.vy

        -- vérifier si une entités touche le heros
        for i = #ennemies, 1, -1 do

            if collideTir(tir, ennemies[i]) then
                table.remove(listeTirs, n)
                table.remove(ennemies, i)
            end
        end
        for i = #neutrals, 1, -1 do

            if collideTir(tir, neutrals[i]) then
                table.remove(listeTirs, n)
                table.remove(neutrals, i)
            end
        end

        -- vérifier si le tir n'est pas sortie de l'écrant
        if tir.y < 0 or tir.y > haut then
            -- marque le sprite pour le suprimer plus tard
            tir.supr = true
            table.remove(listeTirs, n)
        end
    end

    -- définir les touche de deplacement du hero
    if love.keyboard.isDown("right") and heros.x < 600 - heros.l then
        heros.x = heros.x + (SPEED * dt)
    end
    if love.keyboard.isDown("left") and heros.x > 200 then
        heros.x = heros.x - (SPEED * dt)

    end
    if love.keyboard.isDown("up") and heros.y > 0 then
        heros.y = heros.y - (SPEED * dt)

    end
    if love.keyboard.isDown("down") and heros.y < 600 then
        heros.y = heros.y + (SPEED * dt)

    end

    
    -----------------------------------
    if love.mouse.isDown(1) then
        print(love.mouse.getPosition())
    end
end

    

    -- pour chaque listeSprites dans le tableau de listeSprites, on le dessine
    local n

-----DRAW----- : DESSINE CE QUE TU VOIS A L'ECRAN
function heros.draw()
    for n = 1, #listeTirs do
        local s = listeTirs[n]
        love.graphics.draw(imgTir, s.quad, s.x, s.y, 0, 1, 1)
    end

    love.graphics.draw(herosImage, heros.quad, heros.x, heros.y, 0, 1, 1)
end

-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function heros.keypressed(key)

    -- définir la touche de tir du hero
    if key == "space" then
        --creeTir("heros", "laser1", heros.x, heros.y - (heros.h*2)/2, 0, -10)
        --creeTir(pType, pX, pY, pVitesseX, pVitesseY)
    local tir = {}
    tir.x = heros.x + heros.l/2 - 4.5
    tir.y = heros.y
    tir.vx = 0
    tir.vy = - (heros.h*2)/2
    tir.quad = love.graphics.newQuad(0, 0, 9, 9, 9, 9)
    --table.insert(listeTirs, tir)
    local tirIndex = #listeTirs
    listeTirs[tirIndex + 1] = tir

    sonShoot:play()

    end

    print(key)
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function heros.mousepressed()
end


return heros