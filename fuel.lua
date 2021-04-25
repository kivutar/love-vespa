local fuel = {}
fuel.__index = fuel

function newFuel(x, y, speed)
	local n = {}
	n.type = "fuel"
	n.width = 24
	n.height = 16
	n.x = x
	n.y = y
	n.z = 1
	n.speed = speed
	n.yspeed = 0

	n.anim = newAnimation(IMG_fuel,  32, 32, 1, 10)

	return setmetatable(n, fuel)
end

function fuel:update(dt)
	self.x = self.x + self.speed
	self.y = self.y + self.yspeed * dt

	self.anim:update(dt)

	if self.x < -self.width then
		for i=1, #ENTITIES do
			if ENTITIES[i] == self then
				table.remove(ENTITIES, i)
			end
		end
	end
end

function fuel:draw()
	self.anim:draw(self.x-4, self.y - 32)
end

function fuel:on_collide(e1, e2, dx, dy)
end
