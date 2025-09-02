-- HuntyHub Enhanced Version
-- by Developer Resmi Hunty Zombie

-- Wait for the game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old UI if exists
if playerGui:FindFirstChild("HuntyHub") then
    playerGui.HuntyHub:Destroy()
    wait(0.1)
end

-- Color scheme
local colors = {
    background = Color3.fromRGB(30, 30, 40),
    header = Color3.fromRGB(25, 25, 35),
    accent = Color3.fromRGB(100, 70, 200),
    secondary = Color3.fromRGB(60, 60, 80),
    text = Color3.fromRGB(240, 240, 240),
    button = Color3.fromRGB(80, 60, 160),
    buttonHover = Color3.fromRGB(110, 80, 220),
    success = Color3.fromRGB(80, 200, 120),
    warning = Color3.fromRGB(220, 180, 60),
    error = Color3.fromRGB(220, 80, 80)
}

-- Main UI
local HubGui = Instance.new("ScreenGui")
HubGui.Name = "HuntyHub"
HubGui.ResetOnSpawn = false
HubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HubGui.Parent = playerGui

-- Main container (initially hidden)
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 500, 0, 400)
MainContainer.Position = UDim2.new(0.5, -250, 0.5, -200)
MainContainer.BackgroundColor3 = colors.background
MainContainer.BorderSizePixel = 0
MainContainer.ClipsDescendants = true
MainContainer.Visible = false
MainContainer.Parent = HubGui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = MainContainer

-- Drop shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = -1
shadow.Parent = MainContainer

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = colors.header
Header.BorderSizePixel = 0
Header.ZIndex = 2
Header.Parent = MainContainer

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "HUNTYHUB v2.0"
Title.TextColor3 = colors.text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3
Title.Parent = Header

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "×"
CloseButton.TextColor3 = colors.text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 24
CloseButton.ZIndex = 3
CloseButton.Parent = Header

-- Tab buttons
local Tabs = {"Teleport", "Player", "Settings", "Credits"}
local TabButtons = {}
local TabFrames = {}

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -30, 0, 30)
TabContainer.Position = UDim2.new(0, 15, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainContainer

local TabContent = Instance.new("Frame")
TabContent.Size = UDim2.new(1, -20, 1, -85)
TabContent.Position = UDim2.new(0, 10, 0, 80)
TabContent.BackgroundTransparency = 1
TabContent.ClipsDescendants = true
TabContent.Parent = MainContainer

-- Create tabs
for i, tabName in ipairs(Tabs) do
    -- Tab button
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 100, 1, 0)
    tabButton.Position = UDim2.new(0, (i-1)*105, 0, 0)
    tabButton.BackgroundColor3 = colors.secondary
    tabButton.BorderSizePixel = 0
    tabButton.Text = tabName
    tabButton.TextColor3 = colors.text
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 14
    tabButton.Parent = TabContainer
    
    -- Rounded corners for top only
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabButton:GetPropertyChangedSignal("Size"):Connect(function()
        tabCorner.CornerRadius = UDim.new(0, 6)
    end)
    tabCorner.Parent = tabButton
    
    -- Tab content frame
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.Position = UDim2.new(0, 0, 0, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.BorderSizePixel = 0
    tabFrame.ScrollBarThickness = 4
    tabFrame.ScrollBarImageColor3 = colors.accent
    tabFrame.Visible = i == 1
    tabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabFrame.Parent = TabContent
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = tabFrame
    
    TabButtons[tabName] = tabButton
    TabFrames[tabName] = tabFrame
    
    -- Tab button click event
    tabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(TabFrames) do
            frame.Visible = false
        end
        tabFrame.Visible = true
        
        for _, button in pairs(TabButtons) do
            button.BackgroundColor3 = colors.secondary
        end
        tabButton.BackgroundColor3 = colors.accent
    end)
    
    -- Hover effects
    tabButton.MouseEnter:Connect(function()
        if tabButton.BackgroundColor3 ~= colors.accent then
            game:GetService("TweenService"):Create(
                tabButton, 
                TweenInfo.new(0.2), 
                {BackgroundColor3 = Color3.fromRGB(70, 70, 90)}
            ):Play()
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if tabButton.BackgroundColor3 ~= colors.accent then
            game:GetService("TweenService"):Create(
                tabButton, 
                TweenInfo.new(0.2), 
                {BackgroundColor3 = colors.secondary}
            ):Play()
        end
    end)
