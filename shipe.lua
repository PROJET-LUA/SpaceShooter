
------VARIABLE------
------TABLEAU------
local shipe = {}
local img = love.graphics.newImage("images/shipflo.png")
local imgQuad = {}
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



    -----------------------------------
    if love.mouse.isDown(1) then
        print(love.mouse.getPosition())
    end
end


-----DRAW----- : DESSINE CE QUE TU VOIS A L'ECRAN
function shipe.draw()
end



-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function shipe.keypressed(key)
    print(key) 
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function shipe.mousepressed()
end



return shipe