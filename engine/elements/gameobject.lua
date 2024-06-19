---@class GameObject
---@field type string
---@field name string
---@field custom_update fun(GameObject, number)?
---@field custom_draw fun(GameObject)?
local GameObject = {}
GameObject.__index = GameObject

--- Creates a new GameObject
---@param name string The name of the GameObject
---@param type string The type of the GameObject
---@return GameObject
function GameObject.new(name, type)
    local self = setmetatable({}, GameObject)
    self.name = name
    self.type = type or "GameObject"

    _G.objectCluster[name] = self
    
    return self
end

--- Deletes the GameObject
function GameObject:delete()
    table.remove(_G.objectCluster, table.find(_G.objectCluster, self.name))
end

--- Updates the GameObject
---@param dt integer
function GameObject:update(dt)
    if self.custom_update ~= nil then
        self.custom_update(self, dt)
    end
end

--- Draws the GameObject
function GameObject:draw()
    if self.custom_draw ~= nil then
        self.custom_draw(self)
    end
end

--- Called when the event is passed to the engine
---@param key love.KeyConstant   The key
---@param scancode love.Scancode The scancode of the key
---@param isrepeat boolean       Is this a repeated press
function GameObject:keypressed(key, scancode, isrepeat) end

--- Called when the event is passed to the engine
---@param x integer       X position of the press
---@param y integer       Y position of the press
---@param button integer  Which button was pressed
---@param istouch boolean Was this a touch
---@param presses integer How many times has it fired recently
function GameObject:mousepressed(x, y, button, istouch, presses) end

--- Applies a custom update function
---@param custom_update fun(GameObject, number)
---@return GameObject
function GameObject:setcustomupdate(custom_update)
    self.custom_update = custom_update
    return self
end

--- Applies a custom draw function
---@param custom_draw fun(GameObject)
---@return GameObject
function GameObject:setcustomdraw(custom_draw)
    self.custom_draw = custom_draw
    return self
end

return GameObject