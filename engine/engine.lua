require("engine.init")

---@param evtype "mousepressed" | "keypressed"
local function passEvent(evtype, ...)
    if evtype == "mousepressed" or evtype == "keypressed" then
        for _,v in pairs(_G.objectCluster) do
            v[evtype](...)
        end
    else
        print("Unrecognized event was passed to the engine! type: "..tostring(evtype))
    end
end

return {
    ["Image"] = require("engine.elements.image"),
    ["pass"] = passEvent
}