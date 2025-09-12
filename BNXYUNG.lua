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
notify.Text = "✅ BNXYUNG PANEL V1.0 ACTIVADO"
notify.Font = Enum.Font.GothamBold
notify.TextSize = 16
notify.BackgroundTransparency = 0.2
notify.ZIndex = 999
game:GetService("TweenService"):Create(notify, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0, 60)}):Play()
task.delay(3, function() notify:Destroy() end)

local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🔥 BNXYUNG PANEL V1.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local tabs = {"MAIN", "MOVEMENT", "VISUALS", "AIMBOT", "SERVER", "CRÉDITO"}
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

-- FUNCIONES DE EJEMPLO
createButton("MAIN", "Magnet Collect", function()
    for _, drop in pairs(workspace:GetChildren()) do
        if drop:IsA("Tool") and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            drop.Handle.CFrame = lp.Character.HumanoidRootPart.CFrame
        end
    end
end)

createButton("VISUALS", "ESP Name", function()
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

createButton("CRÉDITO", "Crédito: BNXYUNG7", function() end)
createButton("CRÉDITO", "Grupo: https://t.me/kakashii_ios", function() end)

-- BOTÓN MINIMIZAR
local hide = Instance.new("TextButton", panel)
hide.Size = UDim2.new(0, 30, 0, 30)
hide.Position = UDim2.new(1, -70, 0, 10)
hide.Text = "-"
hide.TextColor3 = Color3.fromRGB(255, 255, 255)
hide.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hide.Font = Enum.Font.GothamBold
hide.TextSize = 20
hide.MouseButton1Click:Connect(function()
    panel.Visible = false
    showBtn.Visible = true
end)

-- BOTÓN CERRAR
local close = Instance.new("TextButton", panel)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 10)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
close.Font = Enum.Font.GothamBold
close.TextSize = 20
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- BOTÓN FLOTANTE PARA REABRIR PANEL
local showBtn = Instance.new("TextButton", gui)
showBtn.Size = UDim2.new(0, 160, 0, 40)
showBtn.Position = UDim2.new(0, 20, 0.5, -20)
showBtn.Text = "+ BNXYUNG PANEL"
showBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
showBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
showBtn.Font = Enum.Font.GothamBold
showBtn.TextSize = 16
showBtn.Visible = false
showBtn.MouseButton1Click:Connect(function()
    panel.Visible = true
    showBtn.Visible = false
end)

-- TE
