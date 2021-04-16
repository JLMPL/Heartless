Player = {}
Player.__index = Player

function Player.new(phys_world)
    local self = setmetatable({}, Player)

    self.collider = phys_world:newRectangleCollider(16, 16*10, 10, 16)
    self.collider:setType("dynamic")
    self.collider:setFixedRotation(true)
    self.collider:setFriction(0)
    self.acc_y = 0

    return self
end

function Player:update(dt)
    self.acc_y = self.acc_y + 300 * dt

    local vel = {x = 0, y = self.acc_y}

    if love.keyboard.isDown("left") then
        vel.x = -30
    end

    if love.keyboard.isDown("right") then
        vel.x = 30
    end

    if love.keyboard.isDown("up") then
        self.acc_y = -200
    end

    self.collider:setLinearVelocity(vel.x, vel.y)

end

function Player:draw()
    x, y = self.collider:getPosition()
    love.graphics.draw(res.player, x-8, y-16)
end