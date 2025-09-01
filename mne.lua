local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove existing GUI if any
local existingGui = playerGui:FindFirstChild("HiddenFischHub")
if existingGui then
	existingGui:Destroy()
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HiddenFischHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
screenGui.IgnoreGuiInset = true

-- Utility function for rounded corners
local function addUICorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = radius or UDim.new(0, 8)
	corner.Parent = parent
	return corner
end

-- Utility function for shadows (using ImageLabel)
local function addShadow(parent, size, position)
	local shadow = Instance.new("ImageLabel")
	shadow.Name = "Shadow"
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://1316045217" -- subtle shadow image
	shadow.ImageColor3 = Color3.new(0,0,0)
	shadow.ImageTransparency = 0.7
	shadow.Size = size
	shadow.Position = position
	shadow.ZIndex = parent.ZIndex - 1
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(10,10,118,118)
	shadow.Parent = parent
	return shadow
end

-- Colors
local colors = {
	bgMain = Color3.fromRGB(20,20,20),
	bgMainAlpha = 0.9,
	bgPanel = Color3.fromRGB(0,0,0),
	bgPanelAlpha = 0.7,
	accentGreen = Color3.fromRGB(0,100,70),
	accentRedStart = Color3.fromRGB(139,0,0),
	accentRedEnd = Color3.fromRGB(70,0,0),
	accentBlueStart = Color3.fromRGB(99,102,241),
	accentBlueEnd = Color3.fromRGB(129,140,248),
	textWhite = Color3.fromRGB(255,255,255),
	textGray = Color3.fromRGB(180,180,180),
	sidebarBg = Color3.fromRGB(15,15,15),
	sidebarBtnBg = Color3.fromRGB(0,0,0),
	sidebarBtnHoverBg = Color3.fromRGB(30,30,30),
	sidebarBtnText = Color3.fromRGB(150,150,150),
	sidebarBtnTextHover = Color3.fromRGB(255,255,255),
}

-- Fonts
local fontMain = Enum.Font.Gotham
local fontBold = Enum.Font.GothamBold

-- Main container frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 900, 0, 400)
mainFrame.Position = UDim2.new(0.5, -450, 0.5, -200)
mainFrame.BackgroundColor3 = colors.bgMain
mainFrame.BackgroundTransparency = 1 - colors.bgMainAlpha
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0,0)
mainFrame.Parent = screenGui
addUICorner(mainFrame, UDim.new(0, 16))
addShadow(mainFrame, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0))

-- Header bar
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30,30,30)
header.BackgroundTransparency = 0.3
header.BorderSizePixel = 0
header.Parent = mainFrame
addUICorner(header, UDim.new(0, 16))

-- Moon icon (Roblox asset id for moon icon)
local moonIcon = Instance.new("ImageLabel")
moonIcon.Name = "MoonIcon"
moonIcon.Size = UDim2.new(0, 24, 0, 24)
moonIcon.Position = UDim2.new(0, 10, 0, 8)
moonIcon.BackgroundTransparency = 1
moonIcon.Image = "rbxassetid://3926305904" -- moon icon (white)
moonIcon.ImageColor3 = colors.textWhite
moonIcon.Parent = header

-- Title text
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(0, 300, 0, 40)
titleLabel.Position = UDim2.new(0, 40, 0, 0)
titleLabel.TextColor3 = colors.textWhite
titleLabel.Font = fontBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.RichText = true
titleLabel.Text = '<b>Hidden - Fisch</b> <font size="14" color="#AAAAAA">.gg/hiddenrbx</font>'
titleLabel.Parent = header

-- Close button
local closeBtn = Instance.new("ImageButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -42, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
closeBtn.BorderSizePixel = 0
closeBtn.Image = "rbxassetid://3926307971" -- close icon
closeBtn.ImageColor3 = colors.textWhite
closeBtn.Parent = header
addUICorner(closeBtn, UDim.new(0, 6))

closeBtn.MouseEnter:Connect(function()
	TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(80,0,0)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
	TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50,50,50)}):Play()
