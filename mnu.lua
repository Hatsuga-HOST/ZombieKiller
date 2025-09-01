-- ZiaanHub - Main Menu Hub (Full Custom UI, Tab Home full)
-- Enhanced with modern design elements and better layout

-- ===========================
-- CONFIG / ASSET PLACEHOLDERS
-- ===========================
local ASSETS = {
    WINDOW_BG = nil,             -- optional image asset id for background (leave nil for solid)
    LOGO = 0,                    -- main left-top moon logo (replace with your asset id)
    ICON_HOME = 0,               -- sidebar icon Home
    ICON_CODE = 0,               -- sidebar icon Code
    ICON_PIN = 0,                -- sidebar icon Pin
    ICON_USER = 0,               -- sidebar icon User
    ICON_STAR = 0,               -- sidebar icon Star
    ICON_BELL = 0,               -- sidebar icon Bell
    ICON_GEAR = 0,               -- sidebar icon Gear
    FOOTER_AVATAR = 0,           -- small avatar icon bottom-left
    DISCORD_INVITE = "https://discord.gg/yourinvite" -- replace with your invite
}

-- ===========================
-- SERVICES
-- ===========================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ===========================
-- UTILS
-- ===========================
local function Create(class, props)
    local obj = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            if k ~= "Parent" and k ~= "Children" then
                if type(v) == "table" and v.ClassName then
                    obj[k] = Create(v.ClassName, v)
                else
                    obj[k] = v
                end
            end
        end
        if props.Parent then obj.Parent = props.Parent end
        
        -- Handle children
        if props.Children then
            for _, childProps in ipairs(props.Children) do
                Create(childProps.ClassName or childProps[1], {
                    Parent = obj,
                    table.unpack(childProps, 2)
                })
            end
        end
    end
    return obj
end

local function SafePcall(fn)
    local ok, res = pcall(fn)
    if ok then return res end
    return nil
end

local function SetClipboard(text)
    pcall(function()
        if setclipboard then
            setclipboard(text)
        elseif writeclipboard then
            writeclipboard(text)
        end
    end)
end

local function Tween(instance, props, time, style, dir)
    style = style or Enum.EasingStyle.Quad
    dir = dir or Enum.EasingDirection.Out
    TweenService:Create(instance, TweenInfo.new(time or 0.25, style, dir), props):Play()
end

local function FormatTime(sec)
    sec = math.floor(sec)
    local h = math.floor(sec / 3600)
    local m = math.floor((sec % 3600) / 60)
    local s = sec % 60
    if h > 0 then
        return string.format("%02d:%02d:%02d", h, m, s)
    else
        return string.format("%02d:%02d", m, s)
    end
end

-- ===========================
-- COLORS
-- ===========================
local COLORS = {
    BACKGROUND = {
        PRIMARY = Color3.fromRGB(28, 28, 32),
        SECONDARY = Color3.fromRGB(34, 34, 38),
        TERTIARY = Color3.fromRGB(30, 30, 34),
        CARD = Color3.fromRGB(35, 35, 40),
        BUTTON = Color3.fromRGB(40, 40, 44),
        BUTTON_HOVER = Color3.fromRGB(50, 50, 54),
        BUTTON_ACTIVE = Color3.fromRGB(55, 55, 60),
        BOX = Color3.fromRGB(24, 24, 26)
    },
    TEXT = {
        PRIMARY = Color3.fromRGB(240, 240, 240),
        SECONDARY = Color3.fromRGB(190, 190, 190),
        TERTIARY = Color3.fromRGB(150, 150, 180),
        ACCENT = Color3.fromRGB(180, 180, 180)
    },
    SPECIAL = {
        WAVE = Color3.fromRGB(112, 28, 28),
        WAVE_ALT = Color3.fromRGB(55, 55, 55),
        DISCORD = Color3.fromRGB(88, 101, 242),
        DISCORD_HOVER = Color3.fromRGB(105, 116, 245)
    },
    ACCENT = {
        BLUE = Color3.fromRGB(65, 140, 230),
        GREEN = Color3.fromRGB(65, 200, 100),
        RED = Color3.fromRGB(230, 80, 80),
        PURPLE = Color3.fromRGB(150, 100, 220)
    }
}

