local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Lokasi Teleport (sesuaikan dengan game Anda)
local locations = {
    ["Toko"] = CFrame.new(69.8056411743164, 10.32421588897705, 133.9318084716797),
    ["Senjata"] = CFrame.new(50, 5, 0),
    ["Trait"] = CFrame.new(100, 5, 0),
    ["Lobby"] = CFrame.new(-50, 5, 0),
    ["Inventory"] = CFrame.new(0, 5, 100),
}

-- UI Creation
local HubGui = Instance.new("ScreenGui")
HubGui.Name = "HuntyHub"
HubGui.ResetOnSpawn = false
HubGui.Parent = playerGui

-- Logo Toggle Button
local LogoButton = Instance.new("ImageButton")
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Position = UDim2.new(0, 10, 0.5, -25)
LogoButton.Image = "rbxassetid://134650706258031" -- Ganti dengan asset ID logo Anda
LogoButton.BackgroundTransparency = 1
LogoButton.Parent = HubGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = HubGui

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "HuntyHub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 100, 1, -30)
Sidebar.Position = UDim2.new(0, 0, 0, 30)
Sidebar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -100, 1, -30)
ContentFrame.Position = UDim2.new(0, 100, 0, 30)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentFrame.BorderSizePixel = 0
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Drag Functionality
local dragging, dragInput, dragStart, startPos

local function update(input)
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
        update(input)
    end
end)

-- Toggle UI
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Tab Management
local function clearContent()
    for _, child in ipairs(ContentFrame:GetChildren()) do
        if child:IsA("Frame") or child:IsA("ScrollingFrame") then
            child:Destroy()
        end
    end
end

local function createTab(name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Parent = Sidebar
    
    btn.MouseButton1Click:Connect(function()
        clearContent()
        callback()
    end)
    
    return btn
end

-- Home Tab
local homeTab = createTab("Home", 0, function()
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.ScrollBarThickness = 5
    container.CanvasSize = UDim2.new(0, 0, 0, 200)
    container.Parent = ContentFrame
    
    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.Size = UDim2.new(1, -20, 0, 100)
    welcomeLabel.Position = UDim2.new(0, 10, 0, 10)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.Text = "Selamat datang di HuntyHub!\n\nScript resmi buatan Developer Hunty Zombie."
    welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeLabel.Font = Enum.Font.GothamSemibold
    welcomeLabel.TextSize = 18
    welcomeLabel.TextWrapped = true
    welcomeLabel.Parent = container
    
    local featuresLabel = Instance.new("TextLabel")
    featuresLabel.Size = UDim2.new(1, -20, 0, 80)
    featuresLabel.Position = UDim2.new(0, 10, 0, 120)
    featuresLabel.BackgroundTransparency = 1
    featuresLabel.Text = "Fitur:\n- Teleport ke berbagai lokasi\n- UI yang dapat digerakkan\n- Tampilan yang user-friendly"
    featuresLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    featuresLabel.Font = Enum.Font.Gotham
    featuresLabel.TextSize = 14
    featuresLabel.TextWrapped = true
    featuresLabel.Parent = container
end)

-- Teleport Tab
local teleportTab = createTab("Teleport", 40, function()
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.ScrollBarThickness = 5
    container.CanvasSize = UDim2.new(0, 0, 0, 250)
    container.Parent = ContentFrame
    
    local instruction = Instance.new("TextLabel")
    instruction.Size = UDim2.new(1, -20, 0, 60)
    instruction.Position = UDim2.new(0, 10, 0, 10)
    instruction.BackgroundTransparency = 1
    instruction.Text = "Pilih lokasi dan tekan tombol teleport:"
    instruction.TextColor3 = Color3.fromRGB(255, 255, 255)
    instruction.Font = Enum.Font.Gotham
    instruction.TextSize = 16
    instruction.TextWrapped = true
    instruction.Parent = container
    
    local yOffset = 80
    for locationName, locationCFrame in pairs(locations) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 40)
        button.Position = UDim2.new(0, 10, 0, yOffset)
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        button.BorderSizePixel = 0
        button.Text = locationName
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 16
        button.Parent = container
        
        button.MouseButton1Click:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = locationCFrame
            else
                warn("Karakter atau HumanoidRootPart tidak ditemukan!")
            end
        end)
        
        yOffset = yOffset + 50
    end
end)

-- Initialize with Home tab
homeTab:GetPropertyChangedSignal("BackgroundColor3"):Wait()
clearContent()
homeTab.MouseButton1Click:Connect(function() end)()

-- Make logo slightly transparent when not hovered
LogoButton.MouseEnter:Connect(function()
    TweenService:Create(LogoButton, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
end)

LogoButton.MouseLeave:Connect(function()
    TweenService:Create(LogoButton, TweenInfo.new(0.2), {ImageTransparency = 0.3}):Play()
end)

-- Initial transparency
LogoButton.ImageTransparency = 0.3

print("HuntyHub loaded successfully!")
