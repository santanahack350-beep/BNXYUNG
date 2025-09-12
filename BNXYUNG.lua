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

local corner = Instance.new("UICorner", panel)
corner.CornerRadius = UDim.new(0, 8)

local stroke = Instance.new("UIStroke", panel)
stroke.Color = Color3.fromRGB(80, 80, 80)
stroke.Thickness = 2

local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🔥 BNXYUNG MENU V9.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local tabs = {"MAIN", "MOVEMENT", "VISUALS", "AIMBOT", "SERVER"}
local tabButtons = {}
local currentTab = "MAIN"

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
    btn.Text = "🔘 " .. name .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Name = tab
    btn.Visible = tab == currentTab
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = "🔘 " .. name .. (state and " [ON]" or " [OFF]")
        if state then func() end
    end)
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

-- MAIN
createButton("MAIN", "Magnet Collect", function()
    for _, drop in pairs(workspace:GetChildren()) do
        if drop:IsA("Tool") and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            drop.Handle.CFrame = lp.Character.HumanoidRootPart.CFrame
        end
    end
end)

createButton("MAIN", "Auto Equip Best", function()
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("EquipBest")
end)

createButton("MAIN", "Anti Slow Zones", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 32 end
end)

-- MOVEMENT
createButton("MOVEMENT", "Fly Mode", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = true end
end)

createButton("MOVEMENT", "Super Jump", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 120 end
end)

createButton("MOVEMENT", "Run Fast", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 60 end
end)

createButton("MOVEMENT", "Safe Jump (No Delete)", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
    end
end)

-- VISUALS
createButton("VISUALS", "ESP - Name", function()
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
            local esp = Instance.new("BillboardGui", p.Character.Head)
            esp.Size = UDim2.new(0, 100, 0, 40)
            esp.AlwaysOnTop = true
            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = p.Name
            label.TextColor3 = Color3.fromRGB(255, 0, 0)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
        end
    end
end)

-- AIMBOT
createButton("AIMBOT", "Aimbot (Head)", function()
    local cam = workspace.CurrentCamera
    local closest = nil
    local dist = math.huge
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
            local d = (cam.CFrame.Position - p.Character.Head.Position).Magnitude
            if d < dist then
                dist = d
                closest = p
            end
        end
    end
    if closest then
        cam.CFrame = CFrame.new(cam.CFrame.Position, closest.Character.Head.Position)
    end
end)

-- SERVER
createButton("SERVER", "Server Hop", function()
    local tp = game:GetService("TeleportService")
    tp:TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

createButton("SERVER", "Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, lp)
end)

-- MINIMIZE / CLOSE
local hide = Instance.new("TextButton", panel)
hide.Size = UDim2.new(0.5, -15, 0, 30)
hide.Position = UDim2.new(0, 10, 1, -35)
hide.Text = "🗕 HIDE"
hide.TextColor3 = Color3.fromRGB(255, 255, 255)
hide.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hide.Font = Enum.Font.GothamBold
hide.TextSize = 16
hide.MouseButton1Click:Connect(function()
    panel.Visible = false
end)

local close = Instance.new("TextButton", panel)
