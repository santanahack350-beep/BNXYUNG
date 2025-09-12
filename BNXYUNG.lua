local lp = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "BNXYUNG_PANEL"
gui.ResetOnSpawn = false

local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 600, 0, 500)
panel.Position = UDim2.new(0.5, -300, 0.5, -250)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
panel.BorderSizePixel = 0
panel.Active = true
panel.Draggable = true
panel.Visible = true

local stroke = Instance.new("UIStroke", panel)
stroke.Thickness = 2
task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            stroke.Color = Color3.fromHSV(i, 1, 1)
            task.wait(0.03)
        end
    end
end)

local sound = Instance.new("Sound", gui)
sound.SoundId = "rbxassetid://9118823104"
sound.Volume = 1
sound:Play()

local notify = Instance.new("TextLabel", gui)
notify.Size = UDim2.new(0, 300, 0, 40)
notify.Position = UDim2.new(0.5, -150, 0, 20)
notify.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
notify.TextColor3 = Color3.fromRGB(255, 255, 255)
notify.Text = "✅ BNXYUNG PANEL V2.0 ACTIVADO"
notify.Font = Enum.Font.GothamBold
notify.TextSize = 16
notify.BackgroundTransparency = 0.2
notify.ZIndex = 999
game:GetService("TweenService"):Create(notify, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0, 60)}):Play()
task.delay(3, function() notify:Destroy() end)

local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🔥 BNXYUNG PANEL V2.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local tabs = {"BRAINROT", "CRÉDITO"}
local tabButtons = {}
local currentTab = "BRAINROT"

local tabFrame = Instance.new("Frame", panel)
tabFrame.Size = UDim2.new(0, 120, 1, -50)
tabFrame.Position = UDim2.new(0, 0, 0, 50)
tabFrame.BackgroundTransparency = 1

local contentFrame = Instance.new("Frame", panel)
contentFrame.Size = UDim2.new(1, -140, 1, -60)
contentFrame.Position = UDim2.new(0, 130, 0, 50)
contentFrame.BackgroundTransparency = 1

local scroll = Instance.new("ScrollingFrame", contentFrame)
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, 1000)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local scrollLayout = Instance.new("UIListLayout", scroll)
scrollLayout.Padding = UDim.new(0, 6)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createButton(tab, name, func)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = "🔘 " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Name = tab
    btn.Visible = tab == currentTab
    btn.MouseButton1Click:Connect(func)
end

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton", tabFrame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, (i - 1) * 35)
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    tabButtons[tabName] = btn
    btn.MouseButton1Click:Connect(function()
        currentTab = tabName
        for _, child in pairs(scroll:GetChildren()) do
            if child:IsA("TextButton") then
                child.Visible = child.Name == tabName
            end
        end
    end)
end

-- FUNCIONES BRAINROT
createButton("BRAINROT", "ESP Name", function()
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
            local esp = Instance.new("BillboardGui", p.Character.Head)
            esp.Size = UDim2.new(0, 100, 0, 40)
            esp.AlwaysOnTop = true
            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = p.Name
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
        end
    end
end)

createButton("BRAINROT", "ESP ID", function()
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= lp and p.UserId and p.Character and p.Character:FindFirstChild("Head") then
            local esp = Instance.new("BillboardGui", p.Character.Head)
            esp.Size = UDim2.new(0, 100, 0, 40)
            esp.AlwaysOnTop = true
            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = "ID: " .. p.UserId
            label.TextColor3 = Color3.fromRGB(0, 255, 255)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
        end
    end
end)

createButton("BRAINROT", "ESP Skin", function()
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
            local esp = Instance.new("BillboardGui", p.Character.Head)
            esp.Size = UDim2.new(0, 100, 0, 40)
            esp.AlwaysOnTop = true
            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = "Skin: " .. tostring(p.Character:FindFirstChildOfClass("Shirt") and p.Character.Shirt.ShirtTemplate or "N/A")
            label.TextColor3 = Color3.fromRGB(255, 200, 0)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
        end
    end
end)

createButton("BRAINROT", "Skeleton ESP", function()
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= lp and p.Character then
            for _, limb in pairs(p.Character:GetChildren()) do
                if limb:IsA("BasePart") then
                    local box = Instance.new("BoxHandleAdornment", limb)
                    box.Size = limb.Size
                    box.Adornee = limb
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Color3 = Color3.fromRGB(0, 255, 0)
                    box.Transparency = 0.5
                end
            end
        end
    end
end)

createButton("BRAINROT", "Línea ESP", function()
    local camera = workspace.CurrentCamera
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local tracer
