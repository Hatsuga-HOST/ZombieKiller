-- ZiaanHub - Blox Fruits
-- Hub Stylish Dark UI by Lua
-- Struktur: Sidebar kiri, konten kanan, draggable, show/hide, popup konfirmasi

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- =========================
-- ScreenGui
-- =========================
local ZiaanHub = Instance.new("ScreenGui")
ZiaanHub.Name = "ZiaanHub"
ZiaanHub.ResetOnSpawn = false
ZiaanHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ZiaanHub.Parent = playerGui

-- =========================
-- Main Frame
-- =========================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.AnchorPoint = Vector2.new(0.5,0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ZiaanHub

local mainUICorner = Instance.new("UICorner")
mainUICorner.CornerRadius = UDim.new(0,8)
mainUICorner.Parent = MainFrame

-- =========================
-- Draggable Toggle Logo
-- =========================
local ToggleLogo = Instance.new("ImageButton")
ToggleLogo.Name = "ToggleLogo"
ToggleLogo.Size = UDim2.new(0,50,0,50)
ToggleLogo.Position = UDim2.new(0,10,0,10)
ToggleLogo.BackgroundTransparency = 1
ToggleLogo.Image = "rbxassetid://7072716642" -- ganti asset id logo
ToggleLogo.Parent = ZiaanHub
ToggleLogo.ZIndex = 5

-- Fungsi show/hide MainFrame
local UIVisible = true
ToggleLogo.MouseButton1Click:Connect(function()
    UIVisible = not UIVisible
    MainFrame.Visible = UIVisible
end)

-- =========================
-- TitleBar
-- =========================
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1,0,0,30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20,20,30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1,0,1,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "ZiaanHub - Blox Fruits"
titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.Parent = TitleBar

-- Close Button X
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0,25,0,25)
CloseButton.Position = UDim2.new(1,-30,0,2)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255,100,100)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = TitleBar

-- =========================
-- Popup Confirmation
-- =========================
local Popup = Instance.new("Frame")
Popup.Size = UDim2.new(0,300,0,150)
Popup.Position = UDim2.new(0.5,-150,0.5,-75)
Popup.BackgroundColor3 = Color3.fromRGB(25,25,35)
Popup.Visible = false
Popup.Parent = MainFrame

local popupCorner = Instance.new("UICorner")
popupCorner.CornerRadius = UDim.new(0,8)
popupCorner.Parent = Popup

local popupText = Instance.new("TextLabel")
popupText.Size = UDim2.new(1,-20,0,80)
popupText.Position = UDim2.new(0,10,0,10)
popupText.BackgroundTransparency = 1
popupText.Text = "Yakin mau hapus UI?"
popupText.TextColor3 = Color3.fromRGB(255,255,255)
popupText.TextWrapped = true
popupText.Font = Enum.Font.GothamBold
popupText.TextSize = 16
popupText.Parent = Popup

local yesButton = Instance.new("TextButton")
yesButton.Size = UDim2.new(0,100,0,30)
yesButton.Position = UDim2.new(0.5,-110,1,-40)
yesButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
yesButton.Text = "Yes"
yesButton.TextColor3 = Color3.new(1,1,1)
yesButton.Parent = Popup

local noButton = Instance.new("TextButton")
noButton.Size = UDim2.new(0,100,0,30)
noButton.Position = UDim2.new(0.5,10,1,-40)
noButton.BackgroundColor3 = Color3.fromRGB(255,100,100)
noButton.Text = "No"
noButton.TextColor3 = Color3.new(1,1,1)
noButton.Parent = Popup

CloseButton.MouseButton1Click:Connect(function()
    Popup.Visible = true
end)

yesButton.MouseButton1Click:Connect(function()
    ZiaanHub:Destroy()
end)
noButton.MouseButton1Click:Connect(function()
    Popup.Visible = false
end)

-- =========================
-- Content Area
-- =========================
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1,0,1,-30)
ContentArea.Position = UDim2.new(0,0,0,30)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- =========================
-- Sidebar Kiri
-- =========================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,150,1,0)
Sidebar.BackgroundColor3 = Color3.fromRGB(25,25,35)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = ContentArea

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0,8)
sidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0,5)
SidebarList.Parent = Sidebar

