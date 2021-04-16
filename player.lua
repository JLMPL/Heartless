Player = {}
Player.__index = Player

function Player.new(phys_world)
    local self = setmetatable({}, Player)
    self.name = "player"

    self.collider = phys_world:newRectangleCollider(16, 16*10, 10, 16)
    self.collider:setType("dynamic")
    self.collider:setCollisionClass("player")
    self.collider:setObject(self)
    self.collider:setFixedRotation(true)
    self.collider:setFriction(0)
    self.acc_y = 0
    self.on_ground = false

    return self
end

function Player:update(dt)
    self.acc_y = self.acc_y + 300 * dt

    local vel = {x = 0, y = self.acc_y}

    if self.collider:enter("map") then
        self.acc_y = 0
        self.on_ground = true
    end

    if love.keyboard.isDown("left") then
        vel.x = -30
    end

    if love.keyboard.isDown("right") then
        vel.x = 30
    end

    if love.keyboard.isDown("up") and self.on_ground then
        self.acc_y = -200
        self.on_ground = false
    end

    self.collider:setLinearVelocity(vel.x, vel.y)

end

function Player:draw()
    x, y = self.collider:getPosition()
    love.graphics.draw(res.player, x-8, y-16)
end

function Player:on_contact(other)
    if not other then return end
    print(other.name)
end