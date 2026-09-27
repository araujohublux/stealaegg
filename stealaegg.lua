--[[
    Miranda Hub - Versão Completa e Funcional
    Compatível com Roblox (Luau)
]]

local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local Window = OrionLib:MakeWindow({Name = "★ Miranda Hub ★", HidePremium = false, SaveConfig = true, ConfigFolder = "MirandaHubConfig"})

-- Aba Principal
local MainTab = Window:MakeTab({
    Name = "Principal",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddParagraph("Informações", "Bem-vindo ao Miranda Hub. Seleciona as funções abaixo:")

MainTab:AddButton({
    Name = "Ativar Velocidade (WalkSpeed)",
    Callback = function()
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
            OrionLib:MakeNotification({
                Title = "Miranda Hub",
                Content = "Velocidade alterada para 50!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end)
    end
})

MainTab:AddButton({
    Name = "Resetar Velocidade",
    Callback = function()
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            OrionLib:MakeNotification({
                Title = "Miranda Hub",
                Content = "Velocidade redefinida para o normal.",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end)
    end
})

OrionLib:Init()
