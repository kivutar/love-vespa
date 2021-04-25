require "collisions"

local truck = {}
truck.__index = truck

function newTruck(x, y, speed)
	local n = {}
	n.type = "truck"
	n.width = 75
	n.height = 35
	n.x = x
	n.y = y
	n.z = 1
	n.speed = speed

	n.stance = "normal"

	local colors = {"blue", "red", "white"}

	n.color = colors[math.random(#colors)]

	n.anim = newAnimation(lutro.graphics.newImage(
			"assets/truck_" .. n.color ..".png"),  75, 55, 1, 10)

	return setmetatable(n, truck)
end

function truck:update(dt)
	self.x = self.x + self.speed
	self.anim:update(dt)

	if self.x < -self.width then
		entity_remove(self)
	end
end

function truck:draw()
	self.anim:draw(self.x, self.y - 20)
end

function truck:on_collide(e1, e2, dx, dy)
end
