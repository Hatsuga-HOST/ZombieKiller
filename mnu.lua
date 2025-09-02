--[[
HuntyHub v3.0 - Sidebar UI Modern by AI Assistant
Halus, fungsional, dan mudah dikembangkan
--]]

-- Tunggu game load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hapus UI lama
if playerGui:FindFirstChild("HuntyHub") then
    playerGui.HuntyHub:Destroy()
    wait(0.1)
end

-- Warna tema
local colors = {
    background = Color3.fromRGB(24, 24, 30),
    sidebar = Color3.fromRGB(15, 15, 20),
    accent = Color3.fromRGB(98, 85, 215),
    text = Color3.fromRGB(235, 235, 240),
    button = Color3.fromRGB(40, 40, 50),
    buttonHover = Color3.fromRGB(65, 65, 85),
    success = Color3.fromRGB(80, 200, 120),
}

-- Buat ScreenGui utama
local HubGui = Instance.new("ScreenGui")
HubGui.Name = "HuntyHub"
HubGui.ResetOnSpawn = false
HubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HubGui.Parent = playerGui

-- Container utama
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 520, 0, 400)
MainContainer.Position = UDim2.new(0.5, -260, 0.5, -200)
MainContainer.BackgroundColor3 = colors.background
MainContainer.BorderSizePixel = 0
MainContainer.ClipsDescendants = true
MainContainer.Visible = false
MainContainer.Parent = HubGui
Instance.new("UICorner", MainContainer).CornerRadius = UDim.new(0, 10)

-- Sidebar kiri
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = colors.sidebar
Sidebar.Parent = MainContainer
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

-- Header sidebar
local Title = Instance.new("TextLabel")
Title.Text = "HUNTYHUB v3"
Title.TextColor3 = colors.text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Parent = Sidebar

-- Container tombol tab
local TabButtonsContainer = Instance.new("Frame")
TabButtonsContainer.Size = UDim2.new(1, 0, 1, -50)
TabButtonsContainer.Position = UDim2.new(0, 0, 0, 50)
TabButtonsContainer.BackgroundTransparency = 1
TabButtonsContainer.Parent = Sidebar
local layout = Instance.new("UIListLayout", TabButtonsContainer)
layout.Padding = UDim.new(0, 10)
layout.FillDirection = Enum.FillDirection.Vertical
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top

-- Kontainer konten tab di kanan
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -120, 1, 0)
ContentContainer.Position = UDim2.new(0, 120, 0, 0)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainContainer

-- Fungsi buat tombol sidebar
local function createTabButton(text, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.BackgroundColor3 = colors.button
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = colors.text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.LayoutOrder = order
    btn.AutoButtonColor = false
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)

    btn.MouseEnter:Connect(function()
        if btn.BackgroundColor3 ~= colors.accent then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = colors.buttonHover}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= colors.accent then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = colors.button}):Play()
        end
    end)

    return btn
end

-- Fungsi buat label di konten
local function createLabel(text, order, size)
    local lbl = Instance.new("TextLabel")
    lbl.Text = text
    lbl.TextColor3 = colors.text
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = size or 20
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    lbl.LayoutOrder = order
    lbl.Size = UDim2.new(1, 0, 0, 30)
    return lbl
end

-- Fungsi buat button di konten
local function createContentButton(text, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = colors.button
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = colors.text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.LayoutOrder = order
    btn.AutoButtonColor = false
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 8)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = colors.buttonHover}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = colors.button}):Play()
    end)
    return btn
end

