function love.load() -- load no inicio do jogo
	hero = {} -- new table for the hero
 	hero.x = 300    -- x,y coordinates of the hero
 	hero.y = 450
 	hero.speed = 100
end

function love.update(dt) -- loop principal do jogo // dt é o tempo passado
	if love.keyboard.isDown("left") then
  		hero.x = hero.x - hero.speed*dt
 	elseif love.keyboard.isDown("right") then
   		hero.x = hero.x + hero.speed*dt
 	elseif love.keyboard.isDown("up") then
 		hero.y = hero.y - hero.speed*dt
 	elseif love.keyboard.isDown("down") then
 		hero.y = hero.y + hero.speed*dt
 	end
end

function love.draw() --desenha o que precisar ser desenhado
	-- let's draw some ground
	love.graphics.setColor(100,100,100,255) -- R,G,B, Luz
	love.graphics.rectangle("fill", 0, 0, 640, 480) -- mode,x,y,w,h
	-- let's draw our hero
	love.graphics.setColor(255,255,0,255)
	love.graphics.rectangle("fill", hero.x,hero.y, 16, 16)
end