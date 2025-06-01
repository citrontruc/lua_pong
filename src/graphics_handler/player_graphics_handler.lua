-- Handles how the player position updates and how the animations play out

local PlayerGraphicsHandler = {}
PlayerGraphicsHandler.__index = PlayerGraphicsHandler  -- set up proper metatable for OOP

--creation
function PlayerGraphicsHandler:new(size_x, size_y)
    local object = {
        size_x=size_x,
        size_y=size_y
    }
    setmetatable(object, PlayerGraphicsHandler)
    return object
end

function PlayerGraphicsHandler:draw(x, y)
    -- x, y, width height, can have round corners if needed
    love.graphics.rectangle("fill", x, y, self.size_x, self.size_y)
end

return PlayerGraphicsHandler
