local orbit_manager = {}
local _vecops = require('vector_ops')

	function orbit_manager.new(orbit_point, speed)
	
		self = {}

		local orbit_point = orbit_point
		local orbit_angle = math.random(0.0, (2 * math.pi)) + math.random()
		local new_orbit_position = {x = 0, y = 0}
		local orbit_speed = speed
	
	
    function self.draw()
      love.graphics.circle("fill", orbit_point.x, orbit_point.y, 5, 10)	
      love.graphics.line(orbit_point.x, orbit_point.y, new_orbit_position.x, new_orbit_position.y)
    end
	
    function self.update_orbit(current_orbit_position, new_orbit_point)
	
        --Update orbit_point
        orbit_point = new_orbit_point
	
        --Determine radius from current position to orbit_point
        local orbit_radius = _vecops.distance(orbit_point, current_orbit_position)
	
			  --Increment orbit angle by orbit_speed (working in radians), reset back to 0 when full orbit is made

			if (orbit_angle + orbit_speed > (2 * math.pi)) then
				orbit_angle = 0.0
			else
				orbit_angle = orbit_angle + orbit_speed
			end
		  
			--Using the angle calculate the next position to move to in the planet orbit
			new_orbit_position.x = orbit_radius * math.cos(orbit_angle) + orbit_point.x
			new_orbit_position.y = orbit_radius * math.sin(orbit_angle) + orbit_point.y
			
			return _vecops.subtract(new_orbit_position, current_orbit_position)

	end
	
	function self.angle()
		return orbit_angle
	end
	
	return self
	
	end
	
return orbit_manager
