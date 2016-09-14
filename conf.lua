require "global"

function love.conf(t)
	t.window.width = SCREEN_WIDTH*3
	t.window.height = SCREEN_HEIGHT*3

	t.modules.audio = true
end
