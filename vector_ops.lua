local vector_ops = {}

function vector_ops.distance(v1, v2)

	x1 = v1.x
	x2 = v2.x
	y1 = v1.y
	y2 = v2.y

	dx = x1 - x2
	dy = y1 - y2


	return math.sqrt((dx * dx) + (dy * dy))

end 

function vector_ops.add(v1, v2)

	v3 ={
		x = (v1.x + v2.x),
		y = (v1.y + v2.y)
	}

	return v3


end

function vector_ops.subtract(v1, v2)

	v3 = {
		x = v1.x - v2.x,
		y = v1.y - v2.y
	}

	return v3


end	

function vector_ops.scalarMult(v1, scalar)

	v2 = {
		x = v1.x * scalar,
		y = v1.y * scalar
	}

	return v2


end

function vector_ops.scalarDiv(v1, scalar)


	v2 = {
		x = v1.x / scalar,
		y = v1.y / scalar
	}

	return v2

end

function vector_ops.normalise(v1)


	length = math.sqrt((v1.x * v1.x) + (v1.y * v1.y))

	v1.x = v1.x / length
	v1.y = v1.y / length

	return v1
	
end	

return vector_ops