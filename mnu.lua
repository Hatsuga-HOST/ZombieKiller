local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Main UI Container
local ZiaanHub = Instance.new("ScreenGui")
ZiaanHub.Name = "ZiaanHub"
ZiaanHub.ResetOnSpawn = false
ZiaanHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (Draggable)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ZiaanHub

-- Rounded Corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Drop Shadow
local DropShadow = Instance.new("ImageLabel")
DropShadow.Name = "DropShadow"
DropShadow.BackgroundTransparency = 1
DropShadow.Size = UDim2.new(1, 20, 1, 20)
DropShadow.Position = UDim2.new(0, -10, 0, -10)
DropShadow.Image = "rbxassetid://5554236805"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.8
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(10, 10, 118, 118)
DropShadow.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 8)
TitleBarCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ZiaanHub - Blox Fruits"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = TitleBar

-- Toggle UI Button (Logo)
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 25, 0, 25)
ToggleButton.Position = UDim2.new(1, -60, 0, 2)
ToggleButton.BackgroundTransparency = 1
ToggleButton.Image = "rbxassetid://7072716642" -- Replace with your logo asset ID
ToggleButton.Parent = TitleBar

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -30, 0, 2)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 2)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, 0, 1, -30)
ContentArea.Position = UDim2.new(0, 0, 0, 30)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = ContentArea

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

-- Sidebar Buttons Container
local SidebarButtons = Instance.new("ScrollingFrame")
SidebarButtons.Name = "SidebarButtons"
SidebarButtons.Size = UDim2.new(1, 0, 1, 0)
SidebarButtons.BackgroundTransparency = 1
SidebarButtons.ScrollBarThickness = 3
SidebarButtons.CanvasSize = UDim2.new(0, 0, 0, 0)
SidebarButtons.AutomaticCanvasSize = Enum.AutomaticSize.Y
SidebarButtons.Parent = Sidebar

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = SidebarButtons

-- Home Tab Button
local HomeTabButton = Instance.new("TextButton")
HomeTabButton.Name = "HomeTabButton"
HomeTabButton.Size = UDim2.new(0.9, 0, 0, 40)
HomeTabButton.Position = UDim2.new(0.05, 0, 0, 10)
HomeTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
HomeTabButton.BorderSizePixel = 0
HomeTabButton.Text = "Home"
HomeTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeTabButton.TextSize = 14
HomeTabButton.Font = Enum.Font.GothamBold
HomeTabButton.Parent = SidebarButtons

local HomeTabCorner = Instance.new("UICorner")
HomeTabCorner.CornerRadius = UDim.new(0, 6)
HomeTabCorner.Parent = HomeTabButton

-- Main Tab Button
local MainTabButton = Instance.new("TextButton")
MainTabButton.Name = "MainTabButton"
MainTabButton.Size = UDim2.new(0.9, 0, 0, 40)
MainTabButton.Position = UDim2.new(0.05, 0, 0, 60)
MainTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MainTabButton.BorderSizePixel = 0
MainTabButton.Text = "Main"
MainTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTabButton.TextSize = 14
MainTabButton.Font = Enum.Font.GothamBold
MainTabButton.Parent = SidebarButtons

local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 6)
MainTabCorner.Parent = MainTabButton

-- Right Content Area
local RightContent = Instance.new("Frame")
RightContent.Name = "RightContent"
RightContent.Size = UDim2.new(1, -155, 1, 0)
RightContent.Position = UDim2.new(0, 155, 0, 0)
RightContent.BackgroundTransparency = 1
RightContent.Parent = ContentArea

-- Home Tab Content
local HomeTab = Instance.new("ScrollingFrame")
HomeTab.Name = "HomeTab"
HomeTab.Size = UDim2.new(1, 0, 1, 0)
HomeTab.BackgroundTransparency = 1
HomeTab.ScrollBarThickness = 3
HomeTab.Visible = true
HomeTab.Parent = RightContent

local HomeTabLayout = Instance.new("UIListLayout")
HomeTabLayout.Padding = UDim.new(0, 10)
HomeTabLayout.Parent = HomeTab

