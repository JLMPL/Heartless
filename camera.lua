
camera = {}
camera.x = 0
camera.y = 0

camera.target_x = 256
camera.going_right = false

function camera:update(dt)
    if camera.going_right then
        self.x = math.min(256, self.x + dt * 100)
    end
end

function camera:level_finished()
    camera.target_x = 256
    camera.going_right = true
end

function camera:reset()
    camera.x = 0
    camera.target_x = 0
    camera.going_right = false
end