------VARIABLE------
------TABLEAU------
local backGround = {}
local img = love.graphics.newImage("images/star.png")
local imgQuad = {}
local listEtoile = {}
local NB_STAR = 200 --Nombre d'étoile
local TAILLE_STAR = 0.5 --Taille d'étoile
local VX_MAX = 22 --Vitesse maxX d'étoile 
local VY_MAX = 40 --Vitesse maxY d'étoile 
local VT_MIN = 2 --Vitesse min d'étoile 
local NB_STAR_QUAD = 9



------FONCTION LOAD------
------FONCTION UPDATE------
function createStat()
    local etoile = {
        quad =  math.floor(math.random(1,NB_STAR_QUAD)),
        x = math.random(200,600),
        y = math.random(-600,0),
        vy = math.random(VT_MIN,VY_MAX),
    }

    if etoile.x > 400 then
        etoile.vx = math.random(0,VX_MAX)
    else
        etoile.vx = - math.random(VX_MAX,0) 
    end

    table.insert(listEtoile, etoile)
end
------FONCTION KEYPRESSED------
------FONCTION MOUSEPRESSED------
------FONCTION UTILE------



-----LOAD----- : ACTION DU JEU AU DEMARAGE
function backGround.load()
    for i = 1,NB_STAR_QUAD do
        imgQuad[i] = love.graphics.newQuad((i-1) * 16, 0,16,16,img)
    end
end

-----UPDATE----- : ACTION DU JEU A CHAQUE FRAME  
function backGround.update(dt)

    if #listEtoile < NB_STAR then
        createStat()
    end

    for i = #listEtoile, 1, -1 do
        local s = listEtoile[i]
        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt
    
        if s.x > 584 or s.x < 200 or s.y > 600 then
            table.remove(listEtoile,i)
        end
    end
end


-----DRAW----- : DESSINE CE QUE TU VOIS A L'ECRAN
function backGround.draw()
    for i = #listEtoile, 1, -1 do
        local s = listEtoile[i]

        love.graphics.draw(img,imgQuad[s.quad],s.x,s.y,0, TAILLE_STAR)
    end    
    love.graphics.rectangle("line", 200,0,400,600)
end



-----KEYPRESSED----- : ACTION DU JOUEUR CLAVIER
function backGround.keypressed()
end

-----MOUSEPRESSED----- : ACTION DU JOUEUR SOURIS
function backGround.mousepressed()
end


return backGround