-- Welcome Message
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Name = "WelcomeLabel"
WelcomeLabel.Size = UDim2.new(1, -20, 0, 60)
WelcomeLabel.Position = UDim2.new(0, 10, 0, 10)
WelcomeLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
WelcomeLabel.BorderSizePixel = 0
WelcomeLabel.Text = "Terima kasih telah menggunakan ZiaanHub - Blox Fruits!\n\nScript ini dibuat untuk memudahkan permainan Anda."
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeLabel.TextSize = 14
WelcomeLabel.Font = Enum.Font.Gotham
WelcomeLabel.TextWrapped = true
WelcomeLabel.Parent = HomeTab

local WelcomeCorner = Instance.new("UICorner")
WelcomeCorner.CornerRadius = UDim.new(0, 6)
WelcomeCorner.Parent = WelcomeLabel

-- Discord Banner
local DiscordBanner = Instance.new("Frame")
DiscordBanner.Name = "DiscordBanner"
DiscordBanner.Size = UDim2.new(1, -20, 0, 100)
DiscordBanner.Position = UDim2.new(0, 10, 0, 80)
DiscordBanner.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBanner.BorderSizePixel = 0
DiscordBanner.Parent = HomeTab

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 6)
DiscordCorner.Parent = DiscordBanner

local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Name = "DiscordLabel"
DiscordLabel.Size = UDim2.new(1, 0, 0.6, 0)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Text = "ZiaanHub Discord"
DiscordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordLabel.TextSize = 18
DiscordLabel.Font = Enum.Font.GothamBold
DiscordLabel.Parent = DiscordBanner

local JoinButton = Instance.new("TextButton")
JoinButton.Name = "JoinButton"
JoinButton.Size = UDim2.new(0.6, 0, 0.3, 0)
JoinButton.Position = UDim2.new(0.2, 0, 0.6, 0)
JoinButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
JoinButton.BorderSizePixel = 0
JoinButton.Text = "Join Discord"
JoinButton.TextColor3 = Color3.fromRGB(88, 101, 242)
JoinButton.TextSize = 14
JoinButton.Font = Enum.Font.GothamBold
JoinButton.Parent = DiscordBanner

local JoinButtonCorner = Instance.new("UICorner")
JoinButtonCorner.CornerRadius = UDim.new(0, 4)
JoinButtonCorner.Parent = JoinButton

-- Main Tab Content
local MainTab = Instance.new("ScrollingFrame")
MainTab.Name = "MainTab"
MainTab.Size = UDim2.new(1, 0, 1, 0)
MainTab.BackgroundTransparency = 1
MainTab.ScrollBarThickness = 3
MainTab.Visible = false
MainTab.Parent = RightContent

local MainTabLayout = Instance.new("UIListLayout")
MainTabLayout.Padding = UDim.new(0, 10)
MainTabLayout.Parent = MainTab

-- Player Tab
local PlayerTab = Instance.new("Frame")
PlayerTab.Name = "PlayerTab"
PlayerTab.Size = UDim2.new(1, -20, 0, 200)
PlayerTab.Position = UDim2.new(0, 10, 0, 10)
PlayerTab.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
PlayerTab.BorderSizePixel = 0
PlayerTab.Parent = MainTab

local PlayerTabCorner = Instance.new("UICorner")
PlayerTabCorner.CornerRadius = UDim.new(0, 6)
PlayerTabCorner.Parent = PlayerTab

local PlayerTabLabel = Instance.new("TextLabel")
PlayerTabLabel.Name = "PlayerTabLabel"
PlayerTabLabel.Size = UDim2.new(1, 0, 0, 30)
PlayerTabLabel.BackgroundTransparency = 1
PlayerTabLabel.Text = "Player Settings"
PlayerTabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerTabLabel.TextSize = 16
PlayerTabLabel.Font = Enum.Font.GothamBold
PlayerTabLabel.Parent = PlayerTab

-- WalkSpeed Slider
local WalkSpeedContainer = Instance.new("Frame")
WalkSpeedContainer.Name = "WalkSpeedContainer"
WalkSpeedContainer.Size = UDim2.new(0.9, 0, 0, 50)
WalkSpeedContainer.Position = UDim2.new(0.05, 0, 0, 40)
WalkSpeedContainer.BackgroundTransparency = 1
WalkSpeedContainer.Parent = PlayerTab

