---@param f table
---@param l any
function table.find(f, l)
    for _, v in ipairs(l) do
        if f(v) then
        return v
        end
        end
    return nil
end

return {}