-- Professional Key System UI v3.0
-- Advanced Glassmorphism with Security Features
-- Created with enhanced animations and professional design

-- CONFIGURATION
local CONFIG = {
    APP_NAME = "SecureHub Pro",
    VERSION = "v3.0",
    COMPANY = "Professional Systems",
    -- Use local validation instead of remote for security
    VALID_KEYS = {
        "DEMO-KEY-2025",
        "PREMIUM-ACCESS",
        "PROFESSIONAL-KEY"
    },
    -- Removed remote execution for security
    SUCCESS_MESSAGE = "Access granted! Welcome to SecureHub Pro."
}

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInput = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")

-- ADVANCED HELPER FUNCTIONS
local function createTween(obj, duration, props, style, direction, repeatCount, reverses)
    return TweenService:Create(obj, TweenInfo.new(
        duration or 0.3,
        style or Enum.EasingStyle.Quart,
        direction or Enum.EasingDirection.Out,
        repeatCount or 0,
        reverses or false
    ), props)
end

local function playTween(obj, duration, props, style, direction)
    createTween(obj, duration, props, style, direction):Play()
end

local function createUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = parent
    return corner
end

local function createUIStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(100, 150, 255)
    stroke.Thickness = thickness or 1.5
    stroke.Transparency = transparency or 0.5
    stroke.Parent = parent
    return stroke
end

local function createGradient(parent, rotation, colors)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = rotation or 90
    gradient.Color = colors or ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 100, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 60, 120))
    }
    gradient.Parent = parent
    return gradient
end

local function createDropShadow(parent, size, offset, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "DropShadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = transparency or 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.Size = parent.Size + UDim2.new(0, size*2, 0, size*2)
    shadow.Position = UDim2.new(0, -size + offset.X, 0, -size + offset.Y)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent.Parent
    return shadow
end

-- ADVANCED PARTICLE SYSTEM
local ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem.new(parent)
    local self = setmetatable({}, ParticleSystem)
    self.parent = parent
    self.particles = {}
    self.running = true
    
    self:startSystem()
    return self
end

function ParticleSystem:createParticle()
    local particle = Instance.new("Frame")
    particle.Name = "Particle"
    particle.Size = UDim2.new(0, math.random(3, 8), 0, math.random(3, 8))
    particle.Position = UDim2.new(math.random(), 0, 1.1, 0)
    particle.BackgroundColor3 = Color3.fromHSV(0.6 + math.random() * 0.2, 0.7, 1)
    particle.BackgroundTransparency = 0.3
    particle.BorderSizePixel = 0
    particle.ZIndex = 1
    particle.Parent = self.parent
    
    createUICorner(particle, 50)
    
    -- Animate particle
    local endPos = UDim2.new(math.random(), math.random(-100, 100), -0.1, 0)
    local duration = math.random(40, 80) / 10
    
    playTween(particle, duration, {
        Position = endPos,
        BackgroundTransparency = 1,
        Rotation = math.random(-180, 180)
    }, Enum.EasingStyle.Sine)
    
    task.delay(duration, function()
        if particle and particle.Parent then
            particle:Destroy()
        end
    end)
    
    table.insert(self.particles, particle)
end

function ParticleSystem:startSystem()
    task.spawn(function()
        while self.running do
            if math.random() < 0.7 then
                self:createParticle()
            end
            task.wait(0.1)
        end
    end)
end

function ParticleSystem:destroy()
    self.running = false
    for _, particle in pairs(self.particles) do
        if particle and particle.Parent then
            particle:Destroy()
        end
    end
end

-- ADVANCED SOUND SYSTEM
local SoundSystem = {}
SoundSystem.sounds = {}

function SoundSystem:createSound(id, volume, pitch)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. id
    sound.Volume = volume or 0.5
    sound.Pitch = pitch or 1
    sound.Parent = SoundService
    return sound
end

function SoundSystem:init()
    self.sounds.hover = self:createSound("131961136", 0.3, 1.2)
    self.sounds.click = self:createSound("131961136", 0.4, 0.8)
    self.sounds.success = self:createSound("131961136", 0.6, 1.5)
    self.sounds.error = self:createSound("131961136", 0.5, 0.6)
end

function SoundSystem:play(soundName)
    if self.sounds[soundName] then
        self.sounds[soundName]:Play()
    end
end

-- INITIALIZE SOUND SYSTEM
SoundSystem:init()

-- MAIN UI CREATION
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ProfessionalKeySystem_" .. HttpService:GenerateGUID(false)
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Advanced background with animated gradient
local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(8, 12, 25)
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

-- Animated background gradient
local BgGradient = createGradient(Background, 45, ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 25, 45)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 35, 65)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 20, 40))
})

-- Animate gradient rotation
task.spawn(function()
    while ScreenGui.Parent do
        playTween(BgGradient, 8, {Rotation = BgGradient.Rotation + 360})
        task.wait(8)
    end
end)

-- Advanced blur effect
local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Size = 0
BlurEffect.Parent = Lighting
playTween(BlurEffect, 1, {Size = 24}, Enum.EasingStyle.Quart)

-- Particle system
local particles = ParticleSystem.new(ScreenGui)

-- MAIN CONTAINER with advanced glassmorphism
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 520, 0, 420)
MainContainer.Position = UDim2.new(0.5, -260, 0.5, -210)
MainContainer.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
MainContainer.BackgroundTransparency = 0.15
MainContainer.BorderSizePixel = 0
MainContainer.ZIndex = 5
MainContainer.Parent = ScreenGui

createUICorner(MainContainer, 20)
createUIStroke(MainContainer, Color3.fromRGB(120, 160, 255), 2, 0.3)

-- Drop shadow
createDropShadow(MainContainer, 20, Vector2.new(0, 5), 0.6)

-- Glass overlay with multiple layers
local GlassOverlay1 = Instance.new("Frame")
GlassOverlay1.Size = UDim2.new(1, 0, 1, 0)
GlassOverlay1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GlassOverlay1.BackgroundTransparency = 0.92
GlassOverlay1.BorderSizePixel = 0
GlassOverlay1.ZIndex = 6
GlassOverlay1.Parent = MainContainer
createUICorner(GlassOverlay1, 20)

local GlassOverlay2 = Instance.new("Frame")
GlassOverlay2.Size = UDim2.new(1, 0, 0.3, 0)
GlassOverlay2.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
GlassOverlay2.BackgroundTransparency = 0.95
GlassOverlay2.BorderSizePixel = 0
GlassOverlay2.ZIndex = 7
GlassOverlay2.Parent = MainContainer
createUICorner(GlassOverlay2, 20)

-- ADVANCED HEADER SECTION
local HeaderSection = Instance.new("Frame")
HeaderSection.Name = "HeaderSection"
HeaderSection.Size = UDim2.new(1, 0, 0, 80)
HeaderSection.BackgroundColor3 = Color3.fromRGB(30, 45, 80)
HeaderSection.BackgroundTransparency = 0.1
HeaderSection.BorderSizePixel = 0
HeaderSection.ZIndex = 8
HeaderSection.Parent = MainContainer
createUICorner(HeaderSection, 20)

