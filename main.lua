-- Launch love with alt+l or love lua_pong --console
-- This a multi line comment
--[[
    print'Lua is lovely'
--]]

local Ball = require("src.ball.ball")
local Grid = require("src.grid.grid")
local Image = require("src.graphics_handler.image_item")
local Player = require("src.player.player")
local joystick = nil

-- Cell info
local cell_size_x = 100
local cell_size_y = 100
local num_balls = 1000

-- ball info
local ball_xv = 200
local ball_vy = 200
local ball_size = 30

-- Change sizeof screen
love.window.setMode(1200, 900, flags)

-- Main methods
function love.load()
    player = Player:new(100, 100, 50, 50, 200)
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
    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
end

function love.update(dt)
    --player:update(dt, joystick)
    local list_ball = grid:get_objects()
    for _, ball in pairs(list_ball) do
        ball:update(dt, joystick)
    end
    grid:update_cells()
    grid:evaluate_collision()
end

function love.draw()
    --love.graphics.print("Hello World!", 400, 300)
    player:draw()
    local list_ball = grid:get_objects()
    for _, ball in pairs(list_ball) do
        ball:draw()
    end
end

-- Methods to change control type.

function love.keypressed(key, scancode, isrepeat)
   player.player_controller:set_control_type("keyboard")
end

function love.gamepadpressed(joy, button)
    player.player_controller:set_control_type("controller", joystick)
end

function love.joystickadded(j)
    joystick = j  -- support hot-plugging controllers
end
