local _um = require('universe_manager')

function love.conf(t)

	t.window.width = 1024
	t.window.height = 800
	t.console = true

end

function love.load()
  math.randomseed(os.time())
	love.window.setMode(1024,800, {vsync=true})
  universe_manager = _um.new()
  universe_manager.create_planets(10)

end

function love.update(dt)

end


function love.keypressed(key, isrepeat)

end


function love.mousemoved(x,y,dx,dy)
		
end

function love.draw()
  universe_manager.draw_planets()
end

