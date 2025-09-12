local lp = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "BNXYUNG_PANEL"
gui.ResetOnSpawn = false

local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 300, 0, 420)
panel.Position = UDim2.new(0.5, -150, 0.5, -210)
panel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
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
title.Text = "🧠 BNXYUNG MENU"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local layout = Instance.new("UIListLayout", panel)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
title.LayoutOrder = 0

local toggles = {
    {text = "Magnet Collect", func = function()
        for _, drop in pairs(workspace:GetChildren()) do
            if drop:IsA("Tool") and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                drop.Handle.CFrame = lp.Character.HumanoidRootPart.CFrame
            end
        end
    end},
    {text = "Auto Equip Best", func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("EquipBest")
    end},
    {text = "Anti Slow Zones", func = function()
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 32 end
    end},
    {text = "Auto Use Boosters", func = function()
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("UseBoosters")
    end},
    {text = "Auto Respawn", func = function()
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.Died:Connect(function()
                wait(1)
                lp:LoadCharacter()
            end)
        end
    end},
    {text = "Aimbot", func = function()
        local cam = workspace.CurrentCamera
        local closest = nil
        local dist = math.huge
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d = (cam.CFrame.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = p
                end
            end
        end
        if closest then
            cam.CFrame = CFrame.new(cam.CFrame.Position, closest.Character.HumanoidRootPart.Position)
        end
    end},
    {text = "ESP", func = function()
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
    end},
    {text = "Fly Mode", func = function()
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = true end
    end},
    {text = "Infinity Jump", func = function()
        game:GetService("UserInputService").JumpRequest:Connect(function()
            lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end)
    end},
    {text = "Anti Ragdoll", func = function()
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end
    end}
}

for i, data in ipairs(toggles) do
    local btn = Instance.new("TextButton", panel)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, 40 + (i * 35))
    btn.Text = "🔘 " .. data.text .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.LayoutOrder = i
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = "🔘 " .. data.text .. (state and " [ON]" or " [OFF]")
        if state then data.func() end
    end)
end

local hide = Instance.new("TextButton", panel)
hide.Size = UDim2.new(0.5, -15, 0, 30)
hide.Text = "🗕 HIDE"
hide.TextColor3 = Color3.fromRGB(255, 255, 255)
hide.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hide.Font = Enum.Font.GothamBold
hide.TextSize = 16
hide.LayoutOrder = #toggles + 1
hide.MouseButton1Click:Connect(function()
    panel.Visible = false
end)

local close = Instance.new("TextButton", panel)
close.Size = UDim2.new(0.5, -15, 0, 30)
close.Position = UDim2.new(0.5, 5, 0, 0)
close.Text = "❌ CLOSE"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.LayoutOrder = #toggles + 2
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
