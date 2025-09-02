-- Roblox GUI Hub Script
-- Key: 123key123

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variabel Global
local mainGui
local keyFrame
local hubFrame
local sidebarFrame
local mainFrame
local showIcon
local isAuthenticated = false
local dragConnection

-- Fungsi untuk membuat tween animasi
local function createTween(object, properties, duration, easingStyle)
    duration = duration or 0.3
    easingStyle = easingStyle or Enum.EasingStyle.Quart
    local tweenInfo = TweenInfo.new(duration, easingStyle, Enum.EasingDirection.Out)
    return TweenService:Create(object, tweenInfo, properties)
end

-- Fungsi untuk membuat frame dengan corner radius
local function createFrameWithCorner(parent, properties)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    
    -- Apply properties
    for prop, value in pairs(properties) do
        frame[prop] = value
    end
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    return frame
end

-- Fungsi untuk membuat tombol dengan hover effect
local function createButton(parent, properties, hoverScale)
    local button = Instance.new("TextButton")
    button.Parent = parent
    hoverScale = hoverScale or 1.05
    
    -- Apply properties
    for prop, value in pairs(properties) do
        button[prop] = value
    end
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        createTween(button, {Size = button.Size * hoverScale}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        createTween(button, {Size = button.Size / hoverScale}):Play()
    end)
    
    return button
end

-- Fungsi untuk membuat sistem key
local function createKeySystem()
    keyFrame = createFrameWithCorner(mainGui, {
        Name = "KeyFrame",
        Size = UDim2.new(0, 400, 0, 250),
        Position = UDim2.new(0.5, -200, 0.5, -125),
        BackgroundColor3 = Color3.fromRGB(25, 25, 35),
        BorderSizePixel = 0,
        Active = true,
        Draggable = true
    })
    
    -- Shadow effect
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Parent = keyFrame
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://00"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(12, 12, 118, 118)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.ZIndex = keyFrame.ZIndex - 1
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Parent = keyFrame
    title.Size = UDim2.new(1, -40, 0, 50)
    title.Position = UDim2.new(0, 20, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "Authentication Required"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    
    -- Key input
    local keyInput = Instance.new("TextBox")
    keyInput.Parent = keyFrame
    keyInput.Size = UDim2.new(1, -60, 0, 40)
    keyInput.Position = UDim2.new(0, 30, 0, 90)
    keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    keyInput.BorderSizePixel = 0
    keyInput.Text = ""
    keyInput.PlaceholderText = "Enter your key..."
    keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    keyInput.TextScaled = true
    keyInput.Font = Enum.Font.Gotham
    keyInput.ClearTextOnFocus = false
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 8)
    keyCorner.Parent = keyInput
    
    -- Submit button
    local submitBtn = createButton(keyFrame, {
        Size = UDim2.new(0, 120, 0, 35),
        Position = UDim2.new(0.5, -60, 0, 150),
        BackgroundColor3 = Color3.fromRGB(0, 162, 255),
        Text = "Submit",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    })
    
    -- Status label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Parent = keyFrame
    statusLabel.Size = UDim2.new(1, -40, 0, 25)
    statusLabel.Position = UDim2.new(0, 20, 0, 200)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    
    -- Submit function
    local function submitKey()
        local enteredKey = keyInput.Text
        if enteredKey == "123key123" then
            statusLabel.Text = "Access Granted!"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            wait(1)
            isAuthenticated = true
            createTween(keyFrame, {Position = UDim2.new(0.5, -200, -1, 0)}, 0.5):Play()
            wait(0.5)
            keyFrame:Destroy()
            createMainHub()
        else
            statusLabel.Text = "Invalid Key!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            createTween(keyFrame, {Rotation = 5}, 0.1):Play()
            wait(0.1)
            createTween(keyFrame, {Rotation = -5}, 0.1):Play()
            wait(0.1)
            createTween(keyFrame, {Rotation = 0}, 0.1):Play()
        end
    end
    
    submitBtn.MouseButton1Click:Connect(submitKey)
    keyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            submitKey()
        end
    end)
    
    -- Animasi masuk
    keyFrame.Position = UDim2.new(0.5, -200, -1, 0)
    createTween(keyFrame, {Position = UDim2.new(0.5, -200, 0.5, -125)}, 0.8, Enum.EasingStyle.Back):Play()
end