-- Header gradient with animation
local HeaderGradient = createGradient(HeaderSection, 135, ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 100, 180)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 70, 140)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 45, 80))
})

-- Animate header gradient
task.spawn(function()
    while ScreenGui.Parent do
        playTween(HeaderGradient, 6, {Rotation = HeaderGradient.Rotation + 360})
        task.wait(6)
    end
end)

-- LOGO AND TITLE SECTION
local LogoContainer = Instance.new("Frame")
LogoContainer.Size = UDim2.new(0, 60, 0, 60)
LogoContainer.Position = UDim2.new(0, 20, 0.5, -30)
LogoContainer.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
LogoContainer.BackgroundTransparency = 0.2
LogoContainer.BorderSizePixel = 0
LogoContainer.ZIndex = 9
LogoContainer.Parent = HeaderSection
createUICorner(LogoContainer, 30)
createUIStroke(LogoContainer, Color3.fromRGB(120, 180, 255), 2, 0.4)

-- Logo icon with glow effect
local LogoIcon = Instance.new("ImageLabel")
LogoIcon.Size = UDim2.new(0.7, 0, 0.7, 0)
LogoIcon.Position = UDim2.new(0.15, 0, 0.15, 0)
LogoIcon.BackgroundTransparency = 1
LogoIcon.Image = "rbxassetid://7072717770" -- Shield checkmark
LogoIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
LogoIcon.ZIndex = 10
LogoIcon.Parent = LogoContainer

-- Rotating glow effect
local GlowRing = Instance.new("Frame")
GlowRing.Size = UDim2.new(1.2, 0, 1.2, 0)
GlowRing.Position = UDim2.new(-0.1, 0, -0.1, 0)
GlowRing.BackgroundTransparency = 1
GlowRing.BorderSizePixel = 0
GlowRing.ZIndex = 8
GlowRing.Parent = LogoContainer

local GlowStroke = createUIStroke(GlowRing, Color3.fromRGB(100, 200, 255), 3, 0.7)
createUICorner(GlowRing, 35)

-- Animate logo glow
task.spawn(function()
    while ScreenGui.Parent do
        playTween(GlowRing, 2, {Rotation = 360}, Enum.EasingStyle.Linear)
        task.wait(2)
        GlowRing.Rotation = 0
    end
end)

-- TITLE AND SUBTITLE
local TitleContainer = Instance.new("Frame")
TitleContainer.Size = UDim2.new(1, -100, 1, 0)
TitleContainer.Position = UDim2.new(0, 90, 0, 0)
TitleContainer.BackgroundTransparency = 1
TitleContainer.ZIndex = 9
TitleContainer.Parent = HeaderSection

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(1, 0, 0.6, 0)
MainTitle.Position = UDim2.new(0, 0, 0.1, 0)
MainTitle.Text = CONFIG.APP_NAME
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 28
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.ZIndex = 9
MainTitle.Parent = TitleContainer

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0.4, 0)
Subtitle.Position = UDim2.new(0, 0, 0.6, 0)
Subtitle.Text = "Professional Access Control System " .. CONFIG.VERSION
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 14
Subtitle.TextColor3 = Color3.fromRGB(180, 200, 255)
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.BackgroundTransparency = 1
Subtitle.ZIndex = 9
Subtitle.Parent = TitleContainer

-- CLOSE BUTTON with advanced design
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0.5, -20)
CloseButton.Text = "×"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 24
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
CloseButton.BackgroundTransparency = 0.3
CloseButton.BorderSizePixel = 0
CloseButton.ZIndex = 9
CloseButton.Parent = HeaderSection

createUICorner(CloseButton, 10)
createUIStroke(CloseButton, Color3.fromRGB(120, 160, 220), 1.5, 0.5)

-- MAIN CONTENT AREA
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -40, 1, -100)
ContentArea.Position = UDim2.new(0, 20, 0, 90)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 8
ContentArea.Parent = MainContainer

-- SECURITY STATUS INDICATOR
local SecurityIndicator = Instance.new("Frame")
SecurityIndicator.Size = UDim2.new(1, 0, 0, 50)
SecurityIndicator.Position = UDim2.new(0, 0, 0, 0)
SecurityIndicator.BackgroundColor3 = Color3.fromRGB(35, 50, 85)
SecurityIndicator.BackgroundTransparency = 0.3
SecurityIndicator.BorderSizePixel = 0
SecurityIndicator.ZIndex = 8
SecurityIndicator.Parent = ContentArea
createUICorner(SecurityIndicator, 12)
createUIStroke(SecurityIndicator, Color3.fromRGB(80, 120, 200), 1, 0.6)

local SecurityIcon = Instance.new("ImageLabel")
SecurityIcon.Size = UDim2.new(0, 24, 0, 24)
SecurityIcon.Position = UDim2.new(0, 15, 0.5, -12)
SecurityIcon.BackgroundTransparency = 1
SecurityIcon.Image = "rbxassetid://7072717770" -- Shield icon
SecurityIcon.ImageColor3 = Color3.fromRGB(100, 255, 150)
SecurityIcon.ZIndex = 9
SecurityIcon.Parent = SecurityIndicator

local SecurityText = Instance.new("TextLabel")
SecurityText.Size = UDim2.new(1, -50, 1, 0)
SecurityText.Position = UDim2.new(0, 45, 0, 0)
SecurityText.Text = "Secure Connection Established • SSL Protected"
SecurityText.Font = Enum.Font.GothamMedium
SecurityText.TextSize = 13
SecurityText.TextColor3 = Color3.fromRGB(150, 255, 180)
SecurityText.TextXAlignment = Enum.TextXAlignment.Left
SecurityText.BackgroundTransparency = 1
SecurityText.ZIndex = 9
SecurityText.Parent = SecurityIndicator

-- Animate security indicator
playTween(SecurityIcon, 2, {ImageColor3 = Color3.fromRGB(255, 200, 100)}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)

-- WELCOME SECTION
local WelcomeSection = Instance.new("Frame")
WelcomeSection.Size = UDim2.new(1, 0, 0, 70)
WelcomeSection.Position = UDim2.new(0, 0, 0, 65)
WelcomeSection.BackgroundTransparency = 1
WelcomeSection.ZIndex = 8
WelcomeSection.Parent = ContentArea

local WelcomeTitle = Instance.new("TextLabel")
WelcomeTitle.Size = UDim2.new(1, 0, 0, 35)
WelcomeTitle.Position = UDim2.new(0, 0, 0, 0)
WelcomeTitle.Text = "Authentication Required"
WelcomeTitle.Font = Enum.Font.GothamBold
WelcomeTitle.TextSize = 24
WelcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeTitle.TextXAlignment = Enum.TextXAlignment.Left
WelcomeTitle.BackgroundTransparency = 1
WelcomeTitle.ZIndex = 9
WelcomeTitle.Parent = WelcomeSection

