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
local HttpService = game:GetService("HttpService")

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
MainContainer.Size = UDim2.new(0, 500, 0, 500)
MainContainer.Position = UDim2.new(0.5, -250, 0.5, -250)
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
Title.Text = "HUNTYHUB TELEPORT"
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
local Tabs = {"Home", "Teleport"}
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
TabButtons["Home"].BackgroundColor3 = colors.accent

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

-- Populate Home tab
local homeFrame = TabFrames["Home"]
local welcomeLabel = createLabel("Selamat Datang di HuntyHub Teleport", 1, 18)
welcomeLabel.TextXAlignment = Enum.TextXAlignment.Center
welcomeLabel.Size = UDim2.new(1, 0, 0, 40)
welcomeLabel.Parent = homeFrame

local descLabel = createLabel("HuntyHub adalah script eksklusif yang memungkinkan Anda untuk melakukan teleportasi ke berbagai lokasi penting dalam game dengan mudah dan cepat.", 2, 14)
descLabel.TextXAlignment = Enum.TextXAlignment.Center
descLabel.Size = UDim2.new(1, 0, 0, 60)
descLabel.TextWrapped = true
descLabel.Parent = homeFrame

local featuresLabel = createLabel("Fitur Utama:", 3, 16)
featuresLabel.TextXAlignment = Enum.TextXAlignment.Left
featuresLabel.Parent = homeFrame

local feature1 = createLabel("• Teleportasi ke 11 lokasi penting", 4, 14)
feature1.TextXAlignment = Enum.TextXAlignment.Left
feature1.Parent = homeFrame

local feature2 = createLabel("• Antarmuka yang user-friendly", 5, 14)
feature2.TextXAlignment = Enum.TextXAlignment.Left
feature2.Parent = homeFrame

local feature3 = createLabel("• Tombol toggle untuk membuka/menutup UI", 6, 14)
feature3.TextXAlignment = Enum.TextXAlignment.Left
feature3.Parent = homeFrame

local tutorialLabel = createLabel("Cara Penggunaan:", 7, 16)
tutorialLabel.TextXAlignment = Enum.TextXAlignment.Left
tutorialLabel.Parent = homeFrame

local step1 = createLabel("1. Tekan tombol 'H' atau klik tombol H di sudut kiri atas untuk membuka UI", 8, 14)
step1.TextXAlignment = Enum.TextXAlignment.Left
step1.TextWrapped = true
step1.Size = UDim2.new(1, 0, 0, 40)
step1.Parent = homeFrame

local step2 = createLabel("2. Pilih tab 'Teleport' untuk melihat daftar lokasi", 9, 14)
step2.TextXAlignment = Enum.TextXAlignment.Left
step2.TextWrapped = true
step2.Size = UDim2.new(1, 0, 0, 40)
step2.Parent = homeFrame

local step3 = createLabel("3. Klik tombol teleport untuk langsung berpindah ke lokasi tujuan", 10, 14)
step3.TextXAlignment = Enum.TextXAlignment.Left
step3.TextWrapped = true
step3.Size = UDim2.new(1, 0, 0, 40)
step3.Parent = homeFrame

local warningLabel = createLabel("PERINGATAN: Gunakan script ini dengan bijak. Developer tidak bertanggung jawab atas akibat yang ditimbulkan.", 11, 12)
warningLabel.TextXAlignment = Enum.TextXAlignment.Center
warningLabel.TextColor3 = colors.warning
warningLabel.Size = UDim2.new(1, 0, 0, 60)
warningLabel.TextWrapped = true
warningLabel.Parent = homeFrame

-- Populate Teleport tab
local teleportFrame = TabFrames["Teleport"]

-- Teleport locations data
local teleportLocations = {
    ["Store"] = CFrame.new(69.8056411743164, 10.32421588897705, 133.9318084716797),
    ["Items"] = CFrame.new(68.81236267089844, 10.418478965759277, 157.36123657226562),
    ["Characteristics"] = CFrame.new(-24.02008628845215, 9.646740913391113, 182.21234130859375),
    ["Weapons"] = CFrame.new(63.00526428222656, 9.203720092773438, 91.75598907470703),
    ["Achievements"] = CFrame.new(5.308657169342041, 9.203719139099121, 188.3883819580078),
    ["Daily Tasks"] = CFrame.new(48.050018310546875, 9.203718185424805, 184.59385681152344),
    ["Secret Tasks"] = CFrame.new(34.36442565917969, 9.453873634338379, 85.84275817871094),
    ["Lobby"] = CFrame.new(-1.4279574155807495, 9.64672565460205, 161.88681030273438),
    ["Events"] = CFrame.new(21.252410888671875, 9.757711410522461, 146.3155975341797),
    ["Playing"] = CFrame.new(-22.4, 9.6, 110.3),
}

