local _u = require('universe')
local scale = 1.0
local m_start = {x = 0, y = 0}
local m_end = {x = 0, y = 0}
local offset = {x = 0, y = 0}
local offset_sum = {x = 0, y = 0}
local translate = false

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
	debug.debug()

end

function love.update(dt)
    universe.update()
end

function love.keypressed(key, isrepeat)

end

--Mouse scroll - zoom
function love.wheelmoved(x, y)
	if y > 0 then
		scale = scale + 0.1
	else
		scale = scale - 0.1
	end
end

function love.mousepressed(x, y, buttons, istouch)

	m_start.x = x
	m_start.y = y

	translate = true
end

function love.mousereleased(x, y, buttons, istouch)

	offset_sum.x = offset_sum.x + offset.x
	offset_sum.y = offset_sum.y + offset.y
	offset.x = 0
	offset.y = 0

	translate = false
end


function love.mousemoved(x,y,dx,dy)

	if translate then
		m_end.x = x
		m_end.y = y

		offset.x = m_end.x - m_start.x
		offset.y = m_end.y - m_start.y
	end

end

function love.draw()

  love.graphics.push()
	  love.graphics.scale(scale,scale)
	  love.graphics.translate(offset.x + offset_sum.x, offset.y + offset_sum.y)
	  universe.draw()
  love.graphics.pop()
end
