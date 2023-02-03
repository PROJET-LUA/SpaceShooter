------VARIABLE------ salut
--setFullScreen : change taille ecrant true or false
SetFullScreen = false

------TABLEAU------
------FONCTION LOAD------
------FONCTION UPDATE------
------FONCTION KEYPRESSED------
------FONCTION MOUSEPRESSED------
------FONCTION UTILE------
local backGround = require("backGround")
local myGame = require("game")

-----LOAD----- : ACTION DU JEU AU DEMARAGE
function love.load()
    if (SetFullScreen) then
        love.window.setFullscreen(true)
        screenWidth, screenHeight = love.window.getMode()
        scale_x = screenWidth / 800
        scale_y = screenHeight / 600
    end
    myGame.Load()
end

-----UPDATE----- : ACTION DU JEU A CHAQUE FRAME  
function love.update(dt)
    backGround.update(dt)

    -----------------------------------
    if love.mouse.isDown(1) then
        print(love.mouse.getPosition())
    end
    myGame.Update(dt)
end


-----DRAW----- : DESSINE CE QUE TU VOIS A L'ECRAN
function love.draw()
    --full screen scale
    if (SetFullScreen) then love.graphics.scale(scale_x,scale_y) end
    ----------------------------------------------------
    backGround.draw()
    myGame.Draw()
end



-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function love.keypressed(key)
    print(key)
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function love.mousepressed()
end
























