require "res"
require "collisions"
local anim8 = require "anim8"

Spikes = {}
Spikes.__index = Spikes

function Spikes.new(player)
    local self = setmetatable({}, Spikes)

    local grid = anim8.newGrid(16, 16, res.spikes:getWidth(), res.spikes:getHeight())
    self.anim = anim8.newAnimation(grid('1-2',1), 0.6)

    self.rect = CollisionRect.new(32,48,16,16)
    self.prev_frame = 0
    self.player = player

    return self
end

function Spikes:update(dt)

    self.prev_frame = self.anim.position
    self.anim:update(dt)

    if self.prev_frame == 2 and self.anim.position == 1 then
        if aabb_overlap(self.rect, self.player.collider) then
            self.player:get_hit()
        end
    end
end

function Spikes:draw()
    local ro = self.rect
    self.anim:draw(res.spikes, ro.x, ro.y)
    -- love.graphics.rectangle("line", ro.x, ro.y, ro.w, ro.h)
end