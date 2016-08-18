local universe = {}
local _galaxy = require('galaxy')

--The universe sits at the topmost level and contains every object in play
--The general hierarchy is as follows, with each parent being responsible for its immediate child
--Universe -> Galaxy -> (Solar) System -> Planet -> Satellite

function universe.new()

    local self = {}
    local galaxies = {}
    local position = {x = 200, y = 200} --Center, galaxy rotation point
	
	local radius =  200
	--Build values
	local no_galaxies = 10
	local orbit_sectors = {0,1,2,3,4,5,6,7}
	
	
    function self.build()
    
--Start by picking a random galaxy size (radius)
--Place galaxy within universe:
--	closest point -> universe center + galaxy size
--	furthest point -> universe edge - galaxy size
--Determine the angle next galaxy will need to be rotated by in order to avoid overlap:
--
--
--	  [Distance from universe center to galaxy center] (b)
--	           |
--	           v
--	      Ucenter o-----------o Gcenter1
--	               \ A     C /  
--	                \       /
--Ucenter to Gcenter2 -> \     /<-- [Galaxy Radius + Radius of next Galaxy] (a)
--        (c)             \   /
--                         \B/
--                          0 Gcenter2 + Radius2 
--
--
--	Not right angled as initially thought - use Cos Rule
--	A = a^2 - b^2 - c^2 / -2bc


	local galaxy_angles = {}
	local galaxy_radii = {}
	local galaxy_starts = {}


	local galaxy_angle = 0
	local galaxy_radius = math.random(25,50) --Fix at 50 for testing
	
	--Determine a galaxy position
	local galaxy_position = {x = math.random(position.x + galaxy_radius, (position.x + radius - galaxy_radius)), y = position.y}


      for i = 1, no_galaxies, 1 do

	
	local next_galaxy_radius = math.random(25,50) --Fix at 50 for testing



	local next_galaxy_position = {x = math.random(position.x + next_galaxy_radius, (position.x + radius - next_galaxy_radius)), y = position.y}

	--Create a new galaxy using universe position, orbit angle, radius and galaxy position
        table.insert(galaxies, _galaxy.new(position, galaxy_angle, galaxy_radius, galaxy_position))

	--Update angle for next galaxy
	--using cos rule
	local a = galaxy_radius + next_galaxy_radius
	local b = galaxy_position.x - position.x
	local c = next_galaxy_position.x - position.x
	
	galaxy_angle = galaxy_angle + math.acos(((a*a) - (b*b) - (c*c)) / (-2 * b * c))

	--Update radius for next galaxy
	galaxy_radius = next_galaxy_radius
	galaxy_position = next_galaxy_position

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
