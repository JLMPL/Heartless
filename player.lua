Player = {}
Player.__index = Player

function Player.new(phys_world)
    local self = setmetatable({}, Player)
    self.name = "player"

    self.collider = phys_world:add_rect(16, 16, 10, 16)
    self.feet = phys_world:add_trigger(16,16,8,2)
    self.head = phys_world:add_trigger(0,0,8,2)
    self.acc_y = 0

    return self
end

function Player:update(dt)
    local rect = self.collider
    self.acc_y = math.min(5, self.acc_y + 5 * dt)

    if self.feet.is_overlapping and self.acc_y > 0 then
        self.acc_y = 0
    end

    if self.head.is_overlapping and self.acc_y < 0 then
        self.acc_y = 0
    end

    rect.y = rect.y + self.acc_y

    if love.keyboard.isDown("left") then
        rect.x = rect.x - 50 * dt
    end

    if love.keyboard.isDown("right") then
        rect.x = rect.x + 50 * dt
    end

    if love.keyboard.isDown("up") and self.feet.is_overlapping then
        self.acc_y = -3
        self.feet.is_overlapping = false
    end
end

function Player:late_update()
    self.feet.x = self.collider.x + 1
    self.feet.y = self.collider.y + 16

    self.head.x = self.collider.x + 1
    self.head.y = self.collider.y - 2
end

function Player:draw()
    local rect = self.collider
    love.graphics.draw(res.player, rect.x-4, rect.y-8)
end

function Player:on_contact(other)
    if not other then return end
    print(other.name)
end