local WalkSpeedLabel = Instance.new("TextLabel")
WalkSpeedLabel.Name = "WalkSpeedLabel"
WalkSpeedLabel.Size = UDim2.new(1, 0, 0, 20)
WalkSpeedLabel.BackgroundTransparency = 1
WalkSpeedLabel.Text = "WalkSpeed: 16"
WalkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedLabel.TextSize = 14
WalkSpeedLabel.Font = Enum.Font.Gotham
WalkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
WalkSpeedLabel.Parent = WalkSpeedContainer

local WalkSpeedSlider = Instance.new("Frame")
WalkSpeedSlider.Name = "WalkSpeedSlider"
WalkSpeedSlider.Size = UDim2.new(1, 0, 0, 5)
WalkSpeedSlider.Position = UDim2.new(0, 0, 0, 25)
WalkSpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
WalkSpeedSlider.BorderSizePixel = 0
WalkSpeedSlider.Parent = WalkSpeedContainer

local WalkSpeedSliderCorner = Instance.new("UICorner")
WalkSpeedSliderCorner.CornerRadius = UDim.new(1, 0)
WalkSpeedSliderCorner.Parent = WalkSpeedSlider

local WalkSpeedFill = Instance.new("Frame")
WalkSpeedFill.Name = "WalkSpeedFill"
WalkSpeedFill.Size = UDim2.new(0.08, 0, 1, 0)
WalkSpeedFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
WalkSpeedFill.BorderSizePixel = 0
WalkSpeedFill.Parent = WalkSpeedSlider

local WalkSpeedSliderCorner2 = Instance.new("UICorner")
WalkSpeedSliderCorner2.CornerRadius = UDim.new(1, 0)
WalkSpeedSliderCorner2.Parent = WalkSpeedFill

local WalkSpeedButton = Instance.new("TextButton")
WalkSpeedButton.Name = "WalkSpeedButton"
WalkSpeedButton.Size = UDim2.new(1, 0, 2, 0)
WalkSpeedButton.Position = UDim2.new(0, 0, -0.5, 0)
WalkSpeedButton.BackgroundTransparency = 1
WalkSpeedButton.Text = ""
WalkSpeedButton.Parent = WalkSpeedSlider

-- Dash Length Slider
local DashContainer = Instance.new("Frame")
DashContainer.Name = "DashContainer"
DashContainer.Size = UDim2.new(0.9, 0, 0, 50)
DashContainer.Position = UDim2.new(0.05, 0, 0, 100)
DashContainer.BackgroundTransparency = 1
DashContainer.Parent = PlayerTab

local DashLabel = Instance.new("TextLabel")
DashLabel.Name = "DashLabel"
DashLabel.Size = UDim2.new(1, 0, 0, 20)
DashLabel.BackgroundTransparency = 1
DashLabel.Text = "Dash Length: 10"
DashLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DashLabel.TextSize = 14
DashLabel.Font = Enum.Font.Gotham
DashLabel.TextXAlignment = Enum.TextXAlignment.Left
DashLabel.Parent = DashContainer

local DashSlider = Instance.new("Frame")
DashSlider.Name = "DashSlider"
DashSlider.Size = UDim2.new(1, 0, 0, 5)
DashSlider.Position = UDim2.new(0, 0, 0, 25)
DashSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
DashSlider.BorderSizePixel = 0
DashSlider.Parent = DashContainer

local DashSliderCorner = Instance.new("UICorner")
DashSliderCorner.CornerRadius = UDim.new(1, 0)
DashSliderCorner.Parent = DashSlider

local DashFill = Instance.new("Frame")
DashFill.Name = "DashFill"
DashFill.Size = UDim2.new(0.01, 0, 1, 0)
DashFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
DashFill.BorderSizePixel = 0
DashFill.Parent = DashSlider

local DashSliderCorner2 = Instance.new("UICorner")
DashSliderCorner2.CornerRadius = UDim.new(1, 0)
DashSliderCorner2.Parent = DashFill

local DashButton = Instance.new("TextButton")
DashButton.Name = "DashButton"
DashButton.Size = UDim2.new(1, 0, 2, 0)
DashButton.Position = UDim2.new(0, 0, -0.5, 0)
DashButton.BackgroundTransparency = 1
DashButton.Text = ""
DashButton.Parent = DashSlider

