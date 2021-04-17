require "camera"
require "res"
require "map"
require "player"
require "collisions"

Scene = {}
Scene.__index = Scene

function Scene.new()
    local self = setmetatable({}, Scene)

    self.col_world = CollisionWorld.new()
    self.draw_physics = true

    self.mape = Map.new(self.col_world, "data/test_map")
    self.player = Player.new(self.col_world)

    return self
end

function Scene:on_key(key)
    if key == "f1" then
        self.draw_physics = not self.draw_physics
    end
end

function Scene:update(dt)

    self.player:update(dt)
    self.col_world:solve()
    self.player:late_update()
    camera:update(dt)
end

function Scene:draw()
    self.mape:draw()
    self.player:draw()

    if self.draw_physics then
        self.col_world:draw()
    end
end

function Scene:draw_ui()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(res.ui_hearts, 8, 8)
    love.graphics.draw(res.heart, love.graphics.newQuad(0,0,8*5,8,8,8), 8, 16)
end