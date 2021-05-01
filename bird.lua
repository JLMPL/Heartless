require "res"
require "collisions"
local anim8 = require "anim8"

Bird = {}
Bird.__index = Bird

function Bird.new(player, x, y)
    local self = setmetatable({}, Bird)

    local grid = anim8.newGrid(24, 32, res.bird:getWidth(), res.bird:getHeight())
    self.anim = anim8.newAnimation(grid('1-2',1), 0.5)
    self.anim:flipH()

    self.player = player

    self.rect = CollisionRect.new(x,y,14,10)

    return self
end

function Bird:update(dt)
    self.prev_frame = self.anim.position
    self.anim:update(dt)

    self.rect.x = self.rect.x + dt * 100

    if self.rect.x > 300 then
        self.rect.x = -50
    end

    if self.anim.position ~= self.prev_frame then
        if aabb_overlap(self.rect, self.player.collider) then
            self.player:get_hit()
        end
    end
end

function Bird:draw()
    local cr = self.rect
    self.anim:draw(res.bird, cr.x - 5, cr.y - 10)
    -- love.graphics.rectangle("line", cr.x, cr.y, cr.w, cr.h)
end