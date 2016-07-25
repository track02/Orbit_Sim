local galaxy = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')
local _solar_system = require('solar_system')

  function galaxy.new(universe_center) --Galaxies orbit around some center point of the universe

    local self = {}
    local position = {x = 256, y = 200}
    local speed = 0.0001
    local radius = 100
    local orbitmanager =  _orbitmanager.new(universe_center) --Pass this center point to orbit manager
	
	--Setup solar systems here--
	local solar_systems = {}
	local no_solar_systems = 1
	
	for i = 1, no_solar_systems, 1 do
		table.insert(solar_systems, _solar_system.new(position))
	end
		

    function self.draw()
      love.graphics.setColor(0,0,255)
      orbitmanager.draw()
      love.graphics.print(position, 10, 50)
      love.graphics.circle("line", position.x, position.y, radius, 5)
      
      --Draw solar systems here--
      for i = 1,#solar_systems,1 do
        solar_systems[i].draw()
      end
		
    end
    

    function self.update()
	
		local orbit_vector = orbitmanager.update_orbit(position, {x = 512, y=400})
		position = _vecops.add(orbit_vector, position)
		
		--Update solar systems here--
		for i = 1,#solar_systems,1 do
			solar_systems[i].update(orbit_vector, position) --Solar systems will orbit with galaxy, need the vector
		end
    end

    return self

  end

return galaxy
