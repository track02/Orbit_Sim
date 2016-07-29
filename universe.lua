local universe = {}
local _galaxy = require('galaxy')

--The universe sits at the topmost level and contains every object in play
--The general hierarchy is as follows, with each parent being responsible for its immediate child
--Universe -> Galaxy -> (Solar) System -> Planet -> Satellite

function universe.new()

    local self = {}
    local galaxies = {}
    local position = {x = 200, y = 200} --Center, galaxy rotation point
	
	local radius = 100

	--Build values
	local no_galaxies = 2
	local orbit_sectors = {0,1,2,3,4,5,6,7}
	
	
    function self.build()
    	
      for i = 1, no_galaxies, 1 do
        local sector = orbit_sectors[math.random(#orbit_sectors)]
		table.insert(galaxies, _galaxy.new(position, orbit_sectors[sector]))
		table.remove(orbit_sectors, sector)		
      end

    end

    function self.draw() --Draw the universe, draw each galaxy which in turn draws each system and so on...
		love.graphics.circle("line", position.x, position.y, radius, 20)
        for i = 1, #galaxies, 1 do
          galaxies[i].draw()
        end
    end
    
    function self.update() --Update the universe, for now orbital movements
    
        for i = 1, #galaxies, 1 do
          galaxies[i].update()
        end
    
    end

    return self

end

return universe
