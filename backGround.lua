
------VARIABLE------
------TABLEAU------
local backGround = {
    x = 200,
    y = 2,
    y2 = -596,
    larg = 400,
    haut = 596,
    speed = 100,
    img = love.graphics.newImage("images/background.png"),
    img2 = love.graphics.newImage("images/background2.png")
}


------FONCTION LOAD------
------FONCTION UPDATE------
------FONCTION KEYPRESSED------
------FONCTION MOUSEPRESSED------
------FONCTION UTILE------


-----LOAD----- : ACTION DU JEU AU DEMARAGE
function backGround.load()
end

-----UPDATE----- : ACTION DU JEU A CHAQUE FRAME  
function backGround.update(dt)

    backGround.y = backGround.y + backGround.speed * dt
    backGround.y2 = backGround.y2 + backGround.speed * dt
    if backGround.y > love.graphics.getHeight() then
        backGround.y = - backGround.img:getHeight()
    end
    if backGround.y2 > love.graphics.getHeight() then
        backGround.y2 = - backGround.img:getHeight()
    end
end


-----DRAW----- : DESSINE CE QUE TU VOIS A L'ECRAN
function backGround.draw()
    love.graphics.draw(backGround.img, backGround.x, backGround.y, 0, backGround.larg / backGround.img:getWidth(), backGround.haut /
        backGround.img:getHeight(), 0, 0)

    love.graphics.draw(backGround.img2, backGround.x, backGround.y2, 0, backGround.larg / backGround.img2:getWidth(), backGround.haut /
        backGround.img2:getHeight(), 0, 0)

    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", 200, 1, 400, 598)
end



-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function backGround.keypressed()
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function backGround.mousepressed()
end


return backGround





