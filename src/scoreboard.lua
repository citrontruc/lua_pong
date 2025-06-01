-- A class to handle the player score

scoreboard = {
    player1 = 0,
    player2 = 0,
    goal = 10
}

function scoreboard:player_scored(player)
    self[player] = self[player] + 1
end

function scoreboard:reset(player)
    self[player1] = 0
    self[player2] = 0
end