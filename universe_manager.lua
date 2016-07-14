local universe_manager = {}
local planet = require('planet')

function universe_manager.new()

    local self = {}
    local planets = {}

    function self.create_planets(no_planets)
    	
      for i = 1, no_planets, 1 do
        table.insert(planets, planet.new())		
      end

    end

    function self.draw_planets()

        for i = 1, #planets, 1 do
          planets[i].draw()
        end
    end
    
    function self.update_planets()
    
        for i = 1, #planets, 1 do
          planets[i].update()
        end
    
    end

    return self

end

return universe_manager
