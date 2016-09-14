local lines = {}
lines.__index = lines

function newLines()
	local l = {}
	l.x = 0
	l.y = 150
	l.z = 0
	l.width = 0
	l.height = 0

	return setmetatable(l, lines)
end

function lines:update(dt)
	self.x = self.x - SPEED

	if self.x < -4 * 64 then
		self.x = 0
	end
end

function lines:draw()
	lutro.graphics.rectangle("fill", self.x + 0*64, self.y, 64, 4)
	lutro.graphics.rectangle("fill", self.x + 2*64, self.y, 64, 4)
	lutro.graphics.rectangle("fill", self.x + 4*64, self.y, 64, 4)
	lutro.graphics.rectangle("fill", self.x + 6*64, self.y, 64, 4)
	lutro.graphics.rectangle("fill", self.x + 8*64, self.y, 64, 4)
end
