-- Launch love with alt+l or love lua_pong --console
-- This a multi line comment
--[[
    print'Lua is lovely'
--]]

local Player = require("src.player.player")
local Ball = require("src.ball.ball")
local joystick = nil

-- Main methods
function love.load()
    player = Player:new(100, 100, 50, 50, 500)
    ball = Ball:new(0, 0, 200, 200, 30, 0, 5, "src/assets/kirball.png")
    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
end

function love.update(dt)
    player:update(dt, joystick)
    ball:update(dt)
end

function love.draw()
    --love.graphics.print("Hello World!", 400, 300)
    player:draw()
    ball:draw(dt)
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