end)
closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Left sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 64, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = colors.sidebarBg
sidebar.BackgroundTransparency = 0
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame
addUICorner(sidebar, UDim.new(0, 16))

-- Sidebar buttons container
local sidebarButtons = {}

-- Roblox asset IDs for sidebar icons (replace with your own asset IDs)
local sidebarAssetIds = {
	6031094677, -- Home icon
	6031094680, -- Left arrow icon
	6031094683, -- Right arrow icon
	6031094686, -- Location icon
	6031094689, -- User icon
	6031094692, -- Star icon
	6031094695, -- Bell icon
	6031094698, -- Gear icon
}

local function createSidebarIcon(assetId, posY)
	local btn = Instance.new("ImageButton")
	btn.Size = UDim2.new(0, 40, 0, 40)
	btn.Position = UDim2.new(0, 12, 0, posY)
	btn.BackgroundColor3 = colors.sidebarBtnBg
	btn.BackgroundTransparency = 0.3
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true
	btn.Image = "rbxassetid://"..tostring(assetId)
	btn.ScaleType = Enum.ScaleType.Fit
	btn.Parent = sidebar
	addUICorner(btn, UDim.new(0, 8))
	
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
		TweenService:Create(btn, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
	end)
	
	return btn
end

for i, assetId in ipairs(sidebarAssetIds) do
	local yPos = (i-1)*48 + 8
	local btn = createSidebarIcon(assetId, yPos)
	table.insert(sidebarButtons, btn)
end

-- Small user avatar bottom
local avatarSmall = Instance.new("ImageButton")
avatarSmall.Size = UDim2.new(0, 40, 0, 40)
avatarSmall.Position = UDim2.new(0, 12, 1, -48)
avatarSmall.BackgroundColor3 = colors.sidebarBtnBg
avatarSmall.BackgroundTransparency = 0.3
avatarSmall.BorderSizePixel = 0
avatarSmall.AutoButtonColor = true
avatarSmall.Parent = sidebar
addUICorner(avatarSmall, UDim.new(0, 8))
avatarSmall.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=48&h=48"

