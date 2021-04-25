lutro = love

require "global"
require "anim"
require "player"
require "truck"
require "bigtruck"
require "scooter"
require "bus"
require "fuel"
require "repair"
require "life"
require "lines"
require "crosswalk"
require "pavements_up"
require "pavements_down"
require "hole_down"
require "hole_up"
require "game_over"
require "warning"
require "minifuel"
require "money"
require "notif"
require "lifebar"

function newRandomItem(x, y, speed)
	r = math.random(10)
	if r == 1 then
		return newLife(x, y, speed)
	elseif r < 4 then
		return newFuel(x, y, speed)
	elseif r < 6 then
		return newRepair(x, y, speed)
	else
		return newRepair(x, y, speed)
	end
end

function lutro.load()
	love.graphics.setDefaultFilter("nearest", "nearest", 0)

	love.audio.setVolume(1)

	math.randomseed(os.time())

	SFX_touch = lutro.audio.newSource("assets/touch.wav", "static")
	SFX_pickup = lutro.audio.newSource("assets/pickup.wav", "static")
	SFX_splash = lutro.audio.newSource("assets/splash.wav", "static")
	SFX_select = lutro.audio.newSource("assets/select.wav", "static")
	SFX_fall = lutro.audio.newSource("assets/fall.wav", "static")

	BGM_labbed = lutro.audio.newSource("assets/labbed.ogg", "stream")
	BGM_labbed:setVolume(1)
	love.audio.play(BGM_labbed)

	IMG_warning = lutro.graphics.newImage("assets/warning.png")
	IMG_repair = lutro.graphics.newImage("assets/repair.png")
	IMG_life = lutro.graphics.newImage("assets/life.png")
	IMG_hole_up = lutro.graphics.newImage("assets/hole_up.png")
	IMG_hole_down = lutro.graphics.newImage("assets/hole_down.png")
	IMG_fuel = lutro.graphics.newImage("assets/fuel.png")
	IMG_crosswalk = lutro.graphics.newImage("assets/crosswalk.png")

	font = lutro.graphics.newImageFont("assets/font.png", " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789*:|=-<>./'\"+$")
	lutro.graphics.setFont(font)

	moneyfont = lutro.graphics.newImageFont("assets/moneyfont.png", "0123456789$")
	numbersfont = lutro.graphics.newImageFont("assets/numbersfont.png", "0123456789+")

	MENU = nil

	SHAKE = 0

	lutro.graphics.setBackgroundColor(64, 64, 64)
	table.insert(ENTITIES, newLines())
	table.insert(ENTITIES, newPavementsUp())
	table.insert(ENTITIES, newPavementsDown())
	player = newPlayer()
	table.insert(ENTITIES, player)
	table.insert(ENTITIES, newLifeBar())

	challenges = {
		function ()
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH,
				90,
				- SPEED/1.5
			))
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH + 30,
				115,
				- SPEED/1.5
			))
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH + 30,
				200,
				- SPEED/1.5
			))
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH,
				225,
				- SPEED/1.5
			))
			table.insert(ENTITIES, newBus(
				SCREEN_WIDTH + 400,
				152,
				- SPEED/1
			))
		end,
		function ()
			table.insert(ENTITIES, newBigTruck(
				SCREEN_WIDTH,
				75 + math.random(120),
				- SPEED/2.5
			))
		end,
		function ()
			table.insert(ENTITIES, newBus(
				SCREEN_WIDTH,
				75 + math.random(120),
				- SPEED/2.5
			))
		end,
		function ()
			table.insert(ENTITIES, newTruck(
				SCREEN_WIDTH,
				100,
				- SPEED/(math.random(3)+1)
			))
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH + math.random()*40,
				170,
				- SPEED/(math.random(3)+1)
			))
		end,
		function ()
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH + math.random()*30,
				100,
				- SPEED/(math.random(3)+1)
			))
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH + math.random()*40,
				170,
				- SPEED/(math.random(3)+1)
			))
		end,
		function ()
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH + math.random()*30,
				100,
				- SPEED/(math.random(3)+1)
			))
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH + math.random()*40,
				145,
				- SPEED/(math.random(3)+1)
			))
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH + math.random()*40,
				190,
				- SPEED/(math.random(3)+1)
			))
		end,
		function ()
			local y = math.random(115) + 80
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH,
				y,
				- SPEED/2
			))
			table.insert(ENTITIES, newRandomItem(
				SCREEN_WIDTH,
				y+20,
				- SPEED/2
			))
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH,
				y+40,
				- SPEED/2
			))
		end,
		function ()
			table.insert(ENTITIES, newTruck(
				SCREEN_WIDTH,
				75 + math.random(60),
				- SPEED/2.5
			))
			table.insert(ENTITIES, newScooter(
				SCREEN_WIDTH + math.random()*40,
				75 + 60 + math.random(60),
				- SPEED/(math.random(3)+1)
			))
		end,
		function ()
			table.insert(ENTITIES, newCrosswalk())
		end,
		function ()
			table.insert(ENTITIES, newHoleDown(300))
			table.insert(ENTITIES, newWarning(182))
		end,
		function ()
			table.insert(ENTITIES, newHoleUp(300))
			table.insert(ENTITIES, newWarning(102))
		end,

	}

	lx = 0
