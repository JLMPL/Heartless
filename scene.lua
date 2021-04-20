require "camera"
require "res"
require "map"
require "player"
require "collisions"
require "heart"
require "score_counter"

Scene = {}
Scene.__index = Scene

levels = {
    "data/test_map",
    "data/test_map2",
    "data/test_map"
}

function Scene.new(level)
    local self = setmetatable({}, Scene)

    self.hearts = {}
    self.col_world = CollisionWorld.new()
    self.draw_physics = true

    self.player = Player.new(self.col_world)
    self.mape = Map.new(self.col_world, self.hearts, self.player, levels[level])
    self.max_hearts = #self.hearts

    self.is_finished = false
    self.is_next_level = false
    camera:reset()

    return self
end

function Scene:on_key(key)
    if key == "f1" then
        self.draw_physics = not self.draw_physics
    end
end

function Scene:update(dt)
    if not self.is_finished then
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

        if #self.hearts == 0 then
            self.is_finished = true
            camera:level_finished()
        end
    else
        if camera.x == 256 then
            score_counter:count(self.player, self)
            score_counter:update(dt)
        end
    end

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
    love.graphics.draw(res.heart, love.graphics.newQuad(0,0,8*self.player.hearts,8,8,8), 8, 16)

    if camera.x == 256 then
        score_counter:draw()
    else
        love.graphics.draw(res.ui_hearts, 8, 8)
    end
end