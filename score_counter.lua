require "res"

score_counter = {
    player = nil,
    score = 0,
    scene = nil
}

num_quads = {
    [0] = love.graphics.newQuad(0,0,8,8, 80, 8),
    [1] = love.graphics.newQuad(1*8,0,8,8, 80, 8),
    [2] = love.graphics.newQuad(2*8,0,8,8, 80, 8),
    [3] = love.graphics.newQuad(3*8,0,8,8, 80, 8),
    [4] = love.graphics.newQuad(4*8,0,8,8, 80, 8),
    [5] = love.graphics.newQuad(5*8,0,8,8, 80, 8),
    [6] = love.graphics.newQuad(6*8,0,8,8, 80, 8),
    [7] = love.graphics.newQuad(7*8,0,8,8, 80, 8),
    [8] = love.graphics.newQuad(8*8,0,8,8, 80, 8),
    [9] = love.graphics.newQuad(9*8,0,8,8, 80, 8)
}

function score_counter:count(player, scene)
    if self.player == nil then
        self.player = player
        self.score = 0
        self.timer = 0
        self.scene = scene
    end
end

function score_counter:update(dt)
    self.timer = self.timer + dt

    if self.timer > 0.1 and self.player.hearts > 0 then
        self.player.hearts = math.max(0, self.player.hearts - 1)
        self.score = self.score + 1
        self.timer = 0
    end

    if self.player.hearts == 0 then
        if love.keyboard.isDown("return") then
            self.scene.is_next_level = true
            self.player = nil
            self.score = 0
            self.timer = 0
            return
        end
    end
end

function score_counter:draw()
    love.graphics.draw(res.score, 10*8, 12*8)

    if self.player and self.player.hearts == 0 then
        love.graphics.draw(res.press_start, 10*8, 15*8)
    end

    if self.score > 9 then
        love.graphics.draw(res.numbers, num_quads[math.floor(self.score / 10 % 10)], 17*8, 13*8)
    end

    love.graphics.draw(res.numbers, num_quads[math.floor(self.score % 10)], 18*8, 13*8)
    love.graphics.draw(res.numbers, num_quads[0], 19*8, 13*8)
    love.graphics.draw(res.numbers, num_quads[0], 20*8, 13*8)
end