-- =====================================================================
-- Steal an Egg: Bot Completo (Auto Kill de Robôs + Auto Steal + Preço de Ovos)
-- =====================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Configurações globais
getgenv().Config = {
    AutoKillRobots = true,
    AutoStealEgg = true,
    ShowEggPrices = true,
    TargetName = "EXPERIMENTO DO DR. SCRAMBLE"
}

-- Criando a Interface Gráfica (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealAnEggBotGui"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Bot: Steal an Egg"
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Botão para Auto Kill de Robôs
local ToggleRobotBtn = Instance.new("TextButton")
ToggleRobotBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleRobotBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
ToggleRobotBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ToggleRobotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleRobotBtn.Text = "Auto Kill Robôs: ON"
ToggleRobotBtn.TextSize = 12
ToggleRobotBtn.Font = Enum.Font.SourceSansBold
ToggleRobotBtn.Parent = MainFrame

ToggleRobotBtn.MouseButton1Click:Connect(function()
    getgenv().Config.AutoKillRobots = not getgenv().Config.AutoKillRobots
    if getgenv().Config.AutoKillRobots then
        ToggleRobotBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        ToggleRobotBtn.Text = "Auto Kill Robôs: ON"
    else
        ToggleRobotBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        ToggleRobotBtn.Text = "Auto Kill Robôs: OFF"
    end
end)

-- Botão para Mostrar Preço dos Ovos
local ToggleEggBtn = Instance.new("TextButton")
ToggleEggBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleEggBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ToggleEggBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleEggBtn.Text = "Ver Preços de Ovos: ON"
ToggleEggBtn.TextSize = 12
ToggleEggBtn.Font = Enum.Font.SourceSansBold
ToggleEggBtn.Parent = MainFrame

ToggleEggBtn.MouseButton1Click:Connect(function()
    getgenv().Config.ShowEggPrices = not getgenv().Config.ShowEggPrices
    if getgenv().Config.ShowEggPrices then
        ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        ToggleEggBtn.Text = "Ver Preços de Ovos: ON"
    else
        ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        ToggleEggBtn.Text = "Ver Preços de Ovos: OFF"
    end
end)

-- Loop principal: Auto Kill dos Robôs
task.spawn(function()
    while task.wait(0.4) do
        if getgenv().Config.AutoKillRobots then
            pcall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj.Name == getgenv().Config.TargetName and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                        local humanoid = obj.Humanoid
                        local rootPart = obj.HumanoidRootPart
                        
                        if humanoid.Health > 0 then
                            local char = LocalPlayer.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = rootPart.CFrame + Vector3.new(0, 3, 2)
                                
                                local tool = char:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool:Activate()
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Loop secundário: Monitoramento de Ovos e Preços
task.spawn(function()
    while task.wait(1) do
        if getgenv().Config.ShowEggPrices then
            pcall(function()
                for _, item in pairs(Workspace:GetDescendants()) do
                    if string.find(string.lower(item.Name), "egg") or string.find(string.lower(item.Name), "ovo") then
                        local priceAttr = item:GetAttribute("Price") or item:GetAttribute("Value")
                        if priceAttr then
                            print("Ovo encontrado: " .. item.Name .. " | Preço: " .. tostring(priceAttr))
                        end
                    end
                end
            end)
        end
    end
end)

print("Script executado com sucesso! Painel flutuante carregado.")
