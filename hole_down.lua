require "collisions"

local hole_down = {}
hole_down.__index = hole_down

function newHoleDown(x)
	local n = {}
	n.type = "hole"
	n.width = 256 - 64
	n.height = 50
	n.x = x + SCREEN_WIDTH
	n.y = 158 + 12
	n.z = 0

	n.anim = newAnimation(IMG_hole_down,  256, 66, 1, 10)

	return setmetatable(n, hole_down)
end

function hole_down:update(dt)
	self.x = self.x - SPEED

	if self.x < -self.width then
		for i=1, #entities do
			if entities[i] == self then
				table.remove(entities, i)
			end
		end
	end
end

function hole_down:draw()
	self.anim:draw(self.x - 32, self.y - 12)
end

function hole_down:on_collide(e1, e2, dx, dy)
end
