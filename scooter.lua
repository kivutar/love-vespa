require "collisions"

local scooter = {}
scooter.__index = scooter

function newScooter(x, y, speed)
	local n = {}
	n.type = "scooter"
	n.width = 24
	n.height = 8
	n.x = x
	n.y = y
	n.z = 1
	n.speed = speed
	n.yspeed = 0

	n.color = math.random(22)

	n.anim = newAnimation(lutro.graphics.newImage(
			"assets/scooter_"..n.color..".png"),  48, 48, 1, 10)

	return setmetatable(n, scooter)
end

function scooter:update(dt)
	self.x = self.x + self.speed
	self.y = self.y + self.yspeed * dt

	self.anim:update(dt)

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

	if self.x < -self.width then
		for i=1, #ENTITIES do
			if ENTITIES[i] == self then
				table.remove(ENTITIES, i)
			end
		end
	end
end

function scooter:draw()
	self.anim:draw(self.x-11, self.y - 34)
end

function scooter:on_collide(e1, e2, dx, dy)
	if e2.type == "pavement"
	then
		self.yspeed = -self.yspeed*2
		self.y = self.y + dy
	elseif e2.type == "truck"
	or e2.type == "bus"
	then
		if e2.y > self.y then
			self.yspeed = -200
			e2.yspeed = 200
		else
			self.yspeed = 200
			e2.yspeed = -200
		end
		self.y = self.y + dy
	end
end