-- Create teleport buttons
for i, locationName in ipairs({"Store", "Items", "Characteristics", "Weapons", "Achievements", "Daily Tasks", "Secret Tasks", "Lobby", "Events", "Playing"}) do
    local button = createButton(locationName, i)
    button.Parent = teleportFrame
    
    button.MouseButton1Click:Connect(function()
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- Smooth teleport with tween
            local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(character.HumanoidRootPart, tweenInfo, {CFrame = teleportLocations[locationName]})
            tween:Play()
            
            -- Show notification
            spawn(function()
                local notification = Instance.new("TextLabel")
                notification.Size = UDim2.new(0, 200, 0, 40)
                notification.Position = UDim2.new(0.5, -100, 0, 50)
                notification.BackgroundColor3 = colors.success
                notification.Text = "Teleported to: " .. locationName
                notification.TextColor3 = colors.text
                notification.Font = Enum.Font.GothamBold
                notification.TextSize = 14
                notification.Visible = true
                notification.ZIndex = 20
                notification.Parent = HubGui
                
                local notifCorner = Instance.new("UICorner")
                notifCorner.CornerRadius = UDim.new(0, 6)
                notifCorner.Parent = notification
                
                wait(2)
                
                local fadeTween = TweenService:Create(notification, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1})
                fadeTween:Play()
                fadeTween.Completed:Connect(function()
                    notification:Destroy()
                end)
            end)
        end
    end)
end

-- Custom teleport section
local customLabel = createLabel("Custom Teleport (Input Coordinates):", 12, 16)
customLabel.TextXAlignment = Enum.TextXAlignment.Center
customLabel.Size = UDim2.new(1, 0, 0, 30)
customLabel.Parent = teleportFrame

local xInput = createTextBox("X Coordinate", 13)
xInput.Parent = teleportFrame

local yInput = createTextBox("Y Coordinate", 14)
yInput.Parent = teleportFrame

local zInput = createTextBox("Z Coordinate", 15)
zInput.Parent = teleportFrame

local teleportButton = createButton("Teleport to Coordinates", 16)
teleportButton.Parent = teleportFrame

teleportButton.MouseButton1Click:Connect(function()
    local x = tonumber(xInput.Text) or 0
    local y = tonumber(yInput.Text) or 5
    local z = tonumber(zInput.Text) or 0
    
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(x, y, z)})
        tween:Play()
        
        -- Show notification
        spawn(function()
            local notification = Instance.new("TextLabel")
            notification.Size = UDim2.new(0, 250, 0, 40)
            notification.Position = UDim2.new(0.5, -125, 0, 50)
            notification.BackgroundColor3 = colors.success
            notification.Text = "Teleported to: " .. x .. ", " .. y .. ", " .. z
            notification.TextColor3 = colors.text
            notification.Font = Enum.Font.GothamBold
            notification.TextSize = 14
            notification.Visible = true
            notification.ZIndex = 20
            notification.Parent = HubGui
            
            local notifCorner = Instance.new("UICorner")
            notifCorner.CornerRadius = UDim.new(0, 6)
            notifCorner.Parent = notification
            
            wait(2)
            
            local fadeTween = TweenService:Create(notification, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1})
            fadeTween:Play()
            fadeTween.Completed:Connect(function()
                notification:Destroy()
            end)
        end)
    end
end)

-- UI toggle functionality
local uiVisible = false

local function toggleUI()
    uiVisible = not uiVisible
    
    if uiVisible then
        MainContainer.Visible = true
        TweenService:Create(
            MainContainer,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 500, 0, 500)}
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
print("Press H to toggle the UI")

-- Add notification system
function showNotification(message, color)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 300, 0, 50)
    notification.Position = UDim2.new(0.5, -150, 0, 10)
    notification.BackgroundColor3 = color or colors.accent
    notification.Text = message
    notification.TextColor3 = colors.text
    notification.Font = Enum.Font.GothamBold
    notification.TextSize = 14
    notification.Visible = true
    notification.ZIndex = 20
    notification.Parent = HubGui
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 6)
    notifCorner.Parent = notification
    
    -- Auto-remove after 3 seconds
    delay(3, function()
        if notification then
            local fadeTween = TweenService:Create(notification, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1})
            fadeTween:Play()
            fadeTween.Completed:Connect(function()
                notification:Destroy()
            end)
        end
    end)
end

-- Show welcome notification
showNotification("HuntyHub Teleport Loaded! Press H to open", colors.success) 
