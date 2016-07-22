local planet = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')

  function planet.new()

    local self = {}
    local position = {x = math.random(0,800), y = math.random(0,1000)}
    local speed = 0.01
    local radius = math.random(5, 15)
   	
    local  orbitmanager =  _orbitmanager.new({x = 400, y = 500})
	  

    function self.draw()
	
		orbitmanager.draw()
		love.graphics.print(position, 10, 50)
		love.graphics.circle("line", position.x, position.y, radius, 5)

    end
    

    function self.update()
		position = _vecops.add(orbitmanager.update_orbit(position), position)
    end

    return self

  end

return planet
