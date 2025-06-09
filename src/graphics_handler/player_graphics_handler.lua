-- Handles how the player position updates and how the animations play out

local PlayerGraphicsHandler = {}
PlayerGraphicsHandler.__index = PlayerGraphicsHandler  -- set up proper metatable for OOP

--creation
function PlayerGraphicsHandler:new(size_x, size_y, initial_x, initial_y)
    local object = {
        size_x=size_x,
        size_y=size_y,
        x=initial_x,
        y=initial_y
    }
    setmetatable(object, PlayerGraphicsHandler)
    return object
end

function PlayerGraphicsHandler:update(x, y)
    self.x, self.y = x, y
end

function PlayerGraphicsHandler:draw()
    -- x, y, width height, can have round corners if needed
    love.graphics.rectangle("fill", self.x - self.size_x/2, self.y - self.size_y/2, self.size_x, self.size_y)
end

return PlayerGraphicsHandler
