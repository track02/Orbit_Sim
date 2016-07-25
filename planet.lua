local planet = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')
local _satellite = require('satellite')

  function planet.new(solar_system_center) --Orbits around center of solar system

    local self = {}
    local position = {x = solar_system_center.x + 3, y = solar_system_center.y + 3}
    local speed = 0.01
    local radius = 50   	
    local orbitmanager =  _orbitmanager.new(solar_system_center)
	
	--Setup satellites systems here--
	local satellites = {}
	local no_satellites = 1
	
	for i = 1,no_satellites,1 do
		table.insert(satellites, _satellite.new(position))
	end

    function self.draw()
    love.graphics.setColor(0,255,0)
		orbitmanager.draw()
		love.graphics.print(position, 10, 150)
		love.graphics.circle("line", position.x, position.y, radius, radius)
		
		--Draw Satellites here
		for i = 1,#satellites,1 do
			satellites[i].draw()
		end

    end
    

    function self.update(solar_system_orbit_vector, solar_system_position)
	
		local orbit_vector = orbitmanager.update_orbit(position, solar_system_position)
		position = _vecops.add(orbit_vector, position)
		position = _vecops.add(solar_system_orbit_vector, position)
		
		--Update satellites here--
		for i = 1,#satellites,1 do
			satellites[i].update(orbit_vector, position) --Planets will orbit system, pass down vector
		end
    end

    return self

  end

return planet
