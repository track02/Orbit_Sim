local planet = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')
local _orbit_positioning = require('orbit_positioning')
local _satellite = require('satellite')

  function planet.new(ss_position, orbit_sector, radius, planet_position) --Orbits around center of solar system
	
    local self = {}
    local position = planet_position
    local orbit_point = ss_position --May want to update orbit_point
    local speed = math.random(1, 5) / 100
    local init_angle = orbit_sector
    local radius = radius
    local orbitmanager =  _orbitmanager.new((position.x - orbit_point.x), orbit_point, speed, orbit_sector) --Pass this center point to orbit manager

	
	--Setup satellites systems here--
	local satellites = {}
	local max_satellites = 3
	local satellite_max_padding = 1
	local satellite_max_radius = (radius - (satellite_max_padding * max_satellites)) / max_satellites
	local satellite_max_speed = 15
	local orbit_positioning = _orbit_positioning.new(position, radius, satellite_max_radius, satellite_max_padding)
	
	for i = 1, max_satellites, 1 do

		new_sat_details = orbit_positioning.find_next_orbit() --Returns values needed to construct new planet

			table.insert(satellites, _satellite.new(position, 
											   new_sat_details.angle, 
											   new_sat_details.radius, 
											   new_sat_details.position,
											   1))

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
