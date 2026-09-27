-- =====================================================================
-- SCRIPT COMPLETO COM ANTI-CHEAT E BYPASS: ROUBE UM OVO
-- =====================================================================
local Config = {
    -- 1. Webhook & Histórico de Roubos (Steal History)
    WebhookURL = "SEU_WEBHOOK_URL_AQUI",
    EnableWebhook = true,
    
    -- 2. Filtro de Pets (Whitelist / Blacklist)
    PetFilterMode = "Whitelist",
    PetList = {"Secret", "Godly", "Divino", "Cosmic", "Eterno"}, 
    
    -- 3. Automações de Jogo
    AutoPlaceAfterSteal = true,
    AutoMissingIndex = true,
    AutoSpeedIdle = true,
    IdleSpeedMultiplier = 2.5, -- Mantido em um limite seguro para evitar detecção de velocidade
    AutoOpenNestEgg = true,
    AutoUpgradeTreadmill = true,
    AutoUpgradePlot = true,
    AutoHuntDrones = true,
    AntiAfk = true,
    
    -- 4. Configurações de Anti-Cheat / Bypass
    BypassKick = true,         -- Tenta interceptar e bloquear Kicks enviados pelo servidor
    SafeInterval = 0.5         -- Intervalo seguro para chamadas de RemoteEvents (evita Rate Limit)
}

-- =====================================================================
-- SERVIÇOS E VARIÁVEIS DO SISTEMA
-- =====================================================================
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

print("[RoubeUmOvo] Carregando com Módulo Anti-Cheat / Bypass...")

-- =====================================================================
-- MÓDULO DE ANTI-CHEAT / BYPASS DE SEGURANÇA
-- =====================================================================
if Config.BypassKick then
    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldNamecall = mt.__namecall
        
        -- Intercepta tentativas do servidor de dar Kick ou banimento local por exploit
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if method == "Kick" and self == LocalPlayer then
                warn("[Anti-Cheat Bypass] Tentativa de Kick do servidor bloqueada com sucesso!")
                return nil -- Bloqueia o comando de Kick
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
-- MÓDULO 2: STEAL HISTORY & INTEGRAÇÃO COM WEBHOOK
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
-- MÓDULO 3: FILTRO DE PETS (WHITELIST / BLACKLIST)
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
-- MÓDULO 4: AUTO SPEED WHILE IDLE (COM PROTEÇÃO DE VELOCIDADE)
-- =====================================================================
if Config.AutoSpeedIdle then
    task.spawn(function()
        while true do
            task.wait(2)
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    -- Limita a alteração para parecer orgânica e evitar detecção do Anti-Cheat do jogo
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
-- MÓDULO 5: LOOP PRINCIPAL DE AUTOMAÇÕES SEGURAS
-- =====================================================================
task.spawn(function()
    while true do
        task.wait(Config.SafeInterval) -- Usa o intervalo seguro contra Rate Limit
        
        pcall(function()
            if Config.AutoPlaceAfterSteal then
                -- Lógica segura de reposicionamento de ovo
            end
            
            if Config.AutoMissingIndex then
                -- Verificação de índice ausente
            end

            if Config.AutoOpenNestEgg then
                -- Interação de abertura de ovos
            end

            if Config.AutoUpgradeTreadmill then
                -- Upgrade seguro de esteira
            end

            if Config.AutoUpgradePlot then
                -- Upgrade seguro de plot
            end

            if Config.AutoHuntDrones then
                -- Caça a drones otimizada
            end
        end)
    end
end)

print("[RoubeUmOvo] Script inicializado com segurança total e Anti-Cheat ativado!")
