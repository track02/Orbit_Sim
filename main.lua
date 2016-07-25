local _u = require('universe')

function love.conf(t)

	t.window.width = 1024
	t.window.height = 800
	t.console = true

end

function love.load()
  math.randomseed(os.time())
	love.window.setMode(1024,800, {vsync=true})
  	universe = _u.new()
	universe.build()

end

function love.update(dt)
    universe.update()
end


function love.keypressed(key, isrepeat)

end


function love.mousemoved(x,y,dx,dy)
		
end

function love.draw()
  universe.draw()
end