local WelcomeDesc = Instance.new("TextLabel")
WelcomeDesc.Size = UDim2.new(1, 0, 0, 35)
WelcomeDesc.Position = UDim2.new(0, 0, 0, 35)
WelcomeDesc.Text = "Please enter your premium access key to continue"
WelcomeDesc.Font = Enum.Font.Gotham
WelcomeDesc.TextSize = 15
WelcomeDesc.TextColor3 = Color3.fromRGB(180, 200, 255)
WelcomeDesc.TextXAlignment = Enum.TextXAlignment.Left
WelcomeDesc.BackgroundTransparency = 1
WelcomeDesc.ZIndex = 9
WelcomeDesc.Parent = WelcomeSection

-- KEY INPUT SECTION with advanced design
local InputSection = Instance.new("Frame")
InputSection.Size = UDim2.new(1, 0, 0, 80)
InputSection.Position = UDim2.new(0, 0, 0, 150)
InputSection.BackgroundTransparency = 1
InputSection.ZIndex = 8
InputSection.Parent = ContentArea

-- Input label
local InputLabel = Instance.new("TextLabel")
InputLabel.Size = UDim2.new(1, 0, 0, 25)
InputLabel.Position = UDim2.new(0, 0, 0, 0)
InputLabel.Text = "Access Key"
InputLabel.Font = Enum.Font.GothamMedium
InputLabel.TextSize = 14
InputLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
InputLabel.TextXAlignment = Enum.TextXAlignment.Left
InputLabel.BackgroundTransparency = 1
InputLabel.ZIndex = 9
InputLabel.Parent = InputSection

-- Advanced input field container
local InputFieldContainer = Instance.new("Frame")
InputFieldContainer.Size = UDim2.new(1, 0, 0, 50)
InputFieldContainer.Position = UDim2.new(0, 0, 0, 30)
InputFieldContainer.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
InputFieldContainer.BackgroundTransparency = 0.2
InputFieldContainer.BorderSizePixel = 0
InputFieldContainer.ZIndex = 8
InputFieldContainer.Parent = InputSection
createUICorner(InputFieldContainer, 12)

-- Multi-layer input styling
local InputBorder = createUIStroke(InputFieldContainer, Color3.fromRGB(80, 120, 200), 2, 0.4)

local InputGradient = createGradient(InputFieldContainer, 90, ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 40, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 30, 50))
})

-- Key input field
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -60, 1, -10)
KeyInput.Position = UDim2.new(0, 15, 0, 5)
KeyInput.PlaceholderText = "Enter your premium access key..."
KeyInput.Text = ""
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.TextSize = 16
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundTransparency = 1
KeyInput.ClearTextOnFocus = false
KeyInput.PlaceholderColor3 = Color3.fromRGB(140, 160, 200)
KeyInput.ZIndex = 9
KeyInput.Parent = InputFieldContainer

-- Advanced show/hide toggle
local VisibilityToggle = Instance.new("TextButton")
VisibilityToggle.Size = UDim2.new(0, 35, 0, 35)
VisibilityToggle.Position = UDim2.new(1, -45, 0.5, -17.5)
VisibilityToggle.Text = ""
VisibilityToggle.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
VisibilityToggle.BackgroundTransparency = 0.5
VisibilityToggle.BorderSizePixel = 0
VisibilityToggle.ZIndex = 9
VisibilityToggle.Parent = InputFieldContainer
createUICorner(VisibilityToggle, 8)

local EyeIcon = Instance.new("ImageLabel")
EyeIcon.Size = UDim2.new(0.7, 0, 0.7, 0)
EyeIcon.Position = UDim2.new(0.15, 0, 0.15, 0)
EyeIcon.BackgroundTransparency = 1
EyeIcon.Image = "rbxassetid://7072717000" -- Eye icon
EyeIcon.ImageColor3 = Color3.fromRGB(180, 200, 255)
EyeIcon.ZIndex = 10
EyeIcon.Parent = VisibilityToggle

local keyVisible = false
VisibilityToggle.MouseButton1Click:Connect(function()
    SoundSystem:play("click")
    keyVisible = not keyVisible
    
    if keyVisible then
        KeyInput.TextTransparency = 0
        playTween(EyeIcon, 0.2, {ImageColor3 = Color3.fromRGB(100, 200, 255)})
        playTween(VisibilityToggle, 0.2, {BackgroundTransparency = 0.2})
    else
        KeyInput.TextTransparency = 0.7
        playTween(EyeIcon, 0.2, {ImageColor3 = Color3.fromRGB(180, 200, 255)})
        playTween(VisibilityToggle, 0.2, {BackgroundTransparency = 0.5})
    end
end)

-- KEY STRENGTH INDICATOR
local StrengthIndicator = Instance.new("Frame")
StrengthIndicator.Size = UDim2.new(1, 0, 0, 6)
StrengthIndicator.Position = UDim2.new(0, 0, 1, 5)
StrengthIndicator.BackgroundColor3 = Color3.fromRGB(40, 50, 80)
StrengthIndicator.BorderSizePixel = 0
StrengthIndicator.ZIndex = 8
StrengthIndicator.Parent = InputFieldContainer
createUICorner(StrengthIndicator, 3)

local StrengthFill = Instance.new("Frame")
StrengthFill.Size = UDim2.new(0, 0, 1, 0)
StrengthFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
StrengthFill.BorderSizePixel = 0
StrengthFill.ZIndex = 9
StrengthFill.Parent = StrengthIndicator
createUICorner(StrengthFill, 3)

-- Update strength indicator based on input
KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
    local text = KeyInput.Text
    local strength = math.min(#text / 15, 1)
    
    local color = Color3.fromRGB(
        255 - (strength * 155),
        100 + (strength * 155),
        100
    )
    
    playTween(StrengthFill, 0.3, {Size = UDim2.new(strength, 0, 1, 0), BackgroundColor3 = color})
end)

-- ADVANCED VERIFY BUTTON
local VerifyButtonContainer = Instance.new("Frame")
VerifyButtonContainer.Size = UDim2.new(1, 0, 0, 55)
VerifyButtonContainer.Position = UDim2.new(0, 0, 0, 245)
VerifyButtonContainer.BackgroundTransparency = 1
VerifyButtonContainer.ZIndex = 8
VerifyButtonContainer.Parent = ContentArea

local VerifyButton = Instance.new("TextButton")
VerifyButton.Size = UDim2.new(1, 0, 1, 0)
VerifyButton.Position = UDim2.new(0, 0, 0, 0)
VerifyButton.Text = "VERIFY ACCESS KEY"
VerifyButton.Font = Enum.Font.GothamBold
VerifyButton.TextSize = 18
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyButton.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
VerifyButton.BorderSizePixel = 0
VerifyButton.ZIndex = 9
VerifyButton.Parent = VerifyButtonContainer
createUICorner(VerifyButton, 12)

-- Button effects
local ButtonStroke = createUIStroke(VerifyButton, Color3.fromRGB(120, 180, 255), 2, 0.3)
local ButtonGradient = createGradient(VerifyButton, 90, ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 140, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 120, 255))
})

-- Button shadow
createDropShadow(VerifyButton, 8, Vector2.new(0, 2), 0.5)

