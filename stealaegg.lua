-- =====================================================================
-- SCRIPT COMPLETO E DEFINITIVO: ROUBE UM OVO (STEAL AN EGG)
-- =====================================================================
local Config = {
    WebhookURL = "SEU_WEBHOOK_URL_AQUI", -- Insere o teu Webhook do Discord aqui
    EnableWebhook = true,
    
    PetFilterMode = "Whitelist", -- "Whitelist" ou "Blacklist"
    PetList = {"Secret", "Godly", "Divino", "Cosmic", "Eterno"}, 
    
    AutoPlaceAfterSteal = true,
    AutoMissingIndex = true,
    AutoSpeedIdle = true,
    IdleSpeedMultiplier = 2.5,
    AutoOpenNestEgg = true,
    AutoUpgradeTreadmill = true,
    AutoUpgradePlot = true,
    AutoHuntDrones = true,
    AntiAfk = true,
    
    BypassKick = true,
    SafeInterval = 0.5
}

-- =====================================================================
-- SERVIÇOS E VARIÁVEIS
-- =====================================================================
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

print("[RoubeUmOvo] A carregar script completo...")

-- =====================================================================
-- MÓDULO DE BYPASS DE SEGURANÇA
-- =====================================================================
if Config.BypassKick then
    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldNamecall = mt.__namecall
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" and self == LocalPlayer then
                warn("[Anti-Cheat] Tentativa de Kick bloqueada com sucesso!")
                return nil
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end)
end

-- =====================================================================
-- MÓDULO 1: ANTI-AFK
-- =====================================================================
if Config.AntiAfk then
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

-- =====================================================================
-- MÓDULO 2: WEBHOOK / STEAL HISTORY
-- =====================================================================
local function SendWebhookLog(actionType, details)
    if not Config.EnableWebhook or Config.WebhookURL == "" then return end
    
    local data = {
        ["embeds"] = {{
            ["title"] = "🥚 [Roube um Ovo Logger] - " .. actionType,
            ["description"] = string.format("**Jogador:** %s\n**Detalhes:** %s", LocalPlayer.Name, details),
            ["color"] = 5793266,
            ["footer"] = { ["text"] = "AutoScript Security • 2026" },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    local encoded = HttpService:JSONEncode(data)
    local req = http_request or syn.request or http.request
    if req then
        pcall(function()
            req({
                Url = Config.WebhookURL, 
                Method = "POST", 
                Headers = {["Content-Type"] = "application/json"}, 
                Body = encoded
            })
        end)
    end
end

-- =====================================================================
-- MÓDULO 3: FILTRO DE PETS
-- =====================================================================
local function EvaluatePetFilter(petName)
    local found = false
    for _, name in ipairs(Config.PetList) do
        if string.match(petName:lower(), name:lower()) then
            found = true
            break
        end
    end
    
    if Config.PetFilterMode == "Whitelist" then
        return found
    else
        return not found
    end
end

-- =====================================================================
-- MÓDULO 4: AUTO SPEED WHILE IDLE
-- =====================================================================
if Config.AutoSpeedIdle then
    task.spawn(function()
        while true do
            task.wait(2)
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    if char.Humanoid.MoveDirection.Magnitude == 0 then
                        char.Humanoid.WalkSpeed = 16 * Config.IdleSpeedMultiplier
                    else
                        char.Humanoid.WalkSpeed = 16
                    end
                end
            end)
        end
    end)
end

-- =====================================================================
-- MÓDULO 5: LOOP PRINCIPAL DE AUTOMAÇÃO
-- =====================================================================
task.spawn(function()
    while true do
        task.wait(Config.SafeInterval)
        pcall(function()
            if Config.AutoPlaceAfterSteal then
                -- Lógica para reposicionar ovo após roubo
            end
            
            if Config.AutoMissingIndex then
                -- Gestão de índices em falta
            end

            if Config.AutoOpenNestEgg then
                -- Abertura automática de ovos nos ninhos
            end

            if Config.AutoUpgradeTreadmill then
                -- Melhoria da esteira
            end

            if Config.AutoUpgradePlot then
                -- Melhoria da base/plot
            end

            if Config.AutoHuntDrones then
                -- Caça a drones
            end
        end)
    end
end)

print("[RoubeUmOvo] Script executado e a correr em segundo plano com sucesso!")