avatarSmall.MouseEnter:Connect(function()
	TweenService:Create(avatarSmall, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
end)
avatarSmall.MouseLeave:Connect(function()
	TweenService:Create(avatarSmall, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
end)

-- Main content container
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -64, 1, -40)
content.Position = UDim2.new(0, 64, 0, 40)
content.BackgroundTransparency = 1
content.Parent = mainFrame

-- User info bar
local userInfo = Instance.new("Frame")
userInfo.Name = "UserInfo"
userInfo.Size = UDim2.new(1, 0, 0, 60)
userInfo.Position = UDim2.new(0, 0, 0, 0)
userInfo.BackgroundColor3 = Color3.new(1,1,1)
userInfo.BackgroundTransparency = 0.9
userInfo.BorderSizePixel = 0
userInfo.Parent = content
addUICorner(userInfo, UDim.new(0, 8))

-- User avatar large
local avatarLarge = Instance.new("ImageLabel")
avatarLarge.Name = "AvatarLarge"
avatarLarge.Size = UDim2.new(0, 48, 0, 48)
avatarLarge.Position = UDim2.new(0, 8, 0, 6)
avatarLarge.BackgroundTransparency = 1
avatarLarge.Parent = userInfo
avatarLarge.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=48&h=48"
addUICorner(avatarLarge, UDim.new(0, 8))

-- User text
local userNameLabel = Instance.new("TextLabel")
userNameLabel.Name = "UserName"
userNameLabel.Size = UDim2.new(0, 300, 0, 24)
userNameLabel.Position = UDim2.new(0, 64, 0, 8)
userNameLabel.BackgroundTransparency = 1
userNameLabel.TextColor3 = colors.textWhite
userNameLabel.Font = fontBold
userNameLabel.TextSize = 16
userNameLabel.TextXAlignment = Enum.TextXAlignment.Left
userNameLabel.Text = "Hello, "..player.Name
userNameLabel.Parent = userInfo

local userSubLabel = Instance.new("TextLabel")
userSubLabel.Name = "UserSub"
userSubLabel.Size = UDim2.new(0, 300, 0, 16)
userSubLabel.Position = UDim2.new(0, 64, 0, 32)
userSubLabel.BackgroundTransparency = 1
userSubLabel.TextColor3 = Color3.fromRGB(180,180,180)
userSubLabel.Font = fontMain
userSubLabel.TextSize = 12
userSubLabel.TextXAlignment = Enum.TextXAlignment.Left
userSubLabel.Text = player.Name.." - Hidden - Fisch"
userSubLabel.Parent = userInfo

-- Lower panels container
local lowerPanels = Instance.new("Frame")
lowerPanels.Name = "LowerPanels"
lowerPanels.Size = UDim2.new(1, 0, 1, -70)
lowerPanels.Position = UDim2.new(0, 0, 0, 70)
lowerPanels.BackgroundTransparency = 1
lowerPanels.Parent = content

-- Left side panels container
local leftPanels = Instance.new("Frame")
leftPanels.Name = "LeftPanels"
leftPanels.Size = UDim2.new(0.6, 0, 1, 0)
leftPanels.Position = UDim2.new(0, 0, 0, 0)
leftPanels.BackgroundTransparency = 1
leftPanels.Parent = lowerPanels

-- Server panel
local serverPanel = Instance.new("Frame")
serverPanel.Name = "ServerPanel"
serverPanel.Size = UDim2.new(1, 0, 0, 180)
serverPanel.Position = UDim2.new(0, 0, 0, 0)
serverPanel.BackgroundColor3 = colors.bgPanel
serverPanel.BackgroundTransparency = 1 - colors.bgPanelAlpha
serverPanel.BorderSizePixel = 0
serverPanel.Parent = leftPanels
addUICorner(serverPanel, UDim.new(0, 8))

-- Server title
local serverTitle = Instance.new("TextLabel")
serverTitle.Name = "ServerTitle"
serverTitle.Size = UDim2.new(0, 100, 0, 24)
serverTitle.Position = UDim2.new(0, 8, 0, 8)
serverTitle.BackgroundTransparency = 1
serverTitle.TextColor3 = colors.textWhite
serverTitle.Font = fontBold
serverTitle.TextSize = 14
serverTitle.TextXAlignment = Enum.TextXAlignment.Left
serverTitle.Text = "Server"
serverTitle.Parent = serverPanel

-- Server subtitle
local serverSub = Instance.new("TextLabel")
serverSub.Name = "ServerSub"
serverSub.Size = UDim2.new(0.9, 0, 0, 16)
serverSub.Position = UDim2.new(0, 8, 0, 32)
serverSub.BackgroundTransparency = 1
serverSub.TextColor3 = colors.textGray
serverSub.Font = fontMain
serverSub.TextSize = 10
serverSub.TextXAlignment = Enum.TextXAlignment.Left
serverSub.Text = "Information on the session you're currently in"
serverSub.Parent = serverPanel

-- Server grid container
local serverGrid = Instance.new("Frame")
serverGrid.Name = "ServerGrid"
serverGrid.Size = UDim2.new(1, -16, 1, -60)
serverGrid.Position = UDim2.new(0, 8, 0, 60)
serverGrid.BackgroundTransparency = 1
serverGrid.Parent = serverPanel

-- Function to create server info box
local function createServerBox(parent, pos, title, subtitle, bgColor)
	local box = Instance.new("TextButton")
	box.Size = UDim2.new(0.48, 0, 0, 40)
	box.Position = pos
	box.BackgroundColor3 = bgColor
	box.BorderSizePixel = 0
	box.AutoButtonColor = false
	box.Parent = parent
	addUICorner(box, UDim.new(0, 6))
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -8, 0, 16)
	titleLabel.Position = UDim2.new(0, 4, 0, 4)
	titleLabel.BackgroundTransparency = 1
	titleLabel.TextColor3 = colors.textWhite
	titleLabel.Font = fontBold
	titleLabel.TextSize = 12
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Text = title
	titleLabel.Parent = box
	
	local subLabel = Instance.new("TextLabel")
	subLabel.Size = UDim2.new(1, -8, 0, 16)
	subLabel.Position = UDim2.new(0, 4, 0, 20)
	subLabel.BackgroundTransparency = 1
	subLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	subLabel.Font = fontMain
	subLabel.TextSize = 10
	subLabel.TextXAlignment = Enum.TextXAlignment.Left
	subLabel.Text = subtitle
	subLabel.Parent = box
	
	-- Hover animation
	box.MouseEnter:Connect(function()
		TweenService:Create(box, TweenInfo.new(0.3), {BackgroundColor3 = colors.accentGreen}):Play()
	end)
	box.MouseLeave:Connect(function()
		TweenService:Create(box, TweenInfo.new(0.3), {BackgroundColor3 = bgColor}):Play()
	end)
	
	return box
