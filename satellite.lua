local satellite = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')

  function satellite.new(planet_position, orbit_sector, radius, sat_position) --Satellites orbit a planet

	local self = {}
    local position = sat_position
    local orbit_point = planet_position --May want to update orbit_point
    local speed = math.random(1, 5) / 100
    local init_angle = orbit_sector
    local radius = radius
    local orbitmanager =  _orbitmanager.new((position.x - orbit_point.x), orbit_point, speed, orbit_sector) --Pass this center point to orbit manager
	

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
