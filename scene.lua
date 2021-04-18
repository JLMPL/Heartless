require "camera"
require "res"
require "map"
require "player"
require "collisions"
require "heart"

Scene = {}
Scene.__index = Scene

function Scene.new()
    local self = setmetatable({}, Scene)

    self.hearts = {}
    self.col_world = CollisionWorld.new()
    self.draw_physics = true

    self.player = Player.new(self.col_world)
    self.mape = Map.new(self.col_world, self.hearts, self.player, "data/test_map")

    return self
end

function Scene:on_key(key)
    if key == "f1" then
        self.draw_physics = not self.draw_physics
    end
end

function Scene:update(dt)

    for i = #self.hearts, 1, -1 do
        if self.hearts[i]:is_picked() then
            table.remove(self.hearts, i)
        end
    end

    self.player:update(dt)
    self.col_world:solve()

    for i=1, #self.hearts do
        self.hearts[i]:update(dt)
    end
    self.player:late_update()
    camera:update(dt)
end

function Scene:draw()
    self.mape:draw()
    for i=1, #self.hearts do
        self.hearts[i]:draw()
    end
    self.player:draw()

    if self.draw_physics then
        self.col_world:draw()
    end
end

function Scene:draw_ui()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(res.ui_hearts, 8, 8)
    love.graphics.draw(res.heart, love.graphics.newQuad(0,0,8*self.player.hearts,8,8,8), 8, 16)
end