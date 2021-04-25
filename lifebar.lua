local lifebar = {}
lifebar.__index = lifebar

function newLifeBar()
	local n = {}
	n.x = 0
	n.y = 0
	n.z = 2
	n.height = 8

	return setmetatable(n, lifebar)
end

function lifebar:draw()
	local hp = HP
	for i=1, MAX_HP do
		local heart
		if hp >= 1 then
			heart = IMG_heart_full
		elseif hp == 0.5 then
			heart = IMG_heart_half
		else
			heart = IMG_heart_empty
		end
		lutro.graphics.draw(heart, (i-1) * 8 + 4, 16)
		hp = hp - 1
	end
end
