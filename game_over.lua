local game_over = {}
game_over.__index = game_over

function newGameOver(x, y, speed)
	local n = {}
	n.choice = 1
	n.choices = {
		{ label = "RETRY" },
		{ label = "EXIT"  },
	}
	return setmetatable(n, game_over)
end

function game_over:update(dt)

end

function game_over:draw()
	lutro.graphics.rectangle("fill", 142, 94, 100, 52)
	lutro.graphics.setColor(0,0,0)
	lutro.graphics.rectangle("fill", 144, 96, 96, 48)
	lutro.graphics.setColor(255,255,255)

	lutro.graphics.print("GAME OVER", 153, 103)

	for i,c in ipairs(self.choices) do
		local message
		if i == self.choice then
			message = "* " .. c.label
		else
			message = "  " .. c.label
		end
		lutro.graphics.print(message, 153, 108 + 10*i)
	end
end

function game_over:gamepadpressed(i, k)
	if k == "down" then
		self.choice = self.choice + 1
		lutro.audio.play(sfx_select)
	elseif k == "up" then
		self.choice = self.choice - 1
		lutro.audio.play(sfx_select)
	elseif k == "a" then
		if self.choice == 1 then
			STATE = "game"
			DISTANCE = 0
			FUEL = 100
			menu = nil
			self = nil
			entities = {}
			table.insert(entities, newLines())
			table.insert(entities, newPavementsUp())
			table.insert(entities, newPavementsDown())
			table.insert(entities, newPlayer())
		end
	end
	if self.choice < 1 then self.choice = #self.choices end
	if self.choice > #self.choices then self.choice = 1 end
end