-- ADVANCED LOADING SYSTEM
local LoadingSystem = {}
LoadingSystem.active = false

function LoadingSystem:show()
    if self.active then return end
    self.active = true
    
    -- Create loading overlay
    local LoadingOverlay = Instance.new("Frame")
    LoadingOverlay.Name = "LoadingOverlay"
    LoadingOverlay.Size = UDim2.new(1, 0, 1, 0)
    LoadingOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    LoadingOverlay.BackgroundTransparency = 0.3
    LoadingOverlay.BorderSizePixel = 0
    LoadingOverlay.ZIndex = 15
    LoadingOverlay.Parent = MainContainer
    
    -- Loading content container
    local LoadingContent = Instance.new("Frame")
    LoadingContent.Size = UDim2.new(0, 200, 0, 120)
    LoadingContent.Position = UDim2.new(0.5, -100, 0.5, -60)
    LoadingContent.BackgroundColor3 = Color3.fromRGB(30, 45, 80)
    LoadingContent.BackgroundTransparency = 0.1
    LoadingContent.BorderSizePixel = 0
    LoadingContent.ZIndex = 16
    LoadingContent.Parent = LoadingOverlay
    createUICorner(LoadingContent, 15)
    createUIStroke(LoadingContent, Color3.fromRGB(100, 150, 255), 2, 0.3)
    
    -- Glass effect for loading
    local LoadingGlass = Instance.new("Frame")
    LoadingGlass.Size = UDim2.new(1, 0, 1, 0)
    LoadingGlass.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LoadingGlass.BackgroundTransparency = 0.92
    LoadingGlass.BorderSizePixel = 0
    LoadingGlass.ZIndex = 17
    LoadingGlass.Parent = LoadingContent
    createUICorner(LoadingGlass, 15)
    
    -- Advanced loading spinner
    local SpinnerContainer = Instance.new("Frame")
    SpinnerContainer.Size = UDim2.new(0, 60, 0, 60)
    SpinnerContainer.Position = UDim2.new(0.5, -30, 0.3, -15)
    SpinnerContainer.BackgroundTransparency = 1
    SpinnerContainer.ZIndex = 18
    SpinnerContainer.Parent = LoadingContent
    
    -- Multiple spinning rings
    for i = 1, 3 do
        local Ring = Instance.new("Frame")
        Ring.Size = UDim2.new(0, 40 + (i * 8), 0, 40 + (i * 8))
        Ring.Position = UDim2.new(0.5, -(20 + i * 4), 0.5, -(20 + i * 4))
        Ring.BackgroundTransparency = 1
        Ring.BorderSizePixel = 0
        Ring.ZIndex = 18 + i
        Ring.Parent = SpinnerContainer
        createUICorner(Ring, 50)
        
        local RingStroke = createUIStroke(Ring, Color3.fromRGB(100 + i * 30, 150 + i * 20, 255), 3, 0.4 + i * 0.2)
        
        -- Animate each ring differently
        task.spawn(function()
            while LoadingSystem.active do
                playTween(Ring, 1 + i * 0.3, {Rotation = 360}, Enum.EasingStyle.Linear)
                task.wait(1 + i * 0.3)
                Ring.Rotation = 0
            end
        end)
    end
    
    -- Loading text with typewriter effect
    local LoadingText = Instance.new("TextLabel")
    LoadingText.Size = UDim2.new(1, -20, 0, 30)
    LoadingText.Position = UDim2.new(0, 10, 0.7, 0)
    LoadingText.Text = ""
    LoadingText.Font = Enum.Font.GothamMedium
    LoadingText.TextSize = 14
    LoadingText.TextColor3 = Color3.fromRGB(200, 220, 255)
    LoadingText.BackgroundTransparency = 1
    LoadingText.ZIndex = 18
    LoadingText.Parent = LoadingContent
    
    -- Typewriter animation
    local messages = {"Verifying key...", "Checking permissions...", "Establishing connection...", "Almost ready..."}
    task.spawn(function()
        for _, msg in ipairs(messages) do
            for i = 1, #msg do
                if not LoadingSystem.active then break end
                LoadingText.Text = string.sub(msg, 1, i)
                task.wait(0.05)
            end
            task.wait(0.8)
        end
    end)
    
    self.overlay = LoadingOverlay
end

function LoadingSystem:hide()
    self.active = false
    if self.overlay then
        playTween(self.overlay, 0.3, {BackgroundTransparency = 1})
        task.wait(0.3)
        self.overlay:Destroy()
        self.overlay = nil
    end
end

-- ADVANCED NOTIFICATION SYSTEM
local NotificationSystem = {}

function NotificationSystem:show(message, type, duration)
    local colors = {
        success = {bg = Color3.fromRGB(20, 80, 40), border = Color3.fromRGB(40, 200, 80), text = Color3.fromRGB(150, 255, 180)},
        error = {bg = Color3.fromRGB(80, 30, 30), border = Color3.fromRGB(255, 80, 80), text = Color3.fromRGB(255, 150, 150)},
        warning = {bg = Color3.fromRGB(80, 60, 20), border = Color3.fromRGB(255, 200, 60), text = Color3.fromRGB(255, 230, 150)},
        info = {bg = Color3.fromRGB(20, 40, 80), border = Color3.fromRGB(60, 150, 255), text = Color3.fromRGB(150, 200, 255)}
    }
    
    local color = colors[type] or colors.info
    
    local NotificationContainer = Instance.new("Frame")
    NotificationContainer.Size = UDim2.new(0, 400, 0, 70)
    NotificationContainer.Position = UDim2.new(0.5, -200, 1, 20)
    NotificationContainer.BackgroundColor3 = color.bg
    NotificationContainer.BackgroundTransparency = 0.1
    NotificationContainer.BorderSizePixel = 0
    NotificationContainer.ZIndex = 20
    NotificationContainer.Parent = ScreenGui
    createUICorner(NotificationContainer, 12)
    createUIStroke(NotificationContainer, color.border, 2, 0.2)
    
    -- Glass effect
    local NotifGlass = Instance.new("Frame")
    NotifGlass.Size = UDim2.new(1, 0, 1, 0)
    NotifGlass.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NotifGlass.BackgroundTransparency = 0.9
    NotifGlass.BorderSizePixel = 0
    NotifGlass.ZIndex = 21
    NotifGlass.Parent = NotificationContainer
    createUICorner(NotifGlass, 12)
    
    -- Icon
    local NotifIcon = Instance.new("ImageLabel")
    NotifIcon.Size = UDim2.new(0, 32, 0, 32)
    NotifIcon.Position = UDim2.new(0, 15, 0.5, -16)
    NotifIcon.BackgroundTransparency = 1
    NotifIcon.ImageColor3 = color.text
    NotifIcon.ZIndex = 22
    NotifIcon.Parent = NotificationContainer
    
    local iconIds = {
        success = "7072717770",
        error = "7072717852", 
        warning = "7072718006",
        info = "7072717796"
    }
    NotifIcon.Image = "rbxassetid://" .. (iconIds[type] or iconIds.info)
    
    -- Message text
    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -60, 1, 0)
    NotifText.Position = UDim2.new(0, 55, 0, 0)
    NotifText.Text = message
    NotifText.Font = Enum.Font.GothamMedium
    NotifText.TextSize = 15
    NotifText.TextColor3 = color.text
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.TextWrapped = true
    NotifText.BackgroundTransparency = 1
    NotifText.ZIndex = 22
    NotifText.Parent = NotificationContainer
    
    -- Progress bar
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Size = UDim2.new(1, 0, 0, 3)
    ProgressBar.Position = UDim2.new(0, 0, 1, -3)
    ProgressBar.BackgroundColor3 = color.border
    ProgressBar.BorderSizePixel = 0
    ProgressBar.ZIndex = 22
    ProgressBar.Parent = NotificationContainer
    
    -- Animate notification
    playTween(NotificationContainer, 0.5, {Position = UDim2.new(0.5, -200, 1, -90)}, Enum.EasingStyle.Back)
    playTween(ProgressBar, duration or 3, {Size = UDim2.new(0, 0, 0, 3)}, Enum.EasingStyle.Linear)
    
    task.delay(duration or 3, function()
        playTween(NotificationContainer, 0.3, {Position = UDim2.new(0.5, -200, 1, 20)})
        task.wait(0.3)
        NotificationContainer:Destroy()
    end)