-- Jump Power Slider
local JumpContainer = Instance.new("Frame")
JumpContainer.Name = "JumpContainer"
JumpContainer.Size = UDim2.new(0.9, 0, 0, 50)
JumpContainer.Position = UDim2.new(0.05, 0, 0, 160)
JumpContainer.BackgroundTransparency = 1
JumpContainer.Parent = PlayerTab

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Name = "JumpLabel"
JumpLabel.Size = UDim2.new(1, 0, 0, 20)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "Jump Height: 50"
JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpLabel.TextSize = 14
JumpLabel.Font = Enum.Font.Gotham
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left
JumpLabel.Parent = JumpContainer

local JumpSlider = Instance.new("Frame")
JumpSlider.Name = "JumpSlider"
JumpSlider.Size = UDim2.new(1, 0, 0, 5)
JumpSlider.Position = UDim2.new(0, 0, 0, 25)
JumpSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
JumpSlider.BorderSizePixel = 0
JumpSlider.Parent = JumpContainer

local JumpSliderCorner = Instance.new("UICorner")
JumpSliderCorner.CornerRadius = UDim.new(1, 0)
JumpSliderCorner.Parent = JumpSlider

local JumpFill = Instance.new("Frame")
JumpFill.Name = "JumpFill"
JumpFill.Size = UDim2.new(0.1, 0, 1, 0)
JumpFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
JumpFill.BorderSizePixel = 0
JumpFill.Parent = JumpSlider

local JumpSliderCorner2 = Instance.new("UICorner")
JumpSliderCorner2.CornerRadius = UDim.new(1, 0)
JumpSliderCorner2.Parent = JumpFill

local JumpButton = Instance.new("TextButton")
JumpButton.Name = "JumpButton"
JumpButton.Size = UDim2.new(1, 0, 2, 0)
JumpButton.Position = UDim2.new(0, 0, -0.5, 0)
JumpButton.BackgroundTransparency = 1
JumpButton.Text = ""
JumpButton.Parent = JumpSlider

-- Confirmation Popup
local ConfirmPopup = Instance.new("Frame")
ConfirmPopup.Name = "ConfirmPopup"
ConfirmPopup.Size = UDim2.new(0, 300, 0, 150)
ConfirmPopup.Position = UDim2.new(0.5, -150, 0.5, -75)
ConfirmPopup.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ConfirmPopup.BorderSizePixel = 0
ConfirmPopup.Visible = false
ConfirmPopup.ZIndex = 10
ConfirmPopup.Parent = ZiaanHub

local ConfirmPopupCorner = Instance.new("UICorner")
ConfirmPopupCorner.CornerRadius = UDim.new(0, 8)
ConfirmPopupCorner.Parent = ConfirmPopup

local ConfirmLabel = Instance.new("TextLabel")
ConfirmLabel.Name = "ConfirmLabel"
ConfirmLabel.Size = UDim2.new(1, -20, 0, 60)
ConfirmLabel.Position = UDim2.new(0, 10, 0, 10)
ConfirmLabel.BackgroundTransparency = 1
ConfirmLabel.Text = "Apakah Anda yakin ingin menutup ZiaanHub?\nAnda harus menjalankan ulang script untuk membukanya kembali."
ConfirmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmLabel.TextSize = 14
ConfirmLabel.Font = Enum.Font.Gotham
ConfirmLabel.TextWrapped = true
ConfirmLabel.ZIndex = 11
ConfirmLabel.Parent = ConfirmPopup

local ConfirmYes = Instance.new("TextButton")
ConfirmYes.Name = "ConfirmYes"
ConfirmYes.Size = UDim2.new(0, 100, 0, 30)
ConfirmYes.Position = UDim2.new(0.5, -110, 1, -50)
ConfirmYes.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
ConfirmYes.BorderSizePixel = 0
ConfirmYes.Text = "Ya, Tutup"
ConfirmYes.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmYes.TextSize = 14
ConfirmYes.Font = Enum.Font.GothamBold
ConfirmYes.ZIndex = 11
ConfirmYes.Parent = ConfirmPopup

local ConfirmYesCorner = Instance.new("UICorner")
ConfirmYesCorner.CornerRadius = UDim.new(0, 4)
ConfirmYesCorner.Parent = ConfirmYes

