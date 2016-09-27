local galaxy = {}
local _vecops = require('vector_ops')
local _orbit_positioning = require('orbit_positioning')
local _orbitmanager = require('orbit_manager')
local _solar_system = require('solar_system')

  function galaxy.new(universe_center, orbit_sector, radius, galaxy_position) --Galaxies orbit around some center point of the universe, assigned a sector

    local self = {}
    local position = galaxy_position
    local orbit_point = universe_center --May want to update orbit_point
    local speed = math.random(1, 5) / 100000
    local init_angle = orbit_sector
    local radius = radius
    local orbitmanager =  _orbitmanager.new((position.x - universe_center.x), orbit_point, speed, orbit_sector) --Pass this center point to orbit manager

	--Setup solar systems here--
	local solar_systems = {}
	local max_solar_systems = 4
	local solar_sys_max_padding = 3
	local solar_sys_max_radius = ((radius - (solar_sys_max_padding * max_solar_systems)) / max_solar_systems) / 2
	local orbit_positioning = _orbit_positioning.new(position, radius, solar_sys_max_radius,solar_sys_max_padding)

	for i = 1, max_solar_systems, 1  do

		new_ss_details = orbit_positioning.find_next_orbit() --Returns values needed to construct new solar system

			table.insert(solar_systems, _solar_system.new(position,
											   new_ss_details.angle,
											   new_ss_details.radius,
											   new_ss_details.position))
	end

    function self.draw()
	--print("Drawing at: " .. position.x .. "," .. position.y)
	--orbitmanager.draw()
	love.graphics.setColor(255,0,0)
	love.graphics.circle("line", position.x, position.y, radius, 15)

      --Draw solar systems here--
      for i = 1,#solar_systems,1 do
        solar_systems[i].draw()
      end

    end

    function self.update()

		--print("Universe Center: (" .. orbit_point.x .. "," .. orbit_point.y)

		local orbit_vector = orbitmanager.update_orbit(position, orbit_point)
		position = _vecops.add(orbit_vector, position)

		--print("New Position: (" .. position.x  .. "," .. position.y .. ")")

		--Update solar systems here--
		for i = 1,#solar_systems,1 do
			solar_systems[i].update(orbit_vector, position) --Solar systems will orbit with galaxy, need the vector
		end
    end

    return self

  end

return galaxy
