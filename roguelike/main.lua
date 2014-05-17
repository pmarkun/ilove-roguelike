function love.load() -- load no inicio do jogo
	love.keyboard.setKeyRepeat(true)
	
	tile = 16

	map = {}
	map.width = 40
	map.height = 30

	hero = {} -- new table for the hero
 	hero.x = 16    -- x,y coordinates of the hero
 	hero.y = 16
 	hero.speed = 1
end

function love.keypressed(key) -- loop principal do jogo // dt é o tempo passado
	if key == "left" and hero.x-hero.speed*tile >= 0 then
  		hero.x = hero.x - hero.speed*tile
 	elseif key == "right" and hero.x+hero.speed*tile <= map.width*tile-tile then
   		hero.x = hero.x + hero.speed*tile
 	elseif key == "up" and hero.y-hero.speed*tile >= 0 then
 		hero.y = hero.y - hero.speed*tile
 	elseif key == "down" and hero.y+hero.speed*tile <= map.height*tile-tile then
 		hero.y = hero.y + hero.speed*tile
	end
end

function love.draw() --desenha o que precisar ser desenhado
	-- let's draw some ground
	love.graphics.setColor(100,100,100) -- R,G,B, Luz
	love.graphics.rectangle("fill", 0, 0, map.width*tile, map.height*tile) -- mode,x,y,w,h
	-- let's draw our hero
	love.graphics.setColor(255,255,0)
	love.graphics.rectangle("fill", hero.x,hero.y, 16, 16)
end