local ConfirmNo = Instance.new("TextButton")
ConfirmNo.Name = "ConfirmNo"
ConfirmNo.Size = UDim2.new(0, 100, 0, 30)
ConfirmNo.Position = UDim2.new(0.5, 10, 1, -50)
ConfirmNo.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
ConfirmNo.BorderSizePixel = 0
ConfirmNo.Text = "Batal"
ConfirmNo.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmNo.TextSize = 14
ConfirmNo.Font = Enum.Font.GothamBold
ConfirmNo.ZIndex = 11
ConfirmNo.Parent = ConfirmPopup

local ConfirmNoCorner = Instance.new("UICorner")
ConfirmNoCorner.CornerRadius = UDim.new(0, 4)
ConfirmNoCorner.Parent = ConfirmNo

-- Variables
local dragging = false
local dragInput, dragStart, startPos
local uiVisible = true
local currentTab = "Home"

-- Function to update sliders
local function updateSlider(slider, fill, label, value, min, max, text)
    local percentage = (value - min) / (max - min)
    fill.Size = UDim2.new(percentage, 0, 1, 0)
    label.Text = text .. ": " .. value
end

-- Function to create slider functionality
local function setupSlider(button, fill, label, min, max, current, callback, text)
    local sliding = false
    
    button.MouseButton1Down:Connect(function()
        sliding = true
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if not sliding then
                connection:Disconnect()
                return
            end
            
            local mouse = UserInputService:GetMouseLocation()
            local sliderAbsolutePos = button.AbsolutePosition
            local sliderAbsoluteSize = button.AbsoluteSize
            
            local relativeX = math.clamp((mouse.X - sliderAbsolutePos.X) / sliderAbsoluteSize.X, 0, 1)
            local value = math.floor(min + relativeX * (max - min))
            
            updateSlider(button, fill, label, value, min, max, text)
            callback(value)
        end)
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = false
        end
    end)
    
    updateSlider(button, fill, label, current, min, max, text)
end

-- Initialize sliders
setupSlider(
    WalkSpeedButton, 
    WalkSpeedFill, 
    WalkSpeedLabel, 
    16, 200, 16,
    function(value)
        local character = player.Character
        if character then
            character:SetAttribute("SpeedMultiplier", value)
        end
    end,
    "WalkSpeed"
)

setupSlider(
    DashButton, 
    DashFill, 
    DashLabel, 
    10, 1000, 10,
    function(value)
        local character = player.Character
        if character then
            character:SetAttribute("DashLength", value)
        end
    end,
    "Dash Length"
)

setupSlider(
    JumpButton, 
    JumpFill, 
    JumpLabel, 
    50, 500, 50,
    function(value)
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = value
        end
    end,
    "Jump Height"
)

-- Auto-update character reference
player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    
    local speedMultiplier = character:GetAttribute("SpeedMultiplier") or 16
    updateSlider(WalkSpeedButton, WalkSpeedFill, WalkSpeedLabel, speedMultiplier, 16, 200, "WalkSpeed")
    
    local dashLength = character:GetAttribute("DashLength") or 10
    updateSlider(DashButton, DashFill, DashLabel, dashLength, 10, 1000, "Dash Length")
    
    updateSlider(JumpButton, JumpFill, JumpLabel, character.Humanoid.JumpPower, 50, 500, "Jump Height")
end)

-- Dragging functionality
local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Toggle UI function
ToggleButton.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    
    if uiVisible then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 600, 0, 400)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        wait(0.2)
        MainFrame.Visible = false
    end
end)

-- Minimize function
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Close function with confirmation
CloseButton.MouseButton1Click:Connect(function()
    ConfirmPopup.Visible = true
end)

ConfirmYes.MouseButton1Click:Connect(function()
    ZiaanHub:Destroy()
end)

ConfirmNo.MouseButton1Click:Connect(function()
    ConfirmPopup.Visible = false
end)

-- Tab switching
HomeTabButton.MouseButton1Click:Connect(function()
    if currentTab ~= "Home" then
        currentTab = "Home"
        HomeTab.Visible = true
        MainTab.Visible = false
        
        HomeTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        MainTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)

MainTabButton.MouseButton1Click:Connect(function()
    if currentTab ~= "Main" then
        currentTab = "Main"
        HomeTab.Visible = false
        MainTab.Visible = true
        
        HomeTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        MainTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    end
end)

-- Discord button functionality
JoinButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/example") -- Replace with your Discord invite link
end)

-- Final setup
ZiaanHub.Parent = playerGui