-- ===========================
-- FONTS
-- ===========================
local FONTS = {
    TITLE = Enum.Font.GothamBold,
    SUBTITLE = Enum.Font.Gotham,
    BODY = Enum.Font.Gotham
}

-- ===========================
-- UI COMPONENTS
-- ===========================
local screenGui = Create("ScreenGui", {
    Name = "ZiaanHub_UI",
    Parent = PlayerGui,
    ResetOnSpawn = false
})

-- Main Window
local MainFrame = Create("Frame", {
    Parent = screenGui,
    Size = UDim2.new(0, 920, 0, 520),
    Position = UDim2.new(0.5, -460, 0.5, -260),
    BackgroundColor3 = COLORS.BACKGROUND.PRIMARY,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 14)}
    }
})

-- Top Header (title + small link)
local Header = Create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, 0, 0, 60),
    BackgroundColor3 = COLORS.BACKGROUND.SECONDARY,
    Position = UDim2.new(0, 0, 0, 0),
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 14)}
    }
})

local LogoImg = Create("ImageLabel", {
    Parent = Header,
    Size = UDim2.new(0, 44, 0, 44),
    Position = UDim2.new(0, 12, 0.5, -22),
    BackgroundTransparency = 1,
    Image = (ASSETS.LOGO and ASSETS.LOGO ~= 0) and ("rbxassetid://" .. tostring(ASSETS.LOGO)) or ""
})

local TitleLabel = Create("TextLabel", {
    Parent = Header,
    Size = UDim2.new(0, 420, 0, 44),
    Position = UDim2.new(0, 70, 0.5, -22),
    BackgroundTransparency = 1,
    Text = "Hidden - Fisch",
    Font = FONTS.TITLE,
    TextSize = 20,
    TextColor3 = COLORS.TEXT.PRIMARY,
    TextXAlignment = Enum.TextXAlignment.Left
})

local SmallLink = Create("TextLabel", {
    Parent = Header,
    Size = UDim2.new(0, 200, 0, 20),
    Position = UDim2.new(1, -220, 0.5, -10),
    BackgroundTransparency = 1,
    Text = ".gg/hiddenrbx",
    Font = FONTS.SUBTITLE,
    TextSize = 14,
    TextColor3 = COLORS.TEXT.TERTIARY,
    TextXAlignment = Enum.TextXAlignment.Right
})

-- Close & Minimize buttons (top-right)
local BtnClose = Create("TextButton", {
    Parent = Header,
    Size = UDim2.new(0, 36, 0, 36),
    Position = UDim2.new(1, -46, 0.5, -18),
    BackgroundColor3 = COLORS.BACKGROUND.BUTTON,
    Text = "X",
    Font = FONTS.TITLE,
    TextSize = 16,
    TextColor3 = COLORS.TEXT.PRIMARY,
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 8)}
    }
})

local BtnMin = Create("TextButton", {
    Parent = Header,
    Size = UDim2.new(0, 36, 0, 36),
    Position = UDim2.new(1, -90, 0.5, -18),
    BackgroundColor3 = COLORS.BACKGROUND.BUTTON,
    Text = "◻",
    Font = FONTS.SUBTITLE,
    TextSize = 16,
    TextColor3 = COLORS.TEXT.PRIMARY,
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 8)}
    }
})

-- Left Sidebar
local SideBar = Create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(0, 72, 1, -70),
    Position = UDim2.new(0, 12, 0, 70),
    BackgroundColor3 = COLORS.BACKGROUND.TERTIARY,
    BorderSizePixel = 0,
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 10)},
        {"UIListLayout", 
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        }
    }
})

-- Sidebar Buttons (icon placeholders)
local sidebarIcons = {
    {name = "Home", id = ASSETS.ICON_HOME},
    {name = "Code", id = ASSETS.ICON_CODE},
    {name = "Pin", id = ASSETS.ICON_PIN},
    {name = "User", id = ASSETS.ICON_USER},
    {name = "Star", id = ASSETS.ICON_STAR},
    {name = "Bell", id = ASSETS.ICON_BELL},
    {name = "Gear", id = ASSETS.ICON_GEAR},
}

