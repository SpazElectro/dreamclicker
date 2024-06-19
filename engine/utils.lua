local MOUSE_WIDTH  = 50
local MOUSE_HEIGHT = 50

--- Finds the index of an element in a table
---@param tbl table The table to search
---@param value any The value to find
---@return number|nil The index of the value if found, or nil if not found
function table.find(tbl, value)
    for i, v in ipairs(tbl) do
        if v == value then
            return i
        end
    end
    return nil
end

--- Checks if 2 boxes are colliding
---@param x1 integer The x position of the first box
---@param y1 integer The y position of the first box
---@param w1 integer The width of the first box
---@param h1 integer The height of the first box
---@param x2 integer The x position of the second box
---@param y2 integer The y position of the second box
---@param w2 integer The width of the second box
---@param h2 integer The height of the second box
---@return boolean
local function colch(
    x1, y1, w1, h1,
    x2, y2, w2, h2
)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

--- Check if 2 bounding boxes are colliding
---@param a table<integer, integer, integer, integer> The first bounding box
---@param b table<integer, integer, integer, integer> The second bounding box
---@return boolean
local function boundingboxcheck(a, b)
    return colch(a[1], a[2], a[3], a[4], b[1], b[2], b[3], b[4])
end

--- Gets the bounding box of the mouse
---@return table<integer, integer, integer, integer>
local function getmouseboundingbox()
    return {love.mouse.getX(), love.mouse.getY(), MOUSE_WIDTH, MOUSE_HEIGHT}
end

--- Checks if the mouse is colliding with another bounding box
---@param b table<integer, integer, integer, integer> The bounding box
---@return boolean
local function ismousecolliding(b)
    return boundingboxcheck(getmouseboundingbox(), b)
end

local function mergetables(...)
    local result = {}
    for _, tbl in ipairs({...}) do
        for k, v in pairs(tbl) do
            result[k] = v
        end
    end
    return result
end

return {
    collisioncheck = colch,
    boundingboxcheck = boundingboxcheck,
    getmouseboundingbox = getmouseboundingbox,
    ismousecolliding = ismousecolliding,
    mergetables = mergetables
}