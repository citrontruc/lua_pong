-- A class to handle the generation of the ball for our pong game

local BallGraphicsHandler = require("src.graphics_handler.ball_graphics_handler")

local Ball = {}
Ball.__index = Ball


function Ball:new(initial_x, initial_y, initial_vx, initial_vy, radius, rotation, rotation_speed, img_dir)
    local object = {
        x = initial_x,
        y = initial_y,
        vx = initial_vx,
        vy = initial_vy,
        radius = radius,
        graphics_handler = BallGraphicsHandler:new(initial_x, initial_y, radius, rotation, rotation_speed, img_dir)
    }
    setmetatable(object, Ball)
    return object
end

-- Movement methods
function Ball:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
    self:check_walls(dt)
end

function Ball:check_walls(dt)
    -- Check collisions with walls and inverts speed if there is a collision with a wall.
    x = math.min(math.max(self.radius/2, self.x), love.graphics.getWidth() - self.radius/2)
    y = math.min(math.max(self.radius/2, self.y), love.graphics.getHeight() - self.radius/2)
    if x ~= self.x then 
        self.vx = -self.vx
        self.x = x
        self.graphics_handler:flip_width_image()
    end
    if y ~= self.y then 
        self.vy = -self.vy
        self.y = y
    end
    
    self.graphics_handler:update(dt, x, y)
end

-- draw methods
function Ball:draw()
    self.graphics_handler:draw()
end

return Ball
