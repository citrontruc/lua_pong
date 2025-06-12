-- A method to load images and handle them.
-- Avoids having to create an image for every item 

local Image = {}
Image.__index = Image

function Image:new(img_dir)
    local object = {
        img_dir = img_dir,
        img = love.graphics.newImage(img_dir)
    }
    setmetatable(object, Image)
    return object
end

return Image
