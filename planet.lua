local planet = {}
local _vecops = require('vector_ops')
local _orbitmanager = require('orbit_manager')
local _satellite = require('satellite')

  function planet.new(solar_system_center) --Orbits around center of solar system
	
	local solar_center = solar_system_center
    local self = {}
    local position = {x = solar_system_center.x + 12, y = solar_system_center.y + 12}
    local speed = 0.01
    local radius = 12   	
    local orbitmanager =  _orbitmanager.new(solar_system_center, speed)
	local initial_angle = orbitmanager.angle()
	
	--Setup satellites systems here--
	local satellites = {}
	local no_satellites = 1
	
	for i = 1,no_satellites,1 do
		table.insert(satellites, _satellite.new(position))
	end

    function self.draw()
		love.graphics.setColor(255,255,255)
		love.graphics.print(string.format("Planet: %i,%i", math.floor(position.x), math.floor(position.y)), 0,40)
		--love.graphics.print(string.format("Received orbit: %i,%i", math.floor(solar_center.x), math.floor(solar_center.y)),200,40)
		love.graphics.print(string.format("Initial Angle: %.4f", initial_angle ),110,40)

		love.graphics.setColor(0,255,0)
		orbitmanager.draw()
		love.graphics.circle("line", position.x, position.y, radius, radius)
		
		--Draw Satellites here
		for i = 1,#satellites,1 do
			satellites[i].draw()
		end

    end
    

    function self.update(solar_system_orbit_vector, solar_system_position)
	
		position = _vecops.add(solar_system_orbit_vector, position)
		local orbit_vector = orbitmanager.update_orbit(position, solar_system_position)
		position = _vecops.add(orbit_vector, position)
		
		--Update satellites here--
		for i = 1,#satellites,1 do
			satellites[i].update(orbit_vector, position) --Planets will orbit system, pass down vector
		end
    end

    return self

  end

return planet
