-- Handles The creation of a ball object for our game and its movement

local BallGraphicsHandler = {}
BallGraphicsHandler.__index = BallGraphicsHandler  -- set up proper metatable for OOP

--creation
function BallGraphicsHandler:new(radius, initial_x, initial_y)
    local object = {
        x=initial_x,
        y=initial_y,
        radius=radius,
        rotation
    }
    setmetatable(object, BallGraphicsHandler)
    return object
end

function BallGraphicsHandler:draw()
    -- x, y, width height, can have round corners if needed
    love.graphics.rectangle("fill", x, y, self.size_x, self.size_y)
end

return BallGraphicsHandler
