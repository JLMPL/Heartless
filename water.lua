require "res"
require "collisions"
local anim8 = require "anim8"

Water = {}
Water.__index = Water

function Water.new(player, x, y)
    local self = setmetatable({}, Water)

    local grid = anim8.newGrid(16, 16, res.water:getWidth(), res.water:getHeight())
    self.anim = anim8.newAnimation(grid('1-2',1), 0.4)

    self.player = player

    self.rect = CollisionRect.new(x,y,16,16)

    return self
end

function Water:update(dt)
    self.prev_frame = self.anim.position
    self.anim:update(dt)

    if self.anim.position ~= self.prev_frame then
        if aabb_overlap(self.rect, self.player.collider) then
            self.player:get_hit()
        end
    end
end

function Water:draw()
    local cr = self.rect
    self.anim:draw(res.water, cr.x, cr.y)
end