local sideButtons = {}
for i, info in ipairs(sidebarIcons) do
    local btn = Create("ImageButton", {
        Parent = SideBar,
        Size = UDim2.new(0, 48, 0, 48),
        BackgroundColor3 = COLORS.BACKGROUND.BUTTON,
        Image = (info.id and info.id ~= 0) and ("rbxassetid://" .. tostring(info.id)) or "",
        ScaleType = Enum.ScaleType.Fit,
        LayoutOrder = i,
        Children = {
            {"UICorner", CornerRadius = UDim.new(0, 10)}
        }
    })
    
    -- Hover effect
    btn.MouseEnter:Connect(function()
        if not (i == 1 and btn.BackgroundColor3 == COLORS.BACKGROUND.BUTTON_ACTIVE) then
            Tween(btn, {BackgroundColor3 = COLORS.BACKGROUND.BUTTON_HOVER}, 0.2)
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if not (i == 1 and btn.BackgroundColor3 == COLORS.BACKGROUND.BUTTON_ACTIVE) then
            Tween(btn, {BackgroundColor3 = COLORS.BACKGROUND.BUTTON}, 0.2)
        end
    end)
    
    sideButtons[#sideButtons+1] = btn
end

-- Small footer avatar (bottom-left)
local FooterAvatar = Create("ImageLabel", {
    Parent = MainFrame,
    Size = UDim2.new(0, 46, 0, 46),
    Position = UDim2.new(0, 20, 1, -56),
    BackgroundTransparency = 1,
    Image = (ASSETS.FOOTER_AVATAR and ASSETS.FOOTER_AVATAR ~= 0) and 
            ("rbxassetid://" .. tostring(ASSETS.FOOTER_AVATAR)) or 
            ("rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=100&h=100"),
    Children = {
        {"UICorner", CornerRadius = UDim.new(1, 0)}
    }
})

-- Content Area (right of sidebar)
local ContentArea = Create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, -108, 1, -86),
    Position = UDim2.new(0, 92, 0, 70),
    BackgroundTransparency = 1
})

-- Scrolling Frame for Content
local ContentScroller = Create("ScrollingFrame", {
    Parent = ContentArea,
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 1,
    ScrollBarThickness = 6,
    ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100),
    CanvasSize = UDim2.new(0, 0, 0, 0), -- Will be updated later
    ScrollingDirection = Enum.ScrollingDirection.Y,
    VerticalScrollBarInset = Enum.ScrollBarInset.Always,
    Children = {
        {"UIListLayout", 
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10)
        }
    }
})

-- === HOME TAB CONTENT ===

-- Profile Bar (top)
local ProfileBar = Create("Frame", {
    Parent = ContentScroller,
    Size = UDim2.new(1, 0, 0, 92),
    BackgroundColor3 = COLORS.BACKGROUND.CARD,
    ClipsDescendants = true,
    LayoutOrder = 1,
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 10)}
    }
})

local Av = Create("ImageLabel", {
    Parent = ProfileBar,
    Size = UDim2.new(0, 68, 0, 68),
    Position = UDim2.new(0, 14, 0.5, -34),
    BackgroundTransparency = 1,
    Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420",
    Children = {
        {"UICorner", CornerRadius = UDim.new(1, 0)}
    }
})

local HelloText = Create("TextLabel", {
    Parent = ProfileBar,
    Size = UDim2.new(0.6, 0, 0, 36),
    Position = UDim2.new(0, 100, 0.18, 0),
    BackgroundTransparency = 1,
    Text = "Hello, " .. (LocalPlayer.DisplayName ~= "" and LocalPlayer.DisplayName or LocalPlayer.Name),
    Font = FONTS.TITLE,
    TextSize = 20,
    TextColor3 = COLORS.TEXT.PRIMARY,
    TextXAlignment = Enum.TextXAlignment.Left
})

