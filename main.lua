require "config"
require "scene"
require "splash_screen"
require "end_screen"

local scene = nil

function love.load()
    love.window.setTitle("LOVE2D")
    love.window.setMode(config.screen_width * config.scale, config.screen_height * config.scale)
    love.graphics.setDefaultFilter("nearest", "nearest")

    res:load()
    score_counter:init()
    -- scene = Scene.new(1)
    scene = SplashScreen.new()
end

function love.keypressed(key)
    if key == "f4" then
        love.event.quit()
    end

    scene:on_key(key)
end

function love.update(dt)
    if scene.is_next_level then
        local next_level = scene.next_level

        if next_level == #levels + 1 then
            scene = EndScreen.new()
        elseif next_level == -1 then
            scene = SplashScreen.new()
        else
            scene = Scene.new(next_level)
        end
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