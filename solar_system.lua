local solar_system = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')
local _planet = require('planet')

  function solar_system.new(galaxy_center) --Galaxy center - used for placement / orbit setup

    local self = {}
    local position = {x = galaxy_center.x + 25, y = galaxy_center.y + 25}
    local speed = 0.001
    local radius = 25   	
    local  orbitmanager =  _orbitmanager.new(galaxy_center, speed)
	
	--Setup planets systems here--
	local planets = {}
	local no_planets = 1
	
	for i = 1,no_planets,1 do
		table.insert(planets, _planet.new(position))
	end
	  

    function self.draw()
		love.graphics.setColor(255,255,255)
		love.graphics.print(string.format("System: %i,%i", math.floor(position.x), math.floor(position.y)), 0,20)
		love.graphics.setColor(255,0,0)
		orbitmanager.draw()
		love.graphics.circle("line", position.x, position.y, radius, 5)
		
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
