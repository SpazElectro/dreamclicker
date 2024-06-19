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
    local self = setmetatable(Button.new(name, x, y, img.image:getWidth(), img.image:getHeight()), Button)
    self.on_trigger = nil
---@diagnostic disable-next-line: inject-field
    self.img = img

    return self
end

return ImageButton