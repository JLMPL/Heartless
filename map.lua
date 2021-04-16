Map = {}
Map.__index = Map

function Map.new(phys_world, file)
    local tiles = {
        love.graphics.newQuad(0, 0, 16, 16, res.tileset:getWidth(), res.tileset:getHeight()),
        love.graphics.newQuad(16, 0, 16, 16, res.tileset:getWidth(), res.tileset:getHeight()),
        love.graphics.newQuad(32, 0, 16, 16, res.tileset:getWidth(), res.tileset:getHeight())
    }

    local self = setmetatable({}, Map)
    self.name = "map"

    local raw = require("data/test_map")

    self.colliders = {}
    local objects = raw.layers[1].objects

    for i = 1, #objects do
        local obj = objects[i]
        self.colliders[i] = phys_world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
        self.colliders[i]:setType("static")
        self.colliders[i]:setCollisionClass("map")
        self.colliders[i]:setObject(self)
    end

    local layer = raw.layers[2]

    self.width = layer.width
    self.height = layer.height
    self.sprite_batch = love.graphics.newSpriteBatch(res.tileset, self.width * self.height)

    for i = 1, layer.height-1 do
        for j = 1, layer.width do
            local index = i * layer.width + j

            if layer.data[index] == 0 then
                goto why_no_continue
            end

            local tile = love.graphics.newQuad((layer.data[index]-1) * 16, 0, 16, 16, res.tileset:getWidth(), res.tileset:getHeight())

            self.sprite_batch:add(tile, (j-1) * 16, i * 16)
            ::why_no_continue::
        end
    end

    return self
end

function Map:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.sprite_batch)
end