
res = {}

function res:load()
    self.ui_hearts    = love.graphics.newImage("data/ui_hearts.png")
    self.tileset      = love.graphics.newImage("data/tileset.png")
    self.heart        = love.graphics.newImage("data/heart.png")
    self.heart:setWrap("repeat", "repeat")
    self.player       = love.graphics.newImage("data/run.png")
    self.pickup_heart = love.graphics.newImage("data/pickup_heart.png")
    self.score        = love.graphics.newImage("data/score.png")
    self.press_start  = love.graphics.newImage("data/press_start2.png")
    self.numbers      = love.graphics.newImage("data/numbers.png")
    self.spikes       = love.graphics.newImage("data/spikes.png")
    self.total        = love.graphics.newImage("data/total.png")
    self.water        = love.graphics.newImage("data/water.png")
    self.bird         = love.graphics.newImage("data/birb.png")
    self.splash       = love.graphics.newImage("data/splash.png")
    self.the_end      = love.graphics.newImage("data/the_end.png")
end
