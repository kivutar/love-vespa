local minifuel = {}
minifuel.__index = minifuel

function newMinifuel(x, y, speed)
	local n = {}
	n.type = "minifuel"
	n.width = 16
	n.height = 16
	n.x = x
	n.y = y
	n.z = 1
	n.speed = speed
	n.yspeed = 0

	n.anim = newAnimation(IMG_minifuel,  16, 16, 1, 10)

	return setmetatable(n, minifuel)
end

function minifuel:update(dt)
	self.x = self.x + self.speed
	self.y = self.y + self.yspeed * dt

	self.anim:update(dt)

	if self.x < -self.width then
		entity_remove(self)
	end
end

function minifuel:draw()
	self.anim:draw(self.x, self.y)
end

function minifuel:on_collide(e1, e2, dx, dy)
end