local SubText = Create("TextLabel", {
    Parent = ProfileBar,
    Size = UDim2.new(0.6, 0, 0, 20),
    Position = UDim2.new(0, 100, 0.58, 0),
    BackgroundTransparency = 1,
    Text = LocalPlayer.Name .. " - Hidden - Fisch",
    Font = FONTS.SUBTITLE,
    TextSize = 14,
    TextColor3 = COLORS.TEXT.SECONDARY,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Container below profile
local LowerContainer = Create("Frame", {
    Parent = ContentScroller,
    Size = UDim2.new(1, 0, 0, 322), -- Fixed height
    BackgroundTransparency = 1,
    LayoutOrder = 2,
})

-- left column (server)
local LeftCol = Create("Frame", {
    Parent = LowerContainer,
    Size = UDim2.new(0.55, -10, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 1,
})

-- right column (wave + friends)
local RightCol = Create("Frame", {
    Parent = LowerContainer,
    Size = UDim2.new(0.45, 0, 1, 0),
    Position = UDim2.new(0.55, 10, 0, 0),
    BackgroundTransparency = 1,
})

-- Server Card (big)
local ServerCard = Create("Frame", {
    Parent = LeftCol,
    Size = UDim2.new(1, 0, 0, 240),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = COLORS.BACKGROUND.TERTIARY,
    ClipsDescendants = true,
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 12)}
    }
})

local ServerTitle = Create("TextLabel", {
    Parent = ServerCard,
    Text = "Server",
    Size = UDim2.new(1, 0, 0, 28),
    Position = UDim2.new(0, 10, 0, 6),
    BackgroundTransparency = 1,
    Font = FONTS.TITLE,
    TextSize = 18,
    TextColor3 = COLORS.TEXT.PRIMARY,
    TextXAlignment = Enum.TextXAlignment.Left
})

local ServerDesc = Create("TextLabel", {
    Parent = ServerCard,
    Text = "Information on the session you're currently in",
    Size = UDim2.new(1, -20, 0, 20),
    Position = UDim2.new(0, 10, 0, 32),
    BackgroundTransparency = 1,
    Font = FONTS.SUBTITLE,
    TextSize = 13,
    TextColor3 = COLORS.TEXT.SECONDARY,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Grid inside server: we'll create 6 small boxes
local function makeServerBox(name, top, pos)
    local box = Create("Frame", {
        Parent = ServerCard,
        Size = UDim2.new(0.48, 0, 0, 64),
        Position = pos or UDim2.new(0, 10, 0, 64 + (top-1)*74),
        BackgroundColor3 = COLORS.BACKGROUND.BOX,
        Children = {
            {"UICorner", CornerRadius = UDim.new(0, 8)}
        }
    })
    
    local t = Create("TextLabel", {
        Parent = box,
        Text = name,
        Size = UDim2.new(1, -14, 0, 20),
        Position = UDim2.new(0, 8, 0, 6),
        BackgroundTransparency = 1,
        Font = FONTS.TITLE,
        TextSize = 14,
        TextColor3 = COLORS.TEXT.PRIMARY,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local v = Create("TextLabel", {
        Parent = box,
        Text = "—",
        Size = UDim2.new(1, -14, 0, 20),
        Position = UDim2.new(0, 8, 0, 34),
        BackgroundTransparency = 1,
        Font = FONTS.SUBTITLE,
        TextSize = 14,
        TextColor3 = COLORS.TEXT.ACCENT,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    return {frame = box, title = t, value = v}
end

local PlayersBox = makeServerBox("Players", 1, UDim2.new(0, 10, 0, 64))
local MaxPlayersBox = makeServerBox("Maximum Players", 1, UDim2.new(0.52, 0, 0, 64))
local LatencyBox = makeServerBox("Latency", 2, UDim2.new(0, 10, 0, 64 + 74))
local RegionBox = makeServerBox("Server Region", 2, UDim2.new(0.52, 0, 0, 64 + 74))
local InServerForBox = makeServerBox("In server for", 3, UDim2.new(0, 10, 0, 64 + 148))
local JoinScriptBox = makeServerBox("Join Script", 3, UDim2.new(0.52, 0, 0, 64 + 148))

-- Join script button (copy)
local JoinBtn = Create("TextButton", {
    Parent = JoinScriptBox.frame,
    Size = UDim2.new(0.46, -10, 0, 28),
    Position = UDim2.new(0.52, 8, 0, 30),
    BackgroundColor3 = COLORS.BACKGROUND.BUTTON,
    Text = "Copy",
    Font = FONTS.TITLE,
    TextSize = 14,
    TextColor3 = COLORS.TEXT.PRIMARY,
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 6)}
    }
})

-- Right column: Wave + Friends
local WaveCard = Create("Frame", {
    Parent = RightCol,
    Size = UDim2.new(1, 0, 0, 120),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = COLORS.SPECIAL.WAVE,
    ClipsDescendants = true,
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 10)}
    }
})

