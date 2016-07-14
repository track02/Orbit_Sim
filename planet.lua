local planet = {}
local _vecops = require('vector_ops')

  function planet.new()

    local self = {}

    local position = {x = math.random(0,800), y = math.random(0,1000)}
    --local position = {x = 500, y = 500}
    local radius = math.random(5, 15)

    local orbit_point = {x = 500, y = 400}
    local orbit_angle = math.random(0, (2 * math.pi))
    local orbit_velocity = {x = 0, y = 0}    
    local orbit_radius = _vecops.distance(orbit_point, position)
    local orbit_position = {x = 0, y = 0}
    local orbit_speed = 0.5

    function self.draw()
      love.graphics.circle("line", position.x, position.y, radius, 5)
      love.graphics.print(orbit_velocity.x,10, 10)
      love.graphics.print(orbit_velocity.y, 10, 20)
      love.graphics.print(orbit_angle, 10, 30)
      love.graphics.print(orbit_radius, 10, 40)
      love.graphics.print(position, 10, 50)
      love.graphics.circle("fill", orbit_point.x, orbit_point.y, 5, 10)
    end
    
    function self.update_orbit()
          
      --Increment orbit angle by 0.01 (working in radians), reset back to 0 when full orbit is made
      if (orbit_angle + 0.01 > (2 * math.pi)) then
        orbit_angle = 0.0
      else
        orbit_angle = orbit_angle + 0.01
      end
      
      --Using the angle calculate the next position to move to in the planet orbit
      orbit_position.x = orbit_radius * math.cos(orbit_angle) + orbit_point.x
      orbit_position.y = orbit_radius * math.sin(orbit_angle) + orbit_point.y
      
      --Normalise this into a vector and multiply by speed to obtain velocity
      orbit_velocity = _vecops.subtract(orbit_position, position)
      
      
          
    end

    function self.update()
        self.update_orbit()
        position = orbit_position
    end

    return self

  end

return planet
