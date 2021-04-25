require "collisions"

local bigtruck = {}
bigtruck.__index = bigtruck

function newBigTruck(x, y, speed)
	local n = {}
	n.type = "truck"
	n.width = 90
	n.height = 35
	n.x = x
	n.y = y
	n.z = 1
	n.speed = speed

	n.stance = "normal"

	local colors = {"red", "white"}

	n.color = colors[math.random(#colors)]

	n.anim = newAnimation(lutro.graphics.newImage(
			"assets/bigtruck_" .. n.color ..".png"),  90, 65, 1, 10)

	return setmetatable(n, bigtruck)
end

function bigtruck:update(dt)
	self.x = self.x + self.speed
	self.anim:update(dt)

	if self.x < -self.width then
		entity_remove(self)
	end
end

function bigtruck:draw()
	self.anim:draw(self.x, self.y - 30)
end