local WaveTitle = Create("TextLabel", {
    Parent = WaveCard,
    Text = "Wave",
    Size = UDim2.new(1, -18, 0, 28),
    Position = UDim2.new(0, 10, 0, 6),
    BackgroundTransparency = 1,
    Font = FONTS.TITLE,
    TextSize = 16,
    TextColor3 = COLORS.TEXT.PRIMARY,
    TextXAlignment = Enum.TextXAlignment.Left
})

local WaveDesc = Create("TextLabel", {
    Parent = WaveCard,
    Text = "Your executor seems to support this script.",
    Size = UDim2.new(1, -18, 0, 40),
    Position = UDim2.new(0, 10, 0, 36),
    BackgroundTransparency = 1,
    Font = FONTS.SUBTITLE,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(230, 200, 200),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextWrapped = true
})

local FriendsCard = Create("Frame", {
    Parent = RightCol,
    Size = UDim2.new(1, 0, 0, 220),
    Position = UDim2.new(0, 0, 0, 140),
    BackgroundColor3 = COLORS.BACKGROUND.TERTIARY,
    ClipsDescendants = true,
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 10)}
    }
})

local FriendsTitle = Create("TextLabel", {
    Parent = FriendsCard,
    Text = "Friends",
    Size = UDim2.new(1, -18, 0, 28),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Font = FONTS.TITLE,
    TextSize = 16,
    TextColor3 = COLORS.TEXT.PRIMARY,
    TextXAlignment = Enum.TextXAlignment.Left
})

