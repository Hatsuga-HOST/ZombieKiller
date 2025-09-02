--[[ 
HuntyHub by Developer Resmi Hunty Zombie
Features:
- Show/Hide UI pakai logo
- 2 Tab (Home & Teleport)
- Teleport ke 5 lokasi
- Drag & Move UI
--]]

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- 🟢 Lokasi Teleport (edit sesuai game)
local locations = {
    ["Toko"] = Vector3.new(69.8056411743164, 10.32421588897705, 133.9318084716797),
    ["Senjata"] = Vector3.new(50, 5, 0),
    ["Trait"] = Vector3.new(100, 5, 0),
    ["Lobby"] = Vector3.new(-50, 5, 0),
    ["Inventory"] = Vector3.new(0, 5, 100),
}

-- default lokasi (Toko)
local selectedLocation = "Toko"

-- 🔘 Logo Toggle Button
local HubGui = Instance.new("ScreenGui")
HubGui.Name = "HuntyHub"
HubGui.ResetOnSpawn = false
HubGui.Parent = playerGui

local LogoButton = Instance.new("ImageButton")
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Position = UDim2.new(0, 100, 0, 100)
LogoButton.Image = "rbxassetid://90198357725559" -- ganti asset id logo
LogoButton.BackgroundTransparency = 1
LogoButton.Parent = HubGui

-- Frame Utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
MainFrame.Visible = false
MainFrame.Parent = HubGui

-- Bisa drag frame
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
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
MainFrame.InputChanged:Connect(function(input)
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

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 100, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(45,45,45)
Sidebar.Parent = MainFrame

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -100, 1, 0)
ContentFrame.Position = UDim2.new(0, 100, 0, 0)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
ContentFrame.Parent = MainFrame

-- Fungsi ganti tab
local function clearContent()
    for _, child in pairs(ContentFrame:GetChildren()) do
        child:Destroy()
    end
end

-- Tombol Tab
local Tabs = {}
local function createTab(name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Parent = Sidebar
    btn.MouseButton1Click:Connect(callback)
    Tabs[name] = btn
end

-- Tab Home
createTab("Home", 0, function()
    clearContent()
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, -20)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.TextWrapped = true
    label.Text = "Selamat datang di HuntyHub!\n\nScript resmi buatan Developer Hunty Zombie."
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.Parent = ContentFrame
end)

-- Tab Teleport
createTab("Teleport", 45, function()
    clearContent()
    
    local instruksi = Instance.new("TextLabel")
    instruksi.Size = UDim2.new(1, -20, 0, 60)
    instruksi.Position = UDim2.new(0, 10, 0, 10)
    instruksi.BackgroundTransparency = 1
    instruksi.TextWrapped = true
    instruksi.Text = "Cara pakai: Pilih lokasi dengan tombol di bawah, lalu tekan 'Running the Teleportation Feature'."
    instruksi.TextColor3 = Color3.fromRGB(255,255,255)
    instruksi.Font = Enum.Font.Gotham
    instruksi.TextSize = 16
    instruksi.Parent = ContentFrame
    
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(1, -20, 0, 40)
    dropdown.Position = UDim2.new(0, 10, 0, 80)
    dropdown.BackgroundColor3 = Color3.fromRGB(70,70,70)
    dropdown.Text = "Selected: "..selectedLocation
    dropdown.TextColor3 = Color3.fromRGB(255,255,255)
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 18
    dropdown.Parent = ContentFrame
    
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(1, -20, 0, 200)
    optionsFrame.Position = UDim2.new(0, 10, 0, 130)
    optionsFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
    optionsFrame.Visible = false
    optionsFrame.Parent = ContentFrame
    
    local y = 0
    for name, pos in pairs(locations) do
        local opt = Instance.new("TextButton")
        opt.Size = UDim2.new(1, -10, 0, 35)
        opt.Position = UDim2.new(0, 5, 0, y)
        opt.BackgroundColor3 = Color3.fromRGB(80,80,80)
        opt.Text = name
        opt.TextColor3 = Color3.fromRGB(255,255,255)
        opt.Font = Enum.Font.Gotham
        opt.TextSize = 16
        opt.Parent = optionsFrame
        opt.MouseButton1Click:Connect(function()
            selectedLocation = name
            dropdown.Text = "Selected: "..name
            optionsFrame.Visible = false
        end)
        y = y + 40
    end
    
    dropdown.MouseButton1Click:Connect(function()
        optionsFrame.Visible = not optionsFrame.Visible
    end)
    
    local runBtn = Instance.new("TextButton")
    runBtn.Size = UDim2.new(1, -20, 0, 40)
    runBtn.Position = UDim2.new(0, 10, 1, -50)
    runBtn.BackgroundColor3 = Color3.fromRGB(100,0,0)
    runBtn.Text = "Running the Teleportation Feature"
    runBtn.TextColor3 = Color3.fromRGB(255,255,255)
    runBtn.Font = Enum.Font.GothamBold
    runBtn.TextSize = 16
    runBtn.Parent = ContentFrame
    
    runBtn.MouseButton1Click:Connect(function()
        if selectedLocation and locations[selectedLocation] then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(locations[selectedLocation])
            else
                runBtn.Text = "Character not found!"
            end
        else
            runBtn.Text = "Please select a location first!"
        end
    end)
end)

-- ✅ Default buka Tab Home
if Tabs["Home"] then
    Tabs["Home"]:Activate()
end
