local universe = {}
local _galaxy = require('galaxy')
local _orbit_positioning = require('orbit_positioning')

--The universe sits at the topmost level and contains every object in play
--The general hierarchy is as follows, with each parent being responsible for its immediate child
--Universe -> Galaxy -> (Solar) System -> Planet -> Satellite

function universe.new()

    local self = {}
    local galaxies = {}
    local position = {x = 200, y = 200} --Center, galaxy rotation point

	local radius =  math.random(500,750)

	--Build values
	local max_galaxies = 5
	local max_galaxy_padding = 15 --Buffer space between galaxies
	local max_galaxy_radius = (radius - (max_galaxy_padding * max_galaxies)) / max_galaxies
	local max_galaxy_speed = 0.0000000000000005
	local orbit_positioning = _orbit_positioning.new(position, radius, max_galaxy_radius,max_galaxy_padding) --Tables passed by ref in Lua
	local build_ok = true

    function self.build()

		for i=1, max_galaxies, 1 do

			new_galaxy_details = orbit_positioning.find_next_orbit() --Returns values needed to construct new galaxy

				galaxies[i] = _galaxy.new(position,
												   new_galaxy_details.angle,
												   new_galaxy_details.radius,
												   new_galaxy_details.position)

 			--print("Galaxy: " .. i .. "\n"
			--	  .. "Universe: (" .. position.x .. "," .. position.y .. ")\n"
 			--	  .. "Starting Position: ("..new_galaxy_details.position.x .. "," .. new_galaxy_details.position.y .. ")\n"
 			--	  .. "Radius: " .. new_galaxy_details.radius .. "\nAngle: " .. new_galaxy_details.angle)

		end
	end

    function self.draw() --Draw the universe, draw each galaxy which in turn draws each system and so on...
		--love.graphics.circle("line", position.x, position.y, radius, 20)

		--love.graphics.print("No. Galaxies: " .. #galaxies, 150,150)

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
