local Transform = require("engine.elements.transform")
local utils     = require("engine.utils")

---@class Button : Transform
---@field on_trigger fun(self)?
local Button = {}
Button.__index = Button
setmetatable(Button, {__index = Transform})

---@param name string    GameObject name
---@param x integer      X position
---@param y integer      Y position
---@param width integer  Width
---@param height integer Height
---@param _type string?  GameObject type
function Button.new(name, x, y, width, height, _type)
    local self = setmetatable(Transform.new(name, x, y, 0, _type or "Button"), Button)
    self.width = width
    self.height = height
    self.on_trigger = nil

    return self
end

function Button:mousepressed(x, y, button, istouch, presses)
    if utils.ismousecolliding(self:getboundingbox()) then
        if self.on_trigger ~= nil then
            self.on_trigger(self)
        end
    end
end

--- Applies an on trigger function
---@param trigger fun(Button)
---@return Button
function Button:setcustomtrigger(trigger)
    self.on_trigger = trigger
    return self
end

return Button