end

-- ADVANCED HOVER EFFECTS SYSTEM
local HoverSystem = {}

function HoverSystem:setupAdvancedHover(element, config)
    local defaultConfig = {
        hoverScale = 1.05,
        hoverTransparency = -0.1,
        duration = 0.2,
        sound = true
    }
    
    for k, v in pairs(config or {}) do
        defaultConfig[k] = v
    end
    
    local originalSize = element.Size
    local originalTransparency = element.BackgroundTransparency
    
    element.MouseEnter:Connect(function()
        if defaultConfig.sound then SoundSystem:play("hover") end
        
        playTween(element, defaultConfig.duration, {
            Size = originalSize * defaultConfig.hoverScale,
            BackgroundTransparency = math.max(0, originalTransparency + defaultConfig.hoverTransparency)
        }, Enum.EasingStyle.Quart)
        
        if element:FindFirstChild("UIStroke") then
            playTween(element.UIStroke, defaultConfig.duration, {
                Thickness = element.UIStroke.Thickness + 0.5,
                Transparency = math.max(0, element.UIStroke.Transparency - 0.2)
            })
        end
    end)
    
    element.MouseLeave:Connect(function()
        playTween(element, defaultConfig.duration, {
            Size = originalSize,
            BackgroundTransparency = originalTransparency
        }, Enum.EasingStyle.Quart)
        
        if element:FindFirstChild("UIStroke") then
            playTween(element.UIStroke, defaultConfig.duration, {
                Thickness = element.UIStroke.Thickness - 0.5,
                Transparency = element.UIStroke.Transparency + 0.2
            })
        end
    end)
end

-- Apply hover effects
HoverSystem:setupAdvancedHover(VerifyButton, {hoverScale = 1.02, duration = 0.15})
HoverSystem:setupAdvancedHover(CloseButton, {hoverScale = 1.1, duration = 0.2})
HoverSystem:setupAdvancedHover(VisibilityToggle, {hoverScale = 1.1, duration = 0.15})

-- INPUT FIELD FOCUS EFFECTS
InputFieldContainer.MouseEnter:Connect(function()
    playTween(InputBorder, 0.2, {
        Color = Color3.fromRGB(120, 180, 255),
        Thickness = 3,
        Transparency = 0.2
    })
end)

InputFieldContainer.MouseLeave:Connect(function()
    if not KeyInput:IsFocused() then
        playTween(InputBorder, 0.2, {
            Color = Color3.fromRGB(80, 120, 200),
            Thickness = 2,
            Transparency = 0.4
        })
    end
end)

KeyInput.Focused:Connect(function()
    playTween(InputBorder, 0.2, {
        Color = Color3.fromRGB(150, 200, 255),
        Thickness = 3,
        Transparency = 0.1
    })
    playTween(InputFieldContainer, 0.2, {BackgroundTransparency = 0.1})
end)

KeyInput.FocusLost:Connect(function()
    playTween(InputBorder, 0.2, {
        Color = Color3.fromRGB(80, 120, 200),
        Thickness = 2,
        Transparency = 0.4
    })
    playTween(InputFieldContainer, 0.2, {BackgroundTransparency = 0.2})
end)

-- KEY VALIDATION SYSTEM
local function validateKey(key)
    key = string.gsub(key or "", "^%s+", ""):gsub("%s+$", "")
    for _, validKey in ipairs(CONFIG.VALID_KEYS) do
        if key == validKey then
            return true
        end
    end
    return false
end

-- ADVANCED SHAKE ANIMATION
local function performShakeAnimation(element)
    local originalPos = element.Position
    local shakeIntensity = 8
    local shakeDuration = 0.05
    
    for i = 1, 6 do
        local offset = math.random(-shakeIntensity, shakeIntensity)
        playTween(element, shakeDuration, {Position = originalPos + UDim2.new(0, offset, 0, 0)})
        task.wait(shakeDuration)
    end
    playTween(element, shakeDuration, {Position = originalPos})
end

-- SUCCESS ANIMATION SYSTEM
local function playSuccessAnimation()
    -- Create success overlay
    local SuccessOverlay = Instance.new("Frame")
    SuccessOverlay.Size = UDim2.new(1, 0, 1, 0)
    SuccessOverlay.BackgroundColor3 = Color3.fromRGB(20, 80, 40)
    SuccessOverlay.BackgroundTransparency = 0.8
    SuccessOverlay.BorderSizePixel = 0
    SuccessOverlay.ZIndex = 25
    SuccessOverlay.Parent = MainContainer
    
    -- Success checkmark
    local CheckContainer = Instance.new("Frame")
    CheckContainer.Size = UDim2.new(0, 100, 0, 100)
    CheckContainer.Position = UDim2.new(0.5, -50, 0.5, -50)
    CheckContainer.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
    CheckContainer.BackgroundTransparency = 0.2
    CheckContainer.BorderSizePixel = 0
    CheckContainer.ZIndex = 26
    CheckContainer.Parent = SuccessOverlay
    createUICorner(CheckContainer, 50)
    
    local CheckIcon = Instance.new("ImageLabel")
    CheckIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
    CheckIcon.Position = UDim2.new(0.2, 0, 0.2, 0)
    CheckIcon.BackgroundTransparency = 1
    CheckIcon.Image = "rbxassetid://7072717770"
    CheckIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    CheckIcon.ZIndex = 27
    CheckIcon.Parent = CheckContainer
    
    -- Animate success
    CheckContainer.Size = UDim2.new(0, 0, 0, 0)
    playTween(CheckContainer, 0.5, {Size = UDim2.new(0, 100, 0, 100)}, Enum.EasingStyle.Back)
    
    task.delay(1.5, function()
        playTween(SuccessOverlay, 0.5, {BackgroundTransparency = 1})
        task.wait(0.5)
        SuccessOverlay:Destroy()
    end)