end

createServerBox(serverGrid, UDim2.new(0, 0, 0, 0), "Players", "0 playing", Color3.fromRGB(50,50,50))
createServerBox(serverGrid, UDim2.new(0.52, 0, 0, 0), "Maximum Players", "15 players can join this server", Color3.fromRGB(50,50,50))
createServerBox(serverGrid, UDim2.new(0, 0, 0, 44), "Latency", "174 ms", Color3.fromRGB(50,50,50))
createServerBox(serverGrid, UDim2.new(0.52, 0, 0, 44), "Server Region", "US", Color3.fromRGB(50,50,50))
createServerBox(serverGrid, UDim2.new(0, 0, 0, 88), "In server for", "00:00:20", colors.accentGreen)
local joinScriptBox = createServerBox(serverGrid, UDim2.new(0.52, 0, 0, 88), "Join Script", "Tap to copy join script", Color3.fromRGB(30,30,30))

-- Join Script click copies text to clipboard if supported
joinScriptBox.MouseButton1Click:Connect(function()
	local joinScriptText = "Tap to copy join script"
	if setclipboard then
		setclipboard(joinScriptText)
		print("Join script copied to clipboard!")
	else
		print("Clipboard not supported in this executor.")
	end
end)

-- Right top panel (Wave)
local rightTopPanel = Instance.new("Frame")
rightTopPanel.Name = "WavePanel"
rightTopPanel.Size = UDim2.new(0.35, 0, 0, 100)
rightTopPanel.Position = UDim2.new(0.62, 0, 0, 0)
rightTopPanel.BackgroundColor3 = colors.accentRedStart
rightTopPanel.BackgroundTransparency = 0
rightTopPanel.BorderSizePixel = 0
rightTopPanel.Parent = lowerPanels
addUICorner(rightTopPanel, UDim.new(0, 8))

-- Gradient for Wave panel
local waveGradient = Instance.new("UIGradient")
waveGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, colors.accentRedStart),
	ColorSequenceKeypoint.new(1, colors.accentRedEnd)
}
waveGradient.Rotation = 0
waveGradient.Parent = rightTopPanel

local waveTitle = Instance.new("TextLabel")
waveTitle.Name = "WaveTitle"
waveTitle.Size = UDim2.new(0, 100, 0, 24)
waveTitle.Position = UDim2.new(0, 8, 0, 8)
waveTitle.BackgroundTransparency = 1
waveTitle.TextColor3 = colors.textWhite
waveTitle.Font = fontBold
waveTitle.TextSize = 14
waveTitle.TextXAlignment = Enum.TextXAlignment.Left
waveTitle.Text = "Wave"
waveTitle.Parent = rightTopPanel

