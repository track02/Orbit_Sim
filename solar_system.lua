local solar_system = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')
local _orbit_positioning = require('orbit_positioning')
local _planet = require('planet')

  function solar_system.new(galaxy_position, orbit_sector, radius, ss_position)

    local self = {}
    local position = ss_position
    local orbit_point = galaxy_position --May want to update orbit_point
    local speed = math.random(1, 5) / 100
    local init_angle = orbit_sector
    local radius = radius
    local orbitmanager =  _orbitmanager.new((position.x - orbit_point.x), orbit_point, speed, orbit_sector) --Pass this center point to orbit manager

	
	--Setup solar systems here--
	local planets = {}
	local max_planets = 0
	local planet_max_radius = radius / max_planets
	local planet_max_padding = 3
	local planet_max_speed = 10
	local orbit_positioning = _orbit_positioning.new(position, radius, planet_max_radius, planet_max_padding)
	
	for i = 1, max_planets, 1 do

		new_planet_details = orbit_positioning.find_next_orbit() --Returns values needed to construct new planet
				
			table.insert(planets, _planet.new(position, 
											   new_planet_details.angle, 
											   new_planet_details.radius, 
											   new_planet_details.position))
	end
	  

    function self.draw()
		love.graphics.setColor(255,255,255)
		love.graphics.print(string.format("System: %i,%i", math.floor(position.x), math.floor(position.y)), 0,20)
		love.graphics.setColor(255,0,0)
		orbitmanager.draw()
		love.graphics.circle("line", position.x, position.y, radius, 15)
		
		--Draw solar systems here--
		for i = 1,#planets,1 do
			planets[i].draw()
		end

    end
    
    function self.update(galaxy_orbit_vector, galaxy_position)
	
		position = _vecops.add(galaxy_orbit_vector, position)
		local orbit_vector = orbitmanager.update_orbit(position, galaxy_position)
		position = _vecops.add(orbit_vector, position)
		
		
		--Update planets here--
		for i = 1,#planets,1 do
			planets[i].update(orbit_vector, position) --Planets will orbit system, pass down vector
		end
    end

    return self

  end

return solar_system
