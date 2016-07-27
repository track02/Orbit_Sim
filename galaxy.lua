local galaxy = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')
local _solar_system = require('solar_system')

  function galaxy.new(universe_center) --Galaxies orbit around some center point of the universe

    local self = {}
    local position = {x = universe_center.x + 50, y = universe_center.y + 50}
	local orbit_point = universe_center --May want to update orbit_point
    local speed = 0.0001
    local radius = 50
    local orbitmanager =  _orbitmanager.new(orbit_point, speed) --Pass this center point to orbit manager
	
	--Setup solar systems here--
	local solar_systems = {}
	local no_solar_systems = 1
	
	for i = 1, no_solar_systems, 1 do
		table.insert(solar_systems, _solar_system.new(position))
	end
		

    function self.draw()
	  love.graphics.setColor(255,255,255)
		love.graphics.print(string.format("Galaxy: %i,%i", math.floor(position.x), math.floor(position.y)), 0,0)
	  love.graphics.setColor(0,0,255)
      orbitmanager.draw()
      love.graphics.circle("line", position.x, position.y, radius, 10)
      
      --Draw solar systems here--
      for i = 1,#solar_systems,1 do
        solar_systems[i].draw()
      end
		
    end
    

    function self.update()
	
		local orbit_vector = orbitmanager.update_orbit(position, orbit_point)
		position = _vecops.add(orbit_vector, position)
		
		--Update solar systems here--
		for i = 1,#solar_systems,1 do
			solar_systems[i].update(orbit_vector, position) --Solar systems will orbit with galaxy, need the vector
		end
    end

    return self

  end

return galaxy
