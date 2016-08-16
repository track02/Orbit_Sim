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
	local no_galaxies = 3
	local orbit_sectors = {0,1,2,3,4,5,6,7}
	
	
    function self.build()
    
--Start by picking a random galaxy size (radius)
--Place galaxy within universe:
--	closest point -> universe center + galaxy size
--	furthest point -> universe edge - galaxy size
--Determine the angle next galaxy will need to be rotated by in order to avoid overlap:
--
--
--	  [Distance from universe center to galaxy center]
--	           |
--	           v
--	Ucenter o-----o Gcenter
--	         \    |
--	          \   |
--	           \  | <-- [Galaxy Radius + Radius of next Galaxy]
--                  \ |
--                   \|
--                    0 Gcenter + rad
--
--       Angle should = atan (galaxy_radius + next_radius) / (galaxy.x - universe.x)


	local galaxy_angle = 0
	local galaxy_radius = 50 --Fix at 50 for testing
	

      for i = 1, no_galaxies, 1 do
	
	local next_galaxy_radius = 50 --Fix at 50 for testing

	--Determine a galaxy position
	local galaxy_position = {x = math.random((position.x + galaxy_radius),
						((position.x + radius)-galaxy_radius)),
				y = position.y}

	--Create a new galaxy using universe position, orbit angle, radius and galaxy position
        table.insert(galaxies, _galaxy.new(position, galaxy_angle, galaxy_radius, galaxy_position))

	--Update angle for next galaxy
	--atan returns angle in radians
	galaxy_angle = galaxy_angle + math.atan((galaxy_radius) / (galaxy_position.x - position.x))
				
	--Update radius for next galaxy
	galaxy_radius = next_galaxy_radius

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
