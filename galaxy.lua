local galaxy = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')
local _solar_system = require('solar_system')

  function galaxy.new(universe_center, orbit_sector, radius, galaxy_position) --Galaxies orbit around some center point of the universe, assigned a sector

    local self = {}
    local position = galaxy_position
    local orbit_point = universe_center --May want to update orbit_point
    local speed = 0.001
    local radius = radius
    local orbitmanager =  _orbitmanager.new(radius, orbit_point, speed, orbit_sector) --Pass this center point to orbit manager

	--Setup solar systems here--
	local solar_systems = {}
	local no_solar_systems = 1
	local orbit_sectors = {0,1,2,3,4,5,6,7}
	
--	for i = 1, no_solar_systems, 1 do
--		local sector = orbit_sectors[math.random(#orbit_sectors)]
--		table.insert(solar_systems, _solar_system.new(position, i+4))
--		table.remove(orbit_sectors, sector)
--	end


    function self.draw()
	  love.graphics.setColor(255,0,0)
		love.graphics.print(string.format("Galaxy: %i,%i", math.floor(position.x), math.floor(position.y)), position.x,position.y)
	  love.graphics.setColor(0,0,255)
      orbitmanager.draw()
      love.graphics.circle("line", position.x, position.y, radius, 15)

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
