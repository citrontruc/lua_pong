-- Handles The creation of a ball object for our game and its movement

local BallGraphicsHandler = {}
BallGraphicsHandler.__index = BallGraphicsHandler  -- set up proper metatable for OOP

--creation
function BallGraphicsHandler:new(initial_x, initial_y, radius, rotation, rotation_speed, img_object)
    local object = {
        x=initial_x,
        y=initial_y,
        radius=radius,
        rotation=rotation,
        rotation_speed = rotation_speed,
        img = img_object.img,
        flip_width = 1,
        flip_height = 1
    }
    object.scale_w = radius / object.img:getWidth()
    object.scale_h = radius / object.img:getHeight()
    self.origin_x = object.img:getWidth() / 2
    self.origin_y = object.img:getHeight() / 2
    setmetatable(object, BallGraphicsHandler)
    return object
end

-- Methods to update the image. Image is rotated over time.
function BallGraphicsHandler:update(dt, x, y)
    self.x, self.y = x, y
    self.rotation = self.rotation + self.rotation_speed * dt
end

function BallGraphicsHandler:flip_width_image()
    self.flip_width = self.flip_width * -1
end

function BallGraphicsHandler:flip_height_image()
    self.flip_height = self.flip_height * -1
end

-- Methods to draw our image
function BallGraphicsHandler:draw()
    -- love.graphics.circles("fill", x, y, self.radius)
    love.graphics.draw(
        self.img, 
        self.x, self.y, --position
        self.rotation, --rotation
        self.scale_w * self.flip_width, self.scale_h * self.flip_height, --scaling factor
        self.origin_x, self.origin_y --offset. Put original image size values not final radius values
    )
end

return BallGraphicsHandler