local waveDesc = Instance.new("TextLabel")
waveDesc.Name = "WaveDesc"
waveDesc.Size = UDim2.new(0.9, 0, 0, 40)
waveDesc.Position = UDim2.new(0, 8, 0, 32)
waveDesc.BackgroundTransparency = 1
waveDesc.TextColor3 = colors.textWhite
waveDesc.Font = fontMain
waveDesc.TextSize = 12
waveDesc.TextXAlignment = Enum.TextXAlignment.Left
waveDesc.Text = "Your executor seems to support this script."
waveDesc.Parent = rightTopPanel

-- Bottom panels container
local bottomPanels = Instance.new("Frame")
bottomPanels.Name = "BottomPanels"
bottomPanels.Size = UDim2.new(1, 0, 1, -110)
bottomPanels.Position = UDim2.new(0, 0, 0, 110)
bottomPanels.BackgroundTransparency = 1
bottomPanels.Parent = lowerPanels

-- Discord panel (gradient blue)
local discordPanel = Instance.new("TextButton")
discordPanel.Name = "DiscordPanel"
discordPanel.Size = UDim2.new(0.6, 0, 1, 0)
discordPanel.Position = UDim2.new(0, 0, 0, 0)
discordPanel.BackgroundColor3 = colors.accentBlueStart
discordPanel.BorderSizePixel = 0
discordPanel.Parent = bottomPanels
addUICorner(discordPanel, UDim.new(0, 8))
discordPanel.AutoButtonColor = false

local discordGradient = Instance.new("UIGradient")
discordGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, colors.accentBlueStart),
	ColorSequenceKeypoint.new(1, colors.accentBlueEnd)
}
discordGradient.Rotation = 0
discordGradient.Parent = discordPanel

local discordTitle = Instance.new("TextLabel")
discordTitle.Name = "DiscordTitle"
discordTitle.Size = UDim2.new(0, 100, 0, 24)
discordTitle.Position = UDim2.new(0, 8, 0, 8)
discordTitle.BackgroundTransparency = 1
discordTitle.TextColor3 = colors.textWhite
discordTitle.Font = fontBold
discordTitle.TextSize = 14
discordTitle.TextXAlignment = Enum.TextXAlignment.Left
discordTitle.Text = "Discord"
discordTitle.Parent = discordPanel

local discordDesc = Instance.new("TextLabel")
discordDesc.Name = "DiscordDesc"
discordDesc.Size = UDim2.new(0.9, 0, 0, 40)
discordDesc.Position = UDim2.new(0, 8, 0, 32)
discordDesc.BackgroundTransparency = 1
discordDesc.TextColor3 = colors.textWhite
discordDesc.Font = fontMain
discordDesc.TextSize = 12
discordDesc.TextXAlignment = Enum.TextXAlignment.Left
discordDesc.Text = "Tap to join the Discord Server"
discordDesc.Parent = discordPanel

