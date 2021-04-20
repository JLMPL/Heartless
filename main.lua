require "config"
require "scene"

current_level = 1

local scene = nil

function love.load()
    love.window.setTitle("LOVE2D")
    love.window.setMode(config.screen_width * config.scale, config.screen_height * config.scale)
    love.graphics.setDefaultFilter("nearest", "nearest")

    res:load()
    scene = Scene.new(current_level)
end

function love.keypressed(key)
    if key == "f4" then
        love.event.quit()
    end

    scene:on_key(key)
end

function love.update(dt)
    if scene.is_next_level then
        current_level = current_level + 1
        scene = Scene.new(current_level)
    end

    scene:update(dt)
end

function love.draw()
    love.graphics.clear(0,0,0)
    love.graphics.push()
    love.graphics.scale(config.scale, config.scale)
    love.graphics.translate(-camera.x, -camera.y)
    scene:draw()
    love.graphics.pop()

    love.graphics.push()
    love.graphics.scale(config.scale, config.scale)
    scene:draw_ui()
    love.graphics.pop()
end