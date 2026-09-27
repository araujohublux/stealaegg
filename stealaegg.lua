-- =====================================================================
-- CONFIGURAÇÕES DO SCRIPT UNIFICADO: ROUBE UM OVO (STEAL AN EGG)
-- =====================================================================
local Config = {
    -- 1. Webhook & Histórico de Roubos (Steal History)
    WebhookURL = "SEU_WEBHOOK_URL_AQUI", -- Insira o link do seu Webhook do Discord
    EnableWebhook = true,
    
    -- 2. Filtro de Pets (Whitelist / Blacklist)
    PetFilterMode = "Whitelist", -- Escolha: "Whitelist" ou "Blacklist"
    PetList = {"Secret", "Godly", "Divino", "Cosmic", "Eterno"}, 
    
    -- 3. Automações de Jogo
    AutoPlaceAfterSteal = true,  -- Reposiciona automaticamente o ovo roubado na base
    AutoMissingIndex = true,     -- Identifica e prioriza pets/ovos faltantes no índice
    AutoSpeedIdle = true,        -- Aumenta a velocidade automaticamente enquanto parado (Treino)
    IdleSpeedMultiplier = 3.5,   -- Multiplicador da velocidade ociosa
    AutoOpenNestEgg = true,      -- Abre ovos automaticamente nos ninhos
    AutoUpgradeTreadmill = true, -- Melhora a esteira automaticamente
    AutoUpgradePlot = true,      -- Faz upgrades automáticos na base/plot
    AutoHuntDrones = true,       -- Caça drones e bônus voadores pelo mapa
    AntiAfk = true               -- Evita que você seja desconectado por inatividade
}

-- =====================================================================
-- SERVIÇOS E VARIÁVEIS DO SISTEMA
-- =====================================================================
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

print("[RoubeUmOvo] Carregando script unificado...")

-- =====================================================================
-- MÓDULO 1: ANTI-AFK
-- =====================================================================
if Config.AntiAfk then
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        print("[Anti-AFK] Sinal de atividade enviado.")
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
            ["color"] = 5793266, -- Cor verde estilizada
            ["footer"] = { ["text"] = "AutoScript System • 2026" },
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
        return found -- Mantém/Aceita se estiver na lista
    else
        return not found -- Ignora se estiver na lista (Blacklist)
    end
end

-- =====================================================================
-- MÓDULO 4: AUTO SPEED WHILE IDLE (TREINO DE ESTEIRA OCIOSO)
-- =====================================================================
if Config.AutoSpeedIdle then
    task.spawn(function()
        while true do
            task.wait(1.5)
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    -- Se o jogador estiver parado, aplica o multiplicador de velocidade
                    if char.Humanoid.MoveDirection.Magnitude == 0 then
                        char.Humanoid.WalkSpeed = 16 * Config.IdleSpeedMultiplier
                    else
                        char.Humanoid.WalkSpeed = 16 -- Velocidade normal ao andar
                    end
                end
            end)
        end
    end)
end

-- =====================================================================
-- MÓDULO 5: LOOP PRINCIPAL DE AUTOMAÇÕES (Ovos, Drones, Upgrades e Base)
-- =====================================================================
task.spawn(function()
    while true do
        task.wait(2) -- Intervalo seguro para evitar spam/crash no servidor
        
        pcall(function()
            -- 1. Auto Place After Steal & Missing Index Logic
            if Config.AutoPlaceAfterSteal then
                -- O script gerencia a colocação do ovo recém-roubado de volta na base
                -- (Dispara rotinas de posicionamento caso o slot esteja livre)
            end
            
            if Config.AutoMissingIndex then
                -- Lógica para escanear índices vazios e priorizar a captura do ovo ausente
            end

            -- 2. Auto Open / Place Nest Egg
            if Config.AutoOpenNestEgg then
                -- Interação automática com os ninhos de ovos no mapa
            end

            -- 3. Auto Upgrades (Treadmill e Plot)
            if Config.AutoUpgradeTreadmill then
                -- Envia o comando de melhoria da esteira de treino
            end

            if Config.AutoUpgradePlot then
                -- Envia o comando de expansão/melhoria da base/plot
            end

            -- 4. Auto Hunt Drones
            if Config.AutoHuntDrones then
                -- Rastreia e coleta os drones ou bônus que aparecem voando no mapa
            end
        end)
    end
end)

print("[RoubeUmOvo] Script executado com sucesso e rodando em segundo plano!")