-- Fungsi buat slider di konten
local function createSlider(labelText, min, max, default, order, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 60)
    container.BackgroundTransparency = 1
    container.LayoutOrder = order

    local label = Instance.new("TextLabel")
    label.Parent = container
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = labelText .. ": " .. tostring(default)
    label.TextColor3 = colors.text
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left

    local sliderBG = Instance.new("Frame", container)
    sliderBG.Size = UDim2.new(1, 0, 0, 10)
    sliderBG.Position = UDim2.new(0, 0, 0, 30)
    sliderBG.BackgroundColor3 = colors.button
    sliderBG.BorderSizePixel = 0
    sliderBG.ClipsDescendants = true
    sliderBG.AnchorPoint = Vector2.new(0, 0)
    local cornerBG = Instance.new("UICorner", sliderBG)
    cornerBG.CornerRadius = UDim.new(0, 6)

    local sliderFill = Instance.new("Frame", sliderBG)
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = colors.accent
    sliderFill.BorderSizePixel = 0
    local cornerFill = Instance.new("UICorner", sliderFill)
    cornerFill.CornerRadius = UDim.new(0, 6)

    local sliderButton = Instance.new("ImageButton", sliderBG)
    sliderButton.Size = UDim2.new(0, 20, 0, 20)
    sliderButton.Position = UDim2.new(sliderFill.Size.X.Scale, 0, 0.5, -10)
    sliderButton.BackgroundTransparency = 1
    sliderButton.Image = "rbxassetid://3926307971"
    sliderButton.ImageColor3 = colors.text
    sliderButton.Modal = true
    sliderButton.Draggable = false

    local dragging = false

    sliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    sliderBG.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relativeX = math.clamp((input.Position.X - sliderBG.AbsolutePosition.X) / sliderBG.AbsoluteSize.X, 0, 1)
            sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            sliderButton.Position = UDim2.new(relativeX, 0, 0.5, -10)
            local value = math.floor(min + (max - min) * relativeX)
            label.Text = labelText .. ": " .. tostring(value)
            if callback then callback(value) end
        end
    end)

    return container
end

-- Tab list
local Tabs = {"Teleport", "Player", "Settings", "Credits"}
local TabButtons = {}
local TabFrames = {}

-- Buat frame tab content & button masing2
for i, tab in ipairs(Tabs) do
    local btn = createTabButton(tab, i)
    btn.Parent = TabButtonsContainer

    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.CanvasSize = UDim2.new(0, 0, 2, 0)
    frame.ScrollBarThickness = 5
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = ContentContainer

    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0, 12)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    TabButtons[tab] = btn
    TabFrames[tab] = frame

    btn.MouseButton1Click:Connect(function()
        for _, f in pairs(TabFrames) do f.Visible = false end
        frame.Visible = true
        for _, b in pairs(TabButtons) do
            b.BackgroundColor3 = colors.button
        end
        btn.BackgroundColor3 = colors.accent
    end)
end

-- Set tab "Teleport" aktif pertama
TabButtons["Teleport"].BackgroundColor3 = colors.accent
TabFrames["Teleport"].Visible = true

-- Isi tab Teleport
local teleportLocations = {
    Spawn = CFrame.new(0, 5, 0),
    Toko = CFrame.new(69.8, 10.3, 133.9),
    ["Secret Area"] = CFrame.new(100, 50, -200),
    ["VIP Room"] = CFrame.new(-150, 25, 75),
}
local tpFrame = TabFrames["Teleport"]
local tpTitle = createLabel("Teleport Locations", 1, 18)
tpTitle.Parent = tpFrame

for i, locName in ipairs({"Spawn", "Toko", "Secret Area", "VIP Room"}) do
    local btn = createContentButton(locName, i + 1)
    btn.Parent = tpFrame
    btn.MouseButton1Click:Connect(function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = teleportLocations[locName]
        end
    end)
end

-- Custom teleport input
local xBox = Instance.new("TextBox", tpFrame)
xBox.PlaceholderText = "X Coordinate"
xBox.Size = UDim2.new(1, 0, 0, 40)
xBox.LayoutOrder = 6
xBox.BackgroundColor3 = colors.button
xBox.TextColor3 = colors.text
xBox.ClearTextOnFocus = false
Instance.new("UICorner", xBox).CornerRadius = UDim.new(0, 8)

local yBox = Instance.new("TextBox", tpFrame)
yBox.PlaceholderText = "Y Coordinate"
yBox.Size = UDim2.new(1, 0, 0, 40)
yBox.LayoutOrder = 7
yBox.BackgroundColor3 = colors.button
yBox.TextColor3 = colors.text
yBox.ClearTextOnFocus = false
Instance.new("UICorner", yBox).CornerRadius = UDim.new(0, 8)

local zBox = Instance.new("TextBox", tpFrame)
zBox.PlaceholderText = "Z Coordinate"
zBox.Size = UDim2.new(1, 0, 0, 40)
zBox.LayoutOrder = 8
zBox.BackgroundColor3 = colors.button
zBox.TextColor3 = colors.text
zBox.ClearTextOnFocus = false
Instance.new("UICorner", zBox).CornerRadius = UDim.new(0, 8)

