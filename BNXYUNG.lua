-- BNXYUNG PANEL V3.0 🔥
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

lp.CharacterAdded:Wait()
local char = lp.Character
local hum = char:WaitForChild("Humanoid")

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "BNXYUNG_PANEL"
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0.5, -200, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🧠 BNXYUNG PANEL"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Function Buttons
local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Parent = frame
    btn.MouseButton1Click:Connect(callback)
end

-- MAIN
createButton("💸 Auto Buy Brainrot", 50, function()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("BuyBrainrot")
    if remote then remote:FireServer() end
end)

createButton("🧲 Auto Collect", 90, function()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("CollectBrainrot")
    if remote then remote:FireServer() end
end)

createButton("🔒 Auto Lock Base", 130, function()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("LockBase")
    if remote then remote:FireServer() end
end)

createButton("🛡️ Anti AFK", 170, function()
    lp.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new())
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new())
    end)
end)

createButton("📈 Auto Upgrade Stats", 210, function()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("UpgradeStats")
    if remote then remote:FireServer() end
end)

createButton("🔁 Auto Rebirth", 250, function()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Rebirth")
    if remote then remote:FireServer() end
end)

-- PLAYER
createButton("🎯 Aimbot + FOV", 290, function()
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local function getClosest()
        local closest, dist = nil, math.huge
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local pos = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if mag < dist and mag < 150 then
                    closest = v
                    dist = mag
                end
            end
        end
        return closest
    end
    RunService.RenderStepped:Connect(function()
        local target = getClosest()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end)
end)

createButton("💨 Speed Booster 70%", 330, function()
    hum.WalkSpeed = hum.WalkSpeed * 1.7
end)

createButton("🛡️ Vida infinita + chaleco", 370, function()
    hum.MaxHealth = math.huge
    hum.Health = math.huge
    if not char:FindFirstChild("Vest") then
        local vest = Instance.new("Part", char)
        vest.Name = "Vest"
        vest.Size = Vector3.new(2,2,1)
        vest.Position = char.HumanoidRootPart.Position
        vest.Anchored = false
        vest.CanCollide = false
    end
end)

-- STEALER
createButton("🛍️ Auto Steal Brainrot", 410, function()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("StealBrainrot")
    if remote then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= lp and plr.Character and plr.Character:FindFirstChild("Brainrot") then
                remote:FireServer(plr.Character.Brainrot)
            end
        end
    end
end)
