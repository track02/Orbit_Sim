local planet = {}


  function planet.new()

    local self = {}

    local position = {x = math.random(0,800), y = math.random(0,1000)}
    local radius = math.random(5, 15)

    function self.draw()
      love.graphics.circle("line", position.x, position.y, radius, 5)	
    end

    return self

  end

return planet
