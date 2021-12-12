require "res"

score_counter = {
    player = nil,
    scene = nil,
    score = 0,
    total = 0
}

num_quads = {}

function score_counter:init()
    for i = 0, 9 do
        num_quads[i] = love.graphics.newQuad(i*8, 0, 8,8, 80, 8)
    end
end

function score_counter:count(player, scene)
    if self.player == nil then
        self.player = player
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

        joysticks = love.joystick.getJoysticks()
        joystick = joysticks[1]

        if joystick:isGamepadDown("a") then
            self.scene.is_next_level = true
            self.player = nil
            self.timer = 0
            return
        end
    end
end

function score_counter:draw()
    love.graphics.draw(res.score, 10*8, 12*8)
    love.graphics.draw(res.total, 10*8, 14*8)

    if self.player and self.player.hearts == 0 then
        love.graphics.setColor(1,1,1, math.floor((self.timer * 2) % 2))
        love.graphics.draw(res.press_start, 10*8, 16*8)
        love.graphics.setColor(1,1,1,1)
    end

    if self.score > 9 then
        love.graphics.draw(res.numbers, num_quads[math.floor(self.score / 10 % 10)], 17*8, 14*8)
    end

    love.graphics.draw(res.numbers, num_quads[math.floor(self.score % 10)], 18*8, 14*8)
    love.graphics.draw(res.numbers, num_quads[0], 19*8, 14*8)
    love.graphics.draw(res.numbers, num_quads[0], 20*8, 14*8)
end
