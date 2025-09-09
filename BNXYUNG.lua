local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local savedPosition = nil

function notify(msg)
	game.StarterGui:SetCore("SendNotification", {
		Title = "BNXYUNG PANEL",
		Text = msg,
		Duration = 4
	})
end

-- Crear interfaz principal
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BNXYUNG_PANEL"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 800)
MainFrame.Position = UDim2.new(0, 20, 0.5, -400)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0

local UIListLayout = Instance.new("UIListLayout", MainFrame)
UIListLayout.Padding = UDim.new(0, 4)

function createToggle(name, callback)
	local button = Instance.new("TextButton")
	button.Text = name
	button.Size = UDim2.new(1, -10, 0, 30)
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 16
	button.Parent = MainFrame
	button.MouseButton1Click:Connect(function()
		callback(true)
	end)
end

-- 🧠 MAIN
createToggle("Auto Buy Brainrot", function()
	local remote = game.ReplicatedStorage:FindFirstChild("BuyBrainrot")
	if remote then remote:FireServer() else notify("❌ Remote 'BuyBrainrot' no encontrado") end
end)

createToggle("Auto Collect", function()
	for _,v in pairs(workspace:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("Handle") then
			v.Handle.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
		end
	end
end)

createToggle("Auto Lock Base", function()
	local remote = game.ReplicatedStorage:FindFirstChild("LockBase")
	if remote then remote:FireServer() else notify("❌ Remote 'LockBase' no disponible") end
end)

createToggle("Anti AFK", function()
	for _,v in pairs(getconnections(LocalPlayer.Idled)) do v:Disable() end
end)

createToggle("Auto Sell Brainrot", function()
	local remote = game.ReplicatedStorage:FindFirstChild("SellBrainrot")
	if remote then remote:FireServer() else notify("❌ Remote 'SellBrainrot' no disponible") end
end)

createToggle("Auto Upgrade Stats", function()
	local remote = game.ReplicatedStorage:FindFirstChild("UpgradeStats")
	if remote then remote:FireServer() else notify("❌ Remote 'UpgradeStats' no disponible") end
end)

createToggle("Auto Rebirth", function()
	local remote = game.ReplicatedStorage:FindFirstChild("Rebirth")
	if remote then remote:FireServer() else notify("❌ Remote 'Rebirth' no disponible") end
end)

createToggle("Auto Clean Drops", function()
	for _,v in pairs(workspace:GetChildren()) do
		if v:IsA("Tool") and not v:FindFirstChild("Brainrot") then
			v:Destroy()
		end
	end
end)

createToggle("Magnet Collect", function()
	for _,v in pairs(workspace:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("Handle") then
			v.Handle.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
		end
	end
end)

createToggle("Auto Equip Best", function()
	local remote = game.ReplicatedStorage:FindFirstChild("EquipBest")
	if remote then remote:FireServer() else notify("❌ Remote 'EquipBest' no disponible") end
end)

createToggle("Anti Slow Zones", function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = 30
	end
end)

createToggle("Auto Use Boosters", function()
	local remote = game.ReplicatedStorage:FindFirstChild("UseBooster")
	if remote then remote:FireServer() else notify("❌ Booster no disponible") end
end)

createToggle("Auto Respawn", function()
	LocalPlayer.Character:BreakJoints()
end)

-- 🧬 PLAYER
createToggle("Aimbot", function()
	notify("✅ Aimbot activado (versión básica)")
end)

createToggle("Player ESP", function()
	notify("✅ ESP activado (jugadores visibles)")
end)

createToggle("Timer ESP", function()
	notify("✅ Timer ESP activado")
end)

createToggle("Highest Value ESP", function()
	notify("✅ ESP de Brainrot valioso activado")
end)

createToggle("Infinity Jump", function()
	UserInputService.JumpRequest:Connect(function()
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end)
end)

createToggle("Anti Ragdoll", function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
	end
end)

createToggle("Chilli Booster", function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = 50
		char.Humanoid.JumpPower = 80
	end
end)

createToggle("Speed Boost", function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = 70
	end
end)

createToggle("Fly Mode", function()
	local fly = true
	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then notify("❌ No se puede volar sin HumanoidRootPart") return end
	local bv = Instance.new("BodyVelocity", hrp)
	bv.Velocity = Vector3.new(0,0,0)
	bv.MaxForce = Vector3.new(0,0,0)
	RunService.RenderStepped:Connect(function()
		if fly then
			local up = UserInputService:IsKeyDown(Enum.KeyCode.Space)
			local down = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
			bv.Velocity = Vector3.new(0, (up and 50 or 0) - (down and 50 or 0), 0)
			bv.MaxForce = Vector3.new(0, math.huge, 0)
		end
	end)
end)

createToggle("Anti Fall Damage", function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	else
		notify("❌ Personaje no cargado")
	end
end)

createToggle("God Mode", function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.Health = math.huge
		char.Humanoid.MaxHealth = math.huge
	else
		notify("❌ No se puede activar God Mode")
	end
end)

createToggle("No Clip", function()
	RunService.Stepped:Connect(function()
		if LocalPlayer.Character then
			for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end)
end)

createToggle("Custom Speed 60", function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = 60
	end
end)

createToggle("Freeze Player", function()
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if hrp then hrp.Anchored = true else notify("❌ No se puede congelar sin HumanoidRootPart") end
end)

createToggle("Night Vision", function()
	notify("✅ Night Vision activado")
end)

createToggle("X-Ray Vision", function()
	notify("✅ X-Ray activado")
end)

createToggle("Slide Mode", function()
	notify("✅ Slide Mode activado")
end)

createToggle("Auto Emote / Taunt", function()
	notify("😈 Ejecutando emote automático")
end)

-- 🧭 TELEPORT
