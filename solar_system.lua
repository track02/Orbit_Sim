local solar_system = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')
local _orbit_positioning = require('orbit_positioning')
local _planet = require('planet')

  function solar_system.new(galaxy_position, orbit_sector, radius, solsys_position) --Galaxy center - used for placement / orbit setup

    local self = {}
    local position = solsys_position
    local orbit_point = galaxy_position --May want to update orbit_point
    local speed = 0.01
    local init_angle = orbit_sector
    local radius = radius
    local orbitmanager =  _orbitmanager.new((position.x - galaxy_position.x), orbit_point, speed, orbit_sector) --Pass this center point to orbit manager

	
	--Setup solar systems here--
	local planets = {}
	local no_planets = 3
	local planet_max_radius = 5
	local planet_max_padding = 0
	local orbit_positioning = _orbit_positioning.new(position, radius, planet_max_radius, planet_max_padding)
	
	for i = 1, no_planets, 1 do

			new_planet_details = orbit_positioning.find_next_orbit() --Returns values needed to construct new solar system
			
			--table.insert(planets, _planet.new(position, 
			--								   new_planet_details.angle, 
			--								   new_planet_details.radius, 
			--								   new_planet_details.position))
			--
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
