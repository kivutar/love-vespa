local crosswalk = {}
crosswalk.__index = crosswalk

function newCrosswalk()
	local l = {}
	l.x = SCREEN_WIDTH
	l.y = 64
	l.z = 0
	l.width = 80
	l.height = 0

	l.img = lutro.graphics.newImage("assets/crosswalk.png")

	return setmetatable(l, crosswalk)
end

function crosswalk:update(dt)
	self.x = self.x - SPEED

	if self.x < -self.width then
		for i=1, #entities do
			if entities[i] == self then
				table.remove(entities, i)
			end
		end
	end
end

function crosswalk:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end
