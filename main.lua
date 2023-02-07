io.stdout:setvbuf('no')
--Empèche love de filtrer les contours de l'image quand elle est redimensionnées (pixel art)
love.graphics.setDefaultFilter("nearest")
------VARIABLE------
--setFullScreen : change taille ecrant true or false
SetFullScreen = true

------TABLEAU------
------FONCTION LOAD------
------FONCTION UPDATE------
------FONCTION KEYPRESSED------
------FONCTION MOUSEPRESSED------
------FONCTION UTILE------
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
    myGame.Update(dt)
    -----------------------------------
    if love.mouse.isDown(1) then
        print(love.mouse.getPosition())
    end
end


-----DRAW----- : DESSINE CE QUE TU VOIS A L'ECRAN
function love.draw()
    --full screen scale
    if (SetFullScreen) then love.graphics.scale(scale_x,scale_y) end
    ----------------------------------------------------
    myGame.Draw()
end



-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function love.keypressed(key)
    myGame.keypressed(key)
    print(key)
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function love.mousepressed()
end
























