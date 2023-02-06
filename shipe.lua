

------VARIABLE------
------TABLEAU------
local shipe = {
    x = 400,
    y = 500,
    angle = -90,
    img = love.graphics.newImage("images/ship.png"),
    imgEngine = love.graphics.newImage("images/engine.png"),
    engineOn = true
}
local T_SHIPE = 1.2
local V_SHIPE = 200
local VA_SHIPE = 200



------FONCTION LOAD------
------FONCTION UPDATE------

-- moveShip() permet de déplacer le vaisseau et d'activer le réacteur
function moveShipEngin(dt)
    if love.keyboard.isDown("a") then
        shipe.angle = shipe.angle - VA_SHIPE * dt
    end
    if love.keyboard.isDown("e") then
        shipe.angle = shipe.angle + VA_SHIPE * dt
    end

    if love.keyboard.isDown("down") then
        shipe.y = shipe.y + V_SHIPE * dt
    end
    if love.keyboard.isDown("right", "left", "up") then
        shipe.engineOn = true
        if love.keyboard.isDown("right") then
            shipe.x = shipe.x + V_SHIPE * dt
        end
        if love.keyboard.isDown("left") then
            shipe.x = shipe.x - V_SHIPE * dt
        end

        if love.keyboard.isDown("up") then
            shipe.y = shipe.y - V_SHIPE * dt
        end
    else
        shipe.engineOn = false
    end
end
------FONCTION DRAW------

-- drawShipEngin() permet de dessiner le vaisseau et le réacteur
function drawShipEngin()
    love.graphics.draw(shipe.img, shipe.x, shipe.y, math.rad(shipe.angle), T_SHIPE, T_SHIPE, shipe.img:getWidth()/2, shipe.img:getHeight()/2)

    if shipe.engineOn == true then
        love.graphics.draw(shipe.imgEngine, shipe.x, shipe.y,math.rad(shipe.angle), 1, 1, shipe.imgEngine:getWidth()/2, shipe.imgEngine:getHeight()/2)
    end
end
------FONCTION KEYPRESSED------
------FONCTION MOUSEPRESSED------
------FONCTION UTILE------

-----LOAD----- : ACTION DU JEU AU DEMARAGE
function shipe.load()
end


-----UPDATE----- : ACTION DU JEU A CHAQUE FRAME  
function shipe.update(dt)
    moveShipEngin(dt)
end


    -----------------------------------
    if love.mouse.isDown(1) then
        print(love.mouse.getPosition())
end

-----DRAW----- : DESSINE CE QUE TU VOIS A L'ECRAN
function shipe.draw()
    drawShipEngin()
end



-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function shipe.keypressed(key)
    print(key)
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function shipe.mousepressed()
end




return shipe