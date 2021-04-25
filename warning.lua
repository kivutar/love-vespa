require "collisions"

local warning = {}
warning.__index = warning

function newWarning(y)
	local n = {}
	n.type = "warning"
	n.width = 23
	n.height = 19
	n.x = SCREEN_WIDTH - 25
	n.y = y
	n.z = 4
	n.yspeed = 0
	n.t = 0

	n.anim = newAnimation(IMG_warning,  23, 19, 1, 5)

	return setmetatable(n, warning)
end

function warning:update(dt)
	self.t = self.t + dt
	self.anim:update(dt)

	if self.t > 1 then
		entity_remove(self)
	end
end

function warning:draw()
	self.anim:draw(self.x, self.y)
end
