
SplashScreen = {}
SplashScreen.__index = SplashScreen

function SplashScreen.new()
    local self = setmetatable({}, SplashScreen)

    self.timer = 0
    self.is_next_level = false
    self.next_level = 1

    return self
end

function SplashScreen:on_key(key)
    if key == "return" then
        self.is_next_level = true
    end
end

function SplashScreen:update(dt)
    self.timer = self.timer + dt
end

function SplashScreen:draw()
end

function SplashScreen:draw_ui()
    love.graphics.print("Hello World")

    love.graphics.draw(res.splash)

    love.graphics.setColor(1,1,1, math.floor((self.timer * 2) % 2))
    love.graphics.draw(res.press_start, 10*8, 16*8)
    love.graphics.setColor(1,1,1,1)
end
