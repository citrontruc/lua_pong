-- A class to handle the generation of the ball for our pong game

local Ball = {}
Ball.__index = Ball


function Ball:new(initial_x, initial_y, initial_vx, initial_vy, size)
    local object = {
        x = initial_x,
        y = initial_y,
        vx = initial_vx,
        vy = initial_vy,
        size = size
    }
    setmetatable(object, Ball)
    return object
end

function Ball:move()
    self.x = self.x + self.vx
    self.y = sel.y + self.vy
end

return Ball