-- Fungsi untuk membuat icon show/hide
local function createShowIcon()
    showIcon = Instance.new("ImageButton")
    showIcon.Name = "ShowIcon"
    showIcon.Parent = mainGui
    showIcon.Size = UDim2.new(0, 60, 0, 60)
    showIcon.Position = UDim2.new(0, 20, 0, 20)
    showIcon.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    showIcon.BorderSizePixel = 0
    showIcon.Image = "rbxassetid://3926305904" -- Icon eye
    showIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    showIcon.Visible = false
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 15)
    iconCorner.Parent = showIcon
    
    -- Shadow
    local iconShadow = Instance.new("ImageLabel")
    iconShadow.Name = "Shadow"
    iconShadow.Parent = showIcon
    iconShadow.BackgroundTransparency = 1
    iconShadow.Image = "rbxasset://textures/ui/Controls/DropShadow.png"
    iconShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    iconShadow.ImageTransparency = 0.7
    iconShadow.ScaleType = Enum.ScaleType.Slice
    iconShadow.SliceCenter = Rect.new(12, 12, 118, 118)
    iconShadow.Size = UDim2.new(1, 20, 1, 20)
    iconShadow.Position = UDim2.new(0, -10, 0, -10)
    iconShadow.ZIndex = showIcon.ZIndex - 1
    
    -- Hover effect
    showIcon.MouseEnter:Connect(function()
        createTween(showIcon, {Size = UDim2.new(0, 65, 0, 65)}):Play()
    end)
    
    showIcon.MouseLeave:Connect(function()
        createTween(showIcon, {Size = UDim2.new(0, 60, 0, 60)}):Play()
    end)
end

-- Fungsi untuk membuat tab sidebar
local function createSidebarTab(parent, name, icon, position, onClick)
    local tab = createButton(parent, {
        Size = UDim2.new(1, -20, 0, 45),
        Position = UDim2.new(0, 10, 0, position),
        BackgroundColor3 = Color3.fromRGB(40, 40, 55),
        Text = "",
        BorderSizePixel = 0
    }, 1.02)
    
    -- Icon
    local tabIcon = Instance.new("ImageLabel")
    tabIcon.Parent = tab
    tabIcon.Size = UDim2.new(0, 24, 0, 24)
    tabIcon.Position = UDim2.new(0, 15, 0.5, -12)
    tabIcon.BackgroundTransparency = 1
    tabIcon.Image = "rbxassetid://" .. icon
    tabIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
    
    -- Text
    local tabText = Instance.new("TextLabel")
    tabText.Parent = tab
    tabText.Size = UDim2.new(1, -55, 1, 0)
    tabText.Position = UDim2.new(0, 50, 0, 0)
    tabText.BackgroundTransparency = 1
    tabText.Text = name
    tabText.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabText.TextScaled = true
    tabText.Font = Enum.Font.Gotham
    tabText.TextXAlignment = Enum.TextXAlignment.Left
    
    tab.MouseButton1Click:Connect(onClick)
    
    return tab, tabIcon, tabText
end

