local universe = {}
local _galaxy = require('galaxy')

--The universe sits at the topmost level and contains every object in play
--The general hierarchy is as follows, with each parent being responsible for its immediate child
--Universe -> Galaxy -> (Solar) System -> Planet -> Satellite

function universe.new()

    local self = {}
    local galaxies = {}
    local center = {x = 512, y = 400} --Center, galaxy rotation point

	--Build values
	local no_galaxies = 1
	
	
    function self.build()
    	
      for i = 1, no_galaxies, 1 do
        table.insert(galaxies, _galaxy.new(center))		
      end

    end

    function self.draw() --Draw the universe, draw each galaxy which in turn draws each system and so on...

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