local teleportCustomBtn = createContentButton("Teleport to Coordinates", 9)
teleportCustomBtn.Parent = tpFrame
teleportCustomBtn.MouseButton1Click:Connect(function()
    local x = tonumber(xBox.Text) or 0
    local y = tonumber(yBox.Text) or 5
    local z = tonumber(zBox.Text) or 0
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    end
end)

-- Isi tab Player (WalkSpeed, JumpPower, Noclip, Fly)
local playerFrame = TabFrames["Player"]
local playerTitle = createLabel("Player Modifications", 1, 18)
playerTitle.Parent = playerFrame

-- WalkSpeed slider
local walkSpeedSlider = createSlider("WalkSpeed", 16, 100, 16, 2, function(val)
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = val
    end
end)
walkSpeedSlider.Parent = playerFrame

-- JumpPower slider
local jumpPowerSlider = createSlider("JumpPower", 50, 200, 50, 3, function(val)
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = val
    end
end)
jumpPowerSlider.Parent = playerFrame

-- Noclip toggle button
local noclipBtn = createContentButton("Toggle Noclip", 4)
noclipBtn.Parent = playerFrame
local noclipActive = false
local noclipConnection

noclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    local char = player.Character
    if noclipActive then
        noclipBtn.Text = "Noclip: ON"
        noclipBtn.BackgroundColor3 = colors.success
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        noclipConnection = RunService.Stepped:Connect(function()
            if char and noclipActive then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            else
                if noclipConnection then noclipConnection:Disconnect() end
            end
        end)
    else
        noclipBtn.Text = "Toggle Noclip"
        noclipBtn.BackgroundColor3 = colors.button
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        if noclipConnection then noclipConnection:Disconnect() end
    end
end)

-- Fly toggle button with basic fly logic
local flyBtn = createContentButton("Toggle Fly", 5)
flyBtn.Parent = playerFrame
local flyActive = false
local flyConnection
local bodyVelocity

flyBtn.MouseButton1Click:Connect(function()
    flyActive = not flyActive
    local char = player.Character
    if flyActive then
        flyBtn.Text = "Fly: ON"
        flyBtn.BackgroundColor3 = colors.success
        if char and char:FindFirstChild("HumanoidRootPart") then
            bodyVelocity = Instance.new("BodyVelocity", char.HumanoidRootPart)
            bodyVelocity.MaxForce = Vector3.new( Vector3.new(1,1,1).X*math.huge, math.huge, Vector3.new(1,1,1).Z*math.huge )
            bodyVelocity.Velocity = Vector3.new(0,0,0)
            flyConnection = RunService.Heartbeat:Connect(function()
                if not flyActive or not char or not char:FindFirstChild("HumanoidRootPart") then
                    if flyConnection then flyConnection:Disconnect() end
                    if bodyVelocity then bodyVelocity:Destroy() end
                    flyBtn.Text = "Toggle Fly"
                    flyBtn.BackgroundColor3 = colors.button
                    return
                end
                local moveVec = Vector3.new()
                local userInput = UserInputService

                if userInput:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + workspace.CurrentCamera.CFrame.LookVector end
                if userInput:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - workspace.CurrentCamera.CFrame.LookVector end
                if userInput:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - workspace.CurrentCamera.CFrame.RightVector end
                if userInput:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + workspace.CurrentCamera.CFrame.RightVector end
                if userInput:IsKeyDown(Enum.KeyCode.Space) then moveVec = moveVec + Vector3.new(0,1,0) end
                if userInput:IsKeyDown(Enum.KeyCode.LeftControl) then moveVec = moveVec - Vector3.new(0,1,0) end

                moveVec = moveVec.Unit * 50
                if moveVec ~= moveVec then -- check NaN
                    moveVec = Vector3.new(0,0,0)
                end

                bodyVelocity.Velocity = moveVec
            end)
        end
    else
        if flyConnection then flyConnection:Disconnect() end
        if bodyVelocity then bodyVelocity:Destroy() end
        flyBtn.Text = "Toggle Fly"
        flyBtn.BackgroundColor3 = colors.button
    end
end)

-- Tab Settings
local settingsFrame = TabFrames["Settings"]
local settingsTitle = createLabel("Settings", 1, 20)
settingsTitle.Parent = settingsFrame

