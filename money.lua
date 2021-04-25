local money = {}
money.__index = money

function newMoney(x, y, speed)
	local n = {}
	n.type = "money"
	n.width = 16
	n.height = 16
	n.x = x
	n.y = y
	n.z = 1
	n.speed = speed
	n.yspeed = 0

	n.anim = newAnimation(IMG_money,  16, 16, 1, 10)

	return setmetatable(n, money)
end

function money:update(dt)
	self.x = self.x + self.speed
	self.y = self.y + self.yspeed * dt

	self.anim:update(dt)

	if self.x < -self.width then
		entity_remove(self)
	end
end

function money:draw()
	self.anim:draw(self.x, self.y)
end

function money:on_collide(e1, e2, dx, dy)
end
