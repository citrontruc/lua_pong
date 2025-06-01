-- Launch love with alt+l or love lua_pong --console
-- This a multi line comment
--[[
    print'Lua is lovely'
--]]

local Player = require("src.player")

function love.load()
    player = Player:new(100, 100, 50, 50)
end

function love.update()
    player:update()
end

function love.draw()
    --love.graphics.print("Hello World!", 400, 300)
    player:draw()
end
