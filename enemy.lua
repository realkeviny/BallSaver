local love = require "love"

function enemy()
    local dice = math.random(1,4)
    local _x,_y
    local _radius = 30

    if dice == 1 then
        _x = math.random()
    end

    return {
        level = 1,
        radius = _radius,
        x = _x,
        y = _y,

        move = function(self,player_x,player_y)
            if player_x - self.x > 0 then
                self.x = self.x + self.level
            elseif player_x - self.x < 0 then
                self.x = self.x - self.level    
            end

            if player_y - self.y > 0 then
                self.y = self.y + self.level
            elseif player_y - self.y < 0 then
                self.y = self.y - self.level    
            end
        end,

        draw = function(self)
            love.graphics.setColor(1,0,0)

            love.graphics.circle("fill",self.x,self.y,self.radius)
            
            love.graphics.setColor(1,1,1)
        end
    }
end

return enemy