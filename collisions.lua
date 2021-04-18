--

CollisionRect = {}
CollisionRect.__index = CollisionRect

function CollisionRect.new(x, y, w, h)
    local self = setmetatable({}, CollisionRect)

    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.static = false
    self.trigger = false

    return self
end

function aabb_overlap(a, b)
    if a.x > b.x + b.w then return false end
    if a.x + a.w < b.x then return false end
    if a.y > b.y + b.h then return false end
    if a.y + a.h < b.y then return false end

    return true
end

function aabb_response(a, b, move)
    move.x = 0
    move.y = 0

    local left   = b.x - (a.x + a.w);
    local right  = (b.x + b.w) - a.x;
    local top    = b.y - (a.y + a.h);
    local bottom = (b.y + b.h) - a.y;

    if left > 0 or right < 0 or top > 0 or bottom < 0 then
        return false
    end

    move.x = math.abs(left) < right and left or right
    move.y = math.abs(top) < bottom and top or bottom

    if math.abs(move.x) < math.abs(move.y) then
        move.y = 0
    else
        move.x = 0
    end

    return true;
end

CollisionWorld = {}
CollisionWorld.__index = CollisionWorld

function CollisionWorld.new()
    local self = setmetatable({}, CollisionWorld)

    self.rectangles = {}
    self.triggers = {}

    return self
end

function CollisionWorld:add_rect(x,y,w,h)
    local rect = CollisionRect.new(x,y,w,h)
    table.insert(self.rectangles, rect)
    return rect
end

function CollisionWorld:add_trigger(x,y,w,h)
    local rect = CollisionRect.new(x,y,w,h)
    rect.is_overlapping = false
    table.insert(self.triggers, rect)
    return rect
end

function CollisionWorld:solve()
    for i = 1, #self.rectangles-1 do
        for j = i+1, #self.rectangles do
            local move = {x=0,y=0}

            local a = self.rectangles[i]
            local b = self.rectangles[j]
            if aabb_response(a, b, move) then

                if not a.static and not b.static then
                    a.x = a.x + move.x/2
                    a.y = a.y + move.y/2

                    b.x = b.x - move.x/2
                    b.y = b.y - move.y/2
                elseif not a.static and b.static then
                    a.x = a.x + move.x
                    a.y = a.y + move.y
                elseif a.static and not b.static then
                    b.x = b.x - move.x
                    b.y = b.y - move.y
                end
            end
        end
    end

    for i = 1, #self.triggers do
        for j = 1, #self.rectangles do
            local a = self.triggers[i]
            local b = self.rectangles[j]

            a.is_overlapping = aabb_overlap(a, b) and b.static

            if a.is_overlapping then
                -- if a.object then
                --     a.object:on_contact(b.object)
                -- end
                break
            end
        end
    end
end

function CollisionWorld:draw()
    for i = 1, #self.rectangles do
        local rect = self.rectangles[i]
        if rect.static then
            love.graphics.setColor(1,1,1)
        else
            love.graphics.setColor(0,0,1)
        end
        love.graphics.rectangle("line", rect.x, rect.y, rect.w, rect.h)
    end

    for i = 1, #self.triggers do
        local rect = self.triggers[i]

        love.graphics.setColor(0,1,0)
        love.graphics.rectangle("line", rect.x, rect.y, rect.w, rect.h)
    end
end