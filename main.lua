io.stdout:setvbuf('no')
--Empèche love de filtrer les contours de l'image quand elle est redimensionnées (pixel art)
love.graphics.setDefaultFilter("nearest")
------VARIABLE------
--setFullScreen : change taille ecrant true or false
SetFullScreen = true

currentScreen = "menu"

------TABLEAU------
------FONCTION LOAD------
--chargements des images
imgMenu = love.graphics.newImage("images/menu.jpg")
imgGameOver = love.graphics.newImage("images/gameover.jpg")
imgVictory = love.graphics.newImage("images/victory.jpg")

------FONCTION UPDATE------
function updateMenu()
end
------FONCTION DRAW------
function drawMenu()
    love.graphics.draw(imgMenu, -100, -100)
end

function drawGameOver()
    love.graphics.draw(imgGameOver, -100, 0)
end

function drawVictory()
    love.graphics.draw(imgVictory, -100, 0)
end
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
    if currentScreen == "jeu" then
        myGame.Update(dt)
    elseif currentScreen == "menu" then
        updateMenu()
    end
    
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
    if currentScreen == "jeu" then
        myGame.Draw()
    elseif currentScreen == "menu" then
        drawMenu()
    elseif currentScreen == "gameOver" then
        drawGameOver()
    elseif currentScreen == "victory" then
        drawVictory()
    end
end



-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function love.keypressed(key)
    if currentScreen == "jeu" then
        myGame.keypressed(key)
    elseif currentScreen == "menu" then
        if key == "space" then
        currentScreen = "jeu"
        end
    end
    print(key)
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function love.mousepressed()
end
























