-- =====================================================================
-- Steal an Egg: Bot Completo (Versão Corrigida para Ataque)
-- =====================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

getgenv().Config = {
    AutoKillRobots = true,
    ShowEggPrices = true,
    TargetName = "EXPERIMENTO DO DR. SCRAMBLE" -- Se necessário, altere para parte do nome em minúsculas
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

-- Loop principal corrigido: Auto Kill robusto
task.spawn(function()
    while task.wait(0.3) do
        if getgenv().Config.AutoKillRobots then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                
                for _, obj in pairs(Workspace:GetDescendants()) do
                    -- Procura por semelhança no nome para evitar falhas de maiúsculas/minúsculas
                    if obj:IsA("Model") and (obj.Name == getgenv().Config.TargetName or string.find(string.upper(obj.Name), "SCRAMBLE") or string.find(string.upper(obj.Name), "EXPERIMENTO")) then
                        local humanoid = obj:FindFirstChildOfClass("Humanoid")
                        local rootPart = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
                        
                        if humanoid and rootPart and humanoid.Health > 0 then
                            -- Teleporta para cima/trás do robô
                            char.HumanoidRootPart.CFrame = rootPart.CFrame * CFrame.new(0, 0, 3)
                            
                            -- Ativa a ferramenta se houver alguma equipada
                            local tool = char:FindFirstChildOfClass("Tool")
                            if tool then
                                tool:Activate()
                            end
                        end
                    end
                end
            end)
        end
    end
end)

print("Script atualizado carregado com sucesso!")
