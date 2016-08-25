local orbit_positioning = {}

	--Places objects in orbit around an initial orbit point
	--Returns position, radius and angle of new object (galaxy/solar system/planet/satellite)

	function orbit_positioning.new(orbit_point, orbit_radius, max_radius, max_padding)
	
		self = {}

		local orbit_point = orbit_point
		local orbit_radius = orbit_radius --Outer boundary of orbit
		local max_radius = max_radius
		local min_radius = max_radius / 2
		local max_padding = max_padding
		
		local position_1 = {x = 0, y = 0}
		local position_2 = {x = 0, y = 0}
		
		local radius_1 = 0
		local radius_2 = 0
		
		local padding_1 = 0
		local padding_2 = 0
		
		local orbit_angle = math.random(0, (2*math.pi))
		local max_angle = 0
		local orbit_angle_total = 0
		
		local first_pass = true
		
	
    function self.find_next_orbit()
	
		local orbit_object = {position = {x = 0, y = 0}, radius = 0, angle = 0}
		
			
		--First pass, need to generate an initial position
		if first_pass then
		
			radius_1 = math.random(min_radius,max_radius) 
			position_1 = {x = math.random(orbit_point.x + radius_1, 
										 (orbit_point.x + orbit_radius - radius_1)), y = orbit_point.y}
			padding_1 = math.random(0, max_padding)
										 
			first_pass = false
			
		end		
		
		--Set return position / radius
		orbit_object.position = position_1
		orbit_object.radius = radius_1
			
		--Generate next position
		radius_2 = math.random(min_radius,max_radius) 
		position_2 = {x = math.random(orbit_point.x + radius_2, 
									 (orbit_point.x + orbit_radius - radius_2)), y = orbit_point.y}
		padding_2 = math.random(0, max_padding)
									 
		
		--If this is the first object in orbit no angle needs to be calculated, stop here
		if orbit_angle == 0  and first_pass then
			
			orbit_object.angle = 0
			max_angle = (2*math.pi) - math.atan(radius_1 / (position_1.x - orbit_point.x)) --Determine a max angle so the last object cannot overlap the first
					
		--Otherwise calculate needed angle between current object and next
		else
		
			--Use last calculated angle
			orbit_object.angle = orbit_angle
		
			--Update angle for next galaxy
			--using cosine rule
			local a = radius_1 + radius_2 + padding_1 + padding_2
			local b = position_1.x - orbit_point.x --Taking x distance - no change in y as objects rotated after placement
			local c = position_2.x - orbit_point.x
			
			local next_angle = math.acos(((a*a) - (b*b) - (c*c)) / (-2 * b * c)) --Increment orbit_angle, keeping track of previously placed objects
								
			orbit_angle = orbit_angle + next_angle
			
			if orbit_angle > (2 * math.pi) and orbit_angle_total < (2 * math.pi) then
				orbit_angle = 0 + next_angle
			end
			
			orbit_angle_total = orbit_angle_total + next_angle
			
		
		end
		
		--Update current object to next
		radius_1 = radius_2
		position_1 = position_2
		padding_1 = padding_2
		
		return orbit_object		
	
	end
	

	return self
	
	end
	
	
return orbit_positioning


--Notes:
--Start by picking a random galaxy size (radius)
--Place galaxy within universe:
--	closest point -> universe center + galaxy size
--	furthest point -> universe edge - galaxy size
--Determine the angle next galaxy will need to be rotated by in order to avoid overlap:
--
--
--	    [Distance from universe center to galaxy center] (b)
--	                       |
--	                       v
--	          Ucenter o-----------o Gcenter1
--	                   \ A     C /  
--	                    \       /
--Ucenter to Gcenter2 -> \     /<-- [Galaxy Radius + Radius of next Galaxy] (a)
--        (c)             \   /
--                         \B/
--                          0 Gcenter2 + Radius2 
--
--
--	Not right angled as initially thought - use Cos Rule
--	A = a^2 - b^2 - c^2 / -2bc
