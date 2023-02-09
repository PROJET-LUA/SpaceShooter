hero = {}
hero.x = 400+8
hero.y = 550
hero.w = 16
hero.h = 16
hero.speed = 100


local imgHero = love.graphics.newImage("images/flo/hero.png")

function loadQuadHero()
    hero.quad = {}
    for i = 1, 2, 1 do
        for j = 1, 3 , 1 do
            hero.quad[(i - 1) * 3 + j] = love.graphics.newQuad((i-1) * 16, (j-1) * 16, 16, 16, imgHero)
        end
    end 
end

function moveHero(dt)
    if love.keyboard.isDown("right") and hero.x < 600 - hero.w  then
        hero.x = hero.x + (hero.speed * dt)
    end
    if love.keyboard.isDown("left") and hero.x > 200 then
        hero.x = hero.x - (hero.speed * dt)

    end
    if love.keyboard.isDown("up") and hero.y > 0 then
        hero.y = hero.y - (hero.speed * dt)

    end
    if love.keyboard.isDown("down") and hero.y < 600 - hero.h then
        hero.y = hero.y + (hero.speed * dt)

    end
end

hero.load = function()
    loadQuadHero()
end

hero.update = function(dt)
    moveHero(dt)
end

hero.draw = function()
    love.graphics.draw(imgHero, hero.quad[3], hero.x, hero.y, math.rad(180),1,1,16,16)
end


return hero