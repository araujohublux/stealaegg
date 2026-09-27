--[[
    Project: Miranda Hub Style (Com Interface Gráfica)
    Linguagem: Luau (Roblox)
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("[Miranda Hub]: A iniciar interface...")

-- Notificação visual inicial
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Miranda Hub",
        Text = "Carregado com sucesso!",
        Duration = 4
    })
end)

-- Criar Interface Gráfica Básica (GUI) para aparecer no ecrã
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local ActionButton = Instance.new("TextButton")

-- Configurar a GUI
ScreenGui.Name = "MirandaHubGUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true -- Permite arrastar a janela no ecrã

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "★ Miranda Hub ★"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

ActionButton.Name = "ActionButton"
ActionButton.Parent = MainFrame
ActionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ActionButton.Position = UDim2.new(0.1, 0, 0.4, 0)
ActionButton.Size = UDim2.new(0.8, 0, 0, 40)
ActionButton.Font = Enum.Font.SourceSansBold
ActionButton.Text = "Ativar Função Exemplo"
ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.TextSize = 16

-- Ação do botão
ActionButton.MouseButton1Click:Connect(function()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 35
            print("[Miranda Hub]: Velocidade aumentada!")
        end
    end)
end)

print("[Miranda Hub]: Interface carregada com sucesso no ecrã!")