local FriendsDesc = Create("TextLabel", {
    Parent = FriendsCard,
    Text = "Find out what your friends are currently doing",
    Size = UDim2.new(1, -18, 0, 20),
    Position = UDim2.new(0, 10, 0, 34),
    BackgroundTransparency = 1,
    Font = FONTS.SUBTITLE,
    TextSize = 13,
    TextColor3 = COLORS.TEXT.SECONDARY,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Grid of 4 boxes (In Server, Offline, Online, All)
local function makeFriendBox(text, pos)
    local f = Create("Frame", {
        Parent = FriendsCard,
        Size = UDim2.new(0.48, 0, 0, 72),
        Position = pos,
        BackgroundColor3 = COLORS.BACKGROUND.BOX,
        Children = {
            {"UICorner", CornerRadius = UDim.new(0, 8)}
        }
    })
    
    Create("TextLabel", {
        Parent = f,
        Text = text,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 6),
        Size = UDim2.new(1, -16, 0, 20),
        Font = FONTS.TITLE,
        TextSize = 14,
        TextColor3 = COLORS.TEXT.PRIMARY,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local val = Create("TextLabel", {
        Parent = f,
        Text = "0",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 34),
        Size = UDim2.new(1, -16, 0, 28),
        Font = FONTS.SUBTITLE,
        TextSize = 16,
        TextColor3 = COLORS.TEXT.ACCENT,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    return {frame = f, value = val}
end

local FriendInServer = makeFriendBox("In Server", UDim2.new(0, 10, 0, 64))
local FriendOffline   = makeFriendBox("Offline", UDim2.new(0.52, 0, 0, 64))
local FriendOnline    = makeFriendBox("Online", UDim2.new(0, 10, 0, 146))
local FriendAll       = makeFriendBox("All", UDim2.new(0.52, 0, 0, 146))

-- Discord banner (fixed size at bottom)
local DiscordBanner = Create("TextButton", {
    Parent = ContentScroller,
    Size = UDim2.new(1, -20, 0, 50),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundColor3 = COLORS.SPECIAL.DISCORD,
    Text = "",
    LayoutOrder = 3,
    Children = {
        {"UICorner", CornerRadius = UDim.new(0, 12)}
    }
})

local DiscordIcon = Create("ImageLabel", {
    Parent = DiscordBanner,
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(0, 10, 0.5, -15),
    BackgroundTransparency = 1,
    Image = "rbxassetid://72534526032146", -- Discord logo
    ImageColor3 = Color3.fromRGB(255, 255, 255)
})

local DiscTitle = Create("TextLabel", {
    Parent = DiscordBanner,
    Size = UDim2.new(0.7, -10, 0, 24),
    Position = UDim2.new(0, 50, 0, 8),
    BackgroundTransparency = 1,
    Text = "Join Our Discord",
    Font = FONTS.TITLE,
    TextSize = 16,
    TextColor3 = COLORS.TEXT.PRIMARY,
    TextXAlignment = Enum.TextXAlignment.Left
})

local DiscSub = Create("TextLabel", {
    Parent = DiscordBanner,
    Size = UDim2.new(0.8, -10, 0, 18),
    Position = UDim2.new(0, 50, 0, 32),
    BackgroundTransparency = 1,
    Text = "Tap to join the community",
    Font = FONTS.SUBTITLE,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(210, 210, 230),
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Update the ScrollingFrame canvas size
local function UpdateCanvasSize()
    local totalHeight = 0
    for _, child in ipairs(ContentScroller:GetChildren()) do
        if child:IsA("GuiObject") and child ~= ContentScroller:FindFirstChildOfClass("UIListLayout") then
            totalHeight = totalHeight + child.Size.Y.Offset + 10 -- Add padding
        end
    end
    ContentScroller.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- Call this after all elements are added
UpdateCanvasSize()

-- ===========================
-- DYNAMIC LOGIC & UPDATES
-- ===========================
local startTime = tick()

-- update players & max players
local function UpdateServerInfo()
    local cur = #Players:GetPlayers()
    local max = (game.Players.MaxPlayers and tostring(game.Players.MaxPlayers)) or "-"
    PlayersBox.value.Text = tostring(cur) .. " playing"
    MaxPlayersBox.value.Text = tostring(max) .. " max"
end

-- update latency (try Stats)
local function GetLatencyMs()
    local success, Stats = pcall(function() return game:GetService("Stats") end)
    if success and Stats and Stats:FindFirstChild("Network") and Stats.Network:FindFirstChild("ServerStatsItem") then
        local ok, ping = pcall(function()
            local item = Stats.Network.ServerStatsItem
            return item["Data Ping"]:GetValue()
        end)
        if ok and ping then
            return math.floor(ping)
        end
    end
    -- fallback to LocalPlayer:GetNetworkPing if available
    if typeof(LocalPlayer.GetNetworkPing) == "function" then
        local ok, p = pcall(function() return LocalPlayer:GetNetworkPing() end)
        if ok and p then return math.floor(p * 1000) end
    end
    return nil
end

local function UpdateLatencyRegion()
    local ping = GetLatencyMs()
    if ping then
        LatencyBox.value.Text = tostring(ping) .. " ms"
    else
        LatencyBox.value.Text = "-- ms"
    end
    -- region: no direct reliable client API; try to infer from locale or fallback
    local region = "Unknown"
    local ok, Localization = pcall(function() return game:GetService("LocalizationService") end)
    if ok and Localization then
        local suc, locale = pcall(function() return Localization.RobloxLocaleId end)
        if suc and locale then
            region = tostring(locale)
        end
    end
    RegionBox.value.Text = tostring(region)
end

-- update in-server timer
local function UpdateInServerFor()
    local elapsed = tick() - startTime
    InServerForBox.value.Text = FormatTime(elapsed)
end

-- join script copy
JoinBtn.MouseButton1Click:Connect(function()
    local joincode = "loadstring(game:HttpGet('https://raw.githubusercontent.com/your/repo/main/join.lua'))()"
    SetClipboard(joincode)
    -- quick small visual
    JoinBtn.Text = "Copied!"
    Tween(JoinBtn, {BackgroundColor3 = Color3.fromRGB(80, 180, 80)}, 0.2)
    wait(1.2)
    JoinBtn.Text = "Copy"
    Tween(JoinBtn, {BackgroundColor3 = COLORS.BACKGROUND.BUTTON}, 0.2)
end)

-- executor detection (simple)
local function DetectExecutor()
    -- check common globals
    local found = false
    local names = {"syn", "secure_load", "cheat", "KRNL_LOADED", "identifyexecutor", "is_executor"}
    for _, n in ipairs(names) do
        if _G[n] ~= nil or _G[n] == true then found = true break end
        if rawget(_G, n) ~= nil then found = true break end
    end
    -- check functions
    if type(syn) == "table" or type(getexecutor) == "function" or type(writefile) == "function" then
        found = true
    end
    return found
end

local function UpdateWave()
    local ok = DetectExecutor()
    if ok then
        WaveDesc.Text = "Your executor seems to support this script."
        WaveCard.BackgroundColor3 = COLORS.SPECIAL.WAVE
    else
        WaveDesc.Text = "Executor support not detected."
        WaveCard.BackgroundColor3 = COLORS.SPECIAL.WAVE_ALT
    end
end

-- Friends info: use Players:GetFriendsAsync
local friendList = {}
local function RefreshFriends()
    -- get total friends via GetFriendsAsync (might be rate-limited)
    local suc, res = pcall(function() return Players:GetFriendsAsync(LocalPlayer.UserId) end)
    if suc and res then
        friendList = res:GetCurrentPage()
    else
        friendList = {}
    end
end

local function UpdateFriendsBoxes()
    local total = #friendList
    local inServer = 0
    for _, f in ipairs(friendList) do
        for _, p in ipairs(Players:GetPlayers()) do
            if p.UserId == f.Id then
                inServer = inServer + 1
                break
            end
        end
    end
    FriendAll.value.Text = tostring(total)
    FriendInServer.value.Text = tostring(inServer)
    FriendOnline.value.Text = tostring(inServer) -- treat in-server as online
    FriendOffline.value.Text = tostring(math.max(0, total - inServer))
end

-- Discord banner copy
DiscordBanner.MouseButton1Click:Connect(function()
    SetClipboard(ASSETS.DISCORD_INVITE or "")
    -- flash animation
    local orig = DiscordBanner.BackgroundColor3
    Tween(DiscordBanner, {BackgroundColor3 = COLORS.SPECIAL.DISCORD_HOVER}, 0.18)
    wait(0.35)
    Tween(DiscordBanner, {BackgroundColor3 = orig}, 0.25)
end)

-- players join/leave hooking
Players.PlayerAdded:Connect(function()
    UpdateServerInfo()
    UpdateFriendsBoxes()
end)
Players.PlayerRemoving:Connect(function()
    UpdateServerInfo()
    UpdateFriendsBoxes()
end)

-- Button hover effects
BtnClose.MouseEnter:Connect(function()
    Tween(BtnClose, {BackgroundColor3 = Color3.fromRGB(220, 80, 80)}, 0.2)
end)
BtnClose.MouseLeave:Connect(function()
    Tween(BtnClose, {BackgroundColor3 = COLORS.BACKGROUND.BUTTON}, 0.2)
end)

BtnMin.MouseEnter:Connect(function()
    Tween(BtnMin, {BackgroundColor3 = COLORS.BACKGROUND.BUTTON_HOVER}, 0.2)
end)
BtnMin.MouseLeave:Connect(function()
    Tween(BtnMin, {BackgroundColor3 = COLORS.BACKGROUND.BUTTON}, 0.2)
end)

-- Discord banner hover effect
DiscordBanner.MouseEnter:Connect(function()
    Tween(DiscordBanner, {BackgroundColor3 = COLORS.SPECIAL.DISCORD_HOVER}, 0.2)
end)
DiscordBanner.MouseLeave:Connect(function()
    Tween(DiscordBanner, {BackgroundColor3 = COLORS.SPECIAL.DISCORD}, 0.2)
end)

-- initial load
UpdateServerInfo()
UpdateLatencyRegion()
RefreshFriends()
UpdateFriendsBoxes()
UpdateWave()

-- realtime updates via RunService
local lastLatency = 0
RunService.Heartbeat:Connect(function(dt)
    -- update timer every second
    UpdateInServerFor()
    -- update players maybe every 1s
    UpdateServerInfo()

    -- update latency every 2s
    lastLatency = lastLatency + dt
    if lastLatency >= 2 then
        UpdateLatencyRegion()
        lastLatency = 0
    end
end)

-- simple open/close/minimize
local isOpen = true
BtnClose.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    isOpen = false
end)
BtnMin.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- drag behavior for window (TitleLabel and Header)
local dragging, dragStart, startPos
Header.InputBegan:Connect(function(input)
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
Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if dragging and dragStart and startPos then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

-- Focus: default highlight Home sidebar button visually
if sideButtons[1] then
    sideButtons[1].BackgroundColor3 = COLORS.BACKGROUND.BUTTON_ACTIVE
end

-- End of script