end

-- Set first tab as active
TabButtons["Teleport"].BackgroundColor3 = colors.accent

-- Toggle button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = colors.accent
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "H"
ToggleButton.TextColor3 = colors.text
ToggleButton.TextScaled = true
ToggleButton.ZIndex = 10
ToggleButton.Parent = HubGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 12)
toggleCorner.Parent = ToggleButton

-- Function to create button with consistent style
local function createButton(text, layoutOrder)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = colors.button
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = colors.text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.LayoutOrder = layoutOrder
    button.AutoButtonColor = false
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        TweenService:Create(
            button, 
            TweenInfo.new(0.2), 
            {BackgroundColor3 = colors.buttonHover}
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(
            button, 
            TweenInfo.new(0.2), 
            {BackgroundColor3 = colors.button}
        ):Play()
    end)
    
    return button
end

-- Function to create label with consistent style
local function createLabel(text, layoutOrder, textSize)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = colors.text
    label.Font = Enum.Font.Gotham
    label.TextSize = textSize or 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = layoutOrder
    return label
end

-- Function to create textbox with consistent style
local function createTextBox(placeholder, layoutOrder)
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 0, 40)
    textBox.BackgroundColor3 = colors.secondary
    textBox.BorderSizePixel = 0
    textBox.PlaceholderText = placeholder
    textBox.Text = ""
    textBox.TextColor3 = colors.text
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 14
    textBox.LayoutOrder = layoutOrder
    textBox.ClearTextOnFocus = false
    
    local textBoxCorner = Instance.new("UICorner")
    textBoxCorner.CornerRadius = UDim.new(0, 6)
    textBoxCorner.Parent = textBox
    
    return textBox
end

