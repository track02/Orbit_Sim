local planet = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')
local _satellite = require('satellite')

  function planet.new(solar_system_center, orbit_sector) --Orbits around center of solar system
	
	local solar_center = solar_system_center
    local self = {}
    local position = {x = solar_system_center.x + 12, y = solar_system_center.y + 12}
    local speed = 0.01
    local radius = 12   	
    local orbitmanager =  _orbitmanager.new(radius, solar_system_center, speed, orbit_sector)

	
	--Setup satellites systems here--
	local satellites = {}
	local no_satellites = 1
	local orbit_sectors = {0,1,2,3,4,5,6,7}
	
	for i = 1,no_satellites,1 do
		local sector = orbit_sectors[math.random(#orbit_sectors)]
		table.insert(satellites, _satellite.new(position, i))
		table.remove(orbit_sectors, sector)
	end

    function self.draw()
		love.graphics.setColor(0,255,0)
		orbitmanager.draw()
		love.graphics.circle("line", position.x, position.y, radius, 15)
		
		--Draw Satellites here
		for i = 1,#satellites,1 do
			satellites[i].draw()
		end

    end
    

    function self.update(solar_system_orbit_vector, solar_system_position)
	
		position = _vecops.add(solar_system_orbit_vector, position)
		local orbit_vector = orbitmanager.update_orbit(position, solar_system_position)
		position = _vecops.add(orbit_vector, position)
		
		--Update satellites here--
		for i = 1,#satellites,1 do
			satellites[i].update(orbit_vector, position) --Planets will orbit system, pass down vector
		end
    end

    return self

  end

return planet
