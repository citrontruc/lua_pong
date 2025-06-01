-- An object to create a player character

local PlayerController = require("src.player_controller")
local PlayerGraphicsHandler = require("src.graphics_handler.player_graphics_handler")

local Player = {}
Player.__index = Player


function Player:new(initial_x, initial_y, size_x, size_y)
    local control_type = "keyboard"
    local player = {x = initial_x,
        y = initial_y,
        size_x = size_x,
        size_y = size_y,
        player_controller = PlayerController:new(control_type),
        graphics_handler = PlayerGraphicsHandler:new(size_x, size_y)
    }
    setmetatable(player, Player)
    return player
end

--Updates position using the player controller
function Player:update()
    self.x, self.y = self.player_controller:update(self.x, self.y, self.size_x, self.size_y)
end

-- Uses the graphic handler
function Player:draw()
    self.graphics_handler:draw(self.x, self.y)
end

return Player