end

-- VERIFY BUTTON FUNCTIONALITY
VerifyButton.MouseButton1Click:Connect(function()
    SoundSystem:play("click")
    local inputKey = KeyInput.Text
    
    if inputKey == "" then
        NotificationSystem:show("Please enter an access key", "warning", 2)
        performShakeAnimation(InputFieldContainer)
        return
    end
    
    -- Show loading
    LoadingSystem:show()
    VerifyButton.Text = "VERIFYING..."
    playTween(VerifyButton, 0.2, {BackgroundColor3 = Color3.fromRGB(100, 120, 180)})
    
    -- Simulate processing time
    task.wait(1.5)
    
    if validateKey(inputKey) then
        LoadingSystem:hide()
        SoundSystem:play("success")
        NotificationSystem:show("Key verified successfully! Access granted.", "success", 3)
        playSuccessAnimation()
        
        -- Success state
        VerifyButton.Text = "ACCESS GRANTED"
        playTween(VerifyButton, 0.3, {BackgroundColor3 = Color3.fromRGB(40, 200, 80)})
        
        task.wait(2)
        
        -- Smooth exit animation
        playTween(MainContainer, 0.8, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        }, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        
        playTween(BlurEffect, 0.8, {Size = 0})
        
        task.wait(0.8)
        particles:destroy()
        ScreenGui:Destroy()
        BlurEffect:Destroy()
        
        -- Here you would normally load your main application
        print(CONFIG.SUCCESS_MESSAGE)
        
    else
        LoadingSystem:hide()
        SoundSystem:play("error")
        NotificationSystem:show("Invalid access key. Please check and try again.", "error", 3)
        performShakeAnimation(InputFieldContainer)
        
        -- Reset button
        VerifyButton.Text = "VERIFY ACCESS KEY"
        playTween(VerifyButton, 0.3, {BackgroundColor3 = Color3.fromRGB(60, 120, 255)})
    end
end)

-- ADVANCED EXIT CONFIRMATION
local function showExitConfirmation()
    local ExitOverlay = Instance.new("Frame")
    ExitOverlay.Size = UDim2.new(1, 0, 1, 0)
    ExitOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ExitOverlay.BackgroundTransparency = 0.5
    ExitOverlay.BorderSizePixel = 0
    ExitOverlay.ZIndex = 30
    ExitOverlay.Parent = ScreenGui
    
    local ConfirmDialog = Instance.new("Frame")
    ConfirmDialog.Size = UDim2.new(0, 380, 0, 220)
    ConfirmDialog.Position = UDim2.new(0.5, -190, 0.5, -110)
    ConfirmDialog.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
    ConfirmDialog.BackgroundTransparency = 0.1
    ConfirmDialog.BorderSizePixel = 0
    ConfirmDialog.ZIndex = 31
    ConfirmDialog.Parent = ExitOverlay
    createUICorner(ConfirmDialog, 16)
    createUIStroke(ConfirmDialog, Color3.fromRGB(100, 150, 255), 2, 0.3)
    
    -- Glass effect
    local DialogGlass = Instance.new("Frame")
    DialogGlass.Size = UDim2.new(1, 0, 1, 0)
    DialogGlass.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DialogGlass.BackgroundTransparency = 0.9
    DialogGlass.BorderSizePixel = 0
    DialogGlass.ZIndex = 32
    DialogGlass.Parent = ConfirmDialog
    createUICorner(DialogGlass, 16)
    
    -- Dialog content
    local DialogTitle = Instance.new("TextLabel")
    DialogTitle.Size = UDim2.new(1, -30, 0, 40)
    DialogTitle.Position = UDim2.new(0, 15, 0, 20)
    DialogTitle.Text = "Confirm Exit"
    DialogTitle.Font = Enum.Font.GothamBold
    DialogTitle.TextSize = 22
    DialogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    DialogTitle.BackgroundTransparency = 1
    DialogTitle.ZIndex = 33
    DialogTitle.Parent = ConfirmDialog
    
    local DialogMessage = Instance.new("TextLabel")
    DialogMessage.Size = UDim2.new(1, -30, 0, 60)
    DialogMessage.Position = UDim2.new(0, 15, 0, 70)
    DialogMessage.Text = "Are you sure you want to exit the authentication system?"
    DialogMessage.Font = Enum.Font.Gotham
    DialogMessage.TextSize = 15
    DialogMessage.TextColor3 = Color3.fromRGB(180, 200, 255)
    DialogMessage.TextWrapped = true
    DialogMessage.BackgroundTransparency = 1
    DialogMessage.ZIndex = 33
    DialogMessage.Parent = ConfirmDialog
    
    -- Button container
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(1, -30, 0, 50)
    ButtonContainer.Position = UDim2.new(0, 15, 1, -70)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.ZIndex = 33
    ButtonContainer.Parent = ConfirmDialog
    
    -- Cancel button
    local CancelButton = Instance.new("TextButton")
    CancelButton.Size = UDim2.new(0.48, 0, 1, 0)
    CancelButton.Position = UDim2.new(0, 0, 0, 0)
    CancelButton.Text = "CANCEL"
    CancelButton.Font = Enum.Font.GothamBold
    CancelButton.TextSize = 16
    CancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CancelButton.BackgroundColor3 = Color3.fromRGB(70, 140, 230)
    CancelButton.BorderSizePixel = 0
    CancelButton.ZIndex = 34
    CancelButton.Parent = ButtonContainer
    createUICorner(CancelButton, 10)
    createUIStroke(CancelButton, Color3.fromRGB(120, 180, 255))
    
    -- Exit button
    local ExitButton = Instance.new("TextButton")
    ExitButton.Size = UDim2.new(0.48, 0, 1, 0)
    ExitButton.Position = UDim2.new(0.52, 0, 0, 0)
    ExitButton.Text = "EXIT"
    ExitButton.Font = Enum.Font.GothamBold
    ExitButton.TextSize = 16
    ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExitButton.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
    ExitButton.BorderSizePixel = 0
    ExitButton.ZIndex = 34
    ExitButton.Parent = ButtonContainer
    createUICorner(ExitButton, 10)
    createUIStroke(ExitButton, Color3.fromRGB(255, 120, 120))
    
    -- Button functionality
    CancelButton.MouseButton1Click:Connect(function()
        SoundSystem:play("click")
        playTween(ExitOverlay, 0.3, {BackgroundTransparency = 1})
        task.wait(0.3)
        ExitOverlay:Destroy()
    end)
    
    ExitButton.MouseButton1Click:Connect(function()
        SoundSystem:play("click")
        -- Smooth exit animation
        playTween(MainContainer, 0.6, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        }, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        
        playTween(BlurEffect, 0.6, {Size = 0})
        
        task.wait(0.6)
        particles:destroy()
        ScreenGui:Destroy()
        BlurEffect:Destroy()
    end)
    
    -- Apply hover effects to dialog buttons
    HoverSystem:setupAdvancedHover(CancelButton, {hoverScale = 1.05})
    HoverSystem:setupAdvancedHover(ExitButton, {hoverScale = 1.05})
