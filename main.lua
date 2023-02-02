

------VARIABLE------
------TABLEAU------
------FONCTION LOAD------
------FONCTION UPDATE------
------FONCTION KEYPRESSED------
------FONCTION MOUSEPRESSED------
------FONCTION UTILE------

-----LOAD----- : ACTION DU JEU AU DEMARAGE
function love.load()
end


-----UPDATE----- : ACTION DU JEU A CHAQUE FRAME  
function love.update(dt)



    -----------------------------------
    if love.mouse.isDown(1) then
        print(love.mouse.getPosition())
    end
end


-----DRAW----- : DESSINE CE QUE TU VOIS A L'ECRAN
function love.draw()
    love.graphics.rectangle("fill", 50, 50, 100, 100)
end



-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function love.keypressed(key)
    print(key) 
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function love.mousepressed()
end





