local themeBtn = createContentButton("Cycle UI Theme", 2)
themeBtn.Parent = settingsFrame

local themes = {
    {background = Color3.fromRGB(24,24,30), sidebar = Color3.fromRGB(15,15,20), accent = Color3.fromRGB(98, 85, 215)},
    {background = Color3.fromRGB(30,24,24), sidebar = Color3.fromRGB(20,15,15), accent = Color3.fromRGB(215, 85, 98)},
    {background = Color3.fromRGB(24,30,24), sidebar = Color3.fromRGB(15,20,15), accent = Color3.fromRGB(85,215,98)},
}

local currentThemeIndex = 1
themeBtn.MouseButton1Click:Connect(function()
    currentThemeIndex = currentThemeIndex + 1
    if currentThemeIndex > #themes then currentThemeIndex = 1 end
    local t = themes[currentThemeIndex]

    TweenService:Create(MainContainer, TweenInfo.new(0.5), {BackgroundColor3 = t.background}):Play()
    TweenService:Create(Sidebar, TweenInfo.new(0.5), {BackgroundColor3 = t.sidebar}):Play()

    for _, b in pairs(TabButtons) do
        if b.BackgroundColor3 == colors.accent then
            TweenService:Create(b, TweenInfo.new(0.5), {BackgroundColor3 = t.accent}):Play()
        else
            b.BackgroundColor3 = colors.button
        end
    end
    colors.background = t.background
    colors.sidebar = t.sidebar
    colors.accent = t.accent
end)

local toggleKeyLabel = createLabel("Toggle UI Keybind: H", 3, 16)
toggleKeyLabel.Parent = settingsFrame

-- Tab Credits
local creditsFrame = TabFrames["Credits"]
local creditsTitle = createLabel("HuntyHub v3.0", 1, 20)
creditsTitle.Parent = creditsFrame

local devLabel = Instance.new("TextLabel")
devLabel.Text = "Developed by: AI Assistant"
devLabel.TextColor3 = colors.text
devLabel.Font = Enum.Font.GothamItalic
devLabel.TextSize = 16
devLabel.BackgroundTransparency = 1
devLabel.TextXAlignment = Enum.TextXAlignment.Center
devLabel.LayoutOrder = 2
devLabel.Size = UDim2.new(1, 0, 0, 30)
devLabel.Parent = creditsFrame

local thanksLabel = Instance.new("TextLabel")
thanksLabel.Text = "Special thanks to:\nRoblox scripting community\nBeta testers"
thanksLabel.TextColor3 = colors.text
thanksLabel.Font = Enum.Font.Gotham
thanksLabel.TextSize = 14
thanksLabel.BackgroundTransparency = 1
thanksLabel.TextXAlignment = Enum.TextXAlignment.Center
thanksLabel.LayoutOrder = 3
thanksLabel.Size = UDim2.new(1, 0, 0, 60)
thanksLabel.Parent = creditsFrame

local versionLabel = Instance.new("TextLabel")
versionLabel.Text = "Version 3.0 | © 2025"
versionLabel.TextColor3 = colors.text
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextSize = 12
versionLabel.BackgroundTransparency = 1
versionLabel.TextXAlignment = Enum.TextXAlignment.Center
versionLabel.LayoutOrder = 4
versionLabel.Size = UDim2.new(1, 0, 0, 20)
versionLabel.Parent = creditsFrame

-- Toggle UI button (hover, toggle visibility)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 20, 0, 20)
toggleBtn.BackgroundColor3 = colors.accent
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "H"
toggleBtn.TextColor3 = colors.text
toggleBtn.TextScaled = true
toggleBtn.ZIndex = 10
toggleBtn.Parent = HubGui
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 12)

-- Fungsi toggle UI
local uiVisible = false
local function toggleUI()
    uiVisible = not uiVisible
    if uiVisible then
        MainContainer.Visible = true
        TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 400)}):Play()
    else
        TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 520, 0, 0)}):Play()
        wait(0.3)
        MainContainer.Visible = false
    end
end

toggleBtn.MouseButton1Click:Connect(toggleUI)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.H then
        toggleUI()
    end
end)

-- Drag UI by dragging Sidebar header (Title)
local dragging, dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainContainer.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        MainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("HuntyHub v3.0 with sidebar loaded!")
