------VARIABLE------
------TABLEAU------
heros = {}


--liste d'éléments
listeSprites = {}
listeTirs = {}


sonShoot = love.audio.newSource("sons/shoot.wav", "static")


-- createSprite() permet de créé nimporte quel "sprite" du dossier images en appelant juste son nom 
function createSprite(pNomImg, pX, pY)
    
    sprite = {}
        sprite.x = pX
        sprite.y = pY
        sprite.supr = false
        sprite.img = love.graphics.newImage("images/"..pNomImg..".png")
        sprite.l = sprite.img:getWidth()
        sprite.h = sprite.img:getHeight()

    
    table.insert(listeSprites, sprite)

    return sprite
end
------FONCTION LOAD------

-- startGame() au demagarge du jeu place le hero et crée les aliens
function startGame()
    -- place le hero
    heros.x = larg/2
    heros.y = haut - (heros.h*2)
end
------FONCTION UPDATE------
------FONCTION DRAW------
------FONCTION KEYPRESSED------
------FONCTION MOUSEPRESSED------
------FONCTION UTILE------

-----LOAD----- : ACTION DU JEU AU DEMARAGE
function heros.load()

    -- definir larg et haut suivant la taille de l'écrant
    larg = 800
    haut = 600

    -- definir heros pour créé un listeSprites suivant larg et haut
    heros = createSprite("heros", larg/2, haut/2)

    startGame()

end


-----UPDATE----- : ACTION DU JEU A CHAQUE FRAME  
function heros.update(dt)
    local n

    -- pour chaque listeTirs, on fait quelque chose après...
    for n = #listeTirs, 1, -1 do
        local tir = listeTirs[n]
        tir.y = tir.y + tir.v
        -- vérifier si le tir n'est pas sortie de l'écrant
        if tir.y < 0 or tir.y > haut then
            -- marque le sprite pour le suprimer plus tard
            tir.supr = true
            table.remove(listeTirs, n)
        end
    end
    

    -- purge des listeSprites à suprimer 
    for n = #listeSprites, 1, -1 do
        if listeSprites[n].supr == true then
            table.remove(listeSprites, n)
        end
    end

    -- définir les touche de deplacement du hero
    if love.keyboard.isDown("right") and heros.x < larg then
        heros.x = heros.x + 2
    end
    if love.keyboard.isDown("left") and heros.x > 0 then
        heros.x = heros.x - 2
    end
    if love.keyboard.isDown("up") and heros.y > 0 then
        heros.y = heros.y - 2
    end
    if love.keyboard.isDown("down") and heros.y < haut then
        heros.y = heros.y + 2
    end


    -----------------------------------
    if love.mouse.isDown(1) then
        print(love.mouse.getPosition())
    end
end




-----DRAW----- : DESSINE CE QUE TU VOIS A L'ECRAN
function heros.draw()
    -- pour chaque listeSprites dans le tableau de listeSprites, on le dessine
    local n
    for n = 1, #listeSprites do
        local s = listeSprites[n]
        love.graphics.draw(s.img, s.x, s.y, 0, 2, 2, s.l/2, s.h/2)
    end
    -- afficher le nombre de listeTirs et le nombre de listeSprites actuel à l'écrant
    love.graphics.print("Nombre de listeTirs : "..#listeTirs.." Nombre de listeSprites : "..#listeSprites, 0, 0)

end

-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function heros.keypressed(key)

    -- définir la touche de tir du hero
    if key == "space" then
        local tir = createSprite("laser1", heros.x, heros.y - (heros.h*2)/2)
        tir.v = -10
        table.insert( listeTirs, tir)

        sonShoot:play()
    end

    print(key)
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function heros.mousepressed()
end


return heros