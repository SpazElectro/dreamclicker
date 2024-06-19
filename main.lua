local lib_path = love.filesystem.getSaveDirectory().."/libraries"
package.cpath = string.format("%s;%s/?.%s", package.cpath, lib_path, "dll")

local imgui = require("libs.cimgui.init")
local engine = require("engine.engine")

local Image  = engine["Image"]
local Button = engine["Button"]

-- local image = Image.new("testImage", "button.png", 100, 100)
-- local button = Button.new("testButton", 100, 100, 190, 50):setcustomtrigger(
--     ---@param btn Button
--     function (btn)
--         image:addposition(10, 10)
--         btn:addposition(10, 10)
--     end)
local imgbtn = require("engine.elements.imagebutton").new('testimgbtn', "button.png", 200, 200)

function love.load()
    imgui.love.Init()
end

function love.draw()
    for _,v in pairs(_G.objectCluster) do
        v:draw()
    end
    
    -- imgui.ShowDemoWindow()
    imgui.Begin("Engine debug")
    for _,v in pairs(_G.objectCluster) do
        if imgui.Button("Delete##"..v.name) then
            print("Deleting "..v.name.."!")
            v:delete()
        end

        imgui.SameLine()
        imgui.Text(v.type.." - "..v.name)
    end
    imgui.End()

    imgui.Render()
    imgui.love.RenderDrawLists()
end

function love.update(dt)
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

