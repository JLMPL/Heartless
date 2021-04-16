require "camera"
require "res"
require "map"
require "player"

local windfield = require "windfield"

Scene = {}
Scene.__index = Scene

function Scene.new()
    local self = setmetatable({}, Scene)

    self.world = windfield.newWorld(0, 0, true)
    self.mape = Map.new(self.world, "data/test_map")

    self.player = Player.new(self.world)

    self.draw_physics = false

    return self
end

function Scene:update(dt)
    self.player:update(dt)
    self.world:update(dt)
    camera:update(dt)
end

function Scene:draw()
    self.mape:draw()
    if self.draw_physics then
        world:draw()
    end
    self.player:draw()
end

function Scene:draw_ui()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(res.ui_hearts, 8, 8)
    love.graphics.draw(res.heart, love.graphics.newQuad(0,0,8*5,8,8,8), 8, 16)
end