-- Fungsi untuk membuat walkspeed slider
local function createWalkspeedSlider(parent)
    local sliderFrame = createFrameWithCorner(parent, {
        Size = UDim2.new(1, -40, 0, 80),
        Position = UDim2.new(0, 20, 0, 20),
        BackgroundColor3 = Color3.fromRGB(35, 35, 50),
        BorderSizePixel = 0
    })
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Parent = sliderFrame
    title.Size = UDim2.new(1, -20, 0, 25)
    title.Position = UDim2.new(0, 10, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "Walkspeed Control"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Slider background
    local sliderBg = createFrameWithCorner(sliderFrame, {
        Size = UDim2.new(1, -40, 0, 8),
        Position = UDim2.new(0, 20, 0, 45),
        BackgroundColor3 = Color3.fromRGB(20, 20, 30),
        BorderSizePixel = 0
    })
    
    -- Slider fill
    local sliderFill = createFrameWithCorner(sliderBg, {
        Size = UDim2.new(0, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(0, 162, 255),
        BorderSizePixel = 0
    })
    
    -- Slider handle
    local sliderHandle = Instance.new("TextButton")
    sliderHandle.Parent = sliderBg
    sliderHandle.Size = UDim2.new(0, 20, 0, 20)
    sliderHandle.Position = UDim2.new(0, -10, 0.5, -10)
    sliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderHandle.BorderSizePixel = 0
    sliderHandle.Text = ""
    
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(0.5, 0)
    handleCorner.Parent = sliderHandle
    
    -- Value label
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Parent = sliderFrame
    valueLabel.Size = UDim2.new(0, 60, 0, 20)
    valueLabel.Position = UDim2.new(1, -70, 0, 57)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = "16"
    valueLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
    valueLabel.TextScaled = true
    valueLabel.Font = Enum.Font.GothamBold
    
    -- Slider functionality
    local dragging = false
    local minValue = 16
    local maxValue = 100
    local currentValue = 16
    
    local function updateSlider(value)
        currentValue = math.clamp(value, minValue, maxValue)
        local percentage = (currentValue - minValue) / (maxValue - minValue)
        
        createTween(sliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
        createTween(sliderHandle, {Position = UDim2.new(percentage, -10, 0.5, -10)}):Play()
        
        valueLabel.Text = tostring(math.floor(currentValue))
        
        -- Apply walkspeed
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = currentValue
        end
    end
    
    sliderHandle.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouseX = input.Position.X
            local sliderX = sliderBg.AbsolutePosition.X
            local sliderWidth = sliderBg.AbsoluteSize.X
            local percentage = math.clamp((mouseX - sliderX) / sliderWidth, 0, 1)
            local value = minValue + (maxValue - minValue) * percentage
            updateSlider(value)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Initialize slider
    updateSlider(16)
end

-- Fungsi untuk membuat konten Home
local function createHomeContent(parent)
    local homeFrame = createFrameWithCorner(parent, {
        Size = UDim2.new(1, -40, 1, -40),
        Position = UDim2.new(0, 20, 0, 20),
        BackgroundColor3 = Color3.fromRGB(35, 35, 50),
        BorderSizePixel = 0
    })
    
    -- Welcome text
    local welcomeText = Instance.new("TextLabel")
    welcomeText.Parent = homeFrame
    welcomeText.Size = UDim2.new(1, -40, 0, 60)
    welcomeText.Position = UDim2.new(0, 20, 0, 20)
    welcomeText.BackgroundTransparency = 1
    welcomeText.Text = "🎮 Welcome to GUI Hub!"
    welcomeText.TextColor3 = Color3.fromRGB(0, 162, 255)
    welcomeText.TextScaled = true
    welcomeText.Font = Enum.Font.GothamBold
    
    -- Description
    local descText = Instance.new("TextLabel")
    descText.Parent = homeFrame
    descText.Size = UDim2.new(1, -40, 0, 100)
    descText.Position = UDim2.new(0, 20, 0, 90)
    descText.BackgroundTransparency = 1
    descText.Text = "Selamat datang di GUI Hub yang sederhana dan mudah digunakan!\n\nFitur yang tersedia:\n• Walkspeed Control\n• User-friendly Interface\n• Drag & Drop Support"
    descText.TextColor3 = Color3.fromRGB(200, 200, 200)
    descText.TextScaled = true
    descText.Font = Enum.Font.Gotham
    descText.TextXAlignment = Enum.TextXAlignment.Left
    descText.TextYAlignment = Enum.TextYAlignment.Top
    
    return homeFrame
end

-- Fungsi untuk membuat konten Main
local function createMainContent(parent)
    local mainContentFrame = createFrameWithCorner(parent, {
        Size = UDim2.new(1, -40, 1, -40),
        Position = UDim2.new(0, 20, 0, 20),
        BackgroundColor3 = Color3.fromRGB(35, 35, 50),
        BorderSizePixel = 0
    })
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Parent = mainContentFrame
    title.Size = UDim2.new(1, -40, 0, 40)
    title.Position = UDim2.new(0, 20, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "⚙️ Main Scripts"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Walkspeed slider
    createWalkspeedSlider(mainContentFrame)
    
    return mainContentFrame
end

-- Fungsi untuk membuat hub utama
local function createMainHub()
    -- Main hub frame
    hubFrame = createFrameWithCorner(mainGui, {
        Name = "HubFrame",
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.5, -300, 0.5, -200),
        BackgroundColor3 = Color3.fromRGB(25, 25, 35),
        BorderSizePixel = 0,
        Active = true,
        Draggable = true,
        Visible = true
    })
    
    -- Shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Parent = hubFrame
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxasset://textures/ui/Controls/DropShadow.png"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(12, 12, 118, 118)
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.Position = UDim2.new(0, -20, 0, -20)
    shadow.ZIndex = hubFrame.ZIndex - 1
    
    -- Top bar
    local topBar = createFrameWithCorner(hubFrame, {
        Size = UDim2.new(1, 0, 0, 50),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(20, 20, 30),
        BorderSizePixel = 0
    })
    
    -- Logo
    local logo = Instance.new("ImageLabel")
    logo.Parent = topBar
    logo.Size = UDim2.new(0, 30, 0, 30)
    logo.Position = UDim2.new(0, 15, 0.5, -15)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://3926305904" -- Logo icon
    logo.ImageColor3 = Color3.fromRGB(0, 162, 255)
    
    -- Title
    local hubTitle = Instance.new("TextLabel")
    hubTitle.Parent = topBar
    hubTitle.Size = UDim2.new(0, 200, 1, 0)
    hubTitle.Position = UDim2.new(0, 55, 0, 0)
    hubTitle.BackgroundTransparency = 1
    hubTitle.Text = "GUI Hub"
    hubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    hubTitle.TextScaled = true
    hubTitle.Font = Enum.Font.GothamBold
    hubTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Hide button
    local hideBtn = createButton(topBar, {
        Size = UDim2.new(0, 35, 0, 35),
        Position = UDim2.new(1, -80, 0.5, -17.5),
        BackgroundColor3 = Color3.fromRGB(255, 193, 7),
        Text = "—",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    })
    
    -- Close button
    local closeBtn = createButton(topBar, {
        Size = UDim2.new(0, 35, 0, 35),
        Position = UDim2.new(1, -40, 0.5, -17.5),
        BackgroundColor3 = Color3.fromRGB(255, 69, 58),
        Text = "✕",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    })
    
    -- Sidebar
    sidebarFrame = createFrameWithCorner(hubFrame, {
        Size = UDim2.new(0, 180, 1, -60),
        Position = UDim2.new(0, 10, 0, 55),
        BackgroundColor3 = Color3.fromRGB(30, 30, 40),
        BorderSizePixel = 0
    })
    
    -- Main content area
    mainFrame = createFrameWithCorner(hubFrame, {
        Size = UDim2.new(1, -205, 1, -60),
        Position = UDim2.new(0, 195, 0, 55),
        BackgroundColor3 = Color3.fromRGB(40, 40, 55),
        BorderSizePixel = 0
    })
    
    -- Variables untuk konten
    local homeContent
    local mainContent
    local currentTab = "Home"
    
    -- Fungsi untuk switch tab
    local function switchTab(tabName, tabButton, tabIcon, tabText)
        -- Reset semua tab
        for _, child in ipairs(sidebarFrame:GetChildren()) do
            if child:IsA("TextButton") and child ~= tabButton then
                createTween(child, {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
                if child:FindFirstChild("ImageLabel") then
                    createTween(child:FindFirstChild("ImageLabel"), {ImageColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end
                if child:FindFirstChild("TextLabel") then
                    createTween(child:FindFirstChild("TextLabel"), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end
            end
        end
        
        -- Highlight tab aktif
        createTween(tabButton, {BackgroundColor3 = Color3.fromRGB(0, 162, 255)}):Play()
        createTween(tabIcon, {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        createTween(tabText, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        
        -- Clear main frame
        for _, child in ipairs(mainFrame:GetChildren()) do
            if not child:IsA("UICorner") then
                child:Destroy()
            end
        end
        
        -- Show content berdasarkan tab
        if tabName == "Home" then
            homeContent = createHomeContent(mainFrame)
            createTween(homeContent, {BackgroundTransparency = 1}, 0):Play()
            createTween(homeContent, {BackgroundTransparency = 0}, 0.3):Play()
        elseif tabName == "Main" then
            mainContent = createMainContent(mainFrame)
            createTween(mainContent, {BackgroundTransparency = 1}, 0):Play()
            createTween(mainContent, {BackgroundTransparency = 0}, 0.3):Play()
        end
        
        currentTab = tabName
    end
    
    -- Buat tab sidebar
    local homeTab, homeIcon, homeText = createSidebarTab(sidebarFrame, "Home", "3926305904", 20, function()
        switchTab("Home", homeTab, homeIcon, homeText)
    end)
    
    local mainTab, mainIcon, mainText = createSidebarTab(sidebarFrame, "Main", "3926307971", 75, function()
        switchTab("Main", mainTab, mainIcon, mainText)
    end)
    
    -- Set default tab
    switchTab("Home", homeTab, homeIcon, homeText)
    
    -- Hide button functionality
    hideBtn.MouseButton1Click:Connect(function()
        createTween(hubFrame, {Position = UDim2.new(0.5, -300, -1, -200)}, 0.5):Play()
        showIcon.Visible = true
        createTween(showIcon, {Position = UDim2.new(0, 20, 0, 20)}, 0.3, Enum.EasingStyle.Back):Play()
    end)
    
    -- Close button functionality
    closeBtn.MouseButton1Click:Connect(function()
        -- Confirmation popup
        local confirmFrame = createFrameWithCorner(mainGui, {
            Size = UDim2.new(0, 300, 0, 150),
            Position = UDim2.new(0.5, -150, 0.5, -75),
            BackgroundColor3 = Color3.fromRGB(30, 30, 40),
            BorderSizePixel = 0
        })
        
        local confirmText = Instance.new("TextLabel")
        confirmText.Parent = confirmFrame
        confirmText.Size = UDim2.new(1, -40, 0, 60)
        confirmText.Position = UDim2.new(0, 20, 0, 20)
        confirmText.BackgroundTransparency = 1
        confirmText.Text = "Are you sure you want to close the GUI permanently?"
        confirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
        confirmText.TextScaled = true
        confirmText.Font = Enum.Font.Gotham
        confirmText.TextWrapped = true
        
        local yesBtn = createButton(confirmFrame, {
            Size = UDim2.new(0, 80, 0, 30),
            Position = UDim2.new(0, 50, 0, 100),
            BackgroundColor3 = Color3.fromRGB(255, 69, 58),
            Text = "Yes",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            Font = Enum.Font.GothamBold,
            BorderSizePixel = 0
        })
        
        local noBtn = createButton(confirmFrame, {
            Size = UDim2.new(0, 80, 0, 30),
            Position = UDim2.new(0, 170, 0, 100),
            BackgroundColor3 = Color3.fromRGB(100, 100, 100),
            Text = "No",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            Font = Enum.Font.GothamBold,
            BorderSizePixel = 0
        })
        
        yesBtn.MouseButton1Click:Connect(function()
            mainGui:Destroy()
        end)
        
        noBtn.MouseButton1Click:Connect(function()
            confirmFrame:Destroy()
        end)
        
        -- Animasi popup
        confirmFrame.Position = UDim2.new(0.5, -150, -1, 0)
        createTween(confirmFrame, {Position = UDim2.new(0.5, -150, 0.5, -75)}, 0.5, Enum.EasingStyle.Back):Play()
    end)
    
    -- Show icon functionality
    showIcon.MouseButton1Click:Connect(function()
        showIcon.Visible = false
        hubFrame.Position = UDim2.new(0.5, -300, -1, -200)
        hubFrame.Visible = true
        createTween(hubFrame, {Position = UDim2.new(0.5, -300, 0.5, -200)}, 0.5, Enum.EasingStyle.Back):Play()
    end)
    
    -- Animasi masuk hub
    hubFrame.Position = UDim2.new(0.5, -300, -1, -200)
    createTween(hubFrame, {Position = UDim2.new(0.5, -300, 0.5, -200)}, 0.8, Enum.EasingStyle.Back):Play()
end

-- Fungsi untuk membuat drag functionality yang lebih smooth
local function makeDraggable(frame)
    local dragToggle = nil
    local dragSpeed = 0
    local dragStart = nil
    local startPos = nil
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        createTween(frame, {Position = position}, 0.1):Play()
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            
            dragConnection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                    if dragConnection then
                        dragConnection:Disconnect()
                    end
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
            updateInput(input)
        end
    end)
end

-- Fungsi utama untuk memulai script
local function initializeScript()
    -- Buat ScreenGui utama
    mainGui = Instance.new("ScreenGui")
    mainGui.Name = "GUIHub"
    mainGui.Parent = playerGui
    mainGui.ResetOnSpawn = false
    mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Buat show icon
    createShowIcon()
    
    -- Mulai dengan sistem key
    createKeySystem()
end

-- Anti-detection dan cleanup
local function setupAntiDetection()
    -- Cleanup ketika player leave
    Players.PlayerRemoving:Connect(function(leavingPlayer)
        if leavingPlayer == player then
            if mainGui then
                mainGui:Destroy()
            end
        end
    end)
    
    -- Cleanup ketika character respawn
    player.CharacterAdded:Connect(function()
        wait(1)
        if mainGui and isAuthenticated then
            -- Reapply walkspeed jika ada
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                local humanoid = player.Character.Humanoid
                if humanoid.WalkSpeed ~= 16 then
                    -- Keep current walkspeed
                end
            end
        end
    end)
end

-- Mulai script
setupAntiDetection()
initializeScript()

-- Tambahan: Keyboard shortcuts
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.RightControl and isAuthenticated then
        if hubFrame and hubFrame.Visible then
            -- Hide
            createTween(hubFrame, {Position = UDim2.new(0.5, -300, -1, -200)}, 0.5):Play()
            showIcon.Visible = true
            createTween(showIcon, {Position = UDim2.new(0, 20, 0, 20)}, 0.3, Enum.EasingStyle.Back):Play()
        elseif showIcon and showIcon.Visible then
            -- Show
            showIcon.Visible = false
            hubFrame.Position = UDim2.new(0.5, -300, -1, -200)
            hubFrame.Visible = true
            createTween(hubFrame, {Position = UDim2.new(0.5, -300, 0.5, -200)}, 0.5, Enum.EasingStyle.Back):Play()
        end
    end
end)
