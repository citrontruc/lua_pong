-- A class to handle the generation of the ball for our pong game

local BallGraphicsHandler = require("src.graphics_handler.ball_graphics_handler")

local Ball = {}
Ball.__index = Ball


function Ball:new(initial_x, initial_y, initial_vx, initial_vy, radius, rotation, rotation_speed, img_object)
    local object = {
        player_object = false, -- We use player_object to do collision checks
        x = initial_x,
        y = initial_y,
        vx = initial_vx,
        vy = initial_vy,
        radius = radius,
        size_x = radius, -- We use size x and size y to do collision checks
        size_y = radius, -- We use size x and size y to do collision checks
        graphics_handler = BallGraphicsHandler:new(initial_x, initial_y, radius, rotation, rotation_speed, img_object)
    }
    setmetatable(object, Ball)
    return object
end

-- Movement methods
function Ball:update(dt, joystick)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
    self:check_walls(dt)
end

-- Collision methods
function Ball:check_walls(dt)
    -- Check collisions with walls and inverts speed if there is a collision with a wall.
    x = math.min(math.max(self.radius/2, self.x), love.graphics.getWidth() - self.radius/2)
    y = math.min(math.max(self.radius/2, self.y), love.graphics.getHeight() - self.radius/2)
    if x ~= self.x then 
        self:collide_x(x)
    end
    if y ~= self.y then
        self:collide_y(y)
    end
    
    self.graphics_handler:update(dt, x, y)
end

function Ball:collide_x(x)
    self.vx = -self.vx
    self.x = x
    self.graphics_handler:flip_width_image()
end

function Ball:collide_y(y)
    self.vy = -self.vy
    self.y = y
end

-- draw methods
function Ball:draw()
    self.graphics_handler:draw()
end

return Ball
