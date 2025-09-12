local lp = game:GetService("Players").LocalPlayer
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

local y = 50
local function createButton(text, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.MouseButton1Click:Connect(callback)
    y += 40
end

-- 📂 MAIN
createButton("💸 Auto Buy Brainrot", function() print("Auto Buy Brainrot activado") end)
createButton("🧲 Auto Collect", function() print("Auto Collect activado") end)
createButton("🔒 Auto Lock Base", function() print("Auto Lock Base activado") end)
createButton("🛡️ Anti AFK", function()
    lp.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new())
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new())
    end)
end)
createButton("📈 Auto Upgrade Stats", function() print("Auto Upgrade Stats activado") end)
createButton("🔁 Auto Rebirth", function() print("Auto Rebirth activado") end)
createButton("🧲 Magnet Collect", function() print("Magnet activado") end)
createButton("🧤 Auto Equip Best", function() print("Equip Best activado") end)
createButton("🚫 Anti Slow Zones", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 32 end
end)
createButton("⚡ Auto Use Boosters", function() print("Boosters activados") end)
createButton("💀→🧍 Auto Respawn", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Died:Connect(function()
            wait(1)
            lp:LoadCharacter()
        end)
    end
end)

-- 📂 PLAYER
createButton("🎯 Aimbot", function() print("Aimbot activado") end)
createButton("👁️ ESP", function() print("ESP activado") end)
createButton("✈️ Fly Mode", function() print("Fly activado") end)
createButton("🔼 Infinity Jump", function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)
createButton("🧍 Anti Ragdoll", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false) end
end)
createButton("💨 Speed Booster", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed *= 1.7 end
end)
createButton("🌶️ Chilli Booster", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower *= 1.5 end
end)
createButton("🛬 Anti Fall Damage", function()
    local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false) end
end)

-- 📂 PANEL
createButton("🗕 Minimizar Panel", function() frame.Visible = false end)
createButton("🗖 Mostrar Panel", function() frame.Visible = true end)
