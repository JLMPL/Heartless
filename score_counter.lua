require "res"

score_counter = {
    player = nil,
    score = 0
}

function score_counter:count(player)
    if self.player == nil then
        self.player = player
        self.score = 0
        self.timer = 0
    end
end

function score_counter:update(dt)
    self.timer = self.timer + dt

    if self.timer > 0.5 and self.player.hearts > 0 then
        self.player.hearts = math.max(0, self.player.hearts - 1)
        self.score = self.score + 100
        self.timer = 0
    end

    if self.player.hearts == 0 then
    end
end

function score_counter:draw()
    love.graphics.print(tostring(self.score))
    love.graphics.draw(res.score, 10*8, 12*8)

    if self.player and self.player.hearts == 0 then
        love.graphics.print("Press start to continue", 10, 100)
    end
end