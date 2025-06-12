-- This a multi line comment
--[[
    print'Lua is lovely'
--]]

-- Imports of our item
local Ball = require("src.ball.ball")
local Grid = require("src.grid.grid")
local Image = require("src.graphics_handler.image_item")
local Player = require("src.player.player")
local joystick = nil

-- Cell info
local cell_size_x = 100
local cell_size_y = 100
local num_balls = 500

-- ball info
local ball_xv = 200
local ball_vy = 200
local ball_size = 30

-- Change sizeof screen
love.window.setMode(1200, 800, flags)

-- Main methods
function love.load()
    -- We create a player and a grid that will store all of our objects
    -- The role of our grid is to handle collision detection
    player = Player:new(100, 100, 50, 50, 400)
    grid = Grid:new(cell_size_x, cell_size_y)
    grid:assign(player)
    kirby_image = Image:new("src/assets/kirball.png")
    for i = 1, num_balls do
        grid:assign(
            Ball:new(
                math.random(love.graphics.getWidth()), 
                math.random(love.graphics.getHeight()), 
                ball_xv, 
                ball_vy,
                ball_size, 
                0, 
                5, 
                kirby_image
            )
        )
    end

    -- Controls to take care of our controller
    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
end

function love.update(dt)
    --player:update(dt, joystick)

    -- We update all of the elements in our grids
    local list_ball = grid:get_objects()
    for _, ball in pairs(list_ball) do
        ball:update(dt, joystick)
    end

    -- Once all of the elements have been updated, we let our grid take care of collisions by cells
    grid:update()
end

function love.draw()
    --love.graphics.print("Hello World!", 400, 300)
    
    -- We draw all the elements in our grid to fill our screen
    local list_ball = grid:get_objects()
    for _, ball in pairs(list_ball) do
        ball:draw()
    end
    -- We redraw the player so that he appears to squash the kirbys.
    player:draw()
end


-- Methods to change control type.
-- If a controller is pressed, we change to detect controller input
function love.keypressed(key, scancode, isrepeat)
   player.player_controller:set_control_type("keyboard")
end

function love.gamepadpressed(joy, button)
    player.player_controller:set_control_type("controller", joystick)
end

function love.joystickadded(j)
    joystick = j  -- support hot-plugging controllers
end
