local satellite = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')

  function satellite.new(planet_center, orbit_sector) --Satellites orbit a planet

    local self = {}
    local position = {x = planet_center.x + 5, y = planet_center.x + 5}
    local speed = 0.05
    local radius = 5   	
    local orbitmanager =  _orbitmanager.new(radius, planet_center, speed, orbit_sector)
	

    function self.draw()
	
		love.graphics.setColor(255,255,255)
		love.graphics.print(string.format("Satellite: %i,%i", math.floor(position.x), math.floor(position.y)), 0,60)
		love.graphics.setColor(125,125,0)
		orbitmanager.draw()
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
