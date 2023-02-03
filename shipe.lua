

------VARIABLE------
------TABLEAU------
local shipe = {
    x = 400,
    y = 500,
    angle = -90,
    speed = 3,
    img = love.graphics.newImage("images/ship.png"),
    imgEngine = love.graphics.newImage("images/engine.png"),
    engineOn = true
}




------FONCTION LOAD------
------FONCTION UPDATE------
------FONCTION KEYPRESSED------
------FONCTION MOUSEPRESSED------
------FONCTION UTILE------

-----LOAD----- : ACTION DU JEU AU DEMARAGE
function shipe.load()
end


-----UPDATE----- : ACTION DU JEU A CHAQUE FRAME  
function shipe.update(dt)
    if love.keyboard.isDown("a") then
        shipe.angle = shipe.angle - 50 * dt
    end
    if love.keyboard.isDown("e") then
        shipe.angle = shipe.angle + 50 * dt
    end

    if love.keyboard.isDown("down") then
        shipe.y = shipe.y + 200 * dt
    end
    if love.keyboard.isDown("right", "left", "up") then
        shipe.engineOn = true
        if love.keyboard.isDown("right") then
            shipe.x = shipe.x + 200 * dt
        end
        if love.keyboard.isDown("left") then
            shipe.x = shipe.x - 200 * dt
        end

        if love.keyboard.isDown("up") then
            shipe.y = shipe.y - 200 * dt
        end
    else
        shipe.engineOn = false
    end
end


    -----------------------------------
    if love.mouse.isDown(1) then
        print(love.mouse.getPosition())
end

-----DRAW----- : DESSINE CE QUE TU VOIS A L'ECRAN
function shipe.draw()
    love.graphics.draw(shipe.img, shipe.x, shipe.y, math.rad(shipe.angle), 1, 1, shipe.img:getWidth()/2, shipe.img:getHeight()/2)

    if shipe.engineOn == true then
        love.graphics.draw(shipe.imgEngine, shipe.x, shipe.y,math.rad(shipe.angle), 1, 1, shipe.imgEngine:getWidth()/2, shipe.imgEngine:getHeight()/2)
    end
end



-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function shipe.keypressed(key)
    print(key)
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function shipe.mousepressed()
end




return shipe