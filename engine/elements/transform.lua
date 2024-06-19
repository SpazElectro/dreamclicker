local GameObject = require("engine.elements.gameobject")
local utils      = require("engine.utils")

---@class Transform : GameObject
---@field x integer  X position
---@field y integer  Y position
---@field r integer? Rotation
local Transform = {}
Transform.__index = Transform
setmetatable(Transform, {__index = GameObject})

function Transform.new(name, x, y, r, _type)
    local self = setmetatable(GameObject.new(name, _type or "Transform"), Transform)
    self.x = x
    self.y = y
    self.width = 0
    self.height = 0
    self.r = r or 0

    return self
end

---@param x integer? New X position
---@param y integer? New Y position
function Transform:setposition(x, y)
    self.x = x or self.x
    self.y = y or self.y
end

---@param x integer? X position to add
---@param y integer? Y position to add
function Transform:addposition(x, y)
    self.x = self.x + (x or 0)
    self.y = self.y + (y or 0)
end

---@param w integer? New width
---@param h integer? New height
function Transform:setsize(w, h)
    self.width = w or self.width
    self.height = h or self.height
end

--- Returns the bounding box of the Transform
---@return table<integer, integer, integer, integer>
function Transform:getboundingbox()
    return {self.x, self.y, self.width, self.height}
end

--- Is this element colliding with another element
---@param b Transform
---@return boolean
function Transform:iscollidingwith(b)
    return utils.boundingboxcheck(self:getboundingbox(), b:getboundingbox())
end

return Transform