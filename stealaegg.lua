--[[
    Project: Miranda Hub Style (PlayerGui Fix)
    Linguagem: Luau (Roblox)
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove uma cópia anterior se já existir para evitar duplicados
if PlayerGui:FindFirstChild("MirandaHubGUI") then
    PlayerGui.MirandaHubGUI:Destroy()
end

print("[Miranda Hub]: A criar interface na PlayerGui...")

-- Criar Interface Gráfica
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ActionButton = Instance.new("TextButton")

ScreenGui.Name = "MirandaHubGUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true

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
ActionButton.Text = "Ativar Velocidade"
ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.TextSize = 16

ActionButton.MouseButton1Click:Connect(function()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 35
            print("[Miranda Hub]: Velocidade alterada com sucesso!")
        end
    end)
end)

print("[Miranda Hub]: Interface carregada com sucesso!")
