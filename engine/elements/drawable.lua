local GameObject = require("engine.elements.gameobject")

---@class Drawable : GameObject
---@field x integer X position
---@field y integer Y position
---@field r integer? Rotation
local Drawable = {}
Drawable.__index = Drawable
setmetatable(Drawable, {__index = GameObject})

function Drawable.new(name, x, y, r, _type)
    local self = setmetatable(GameObject.new(name, _type or "Drawable"), Drawable)
    self.x = x
    self.y = y
    self.r = r or 0

    return self
end

---@param x integer? New X position
---@param y integer? New Y position
function Drawable:setposition(x, y)
    self.x = x or self.x
    self.y = y or self.y
end

---@param x integer? X position to add
---@param y integer? Y position to add
function Drawable:addposition(x, y)
    self.x = self.x + (x or 0)
    self.y = self.y + (y or 0)
end

return Drawable