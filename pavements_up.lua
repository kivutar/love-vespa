local pavements_up = {}
pavements_up.__index = pavements_up

function newPavementsUp()
	local l = {}
	l.type = "pavement"
	l.x = 0
	l.y = 0
	l.z = 0
	l.width = 112*6
	l.height = 80

	return setmetatable(l, pavements_up)
end

function pavements_up:update(dt)
	self.x = self.x - SPEED

	if self.x < -2 * 112 then
		self.x = 0
	end
end

function pavements_up:draw()
	lutro.graphics.draw(IMG_pavement_up, self.x + 0*112, self.y)
	lutro.graphics.draw(IMG_pavement_up, self.x + 1*112, self.y)
	lutro.graphics.draw(IMG_pavement_up, self.x + 2*112, self.y)
	lutro.graphics.draw(IMG_pavement_up, self.x + 3*112, self.y)
	lutro.graphics.draw(IMG_pavement_up, self.x + 4*112, self.y)
	lutro.graphics.draw(IMG_pavement_up, self.x + 5*112, self.y)
end

function pavements_up:on_collide(e1, e2, dx, dy)
end
