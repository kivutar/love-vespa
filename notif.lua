local notif = {}
notif.__index = notif

function newNotif(object)
	local n = object
	n.y = n.y - 32
	n.z = 2
	n.width = 0
	n.height = 0
	n.yspeed = -2
	n.yaccel = 0.1

	return setmetatable(n, notif)
end

function notif:update(dt)
	self.yspeed = self.yspeed + self.yaccel
	self.y = self.y + self.yspeed

	if self.yspeed >= 0 then
		entity_remove(self)
	end
end

function notif:draw()
	lutro.graphics.setFont(FNT_numbers)
	lutro.graphics.setColor(self.color)
	lutro.graphics.print(self.text, self.x, self.y)
	lutro.graphics.setColor(255, 255, 255)
end