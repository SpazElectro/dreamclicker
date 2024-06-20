local Button = require("engine.elements.button")
local Image  = require("engine.elements.image")

---@class ImageButton : Button
---@field img Image
local ImageButton = {}
ImageButton.__index = ImageButton
setmetatable(ImageButton, {__index = Button})

---@param name string     GameObject name
---@param filename string Image filename
---@param x integer       X position
---@param y integer       Y position
---@param _type string?   GameObject type
function ImageButton.new(name, filename, x, y, _type)
    local img = Image.new(name.."_img", filename, x, y)
    local btn = Button.new(name, x, y, img.image:getWidth(), img.image:getHeight(), _type or nil)
    btn.setposition = ImageButton.setposition
    btn.addposition = ImageButton.addposition
    
    local self = setmetatable(btn, Button)
    
    ---@diagnostic disable-next-line: inject-field
    self.img = img

    return self
end

---@param x integer? New X position
---@param y integer? New Y position
function ImageButton:setposition(x, y)
    self.x = x or self.x
    self.y = y or self.y
    
    self.img.x = x or self.img.x
    self.img.y = y or self.img.y
end

---@param x integer? X position to add
---@param y integer? Y position to add
function ImageButton:addposition(x, y)
    self.x = self.x + (x or 0)
    self.y = self.y + (y or 0)
    
    self.img.x = self.img.x + (x or 0)
    self.img.y = self.img.y + (y or 0)
end

return ImageButton