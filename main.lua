local _u = require('universe')

function love.conf(t)

	t.window.width = 400
	t.window.height = 400
	t.console = true

end

function love.load()
  math.randomseed(os.time())
	love.window.setMode(400,400, {vsync=true})
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