-- Function to create slider with consistent style
local function createSlider(min, max, defaultValue, layoutOrder, valueChangedCallback)
    local sliderContainer = Instance.new("Frame")
    sliderContainer.Size = UDim2.new(1, 0, 0, 50)
    sliderContainer.BackgroundTransparency = 1
    sliderContainer.LayoutOrder = layoutOrder
    
    local sliderName = Instance.new("TextLabel")
    sliderName.Size = UDim2.new(1, 0, 0, 20)
    sliderName.BackgroundTransparency = 1
    sliderName.Text = "Slider"
    sliderName.TextColor3 = colors.text
    sliderName.Font = Enum.Font.Gotham
    sliderName.TextSize = 14
    sliderName.TextXAlignment = Enum.TextXAlignment.Left
    sliderName.Parent = sliderContainer
    
    local sliderBackground = Instance.new("Frame")
    sliderBackground.Size = UDim2.new(1, 0, 0, 5)
    sliderBackground.Position = UDim2.new(0, 0, 0, 25)
    sliderBackground.BackgroundColor3 = colors.secondary
    sliderBackground.BorderSizePixel = 0
    sliderBackground.Parent = sliderContainer
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    sliderFill.BackgroundColor3 = colors.accent
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBackground
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 15, 0, 15)
    sliderButton.Position = UDim2.new(0.5, -7.5, 0, -5)
    sliderButton.BackgroundColor3 = colors.text
    sliderButton.BorderSizePixel = 0
    sliderButton.Text = ""
    sliderButton.Parent = sliderBackground
    
    local sliderValue = Instance.new("TextLabel")
    sliderValue.Size = UDim2.new(1, 0, 0, 20)
    sliderValue.Position = UDim2.new(0, 0, 0, 30)
    sliderValue.BackgroundTransparency = 1
    sliderValue.Text = tostring(defaultValue)
    sliderValue.TextColor3 = colors.text
    sliderValue.Font = Enum.Font.Gotham
    sliderValue.TextSize = 12
    sliderValue.TextXAlignment = Enum.TextXAlignment.Right
    sliderValue.Parent = sliderContainer
    
    -- Rounded corners
    for _, frame in {sliderBackground, sliderFill, sliderButton} do
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame
    end
    
    -- Slider functionality
    local isSliding = false
    local function updateSlider(input)
        if not isSliding then return end
        
        local relativeX = (input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        
        local value = math.floor(min + (max - min) * relativeX)
        sliderValue.Text = tostring(value)
        sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        sliderButton.Position = UDim2.new(relativeX, -7.5, 0, -5)
        
        if valueChangedCallback then
            valueChangedCallback(value)
        end
    end
    
    sliderButton.MouseButton1Down:Connect(function()
        isSliding = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isSliding = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    return sliderContainer, sliderName
end

-- Populate Teleport tab
local teleportFrame = TabFrames["Teleport"]
local teleportLocations = {
    ["Lobby"] = CFrame.new(0, 5, 0),
    ["Toko"] = CFrame.new(69.8056411743164, 10.32421588897705, 133.9318084716797),
    ["Secret Area"] = CFrame.new(100, 50, -200),
    ["VIP Room"] = CFrame.new(-150, 25, 75)
}

local teleportLabel = createLabel("Teleport Locations:", 1, 16)
teleportLabel.TextXAlignment = Enum.TextXAlignment.Center
teleportLabel.Size = UDim2.new(1, 0, 0, 30)
teleportLabel.Parent = teleportFrame

for i, locationName in pairs({"Spawn", "Toko", "Secret Area", "VIP Room"}) do
    local button = createButton(locationName, i + 1)
    button.Parent = teleportFrame
    
    button.MouseButton1Click:Connect(function()
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = teleportLocations[locationName]
            -- Show notification
            spawn(function()
                -- Notification function would be implemented here
            end)
        end
    end)
end

-- Custom teleport section
local customLabel = createLabel("Custom Teleport:", 6, 16)
customLabel.TextXAlignment = Enum.TextXAlignment.Center
customLabel.Size = UDim2.new(1, 0, 0, 30)
customLabel.Parent = teleportFrame

local xInput = createTextBox("X Coordinate", 7)
xInput.Parent = teleportFrame

local yInput = createTextBox("Y Coordinate", 8)
yInput.Parent = teleportFrame

local zInput = createTextBox("Z Coordinate", 9)
zInput.Parent = teleportFrame

local teleportButton = createButton("Teleport to Coordinates", 10)
teleportButton.Parent = teleportFrame

teleportButton.MouseButton1Click:Connect(function()
    local x = tonumber(xInput.Text) or 0
    local y = tonumber(yInput.Text) or 5
    local z = tonumber(zInput.Text) or 0
    
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    end
end)

-- Populate Player tab
local playerFrame = TabFrames["Player"]
local playerLabel = createLabel("Player Modifications:", 1, 16)
playerLabel.TextXAlignment = Enum.TextXAlignment.Center
playerLabel.Size = UDim2.new(1, 0, 0, 30)
playerLabel.Parent = playerFrame

-- WalkSpeed slider
local walkSpeedSlider, walkSpeedLabel = createSlider(16, 100, 16, 2, function(value)
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = value
    end
end)
walkSpeedLabel.Text = "Walk Speed"
walkSpeedSlider.Parent = playerFrame

-- JumpPower slider
local jumpPowerSlider, jumpPowerLabel = createSlider(50, 200, 50, 3, function(value)
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.JumpPower = value
    end
end)
jumpPowerLabel.Text = "Jump Power"
jumpPowerSlider.Parent = playerFrame

-- Noclip toggle
local noclipButton = createButton("Toggle Noclip", 4)
noclipButton.Parent = playerFrame

local noclipEnabled = false
local noclipConnection
noclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    local character = player.Character
    
    if noclipEnabled then
        noclipButton.Text = "Noclip: ON"
        noclipButton.BackgroundColor3 = colors.success
        
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        
        if noclipConnection then noclipConnection:Disconnect() end
        noclipConnection = RunService.Stepped:Connect(function()
            if character and noclipEnabled then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            else
                noclipConnection:Disconnect()
            end
        end)
    else
        noclipButton.Text = "Toggle Noclip"
        noclipButton.BackgroundColor3 = colors.button
        
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        
        if noclipConnection then
            noclipConnection:Disconnect()
        end
    end
end)

-- Fly toggle
local flyButton = createButton("Toggle Fly", 5)
flyButton.Parent = playerFrame

local flyEnabled = false
local flyConnection
flyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    local character = player.Character
    
    if flyEnabled then
        flyButton.Text = "Fly: ON"
        flyButton.BackgroundColor3 = colors.success
        
        -- Fly implementation would go here
        -- This is a simplified version
        if character and character:FindFirstChild("HumanoidRootPart") then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = character.HumanoidRootPart
            
            if flyConnection then flyConnection:Disconnect() end
            flyConnection = RunService.Heartbeat:Connect(function()
                if character and flyEnabled then
                    -- Fly logic would be implemented here
                else
                    flyConnection:Disconnect()
                    if bodyVelocity then bodyVelocity:Destroy() end
                end
            end)
        end
    else
        flyButton.Text = "Toggle Fly"
        flyButton.BackgroundColor3 = colors.button
        
        if flyConnection then
            flyConnection:Disconnect()
        end
        
        if character and character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
            character.HumanoidRootPart.BodyVelocity:Destroy()
        end
    end
end)