-- Fungsi buat tab sidebar
local function createSidebarTab(Name, iconID)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,0,0,40)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = Sidebar

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0,20,0,20)
    icon.Position = UDim2.new(0,10,0.5,-10)
    icon.BackgroundTransparency = 1
    icon.Image = iconID
    icon.Parent = button

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-40,1,0)
    label.Position = UDim2.new(0,35,0,0)
    label.BackgroundTransparency = 1
    label.Text = Name
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Transparency = 1
    stroke.Color = Color3.fromRGB(0,170,255)
    stroke.Parent = button

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,6)
    corner.Parent = button

    return button, stroke
end

-- Sidebar Tabs
local HomeButton, HomeStroke = createSidebarTab("Home", "rbxassetid://7072716642")
local MainButton, MainStroke = createSidebarTab("Main", "rbxassetid://7072716642")

-- =========================
-- Konten Tab
-- =========================
local RightContent = Instance.new("Frame")
RightContent.Size = UDim2.new(1,-155,1,0)
RightContent.Position = UDim2.new(0,155,0,0)
RightContent.BackgroundTransparency = 1
RightContent.Parent = ContentArea

-- Home Tab
local HomeTab = Instance.new("ScrollingFrame")
HomeTab.Size = UDim2.new(1,0,1,0)
HomeTab.BackgroundTransparency = 1
HomeTab.ScrollBarThickness = 3
HomeTab.Visible = true
HomeTab.Parent = RightContent

-- Tambahkan Banner Discord
local DiscordBanner = Instance.new("TextButton")
DiscordBanner.Size = UDim2.new(0,200,0,50)
DiscordBanner.Position = UDim2.new(0.5,-100,0,50)
DiscordBanner.Text = "ZiaanHub Discord\nJoin Discord"
DiscordBanner.TextColor3 = Color3.new(1,1,1)
DiscordBanner.TextWrapped = true
DiscordBanner.Font = Enum.Font.GothamBold
DiscordBanner.TextSize = 14
DiscordBanner.BackgroundColor3 = Color3.fromRGB(0,100,255)
DiscordBanner.Parent = HomeTab

DiscordBanner.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/yourlink") -- link invite discord
end)

-- Main Tab
local MainTab = Instance.new("ScrollingFrame")
MainTab.Size = UDim2.new(1,0,1,0)
MainTab.BackgroundTransparency = 1
MainTab.ScrollBarThickness = 3
MainTab.Visible = false
MainTab.Parent = RightContent

-- =========================
-- Slider Fitur Contoh
-- =========================
local function createSlider(name, min, max, default, parent, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -20, 0, 50)
    sliderFrame.Position = UDim2.new(0,10,0,50)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0,20)
    label.Position = UDim2.new(0,0,0,0)
    label.BackgroundTransparency = 1
    label.Text = name.." "..default
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1,0,0,10)
    sliderBar.Position = UDim2.new(0,0,0,30)
    sliderBar.BackgroundColor3 = Color3.fromRGB(50,50,60)
    sliderBar.Parent = sliderFrame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
    fill.Parent = sliderBar

    local dragging = false
    local function updateSlider(input)
        local pos = math.clamp(input.Position.X - sliderBar.AbsolutePosition.X,0,sliderBar.AbsoluteSize.X)
        fill.Size = UDim2.new(pos/sliderBar.AbsoluteSize.X,0,1,0)
        local value = math.floor(min + ((max-min)*(pos/sliderBar.AbsoluteSize.X)))
        label.Text = name.." "..value
        callback(value)
    end

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
        end
    end)

    sliderBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Contoh Slider
createSlider("WalkSpeed",16,200,16,MainTab,function(value)
    local char = player.Character
    if char then char:SetAttribute("SpeedMultiplier",value) end
end)
createSlider("DashLength",10,1000,10,MainTab,function(value)
    local char = player.Character
    if char then char:SetAttribute("DashLength",value) end
end)
createSlider("JumpPower",50,500,50,MainTab,function(value)
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = value
    end
end)

-- =========================
-- Tab Switching Logic
-- =========================
local function setActiveTab(tab)
    HomeTab.Visible = false
    MainTab.Visible = false
    HomeStroke.Transparency = 1
    MainStroke.Transparency = 1

    if tab == "Home" then
        HomeTab.Visible = true
        HomeStroke.Transparency = 0
    elseif tab == "Main" then
        MainTab.Visible = true
        MainStroke.Transparency = 0
    end
end

HomeButton.MouseButton1Click:Connect(function()
    setActiveTab("Home")
end)
MainButton.MouseButton1Click:Connect(function()
    setActiveTab("Main")
end)

-- =========================
-- Draggable MainFrame
-- =========================
local dragging = false
local dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- =========================
-- Auto Update Character Reference
-- =========================
player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
end)
