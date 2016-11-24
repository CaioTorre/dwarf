Button = class()

function Button:init(x, y, spr, szx, szy, action)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
    self.spr = spr
    self.szx = szx
    self.szy = szy
    self.action = action
end

function Button:draw()
    -- Codea does not automatically call this method
    spriteMode(CENTER)
    sprite(self.spr, self.x, self.y, self.szx, self.szy)
    -- sprite("Documents:buttonDown")
end

function Button:touched(touch)
    -- Codea does not automatically call this method
    if touch.x > (self.x - self.szx/2) and touch.x < (self.x + self.szx/2) and touch.y > (self.y - self.szy/2) and touch.y < (self.y + self.szy/2) and touch.state == BEGAN and oktouch then 
        self.action()
        -- waittime = 0
        oktouch = false
    end
end
