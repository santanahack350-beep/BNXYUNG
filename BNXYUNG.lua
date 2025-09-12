local lp = game:GetService("Players").LocalPlayer
lp.CharacterAdded:Wait()
local char = lp.Character
local hum = char:WaitForChild("Humanoid")

local gui = Instance.new("ScreenGui")
gui.Name = "BNXYUNG_PANEL"
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 540)
frame.Position = UDim2.new(0.5, -210, 0.5, -270)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🧠 BNXYUNG PANEL V4.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

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

-- 📂 MAIN
createButton("💸 Auto Buy Brainrot", 50, function()
    local r = game:GetService("ReplicatedStorage"):FindFirstChild("BuyBrainrot")
    if r then r:FireServer() end
end)

createButton("🧲 Auto Collect", 90, function()
    local r = game:GetService("ReplicatedStorage"):FindFirstChild("CollectBrainrot")
    if r then r:FireServer() end
end)

createButton("🔒 Auto Lock Base", 130, function()
    local r = game:GetService("ReplicatedStorage"):FindFirstChild("LockBase")
    if r then r:FireServer() end
end)

createButton("🛡️ Anti AFK", 170, function()
    lp.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new())
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new())
    end)
end)

createButton("📈 Auto Upgrade Stats", 210, function()
    local r = game:GetService("ReplicatedStorage"):FindFirstChild("UpgradeStats")
    if r then r:FireServer() end
end)

createButton("🔁 Auto Rebirth", 250, function()
    local r = game:GetService("ReplicatedStorage"):FindFirstChild("Rebirth")
    if r then r:FireServer() end
end)

createButton("🧲 Magnet Collect", 290, function()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Handle") then
            v.Handle.CFrame = lp.Character.HumanoidRootPart.CFrame
        end
    end
end)

createButton("🧤 Auto Equip Best", 330, function()
    local r = game:GetService("ReplicatedStorage"):FindFirstChild("EquipBest")
    if r then r:FireServer() end
end)

createButton("🚫 Anti Slow Zones", 370, function()
    hum.WalkSpeed = 32
end)

createButton("⚡ Auto Use Boosters", 410, function()
    local r = game:GetService("ReplicatedStorage"):FindFirstChild("UseBooster")
    if r then r:FireServer() end
end)

createButton("💀→🧍 Auto Respawn", 450, function()
    hum.Died:Connect(function()
        wait(1)
        lp:LoadCharacter()
    end)
end)

-- 📂 PLAYER
createButton("🎯 Aimbot + FOV", 490, function()
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local function getClosest()
        local closest, dist = nil, math.huge
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
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

createButton("👁️ ESP", 530, function()
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local billboard = Instance.new("BillboardGui", v.Character.HumanoidRootPart)
            billboard.Size = UDim2.new(0, 100, 0, 40)
            billboard.AlwaysOnTop = true
            local label = Instance.new("TextLabel", billboard)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Text = v.Name
            label.TextColor3 = Color3.new(1, 0, 0)
            label.BackgroundTransparency = 1
        end
    end
end)

createButton("✈️ Fly Mode", 570, function()
    hum.PlatformStand = true
    lp.Character.HumanoidRootPart.Anchored = false
end)

createButton("🔼 Infinity Jump", 610, function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

createButton("🧍 Anti Ragdoll", 650, function()
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
end)

createButton("💨 Speed Booster", 690, function()
    hum.WalkSpeed = hum.WalkSpeed * 1.7
end)

createButton("🌶️ Chilli Booster", 730, function()
    hum.JumpPower = hum.JumpPower * 1.5
end)

createButton("🛬 Anti Fall Damage", 770, function()
    hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
end)

-- 📂 STEALER
createButton("🛍️ Auto Steal (Remote)", 810, function()
    local r = game:GetService("ReplicatedStorage"):FindFirstChild("StealBrainrot")
    if r then
        for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
            if plr ~= lp and plr.Character and plr.Character:FindFirstChild("Brainrot") then
                r:FireServer(plr.Character.Brainrot)
            end
        end
    end
end)

createButton("👻 Invisible Steal", 850, function()
    lp.Character.HumanoidRootPart.Transparency = 1
end)

createButton("📦 TP a Highest Value", 890, function()
    local best = nil
    local highest = 0
    for _, b in pairs(workspace:GetChildren()) do
        if b:IsA("Model") and b:FindFirstChild("Value") then
            local val = b.Value.Value
            if val > highest then
                highest = val
                best = b
            end
        end
    end
    if best and lp.Character then
        lp.Character:MoveTo(best.Position)
    end
end)

createButton("🧭 Auto Steal Nearest", 930, function()
    local r = game:GetService("ReplicatedStorage"):FindFirstChild("StealBrainrot")
    if r then
        local closest, dist = nil, math.huge
        for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
            if plr ~= lp and plr.Character and plr.Character:FindFirstChild("Brainrot") then
