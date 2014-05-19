math.randomseed( os.time() )

function love.load() -- load no inicio do jogo
	love.keyboard.setKeyRepeat(true)

	tile_size = 16

	map = {}
	map.grid = {
		{ '#','#','#','#','#','#','#','#','#' },
		{ '#','0','0','0','0','0','0','0','#' },
		{ '#','0','0','0','0','0','0','0','#' },
		{ '#','0','0','0','0','0','0','0','#' },
		{ '#','0','0','0','0','0','0','0','#' },
		{ '#','0','B','0','0','0','0','0','#' },
		{ '#','0','0','0','0','0','0','0','#' },
		{ '#','#','#','#','#','#','#','#','#' },
	} -- ToDo: transformar tudo para 1/16 e só no draw mudar
	
	map.grid = generateRoom(30,30)
	map.width = #map.grid[1]-1
	map.height = #map.grid-1
	


	
	library = {}
	
	library["#"] = {
		name = "wall",
		color = {255,255,255}
	}

	library["0"] = {
		name = "floor",
		color = {0,0,0},
	}

	library["@"] = {
		name = "hero",
		color = {0,255,255},
	}

	library["B"] = {
		name = 'boulder',
		color = {100,100,100},
	}
	
	hero = {}
	hero.x = 2
	hero.y = 2
	hero.speed = 1

	map.grid[hero.y][hero.x] = '@' -- inicializa a posicao do hero

 	boulders = {}
 	for i = 0, 10 do --generate boulders
 		pos_x = math.random(1,map.width)
 		pos_y = math.random(1,map.height)
 		if map.grid[pos_x][pos_y] == '0' then
 			map.grid[pos_x][pos_y] = 'B'
 		end
	end
end

function generateRoom(h, w)
	local room = {}
	for row = 1,h do
		room[row] = {}
		for col = 1,w do
			if row == 1 or row == w then
				table.insert(room[row], '#')
			elseif col == 1 or col == h then
				table.insert(room[row], '#')
			else
				table.insert(room[row], '0')
			end
		end
	end
	return room
end

function turn()
end

function love.keypressed(key) -- ativado cada vez que uma tecla é apertada; como é um roguelike os turnos são baseados em keypresses
	local next_pos = { y = hero.y, x = hero.x }

	if key == "left" and hero.x > 1 then
		next_pos.x = hero.x - 1
  		turn()
 	elseif key == "right" and hero.x < map.width then
 		next_pos.x = hero.x + 1
   		turn()
 	elseif key == "up" and hero.y > 1 then
 		next_pos.y = hero.y - 1
 		turn()
 	elseif key == "down" and hero.y < map.height then
 		next_pos.y = hero.y + 1
 		turn()
	end
	
	if map.grid[next_pos.x][next_pos.y] == '0' then --trocar por uma flag
		map.grid[hero.x][hero.y] = '0'
		hero.x = next_pos.x
		hero.y = next_pos.y
		map.grid[hero.x][hero.y] = '@'
	end
end

function love.draw() --desenha o que precisar ser desenhado
	for x, row in pairs(map.grid) do
		for y, tile in pairs(row) do
			local t = library[tile]
			love.graphics.setColor(t.color[1],t.color[2],t.color[3])
			love.graphics.rectangle("fill", (x-1)*tile_size,(y-1)*tile_size, tile_size, tile_size)

		end
	end
end
