local orbit_positioning = {}

	--Places objects in orbit around an initial orbit point
	--Returns position, radius and angle of new object (galaxy/solar system/planet/satellite)

	--Objects overlap due to single rotation angle applied to all
	--this results in the objects further away from the orbit point moving a greater distance with each orbit iteration
	--objects close to the center move the least amount of distance
	--A method is needed to determine a rotation angle that would fix the distance travelled by each object
	--ensuring all objects move the same distance with each iteration preventing overlaps

	--Alternatively allow for random rotation angles and instead increase margin between objects to prevent overlap
	--This would allow for varying speeds of orbital objects
	--After placing an object the next closest position to place the next object would be
	--next_position.x = center.x + prev_position.x _ prev_radius + padding


	function orbit_positioning.new(orbit_point, orbit_radius, max_radius, max_padding)

		self = {}

		local start_point = {x = orbit_point.x, y = orbit_point.y}
		local orbit_radius = orbit_radius --Outer boundary of orbit

		local max_radius = max_radius
		local min_radius = max_radius / 2
		local max_padding = max_padding


    function self.find_next_orbit()

		local orbit_object = {position = {x = 0, y = 0}, radius = 0, angle = 0}

 			padding = math.random(0, max_padding)
 			orbit_object.radius = math.random(max_radius,max_radius)
 			orbit_object.position = {x = start_point.x + orbit_object.radius + padding, y = start_point.y}
			orbit_object.angle = math.random(0, (2*math.pi))
			start_point.x = orbit_object.position.x + orbit_object.radius

		return orbit_object

	end

	return self

	end


return orbit_positioning