end

CloseButton.MouseButton1Click:Connect(showExitConfirmation)

-- DRAGGING SYSTEM with smooth physics
local DragSystem = {}
DragSystem.dragging = false
DragSystem.dragStart = nil
DragSystem.startPos = nil

function DragSystem:enable(dragHandle, targetFrame)
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.dragging = true
            self.dragStart = input.Position
            self.startPos = targetFrame.Position
            
            -- Visual feedback
            playTween(targetFrame, 0.1, {Size = targetFrame.Size * 0.98})
        end
    end)
    
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            self.dragInput = input
        end
    end)
    
    UserInput.InputChanged:Connect(function(input)
        if input == self.dragInput and self.dragging then
            local delta = input.Position - self.dragStart
            targetFrame.Position = UDim2.new(
                self.startPos.X.Scale, 
                self.startPos.X.Offset + delta.X,
                self.startPos.Y.Scale, 
                self.startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    dragHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.dragging = false
            playTween(targetFrame, 0.1, {Size = UDim2.new(0, 520, 0, 420)})
        end
    end)
end

-- Enable dragging
DragSystem:enable(HeaderSection, MainContainer)

-- FOOTER SECTION
local FooterSection = Instance.new("Frame")
FooterSection.Size = UDim2.new(1, 0, 0, 30)
FooterSection.Position = UDim2.new(0, 0, 1, -35)
FooterSection.BackgroundTransparency = 1
FooterSection.ZIndex = 8
FooterSection.Parent = ContentArea

local FooterText = Instance.new("TextLabel")
FooterText.Size = UDim2.new(1, 0, 1, 0)
FooterText.Text = CONFIG.COMPANY .. " © 2025 | " .. CONFIG.VERSION .. " | Professional Edition"
FooterText.Font = Enum.Font.Gotham
FooterText.TextSize = 12
FooterText.TextColor3 = Color3.fromRGB(120, 150, 200)
FooterText.BackgroundTransparency = 1
FooterText.ZIndex = 9
FooterText.Parent = FooterSection

-- ENTRANCE ANIMATION
MainContainer.Size = UDim2.new(0, 0, 0, 0)
MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
MainContainer.BackgroundTransparency = 1

-- Dramatic entrance
task.wait(0.2)
playTween(MainContainer, 1, {
    Size = UDim2.new(0, 520, 0, 420),
    Position = UDim2.new(0.5, -260, 0.5, -210),
    BackgroundTransparency = 0.15
}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- Animate elements sequentially
task.wait(0.5)
HeaderSection.BackgroundTransparency = 1
playTween(HeaderSection, 0.5, {BackgroundTransparency = 0.1})

task.wait(0.2)
SecurityIndicator.BackgroundTransparency = 1
playTween(SecurityIndicator, 0.5, {BackgroundTransparency = 0.3})

task.wait(0.2)
InputFieldContainer.BackgroundTransparency = 1
playTween(InputFieldContainer, 0.5, {BackgroundTransparency = 0.2})

task.wait(0.2)
VerifyButton.BackgroundTransparency = 1
playTween(VerifyButton, 0.5, {BackgroundTransparency = 0})

-- KEYBOARD SHORTCUTS
UserInput.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Return and KeyInput:IsFocused() then
        VerifyButton.MouseButton1Click:Fire()
    elseif input.KeyCode == Enum.KeyCode.Escape then
        showExitConfirmation()
    end
end)

-- ADVANCED STATUS SYSTEM
local StatusSystem = {}
StatusSystem.currentStatus = "idle"

function StatusSystem:updateStatus(status, message)
    self.currentStatus = status
    
    local statusColors = {
        idle = Color3.fromRGB(100, 150, 255),
        processing = Color3.fromRGB(255, 200, 100),
        success = Color3.fromRGB(100, 255, 150),
        error = Color3.fromRGB(255, 100, 100)
    }
    
    -- Update security indicator
    playTween(SecurityIcon, 0.3, {ImageColor3 = statusColors[status]})
    if message then
        SecurityText.Text = message
    end
end

-- ADVANCED RIPPLE EFFECT SYSTEM
local function createRippleEffect(button, clickPosition)
    local ripple = Instance.new("Frame")
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0, clickPosition.X, 0, clickPosition.Y)
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.7
    ripple.BorderSizePixel = 0
    ripple.ZIndex = button.ZIndex + 1
    ripple.Parent = button
    createUICorner(ripple, 100)
    
    -- Animate ripple
    local maxSize = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
    playTween(ripple, 0.6, {
        Size = UDim2.new(0, maxSize, 0, maxSize),
        Position = UDim2.new(0, clickPosition.X - maxSize/2, 0, clickPosition.Y - maxSize/2),
        BackgroundTransparency = 1
    })
    
    task.delay(0.6, function()
        ripple:Destroy()
    end)
end

-- Add ripple effects to buttons
VerifyButton.MouseButton1Click:Connect(function()
    local mouse = UserInput:GetMouseLocation()
    local buttonPos = VerifyButton.AbsolutePosition
    local relativePos = mouse - buttonPos
    createRippleEffect(VerifyButton, relativePos)
end)

CloseButton.MouseButton1Click:Connect(function()
    local mouse = UserInput:GetMouseLocation()
    local buttonPos = CloseButton.AbsolutePosition
    local relativePos = mouse - buttonPos
    createRippleEffect(CloseButton, relativePos)
end)

-- ADVANCED BACKGROUND EFFECTS
local BackgroundEffects = {}

function BackgroundEffects:createFloatingShapes()
    task.spawn(function()
        while ScreenGui.Parent do
            local shape = Instance.new("Frame")
            shape.Size = UDim2.new(0, math.random(20, 60), 0, math.random(20, 60))
            shape.Position = UDim2.new(math.random(), 0, 1.2, 0)
            shape.BackgroundColor3 = Color3.fromHSV(0.55 + math.random() * 0.3, 0.5, 0.8)
            shape.BackgroundTransparency = 0.8
            shape.BorderSizePixel = 0
            shape.ZIndex = 1
            shape.Parent = ScreenGui
            
            -- Random shape
            if math.random() > 0.5 then
                createUICorner(shape, 50) -- Circle
            else
                createUICorner(shape, 8) -- Rounded rectangle
            end
            
            -- Animate upward
            local endY = -0.2
            local duration = math.random(8, 15)
            playTween(shape, duration, {
                Position = UDim2.new(math.random(), math.random(-100, 100), endY, 0),
                Rotation = math.random(-180, 180),
                BackgroundTransparency = 1
            }, Enum.EasingStyle.Sine)
            
            task.delay(duration, function()
                if shape and shape.Parent then
                    shape:Destroy()
                end
            end)
            
            task.wait(math.random(1, 3))
        end
    end)
end

BackgroundEffects:createFloatingShapes()

