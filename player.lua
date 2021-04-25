require "collisions"

local player = {}
player.__index = player

function newPlayer()
	local n = {}
	n.width = 24
	n.height = 8
	n.x = (SCREEN_WIDTH/3 - n.width/1.5)
	n.y = (SCREEN_HEIGHT - n.height) / 2
	n.z = 1

	n.xspeed = 0
	n.xaccel = 200

	n.yspeed = 0
	n.yaccel = 200

	n.stance = "normal"

	n.animations = {
		normal = newAnimation(lutro.graphics.newImage(
				"assets/player_normal.png"),  48, 48, 1, 10),
		crashed = newAnimation(lutro.graphics.newImage(
				"assets/player_crashed.png"),  48, 48, 1, 10),
		stoped = newAnimation(lutro.graphics.newImage(
				"assets/player_stoped.png"),  48, 48, 1, 10),
	}

	n.anim = n.animations[n.stance]

	return setmetatable(n, player)
end

function player:update(dt)
	JOY_LEFT  = lutro.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_LEFT)
	JOY_RIGHT = lutro.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_RIGHT)
	JOY_UP = lutro.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_UP)
	JOY_DOWN = lutro.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_DOWN)

	if JOY_LEFT then self.xspeed = -100 end
	if JOY_RIGHT then self.xspeed = 100 end
	if JOY_UP then self.yspeed = -100 end
	if JOY_DOWN then self.yspeed = 100 end

	self.x = self.x + self.xspeed * dt
	self.y = self.y + self.yspeed * dt

	if self.x < 0 then
		self.x = 0
	end

	if self.x > SCREEN_WIDTH - self.width then
		self.x = SCREEN_WIDTH - self.width
	end

	if  not (JOY_DOWN and self.yspeed > 0)
	and not (JOY_UP and self.yspeed < 0)
	then
		if self.yspeed > 0 then
			self.yspeed = self.yspeed - 10
			if self.yspeed < 0 then
				self.yspeed = 0
			end
		elseif self.yspeed < 0 then
			self.yspeed = self.yspeed + 10
			if self.yspeed > 0 then
				self.yspeed = 0
			end
		end
	end

	if  not (JOY_RIGHT and self.xspeed > 0)
	and not (JOY_LEFT and self.xspeed < 0)
	then
		if self.xspeed > 0 then
			self.xspeed = self.xspeed - 10
			if self.xspeed < 0 then
				self.xspeed = 0
			end
		elseif self.xspeed < 0 then
			self.xspeed = self.xspeed + 10
			if self.xspeed > 0 then
				self.xspeed = 0
			end
		end
	end

	self.anim:update(dt)
end

function player:draw()
	self.anim:draw(self.x-11, self.y - 34)
end

function player:on_collide(e1, e2, dx, dy)

	-- big vehicles --
	if e2.type == "truck"
	or e2.type == "bus"
	then
		lutro.audio.play(sfx_splash)
		scrn_shake = 0.25
		STATE = 'menu'
		MENU = newGameOver()
		self.x = self.x + dx
		self.anim = self.animations.crashed

	elseif e2.type == "hole"
	then
		lutro.audio.play(sfx_fall)
		STATE = 'menu'
		MENU = newGameOver()
		self.anim = self.animations.crashed

	-- pavement --
	elseif e2.type == "pavement"
	then
		self.yspeed = -self.yspeed*2
		self.y = self.y + dy
		lutro.audio.play(sfx_touch)
		scrn_shake = 0.25
		HP = HP - 1

	-- items --
	elseif e2.type == "life"
	or e2.type == "repair"
	or e2.type == "fuel"
	or e2.type == "minifuel"
	or e2.type == "money"
	then
		for i=1, #entities do
			if entities[i] == e2 then
				table.remove(entities, i)
			end
		end

		if LAST == e2.type then
			MULT = MULT + 1
		else
			LAST = nil
			MULT = 1
		end

		gain = 0

		if e2.type == "fuel" then FUEL = 1000 end
		if e2.type == "minifuel" then
			gain = 100 * MULT
			FUEL = FUEL + gain
			table.insert(entities, newNotif({x=self.x, y=self.y, text="+" .. gain, color = {132, 206, 36}}))
			if FUEL > 1000 then
				FUEL = 1000
			end
		end
		if e2.type == "money" then
			gain = 10 * MULT
			MONEY = MONEY + gain
			table.insert(entities, newNotif({x=self.x, y=self.y, text="+" .. gain, color = {255, 255, 0}}))
		end
		if e2.type == "repair" then HP = MAX_HP end

		lutro.audio.play(sfx_pickup)

		LAST = e2.type

	-- scooters --
	elseif e2.type == "scooter"
	then
		if e2.y > self.y then
			self.yspeed = -200
			e2.yspeed = 200
		else
			self.yspeed = 200
			e2.yspeed = -200
		end
		self.y = self.y + dy
		lutro.audio.play(sfx_touch)
		scrn_shake = 0.25
		HP = HP - 1
	end
end
