
res = {}

function res:load()
    self.ui_hearts = love.graphics.newImage("data/ui_hearts.png")
    self.tileset = love.graphics.newImage("data/tileset.png")
    self.heart = love.graphics.newImage("data/heart.png")
    self.heart:setWrap("repeat", "repeat")
    self.player = love.graphics.newImage("data/run.png")
end