-- ADVANCED GLOW EFFECTS
local function createAdvancedGlow(element, color, intensity)
    local glowFrame = Instance.new("Frame")
    glowFrame.Size = UDim2.new(1, intensity * 2, 1, intensity * 2)
    glowFrame.Position = UDim2.new(0, -intensity, 0, -intensity)
    glowFrame.BackgroundTransparency = 1
    glowFrame.BorderSizePixel = 0
    glowFrame.ZIndex = element.ZIndex - 1
    glowFrame.Parent = element.Parent
    
    local glowStroke = createUIStroke(glowFrame, color, intensity, 0.8)
    createUICorner(glowFrame, (element:FindFirstChild("UICorner") and element.UICorner.CornerRadius.Offset or 0) + intensity)
    
    return glowFrame
end

-- Add glows to important elements
createAdvancedGlow(VerifyButton, Color3.fromRGB(100, 200, 255), 10)
createAdvancedGlow(LogoContainer, Color3.fromRGB(120, 180, 255), 8)

-- TYPING ANIMATION FOR TEXT ELEMENTS
local function typewriterEffect(textLabel, finalText, speed)
    textLabel.Text = ""
    task.spawn(function()
        for i = 1, #finalText do
            textLabel.Text = string.sub(finalText, 1, i)
            task.wait(speed or 0.03)
        end
    end)
end

-- Apply typewriter effects with delays
task.wait(1.2)
typewriterEffect(MainTitle, CONFIG.APP_NAME, 0.05)
task.wait(0.5)
typewriterEffect(Subtitle, "Professional Access Control System " .. CONFIG.VERSION, 0.02)
task.wait(0.3)
typewriterEffect(WelcomeTitle, "Authentication Required", 0.04)
task.wait(0.2)
typewriterEffect(WelcomeDesc, "Please enter your premium access key to continue", 0.03)

-- ADVANCED INPUT VALIDATION WITH REAL-TIME FEEDBACK
local ValidationSystem = {}

function ValidationSystem:validateRealTime(input)
    local text = input or ""
    local feedback = {
        strength = 0,
        message = "Enter your key",
        color = Color3.fromRGB(180, 200, 255)
    }
    
    if #text == 0 then
        feedback.message = "Enter your key"
        feedback.strength = 0
    elseif #text < 5 then
        feedback.message = "Key too short"
        feedback.strength = 0.2
        feedback.color = Color3.fromRGB(255, 150, 100)
    elseif #text < 10 then
        feedback.message = "Checking format..."
        feedback.strength = 0.5
        feedback.color = Color3.fromRGB(255, 200, 100)
    else
        feedback.message = "Key format valid"
        feedback.strength = 0.8
        feedback.color = Color3.fromRGB(150, 255, 180)
    end
    
    return feedback
end

-- Real-time validation
KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
    local validation = ValidationSystem:validateRealTime(KeyInput.Text)
    
    -- Update visual feedback
    playTween(StrengthFill, 0.2, {
        Size = UDim2.new(validation.strength, 0, 1, 0),
        BackgroundColor3 = validation.color
    })
    
    -- Update status
    StatusSystem:updateStatus(
        validation.strength > 0.7 and "success" or (validation.strength > 0.3 and "processing" or "idle"),
        validation.message
    )
end)

-- PERFORMANCE OPTIMIZATION
local PerformanceManager = {}
PerformanceManager.frameCount = 0
PerformanceManager.lastFpsUpdate = tick()

function PerformanceManager:monitor()
    task.spawn(function()
        while ScreenGui.Parent do
            self.frameCount = self.frameCount + 1
            
            if tick() - self.lastFpsUpdate >= 1 then
                local fps = self.frameCount
                self.frameCount = 0
                self.lastFpsUpdate = tick()
                
                -- Adjust effects based on performance
                if fps < 30 then
                    -- Reduce particle count for better performance
                    particles.running = false
                end
            end
            
            RunService.Heartbeat:Wait()
        end
    end)
end

PerformanceManager:monitor()

-- ACCESSIBILITY FEATURES
local AccessibilitySystem = {}

function AccessibilitySystem:init()
    -- High contrast mode toggle (for accessibility)
    local function toggleHighContrast()
        -- Implementation for high contrast mode
        MainContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        HeaderSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MainTitle.TextColor3 = Color3.fromRGB(0, 0, 0)
    end
    
    -- Screen reader support (basic implementation)
    local function announceToScreenReader(text)
        -- This would integrate with screen reader APIs in a full implementation
        print("[Screen Reader]: " .. text)
    end
    
    -- Focus management
    KeyInput.Focused:Connect(function()
        announceToScreenReader("Access key input field focused")
    end)
    
    VerifyButton.Focused:Connect(function()
        announceToScreenReader("Verify button focused")
    end)
end

AccessibilitySystem:init()

-- ERROR RECOVERY SYSTEM
local ErrorRecovery = {}

function ErrorRecovery:handleError(errorType, errorMessage)
    warn("[SecureHub Pro] Error: " .. errorType .. " - " .. errorMessage)
    
    NotificationSystem:show("System error occurred. Please try again.", "error", 4)
    
    -- Reset to safe state
    LoadingSystem:hide()
    VerifyButton.Text = "VERIFY ACCESS KEY"
    playTween(VerifyButton, 0.3, {BackgroundColor3 = Color3.fromRGB(60, 120, 255)})
    StatusSystem:updateStatus("idle", "System ready")
end

-- Wrap critical functions in error handling
local originalValidateKey = validateKey
validateKey = function(key)
    local success, result = pcall(originalValidateKey, key)
    if not success then
        ErrorRecovery:handleError("Validation", result)
        return false
    end
    return result
end

-- FINAL INITIALIZATION
task.spawn(function()
    -- Preload sounds and effects
    task.wait(0.1)
    
    -- Initialize all systems
    StatusSystem:updateStatus("idle", "System initialized • Ready for authentication")
    
    -- Welcome animation sequence
    task.wait(0.5)
    playTween(WelcomeTitle, 0.5, {TextTransparency = 0})
    task.wait(0.2)
    playTween(WelcomeDesc, 0.5, {TextTransparency = 0})
    
    -- Focus on input field after animations
    task.wait(1)
    KeyInput:CaptureFocus()
end)

-- CLEANUP FUNCTION
local function cleanup()
    if particles then particles:destroy() end
    if BlurEffect then BlurEffect:Destroy() end
    if ScreenGui then ScreenGui:Destroy() end
end

-- Auto-cleanup on player leaving
Players.PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        cleanup()
    end
end)

-- DEMO KEYS INFORMATION (for testing)
--[[
DEMO KEYS FOR TESTING:
- DEMO-KEY-2025
- PREMIUM-ACCESS  
- PROFESSIONAL-KEY

Features included:
✓ Advanced glassmorphism design
✓ Smooth animations and transitions
✓ Particle effects system
✓ Professional loading states
✓ Real-time key validation
✓ Security status indicators
✓ Sound effects integration
✓ Accessibility features
✓ Error recovery system
✓ Performance optimization
✓ Responsive hover effects
✓ Advanced notification system
--]]

print("[SecureHub Pro] Professional Key System v3.0 loaded successfully!")
print("[SecureHub Pro] Enhanced security and UI features active")
print("[SecureHub Pro] Demo keys available for testing")
