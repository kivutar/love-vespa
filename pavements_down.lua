local pavements_down = {}
pavements_down.__index = pavements_down

function newPavementsDown()
	local l = {}
	l.type = "pavement"
	l.x = 0
	l.y = 224+7
	l.z = 2
	l.width = 112*6
	l.height = 16+7

	return setmetatable(l, pavements_down)
end

function pavements_down:update(dt)
	self.x = self.x - SPEED

	if self.x < -2 * 112 then
		self.x = 0
	end
end

function pavements_down:draw()
	lutro.graphics.draw(IMG_pavement_down, self.x + 0*112, self.y-7)
	lutro.graphics.draw(IMG_pavement_down, self.x + 1*112, self.y-7)
	lutro.graphics.draw(IMG_pavement_down, self.x + 2*112, self.y-7)
	lutro.graphics.draw(IMG_pavement_down, self.x + 3*112, self.y-7)
	lutro.graphics.draw(IMG_pavement_down, self.x + 4*112, self.y-7)
	lutro.graphics.draw(IMG_pavement_down, self.x + 5*112, self.y-7)
end

function pavements_down:on_collide(e1, e2, dx, dy)
end
