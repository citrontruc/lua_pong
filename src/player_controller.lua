-- A class to control our player character
-- TODO; set up controller support

local PlayerController = {}
PlayerController.__index = PlayerController

--creation
function PlayerController:new(control_type)
    local object = {
        control_type = control_type
    }
    setmetatable(object, PlayerController)
    return object
end

--update
function PlayerController:update(x, y, size_x, size_y)
    local move_function = {
        keyboard = PlayerController.move_with_keyboard,
        controller = PlayerController.move_with_controller
    }
    chosen_move_function = move_function[self.control_type]
    x, y = chosen_move_function(self, x, y)
    x, y = self:check_position(x, y, size_x, size_y)
    return x, y
end

--movement functions
function PlayerController:move_with_keyboard(x,y)
    if love.keyboard.isDown("down") then
        y = y + 2
    end
    if love.keyboard.isDown("up") then
        y = y - 2
    end
    if love.keyboard.isDown("right") then
        x = x + 2
    end
    if love.keyboard.isDown("left") then
        x = x - 2
    end
    return x, y
end

function PlayerController:move_with_controller(x,y)
    if love.keyboard.isDown("down") then
        y = y + 2
    end
    if love.keyboard.isDown("up") then
        y = y - 2
    end
    if love.keyboard.isDown("right") then
        x = x + 2
    end
    if love.keyboard.isDown("left") then
        x = x - 2
    end
    return x, y
end

-- Check that player stays on screen
function PlayerController:check_position(x, y, size_x, size_y)
    x = math.min(math.max(0, x), love.graphics.getWidth() - size_x)
    y = math.min(math.max(0, y), love.graphics.getHeight() - size_y)
    return x, y
end

return PlayerController
