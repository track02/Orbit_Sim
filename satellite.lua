local satellite = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')

  function satellite.new(planet_center) --Satellites orbit a planet

    local self = {}
    local position = {x = planet_center.x + 1, y = planet_center.y + 1}
    local speed = 0.05
    local radius = 10   	
    local orbitmanager =  _orbitmanager.new(planet_center)
	

    function self.draw()
    love.graphics.setColor(125,125,0)
		orbitmanager.draw()
		love.graphics.print(position, 10, 200)
		love.graphics.circle("line", position.x, position.y, radius, 5)

    end
    

    function self.update(planet_orbit_vector, planet_position)
	
		local orbit_vector = orbitmanager.update_orbit(position, planet_position)
		position = _vecops.add(orbit_vector, position)
		position = _vecops.add(planet_orbit_vector, position)	
		
    end

    return self

  end

return satellite
