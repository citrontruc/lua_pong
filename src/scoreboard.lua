-- A class to handle the player score

function Scoreboard:new()
    local object = {player1 = 0, player2 = 0}
    setmetatable(object, Scoreboard)
    return object
end

function Scoreboard:player_scored(player)
    self[player] = self[player] + 1
end

function Scoreboard:reset(player)
    self[player1] = 0
    self[player2] = 0
end
