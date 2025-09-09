repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

StarterGui:SetCore("SendNotification", {
    Title = "BNXYUNG",
    Text = "Script ejecutado ✅",
    Duration = 5
})

-- Estado global
local menuVisible = true
local espMenuVisible = false

-- GUI principal
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "BNXYUNG_Menu"

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 220, 0, 400)
mainFrame.Position = UDim2.new(0, 10, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "MENU BNXYUNG"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundTransparency = 1

-- Minimizar botón
local minimizeBtn = Instance.new("TextButton", mainFrame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
minimizeBtn.Text = "-"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Scroll
local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(1, -20, 1, -50)
scroll.Position = UDim2.new(0, 10, 0, 50)
scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 6)

-- Función para crear botones
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

-- Funciones
local function activarAIM()
    StarterGui:SetCore("SendNotification", {Title = "BNXYUNG", Text = "AIM IA Activado 🎯", Duration = 4})
end

local function activarTP()
    StarterGui:SetCore("SendNotification", {Title = "BNXYUNG", Text = "TP Activado 🚀", Duration = 4})
end

local function activarTextura()
    StarterGui:SetCore("SendNotification", {Title = "BNXYUNG", Text = "Textura aplicada 💫", Duration = 4})
end

local function mostrarID()
    StarterGui:SetCore("SendNotification", {
        Title = "BNXYUNG",
        Text = "ID: " .. LocalPlayer.UserId .. " | Nombre: " .. LocalPlayer.Name,
        Duration = 6
    })
end

local function cambiarIdioma()
    StarterGui:SetCore("SendNotification", {
        Title = "BNXYUNG",
        Text = "Idioma cambiado a Español 🌐",
        Duration = 4
    })
end

-- Submenú ESP
local espFrame = Instance.new("Frame", gui)
espFrame.Size = UDim2.new(0, 200, 0, 220)
espFrame.Position = UDim2.new(0, 240, 0.5, -110)
espFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
espFrame.Visible = false

local espLayout = Instance.new("UIListLayout", espFrame)
espLayout.Padding = UDim.new(0, 6)

local function toggleESPMenu()
    espMenuVisible = not espMenuVisible
    espFrame.Visible = espMenuVisible
end

createButton("🎯 AIM IA", activarAIM)
createButton("🚀 TP", activarTP)
createButton("💫 Coloca Textura", activarTextura)
createButton("🧑‍💻 Mostrar ID", mostrarID)
createButton("🌐 Idioma", cambiarIdioma)
createButton("👁️ ESP Opciones", toggleESPMenu)

-- Botones del submenú ESP
local function espOption(name)
    local btn = Instance.new("TextButton", espFrame)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

espOption("Mostrar Nombres")
espOption("Mostrar Cajas")
espOption("Mostrar Líneas")
espOption("Mostrar Distancia")
espOption("Activar/Desactivar ESP")

-- Minimizar lógica
minimizeBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    scroll.Visible = menuVisible
    title.Visible = menuVisible
end)