-- Populate Settings tab
local settingsFrame = TabFrames["Settings"]
local settingsLabel = createLabel("Hub Settings:", 1, 16)
settingsLabel.TextXAlignment = Enum.TextXAlignment.Center
settingsLabel.Size = UDim2.new(1, 0, 0, 30)
settingsLabel.Parent = settingsFrame

-- UI Color picker
local uiColorButton = createButton("Change UI Color", 2)
uiColorButton.Parent = settingsFrame

uiColorButton.MouseButton1Click:Connect(function()
    -- Color picker implementation would go here
    -- For simplicity, we'll just cycle through some colors
    local colorThemes = {
        {background = Color3.fromRGB(30, 40, 50), accent = Color3.fromRGB(0, 150, 200)},
        {background = Color3.fromRGB(40, 30, 50), accent = Color3.fromRGB(180, 70, 200)},
        {background = Color3.fromRGB(50, 40, 30), accent = Color3.fromRGB(220, 150, 50)}
    }
    
    local currentTheme = 1
    
    currentTheme = currentTheme % #colorThemes + 1
    local theme = colorThemes[currentTheme]
    
    TweenService:Create(
        MainContainer,
        TweenInfo.new(0.5),
        {BackgroundColor3 = theme.background}
    ):Play()
    
    TweenService:Create(
        Header,
        TweenInfo.new(0.5),
        {BackgroundColor3 = theme.header}
    ):Play()
    
    for _, button in pairs(TabButtons) do
        if button.BackgroundColor3 == colors.accent then
            TweenService:Create(
                button,
                TweenInfo.new(0.5),
                {BackgroundColor3 = theme.accent}
            ):Play()
        end
    end
    
    colors.background = theme.background
    colors.accent = theme.accent
end)

-- Keybind settings
local keybindLabel = createLabel("Toggle Keybind: H", 3)
keybindLabel.TextXAlignment = Enum.TextXAlignment.Center
keybindLabel.Parent = settingsFrame

-- Populate Credits tab
local creditsFrame = TabFrames["Credits"]
local creditsLabel = createLabel("HuntyHub v2.0", 1, 18)
creditsLabel.TextXAlignment = Enum.TextXAlignment.Center
creditsLabel.Size = UDim2.new(1, 0, 0, 40)
creditsLabel.Parent = creditsFrame

local developerLabel = createLabel("Developed by: Dev HuntyZombie", 2, 16)
developerLabel.TextXAlignment = Enum.TextXAlignment.Center
developerLabel.Parent = creditsFrame

local specialLabel = createLabel("Special thanks to:", 3, 14)
specialLabel.TextXAlignment = Enum.TextXAlignment.Center
specialLabel.Parent = creditsFrame

local thanksLabel = createLabel("The Roblox scripting community\nAll our beta testers", 4, 12)
thanksLabel.TextXAlignment = Enum.TextXAlignment.Center
thanksLabel.Size = UDim2.new(1, 0, 0, 60)
thanksLabel.Parent = creditsFrame

local versionLabel = createLabel("Version 2.0 | © 2023", 5, 12)
versionLabel.TextXAlignment = Enum.TextXAlignment.Center
versionLabel.Parent = creditsFrame

-- UI toggle functionality
local uiVisible = false

local function toggleUI()
    uiVisible = not uiVisible
    
    if uiVisible then
        MainContainer.Visible = true
        TweenService:Create(
            MainContainer,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 500, 0, 400)}
        ):Play()
    else
        TweenService:Create(
            MainContainer,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 500, 0, 0)}
        ):Play()
        wait(0.3)
        MainContainer.Visible = false
    end
end

ToggleButton.MouseButton1Click:Connect(toggleUI)
CloseButton.MouseButton1Click:Connect(toggleUI)

-- Keybind to toggle UI
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.H then
        toggleUI()
    end
end)

-- Make UI draggable
local dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragStart = input.Position
        startPos = MainContainer.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragInput = nil
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput then
        updateInput(input)
    end
end)

-- Initialize UI
print("HuntyHub Enhanced Version Loaded!")
