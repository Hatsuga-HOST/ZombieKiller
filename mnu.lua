local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Tutorial Script Hub",
    LoadingTitle = "Tutorial Script Hub",
    LoadingSubtitle = "by Rolo",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "Big Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink",
       RememberJoins = true
    },
    KeySystem = false
})

local PlayerTab = Window:CreateTab("Player", 4483362458)

-- WalkSpeed Slider
local WalkSpeedSlider = PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        local character = game.Players.LocalPlayer.Character
        if character then
            character:SetAttribute("SpeedMultiplier", Value)
        end
    end,
})

-- Dash Length Slider
local DashSlider = PlayerTab:CreateSlider({
    Name = "Dash length",
    Range = {10, 1000},
    Increment = 1,
    Suffix = "Length",
    CurrentValue = 10,
    Flag = "DashLength",
    Callback = function(Value)
        local character = game.Players.LocalPlayer.Character
        if character then
            character:SetAttribute("DashLength", Value)
        end
    end,
})

-- Jump Power Slider
local JumpSlider = PlayerTab:CreateSlider({
    Name = "Jump Height",
    Range = {50, 500},
    Increment = 1,
    Suffix = "Height",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = Value
        end
    end,
})

-- Auto-update character reference
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    WalkSpeedSlider:Set(character:GetAttribute("SpeedMultiplier") or 16)
    DashSlider:Set(character:GetAttribute("DashLength") or 10)
    JumpSlider:Set(character.Humanoid.JumpPower)
end)