end

function compare(a, b)
	if a.z == b.z then
		return a.y + a.height/2 < b.y + b.height/2
	else
		return a.z < b.z
	end
end

function lutro.update(dt)
	if SHAKE > 0 then
		SHAKE = SHAKE - dt
	end

	if STATE == 'game' then
		game_update(dt)
	end

	if FUEL <= 0 then
		FUEL = 0
	end
end

function game_update(dt)
	DISTANCE = DISTANCE + SPEED
	COUNTER = COUNTER + SPEED

	if COUNTER > 800 then
		challenges[math.random(#challenges)]()

		local r = math.random(2)
		if r == 1 then
			table.insert(ENTITIES, newMinifuel(
				SCREEN_WIDTH,
				75 + math.random(120),
				- SPEED/(math.random(3)+1)
			))
		elseif r == 2 then
			table.insert(ENTITIES, newMoney(
				SCREEN_WIDTH,
				75 + math.random(120),
				- SPEED/(math.random(3)+1)
			))
		end

		COUNTER = 0
		FUEL = FUEL - 3
	end

	if FUEL <= 0 then
		FUEL = 0
		lutro.audio.play(SFX_fall)
		STATE = 'menu'
		MENU = newGameOver()
		player.anim = player.animations.stoped
	end

	if HP <= 0 then
		HP = 0
		lutro.audio.play(SFX_fall)
		STATE = 'menu'
		MENU = newGameOver()
		player.anim = player.animations.crashed
	end

	for i=1, #ENTITIES do
		if ENTITIES[i] and ENTITIES[i].update then
			ENTITIES[i]:update(dt)
		end
	end
	detect_collisions()
	table.sort(ENTITIES, compare)
end

function lutro.draw()
	lutro.graphics.clear()

	-- Shake camera if hit
	if SHAKE > 0 then
		lutro.graphics.translate(5*(math.random()-0.5),5*(math.random()-0.5))
	end

	for i=1, #ENTITIES do
		if ENTITIES[i].draw then
			ENTITIES[i]:draw()
		end
	end

	-- lutro.graphics.print("DISTANCE: " .. math.floor(DISTANCE/10) .. "m", 3, 3)
	-- lutro.graphics.print("SPEED: " .. SPEED*10 .. "m", 3, 13)
	-- lutro.graphics.print("ARMOR: " .. ARMOR, 3, 23)

	lutro.graphics.setFont(moneyfont)
	love.graphics.setColor(255, 255, 0)
	love.graphics.print("$" .. math.floor(MONEY), 260, 4)
	lutro.graphics.setFont(font)
	love.graphics.setColor(255, 255, 255)

	if STATE == "menu" then
		MENU:draw()
	end

	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", 4, 4, 1000/5.0+2, 8)
	love.graphics.setColor(59, 92, 16)
	love.graphics.rectangle("fill", 5, 5, 1000/5.0, 8-2)
	love.graphics.setColor(132, 206, 36)
	love.graphics.rectangle("fill", 5, 5, FUEL/5.0, 8 - 2)
	love.graphics.setColor(255, 255, 255)
end

function lutro.gamepadpressed(i, k)
	if STATE == 'menu' then
		MENU:gamepadpressed(i, k)
	end
end

function lutro.gamepadreleased(i, k)
end