discordPanel.MouseEnter:Connect(function()
	TweenService:Create(discordPanel, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
end)
discordPanel.MouseLeave:Connect(function()
	TweenService:Create(discordPanel, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
end)
discordPanel.MouseButton1Click:Connect(function()
	-- Add your Discord invite link or action here
	print("Discord panel clicked")
end)

-- Friends panel
local friendsPanel = Instance.new("Frame")
friendsPanel.Name = "FriendsPanel"
friendsPanel.Size = UDim2.new(0.35, 0, 1, 0)
friendsPanel.Position = UDim2.new(0.62, 0, 0, 0)
friendsPanel.BackgroundColor3 = colors.bgPanel
friendsPanel.BackgroundTransparency = 1 - colors.bgPanelAlpha
friendsPanel.BorderSizePixel = 0
friendsPanel.Parent = bottomPanels
addUICorner(friendsPanel, UDim.new(0, 8))

local friendsTitle = Instance.new("TextLabel")
friendsTitle.Name = "FriendsTitle"
friendsTitle.Size = UDim2.new(0, 100, 0, 24)
friendsTitle.Position = UDim2.new(0, 8, 0, 8)
friendsTitle.BackgroundTransparency = 1
friendsTitle.TextColor3 = colors.textWhite
friendsTitle.Font = fontBold
friendsTitle.TextSize = 14
friendsTitle.TextXAlignment = Enum.TextXAlignment.Left
friendsTitle.Text = "Friends"
friendsTitle.Parent = friendsPanel

local friendsDesc = Instance.new("TextLabel")
friendsDesc.Name = "FriendsDesc"
friendsDesc.Size = UDim2.new(0.9, 0, 0, 16)
friendsDesc.Position = UDim2.new(0, 8, 0, 32)
friendsDesc.BackgroundTransparency = 1
friendsDesc.TextColor3 = colors.textGray
friendsDesc.Font = fontMain
friendsDesc.TextSize = 10
friendsDesc.TextXAlignment = Enum.TextXAlignment.Left
friendsDesc.Text = "Find out what your friends are currently doing"
friendsDesc.Parent = friendsPanel

-- Friends grid container
local friendsGrid = Instance.new("Frame")
friendsGrid.Name = "FriendsGrid"
friendsGrid.Size = UDim2.new(1, -16, 1, -60)
friendsGrid.Position = UDim2.new(0, 8, 0, 60)
friendsGrid.BackgroundTransparency = 1
friendsGrid.Parent = friendsPanel

-- Function to create friend info box
local function createFriendBox(parent, pos, title, subtitle, bgColor)
	local box = Instance.new("Frame")
	box.Size = UDim2.new(0.48, 0, 0, 40)
	box.Position = pos
	box.BackgroundColor3 = bgColor
	box.BorderSizePixel = 0
	box.Parent = parent
	addUICorner(box, UDim.new(0, 6))
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -8, 0, 16)
	titleLabel.Position = UDim2.new(0, 4, 0, 4)
	titleLabel.BackgroundTransparency = 1
	titleLabel.TextColor3 = colors.textWhite
	titleLabel.Font = fontBold
	titleLabel.TextSize = 12
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Text = title
	titleLabel.Parent = box
	
	local subLabel = Instance.new("TextLabel")
	subLabel.Size = UDim2.new(1, -8, 0, 16)
	subLabel.Position = UDim2.new(0, 4, 0, 20)
	subLabel.BackgroundTransparency = 1
	subLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	subLabel.Font = fontMain
	subLabel.TextSize = 10
	subLabel.TextXAlignment = Enum.TextXAlignment.Left
	subLabel.Text = subtitle
	subLabel.Parent = box
	
	return box
end

createFriendBox(friendsGrid, UDim2.new(0, 0, 0, 0), "In Server", "no friends", Color3.fromRGB(50,50,50))
createFriendBox(friendsGrid, UDim2.new(0.52, 0, 0, 0), "Offline", "28 friends", Color3.fromRGB(50,50,50))
createFriendBox(friendsGrid, UDim2.new(0, 0, 0, 44), "Online", "2 friends", Color3.fromRGB(30,30,30))
createFriendBox(friendsGrid, UDim2.new(0.52, 0, 0, 44), "All", "100 Friends", Color3.fromRGB(30,30,30))

-- Animate mainFrame fade in and scale
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundTransparency = 1

TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 900, 0, 400),
	BackgroundTransparency = 1 - colors.bgMainAlpha,
}):Play()

-- Make GUI draggable by header
local dragging = false
local dragInput, dragStart, startPos

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

header.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		mainFrame.Position = UDim2.new(
			math.clamp(startPos.X.Scale, 0, 1),
			math.clamp(startPos.X.Offset + delta.X, 0, workspace.CurrentCamera.ViewportSize.X - mainFrame.AbsoluteSize.X),
			math.clamp(startPos.Y.Scale, 0, 1),
			math.clamp(startPos.Y.Offset + delta.Y, 0, workspace.CurrentCamera.ViewportSize.Y - mainFrame.AbsoluteSize.Y)
		)
	end
end)

return screenGui
