math.randomseed( os.time() )

function randomPlace(first, last)
	local first = first * tile
	local last = last * tile
	local stepSize = tile
    local maxSteps = math.floor((last-first)/stepSize)
    return first + stepSize * math.random(0, maxSteps)
end

function love.load() -- load no inicio do jogo
	love.keyboard.setKeyRepeat(true)

	tile = 16

	map = {}
	map.width = 40
	map.height = 30
	map.grid = {} -- ToDo: transformar tudo para 1/16 e só no draw mudar

	hero = {} -- new table for the hero
 	hero.x = 16    -- x,y coordinates of the hero
 	hero.y = 16
 	hero.speed = 1
 	hero.size = 1

 	boulders = {}
 	for i = 0, 10 do --generate boulders
 		pos_x = randomPlace(0,map.width-tile)
 		pos_y = randomPlace(0,map.height-tile)
 		if pos_x ~= hero.x or pos_y ~= hero.y then
 			boulders[i] = { x = pos_x, y = pos_y, size = 1 }
 		end
	end
end

function move(what, direction, speed) -- funcao para mover coisas
	if direction == "left" and what.x-speed*tile >= 0 then
  		what.x = what.x - speed*tile
 	elseif direction == "right" and what.x+speed*tile <= map.width*tile-tile then
   		what.x = what.x + speed*tile
 	elseif direction == "up" and what.y-speed*tile >= 0 then
 		what.y = what.y - speed*tile
 	elseif direction == "down" and what.y+speed*tile <= map.height*tile-tile then
 		what.y = what.y + speed*tile
	end
end

function check(what, sight)
	local status = { left = "empty"}
	return status
end
function turn()
end

function love.keypressed(key) -- ativado cada vez que uma tecla é apertada; como é um roguelike os turnos são baseados em keypresses
	if key == "left" then
		status = check(hero, hero.speed*hero.size)
		if status.left == "empty" then
  			move(hero, "left", hero.speed*hero.size)
  		elseif status.left == "boulder" then
  			print("boulder") --to fix
  		end
  		turn()
 	elseif key == "right" then
   		move(hero, "right", hero.speed*hero.size)
   		turn()
 	elseif key == "up" then
 		move(hero, "up", hero.speed*hero.size)
 		turn()
 	elseif key == "down" then
 		move(hero, "down", hero.speed*hero.size)
 		turn()
	end
end

function love.draw() --desenha o que precisar ser desenhado
	-- let's draw some ground
	love.graphics.setColor(100,100,100) -- R,G,B, Luz
	love.graphics.rectangle("fill", 0, 0, map.width*tile, map.height*tile) -- mode,x,y,w,h
	-- let's draw our hero
	love.graphics.setColor(255,255,0)
	love.graphics.rectangle("fill", hero.x,hero.y, hero.size*tile, hero.size*tile)

	-- let's draw our boulder
	love.graphics.setColor(255,255,255)
	for key, boulder in pairs(boulders) do
		love.graphics.rectangle("fill", boulder.x,boulder.y, boulder.size*tile, boulder.size*tile)
	end
end