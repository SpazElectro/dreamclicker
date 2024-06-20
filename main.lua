local ffi = require("ffi")
function createPointer(type, default)
    return ffi.new(type.."[1]", default)
end

local lib_path = love.filesystem.getSaveDirectory().."/libraries"
package.cpath = string.format("%s;%s/?.%s", package.cpath, lib_path, "dll")

local imgui = require("libs.cimgui.init")
local engine = require("engine.engine")

local Image  = engine["Image"]
local Button = engine["Button"]
local ImageButton = engine["ImageButton"]

-- local image = Image.new("testImage", "button.png", 100, 100)
-- local button = Button.new("testButton", 100, 100, 190, 50):setcustomtrigger(
--     ---@param btn Button
--     function (btn)
--         image:addposition(10, 10)
--         btn:addposition(10, 10)
--     end)
local imgbtn = ImageButton.new("testimgbtn", "button.png", 200, 200):setcustomupdate(
---@param g Transform
---@param dt number    
function (g, dt)
    g:setstate("ascend", false, false)
    g:addposition(60*dt*(g:getstate("ascend") and -1 or 1))
    if g.x >= 600 then
        g:setstate("ascend", true)
    end
    if g.x <= 0 then
        g:setstate("ascend", false)
    end
end)

function love.load()
    imgui.love.Init()
end

---@type {inspecting: table<GameObject>, timeScale: ffi.cdata*}
local debug = {
    inspecting = {},
    timeScale = createPointer("float", 1.0)
}

function love.draw()
    for _,v in pairs(_G.objectCluster) do
        v:draw()
    end

    imgui.Begin("Engine")
    imgui.SliderFloat("Time scale", debug.timeScale, 0.5, 10.0, "%.2f", 0)
    imgui.End()

    imgui.Begin("Explorer")
    for _,v in pairs(_G.objectCluster) do
        if imgui.Button("Inspect##"..v.name) then
            if table.find(debug.inspecting, v) == nil then
                table.insert(debug.inspecting, v)
            end
        end

        imgui.SameLine()
        imgui.Text(v.type.." - "..v.name)
    end
    imgui.End()

    for i, t in pairs(debug.inspecting) do
        imgui.Begin("Inspector##"..t.name)
        imgui.Text("Name: "..t.name)
        imgui.SameLine()
        imgui.Text("Type: "..t.type)
        
        imgui.Text("Has custom update: "..tostring(t.custom_update~=nil))
        imgui.SameLine()
        if imgui.Button("Delete##cu"..t.name) then
            t.custom_update = nil
        end
        imgui.Text("Has custom draw: "..tostring(t.custom_draw~=nil))
        imgui.SameLine()
        if imgui.Button("Delete##cd"..t.name) then
            t.custom_draw = nil
        end

        if imgui.Button("Delete##"..t.name) then
            t:delete()
---@diagnostic disable-next-line: param-type-mismatch
            table.remove(debug.inspecting, i)
        end
        imgui.SameLine()
        if imgui.Button("Cancel##"..t.name) then
---@diagnostic disable-next-line: param-type-mismatch
            table.remove(debug.inspecting, i)
        end

        
        imgui.End()
    end

    imgui.Render()
    imgui.love.RenderDrawLists()
end

function love.update(dt)
    dt = dt * debug.timeScale[0]

    for _,v in pairs(_G.objectCluster) do
        v:update(dt)
    end

    imgui.love.Update(dt)
    imgui.NewFrame()
end

function love.quit()
    for _,v in pairs(_G.objectCluster) do
        v:delete()
    end

    return imgui.love.Shutdown()
end

function love.keypressed(key, scancode, isrepeat)
    imgui.love.KeyPressed(key)
    if not imgui.love.GetWantCaptureKeyboard() then
        engine.pass("keypressed", key, scancode, isrepeat)
    end
end
function love.mousepressed(x, y, button, istouch, presses)
    imgui.love.MousePressed(button)
    if not imgui.love.GetWantCaptureMouse() then
        engine.pass("mousepressed", x, y, button, istouch, presses)
    end
end
function love.mousemoved(x, y, ...)
    imgui.love.MouseMoved(x, y)
    if not imgui.love.GetWantCaptureMouse() then

    end
end
function love.mousereleased(x, y, button, ...)
    imgui.love.MouseReleased(button)
    if not imgui.love.GetWantCaptureMouse() then

    end
end
function love.wheelmoved(x, y)
    imgui.love.WheelMoved(x, y)
    if not imgui.love.GetWantCaptureMouse() then

    end
end
function love.keyreleased(key, ...)
    imgui.love.KeyReleased(key)
    if not imgui.love.GetWantCaptureKeyboard() then

    end
end
function love.textinput(t)
    imgui.love.TextInput(t)
    if imgui.love.GetWantCaptureKeyboard() then

    end
end

