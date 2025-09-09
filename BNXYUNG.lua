repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local selectedTarget = nil
local aimbotOn = false
local espOn = false
local flyOn = false
local flySpeed = 50

-- GUI
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "BNXYUNG_HUB"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 250, 0, 420)
main.Position = UDim2.new(0, 10, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "BNXYUNG HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundTransparency = 1

local minimize = Instance.new("TextButton", main)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 5)
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -20, 1, -50)
scroll.Position = UDim2.new(0, 10, 0, 50)
scroll.CanvasSize = UDim2.new(0, 0, 0, 800)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 6)

-- Botón genérico
local function createButton(text, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.MouseButton1Click:Connect(callback)
end

-- Dropdown de jugadores
local dropdown = Instance.new("TextButton", scroll)
dropdown.Size = UDim2.new(1, 0, 0, 30)
dropdown.Text = "Seleccionar enemigo 🎯"
dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)

local listFrame = Instance.new("Frame", scroll)
listFrame.Size = UDim2.new(1, 0, 0, 120)
listFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
listFrame.Visible = false

local listLayout = Instance.new("UIListLayout", listFrame)
listLayout.Padding = UDim.new(0, 4)

dropdown.MouseButton1Click:Connect(function()
    listFrame.Visible = not listFrame.Visible
    listFrame:ClearAllChildren()
    listLayout.Parent = listFrame
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local btn = Instance.new("TextButton", listFrame)
            btn.Size = UDim2.new(1, 0, 0, 25)
            btn.Text = p.Name
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.MouseButton1Click:Connect(function()
                selectedTarget = p
                dropdown.Text = "🎯 " .. p.Name
                listFrame.Visible = false
            end)
        end
    end
end)

-- Aimbot
local function toggleAimbot()
    aimbotOn = not aimbotOn
    StarterGui:SetCore("SendNotification", {
        Title = "BNXYUNG",
        Text = aimbotOn and "Aimbot Activado 🎯" or "Aimbot Desactivado ❌",
        Duration = 4
    })

    if aimbotOn then
        RunService.RenderStepped:Connect(function()
            if not aimbotOn then return end
            if selectedTarget and selectedTarget.Character and selectedTarget.Character:FindFirstChild("Head") then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, selectedTarget.Character.Head.Position)
            end
        end)
    end
end

-- ESP
local function toggleESP()
    espOn = not espOn
    StarterGui:SetCore("SendNotification", {
        Title = "BNXYUNG",
        Text = espOn and "ESP Activado 👁️" or "ESP Desactivado ❌",
        Duration = 4
    })

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if espOn then
                local billboard = Instance.new("BillboardGui", p.Character.HumanoidRootPart)
                billboard.Size = UDim2.new(0, 100, 0, 40)
                billboard.AlwaysOnTop = true
                billboard.Name = "BNX_ESP"
                local label = Instance.new("TextLabel", billboard)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = p.Name
                label.TextColor3 = Color3.fromRGB(255, 255, 0)
                label.BackgroundTransparency = 1
            else
                for _, gui in pairs(p.Character.HumanoidRootPart:GetChildren()) do
                    if gui:IsA("BillboardGui") and gui.Name == "BNX_ESP" then
                        gui:Destroy()
                    end
                end
            end
        end
    end
end

-- TP
local function tpToTarget()
    if selectedTarget and selectedTarget.Character and selectedTarget.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character:MoveTo(selectedTarget.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
    end
end

-- Volar
local bodyGyro, bodyVelocity
local function toggleFly()
    flyOn = not flyOn
    StarterGui:SetCore("SendNotification", {
        Title = "BNXYUNG",
        Text = flyOn and "Vuelo Activado 🛸" or "Vuelo Desactivado ❌",
        Duration = 4
    })

    if flyOn then
        local char = LocalPlayer.Character
        bodyGyro = Instance.new("BodyGyro", char.HumanoidRootPart)
        bodyVelocity = Instance.new("BodyVelocity", char.HumanoidRootPart)
        bodyGyro.P = 9e4
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = char.HumanoidRootPart.CFrame
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)

        RunService.RenderStepped:Connect(function()
            if not flyOn then return end
            local move = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - workspace.CurrentCamera.CFrame.RightVector end
            if
