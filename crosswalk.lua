local crosswalk = {}
crosswalk.__index = crosswalk

function newCrosswalk()
	local l = {}
	l.x = SCREEN_WIDTH
	l.y = 64
	l.z = 0
	l.width = 80
	l.height = 0

	return setmetatable(l, crosswalk)
end

function crosswalk:update(dt)
	self.x = self.x - SPEED

	if self.x < -self.width then
		entity_remove(self)
	end
end

function crosswalk:draw()
	lutro.graphics.draw(IMG_crosswalk, self.x, self.y)
end
