local repair = {}
repair.__index = repair

function newRepair(x, y, speed)
	local n = {}
	n.type = "repair"
	n.width = 24
	n.height = 16
	n.x = x
	n.y = y
	n.z = 1
	n.speed = speed
	n.yspeed = 0

	n.anim = newAnimation(IMG_repair,  32, 32, 1, 10)

	return setmetatable(n, repair)
end

function repair:update(dt)
	self.x = self.x + self.speed
	self.y = self.y + self.yspeed * dt

	self.anim:update(dt)

	if self.x < -self.width then
		entity_remove(self)
	end
end

function repair:draw()
	self.anim:draw(self.x-4, self.y - 32)
end
