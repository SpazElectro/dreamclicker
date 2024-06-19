local Transform = require("engine.elements.transform")
local GameObject = require("engine.elements.gameobject")

---@class Image : Transform
---@field filename string
---@field image love.Image
local Image = {}
Image.__index = Image
setmetatable(Image, {__index = Transform})

---@param name string     GameObject name
---@param filename string Image filename
---@param x integer       X position
---@param y integer       Y position
---@param r integer?      Rotation
---@param _type string?   GameObject type
function Image.new(name, filename, x, y, r, _type)
    local self = setmetatable(Transform.new(name, x, y, r, _type or "Image"), Image)
    self.filename = filename
    self.image = love.graphics.newImage("assets/"..filename)

    return self
end

function Image:draw()
    GameObject.draw(self)
    love.graphics.draw(self.image, self.x, self.y, self.r)
end

return Image