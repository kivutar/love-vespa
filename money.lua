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

	n.anim = newAnimation(lutro.graphics.newImage(
			"assets/money.png"),  16, 16, 1, 10)

	return setmetatable(n, money)
end

function money:update(dt)
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

function money:draw()
	self.anim:draw(self.x, self.y)
end

function money:on_collide(e1, e2, dx, dy)
end
