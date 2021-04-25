local life = {}
life.__index = life

function newLife(x, y, speed)
	local n = {}
	n.type = "life"
	n.width = 24
	n.height = 16
	n.x = x
	n.y = y
	n.z = 1
	n.speed = speed
	n.yspeed = 0

	n.anim = newAnimation(IMG_life,  32, 32, 1, 10)

	return setmetatable(n, life)
end

function life:update(dt)
	self.x = self.x + self.speed
	self.y = self.y + self.yspeed * dt

	self.anim:update(dt)

	if self.x < -self.width then
		for i=1, #entities do
			if entities[i] == self then
				table.remove(entities, i)
			end
		end
	end
end

function life:draw()
	self.anim:draw(self.x-4, self.y - 32)
end

function life:on_collide(e1, e2, dx, dy)

end
