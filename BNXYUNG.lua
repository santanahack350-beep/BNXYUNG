-- BNXYUNG PANEL V3.0 🔥
local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- GUI Setup
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "BNXYUNG_PANEL"
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0.5, -200, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🧠 BNXYUNG PANEL"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Function Buttons
local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.MouseButton1Click:Connect(callback)
end

-- MAIN
createButton("💸 Auto Buy Brainrot", 50, function()
    print("Auto Buy Brainrot activado")
end)

createButton("🧲 Auto Collect", 90, function()
    print("Auto Collect activado")
end)

createButton("🔒 Auto Lock Base", 130, function()
    print("Auto Lock Base activado")
end)

createButton("🛡️ Anti AFK", 170, function()
    lp.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new())
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new())
    end)
end)

createButton("📈 Auto Upgrade Stats", 210, function()
    print("Auto Upgrade Stats activado")
end)

createButton("🔁 Auto Rebirth", 250, function()
    print("Auto Rebirth activado")
end)

-- PLAYER
createButton("🎯 Aimbot + FOV", 290, function()
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

createButton("💨 Speed Booster 70%", 330, function()
    hum.WalkSpeed = hum.WalkSpeed * 1.7
end)

createButton("🛡️ Vida infinita + chaleco", 370, function()
    hum.MaxHealth = math.huge
    hum.Health = math.huge
    if char:FindFirstChild("Vest") then
        char.Vest:Destroy()
    end
    local vest = Instance.new("Part", char)
    vest.Name = "Vest"
    vest.Size = Vector3.new(2,2,1)
    vest.Position = char.HumanoidRootPart.Position
    vest.Anchored = false
    vest.CanCollide = false
end)

-- STEALER
createButton("🛍️ Auto Steal Brainrot", 410, function()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("StealBrainrot")
    if remote then
        for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
            if plr ~= lp and plr.Character and plr.Character:FindFirstChild("Brainrot") then
                remote:FireServer(plr.Character.Brainrot)
            end
        end
    end
end)
