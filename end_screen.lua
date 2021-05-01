
EndScreen = {}
EndScreen.__index = EndScreen

function EndScreen.new()
    local self = setmetatable({}, EndScreen)

    self.timer = 0
    self.is_next_level = false
    self.next_level = -1

    return self
end

function EndScreen:on_key(key)
    if key == "return" then
        self.is_next_level = true
    end
end

function EndScreen:update(dt)
    self.timer = self.timer + dt
end

function EndScreen:draw()
end

function EndScreen:draw_ui()
    love.graphics.print("Goodbye World")

    love.graphics.setColor(1,1,1, math.floor((self.timer * 2) % 2))
    love.graphics.draw(res.press_start, 10*8, 16*8)
    love.graphics.setColor(1,1,1,1)
end
