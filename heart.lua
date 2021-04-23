require "res"
local anim8 = require "anim8"

Heart = {}
Heart.__index = Heart

function Heart.new(player)
    local self = setmetatable({}, Heart)

    self.rect = CollisionRect.new(16,16,16,16)
    self.rect.object = self
    self.player = player

    local grid = anim8.newGrid(16, 16, res.pickup_heart:getWidth(), res.pickup_heart:getHeight())
    self.anim = anim8.newAnimation(grid('1-2',1), 0.4)

    self.picked = false

    return self
end

function Heart:update(dt)

    if aabb_overlap(self.rect, self.player.collider) and not self.picked then
        self.picked = true
        self.player.hearts = self.player.hearts + 1
    end

    self.anim:update(dt)
end

function Heart:draw()
    self.anim:draw(res.pickup_heart, self.rect.x, self.rect.y)
end

function Heart:is_picked()
    return self.picked
end
