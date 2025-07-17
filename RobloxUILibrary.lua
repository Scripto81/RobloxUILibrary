local DiscordStyleUILibrary = {}
DiscordStyleUILibrary.__index = DiscordStyleUILibrary

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function createScreenGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DiscordStyleUILibrary"
    screenGui.Parent = CoreGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    return screenGui
end

local function createFrame(parent, properties)
    local frame = Instance.new("Frame")
    for key, value in pairs(properties) do
        frame[key] = value
    end
    frame.Parent = parent
    return frame
end

local function createTextLabel(parent, properties)
    local textLabel = Instance.new("TextLabel")
    for key, value in pairs(properties) do
        textLabel[key] = value
    end
    textLabel.Parent = parent
    return textLabel
end

local function createTextBox(parent, properties)
    local textBox = Instance.new("TextBox")
    for key, value in pairs(properties) do
        textBox[key] = value
    end
    textBox.Parent = parent
    return textBox
end

local function createImageButton(parent, properties)
    local imageButton = Instance.new("ImageButton")
    local validProperties = {
        "Name", "BackgroundColor3", "BackgroundTransparency", "BorderColor3", "BorderSizePixel",
        "Position", "Size", "AnchorPoint", "Rotation", "LayoutOrder", "ZIndex",
        "Visible", "Active", "Draggable", "AutoButtonColor", "Image", "ImageColor3",
        "ImageRectOffset", "ImageRectSize", "ImageTransparency", "ScaleType", "SliceCenter",
        "SliceScale", "TileSize", "HoverImage", "PressedImage", "SelectedImage"
    }
    
    for key, value in pairs(properties) do
        if table.find(validProperties, key) then
            imageButton[key] = value
        end
    end
    imageButton.Parent = parent
    return imageButton
end

local function createScrollingFrame(parent, properties)
    local scrollingFrame = Instance.new("ScrollingFrame")
    for key, value in pairs(properties) do
        scrollingFrame[key] = value
    end
    scrollingFrame.Parent = parent
    return scrollingFrame
end

local function createUICorner(parent, properties)
    local uiCorner = Instance.new("UICorner")
    for key, value in pairs(properties) do
        uiCorner[key] = value
    end
    uiCorner.Parent = parent
    return uiCorner
end

local function createUIStroke(parent, properties)
    local uiStroke = Instance.new("UIStroke")
    for key, value in pairs(properties) do
        uiStroke[key] = value
    end
    uiStroke.Parent = parent
    return uiStroke
end

local function createUIPadding(parent, properties)
    local uiPadding = Instance.new("UIPadding")
    for key, value in pairs(properties) do
        uiPadding[key] = value
    end
    uiPadding.Parent = parent
    return uiPadding
end

local function createUIListLayout(parent, properties)
    local uiListLayout = Instance.new("UIListLayout")
    for key, value in pairs(properties) do
        uiListLayout[key] = value
    end
    uiListLayout.Parent = parent
    return uiListLayout
end

local function tween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(duration or 0.3, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

local function makeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil
    
    local function Update(input)
        local Delta = input.Position - DragStart
        local pos = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        object.Position = pos
    end
    
    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = object.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    
    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

function DiscordStyleUILibrary.new()
    local self = setmetatable({}, DiscordStyleUILibrary)
    self.screenGui = createScreenGui()
    self.components = {}
    self.windows = {}
    self.theme = {
        primary = Color3.fromRGB(32, 34, 37),
        secondary = Color3.fromRGB(41, 43, 47),
        tertiary = Color3.fromRGB(54, 57, 63),
        accent = Color3.fromRGB(114, 137, 228),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(127, 131, 137),
        textTertiary = Color3.fromRGB(99, 102, 109),
        border = Color3.fromRGB(37, 40, 43),
        success = Color3.fromRGB(87, 227, 137),
        warning = Color3.fromRGB(255, 184, 108),
        error = Color3.fromRGB(237, 66, 69)
    }
    return self
end

function DiscordStyleUILibrary:createWindow(title, size, position)
    local currentservertoggled = ""
    local minimized = false
    local settingsopened = false
    
    local MainFrame = createFrame(self.screenGui, {
        Name = "MainFrame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = self.theme.primary,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = position or UDim2.new(0.5, 0, 0.5, 0),
        Size = size or UDim2.new(0, 681, 0, 396)
    })
    
    local TopFrame = createFrame(MainFrame, {
        Name = "TopFrame",
        BackgroundColor3 = self.theme.primary,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(-0.000658480625, 0, 0, 0),
        Size = UDim2.new(0, 681, 0, 22)
    })
    
    local TopFrameHolder = createFrame(TopFrame, {
        Name = "TopFrameHolder",
        BackgroundColor3 = self.theme.primary,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(-0.000658480625, 0, 0, 0),
        Size = UDim2.new(0, 681, 0, 22)
    })
    
    local Title = createTextLabel(TopFrame, {
        Name = "Title",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0102790017, 0, 0, 0),
        Size = UDim2.new(0, 192, 0, 23),
        Font = Enum.Font.Gotham,
        Text = title or "Discord UI",
        TextColor3 = self.theme.textTertiary,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local CloseBtn = createImageButton(TopFrame, {
        Name = "CloseBtn",
        BackgroundColor3 = self.theme.primary,
        BackgroundTransparency = 0,
        Position = UDim2.new(0.959063113, 0, -0.0169996787, 0),
        Size = UDim2.new(0, 28, 0, 22),
        BorderSizePixel = 0,
        AutoButtonColor = false
    })
    
    local CloseIcon = createTextLabel(CloseBtn, {
        Name = "CloseIcon",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.189182192, 0, 0.128935531, 0),
        Size = UDim2.new(0, 17, 0, 17),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = Color3.fromRGB(220, 221, 222),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    
    local MinimizeBtn = createImageButton(TopFrame, {
        Name = "MinimizeButton",
        BackgroundColor3 = self.theme.primary,
        BackgroundTransparency = 0,
        Position = UDim2.new(0.917947114, 0, -0.0169996787, 0),
        Size = UDim2.new(0, 28, 0, 22),
        BorderSizePixel = 0,
        AutoButtonColor = false
    })
    
    local MinimizeIcon = createTextLabel(MinimizeBtn, {
        Name = "MinimizeLabel",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.189182192, 0, 0.128935531, 0),
        Size = UDim2.new(0, 17, 0, 17),
        Font = Enum.Font.GothamBold,
        Text = "−",
        TextColor3 = Color3.fromRGB(220, 221, 222),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    
    local ServersHolder = createFrame(TopFrameHolder, {
        Name = "ServersHolder"
    })
    
    local Userpad = createFrame(TopFrameHolder, {
        Name = "Userpad",
        BackgroundColor3 = self.theme.secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0.106243297, 0, 15.9807148, 0),
        Size = UDim2.new(0, 179, 0, 43)
    })
    
    local UserIcon = createFrame(Userpad, {
        Name = "UserIcon",
        BackgroundColor3 = Color3.fromRGB(31, 33, 36),
        BorderSizePixel = 0,
        Position = UDim2.new(0.0340000018, 0, 0.123456791, 0),
        Size = UDim2.new(0, 32, 0, 32)
    })
    
    createUICorner(UserIcon, {CornerRadius = UDim.new(0, 16)})
    
    local UserImage = createTextLabel(UserIcon, {
        Name = "UserImage",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 32, 0, 32),
        Font = Enum.Font.GothamBold,
        Text = "U",
        TextColor3 = self.theme.text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    
    local UserName = createTextLabel(Userpad, {
        Name = "UserName",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.245809972, 0, 0.291666657, 0),
        Size = UDim2.new(0, 1, 0, 1),
        Font = Enum.Font.Gotham,
        Text = player.Name,
        TextColor3 = self.theme.text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local UserTag = createTextLabel(Userpad, {
        Name = "UserTag",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.245809972, 0, 0.583333313, 0),
        Size = UDim2.new(0, 1, 0, 1),
        Font = Enum.Font.Gotham,
        Text = "#" .. tostring(math.random(1000, 9999)),
        TextColor3 = self.theme.textSecondary,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local ServersHoldFrame = createFrame(TopFrameHolder, {
        Name = "ServersHoldFrame",
        BackgroundColor3 = self.theme.secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0.106243297, 0, 1.01886797, 0),
        Size = UDim2.new(0, 179, 0, 296)
    })
    
    local ServersHold = createScrollingFrame(ServersHoldFrame, {
        Name = "ServersHold",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 179, 0, 296),
        ScrollBarThickness = 4,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    
    createUIListLayout(ServersHold, {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 0, 0, 0)
    })
    
    createUIPadding(ServersHold, {
        PaddingTop = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 5)
    })
    
    local ChannelHolder = createFrame(MainFrame, {
        Name = "ChannelHolder",
        BackgroundColor3 = self.theme.secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0.262848735, 0, 0, 0),
        Size = UDim2.new(0, 179, 0, 396)
    })
    
    local ChannelHolderTitle = createTextLabel(ChannelHolder, {
        Name = "ChannelHolderTitle",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 179, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = "CHANNELS",
        TextColor3 = self.theme.textSecondary,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    
    local ChannelHolderList = createScrollingFrame(ChannelHolder, {
        Name = "ChannelHolderList",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 30),
        Size = UDim2.new(0, 179, 0, 366),
        ScrollBarThickness = 4,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    
    createUIListLayout(ChannelHolderList, {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 0, 0, 0)
    })
    
    createUIPadding(ChannelHolderList, {
        PaddingTop = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 5)
    })
    
    local ContentHolder = createFrame(MainFrame, {
        Name = "ContentHolder",
        BackgroundColor3 = self.theme.tertiary,
        BorderSizePixel = 0,
        Position = UDim2.new(0.441997081, 0, 0, 0),
        Size = UDim2.new(0, 378, 0, 396)
    })
    
    local ContentHolderTitle = createTextLabel(ContentHolder, {
        Name = "ContentHolderTitle",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 378, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = "CONTENT",
        TextColor3 = self.theme.text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    
    local ContentHolderList = createScrollingFrame(ContentHolder, {
        Name = "ContentHolderList",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 30),
        Size = UDim2.new(0, 378, 0, 366),
        ScrollBarThickness = 4,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    
    createUIListLayout(ContentHolderList, {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 0, 0, 0)
    })
    
    createUIPadding(ContentHolderList, {
        PaddingTop = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 5)
    })
    
    -- Make window draggable
    makeDraggable(TopFrame, MainFrame)
    
    -- Close button functionality
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame:Destroy()
    end)
    
    -- Minimize button functionality
    MinimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            tween(MainFrame, {Size = UDim2.new(0, 681, 0, 22)})
            ServersHoldFrame.Visible = false
            ChannelHolder.Visible = false
            ContentHolder.Visible = false
        else
            tween(MainFrame, {Size = size or UDim2.new(0, 681, 0, 396)})
            ServersHoldFrame.Visible = true
            ChannelHolder.Visible = true
            ContentHolder.Visible = true
        end
    end)
    
    local windowObj = {
        mainFrame = MainFrame,
        topFrame = TopFrame,
        serversHolder = ServersHolder,
        channelHolder = ChannelHolderList,
        contentHolder = ContentHolderList,
        minimized = minimized
    }
    
    table.insert(self.components, windowObj)
    table.insert(self.windows, windowObj)
    return windowObj
end

function DiscordStyleUILibrary:createServer(window, name, icon)
    local ServerFrame = createFrame(window.serversHolder, {
        Name = name,
        BackgroundColor3 = self.theme.tertiary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 47, 0, 47)
    })
    
    createUICorner(ServerFrame, {CornerRadius = UDim.new(0, 23.5)})
    
    local ServerIcon = createTextLabel(ServerFrame, {
        Name = "ServerIcon",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 47, 0, 47),
        Font = Enum.Font.GothamBold,
        Text = icon or string.sub(name, 1, 1):upper(),
        TextColor3 = self.theme.text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    
    ServerFrame.MouseButton1Click:Connect(function()
        -- Handle server selection
        for _, server in pairs(window.serversHolder:GetChildren()) do
            if server:IsA("Frame") then
                tween(server, {BackgroundColor3 = self.theme.tertiary})
            end
        end
        tween(ServerFrame, {BackgroundColor3 = self.theme.accent})
    end)
    
    return ServerFrame
end

function DiscordStyleUILibrary:createChannel(window, name, callback)
    local ChannelFrame = createFrame(window.channelHolder, {
        Name = name,
        BackgroundColor3 = self.theme.tertiary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 161, 0, 30)
    })
    
    createUICorner(ChannelFrame, {CornerRadius = UDim.new(0, 4)})
    
    local ChannelName = createTextLabel(ChannelFrame, {
        Name = "ChannelName",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 5, 0, 0),
        Size = UDim2.new(0, 151, 0, 30),
        Font = Enum.Font.Gotham,
        Text = "# " .. name,
        TextColor3 = self.theme.textSecondary,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    ChannelFrame.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return ChannelFrame
end

function DiscordStyleUILibrary:createButton(parent, text, callback)
    local ButtonFrame = createFrame(parent, {
        Name = "Button",
        BackgroundColor3 = self.theme.tertiary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 358, 0, 30)
    })
    
    createUICorner(ButtonFrame, {CornerRadius = UDim.new(0, 4)})
    
    local ButtonText = createTextLabel(ButtonFrame, {
        Name = "ButtonText",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 5, 0, 0),
        Size = UDim2.new(0, 348, 0, 30),
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = self.theme.text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    ButtonFrame.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return ButtonFrame
end

function DiscordStyleUILibrary:createToggle(parent, text, default, callback)
    local ToggleFrame = createFrame(parent, {
        Name = "Toggle",
        BackgroundColor3 = self.theme.tertiary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 358, 0, 30)
    })
    
    createUICorner(ToggleFrame, {CornerRadius = UDim.new(0, 4)})
    
    local ToggleText = createTextLabel(ToggleFrame, {
        Name = "ToggleText",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 5, 0, 0),
        Size = UDim2.new(0, 200, 0, 30),
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = self.theme.text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local ToggleButton = createFrame(ToggleFrame, {
        Name = "ToggleButton",
        BackgroundColor3 = default and self.theme.accent or self.theme.tertiary,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -25, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16)
    })
    
    createUICorner(ToggleButton, {CornerRadius = UDim.new(0, 8)})
    
    local isToggled = default or false
    
    ToggleFrame.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        if isToggled then
            tween(ToggleButton, {BackgroundColor3 = self.theme.accent})
        else
            tween(ToggleButton, {BackgroundColor3 = self.theme.tertiary})
        end
        if callback then
            callback(isToggled)
        end
    end)
    
    return ToggleFrame
end

function DiscordStyleUILibrary:createSlider(parent, text, min, max, default, callback)
    local SliderFrame = createFrame(parent, {
        Name = "Slider",
        BackgroundColor3 = self.theme.tertiary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 358, 0, 50)
    })
    
    createUICorner(SliderFrame, {CornerRadius = UDim.new(0, 4)})
    
    local SliderText = createTextLabel(SliderFrame, {
        Name = "SliderText",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 5, 0, 0),
        Size = UDim2.new(0, 200, 0, 20),
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = self.theme.text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local SliderTrack = createFrame(SliderFrame, {
        Name = "SliderTrack",
        BackgroundColor3 = self.theme.primary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 5, 0, 25),
        Size = UDim2.new(0, 348, 0, 4)
    })
    
    createUICorner(SliderTrack, {CornerRadius = UDim.new(0, 2)})
    
    local SliderFill = createFrame(SliderTrack, {
        Name = "SliderFill",
        BackgroundColor3 = self.theme.accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 0, 1, 0)
    })
    
    createUICorner(SliderFill, {CornerRadius = UDim.new(0, 2)})
    
    local SliderButton = createFrame(SliderFrame, {
        Name = "SliderButton",
        BackgroundColor3 = self.theme.text,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 5, 0, 25),
        Size = UDim2.new(0, 12, 0, 12)
    })
    
    createUICorner(SliderButton, {CornerRadius = UDim.new(0, 6)})
    
    local currentValue = default or min
    local isDragging = false
    
    local function updateSlider(value)
        currentValue = math.clamp(value, min, max)
        local percentage = (currentValue - min) / (max - min)
        SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        SliderButton.Position = UDim2.new(percentage, -6, 0, 25)
        
        if callback then
            callback(currentValue)
        end
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        isDragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if isDragging then
            local mousePos = UserInputService:GetMouseLocation()
            local sliderPos = SliderTrack.AbsolutePosition
            local sliderSize = SliderTrack.AbsoluteSize
            local relativeX = (mousePos.X - sliderPos.X) / sliderSize.X
            local percentage = math.clamp(relativeX, 0, 1)
            local value = min + (max - min) * percentage
            updateSlider(value)
        end
    end)
    
    updateSlider(currentValue)
    
    return SliderFrame
end

function DiscordStyleUILibrary:createTextBox(parent, text, placeholder, callback)
    local TextBoxFrame = createFrame(parent, {
        Name = "TextBox",
        BackgroundColor3 = self.theme.tertiary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 358, 0, 30)
    })
    
    createUICorner(TextBoxFrame, {CornerRadius = UDim.new(0, 4)})
    
    local TextBoxTitle = createTextLabel(TextBoxFrame, {
        Name = "TextBoxTitle",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 5, 0, 0),
        Size = UDim2.new(0, 200, 0, 15),
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = self.theme.textSecondary,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local TextBoxInput = createTextBox(TextBoxFrame, {
        Name = "TextBoxInput",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 5, 0, 15),
        Size = UDim2.new(0, 348, 0, 15),
        Font = Enum.Font.Gotham,
        PlaceholderText = placeholder or "Enter text...",
        PlaceholderColor3 = self.theme.textSecondary,
        Text = "",
        TextColor3 = self.theme.text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    TextBoxInput.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            callback(TextBoxInput.Text)
        end
    end)
    
    return TextBoxFrame
end

function DiscordStyleUILibrary:destroy()
    if self.screenGui then
        self.screenGui:Destroy()
    end
end

return DiscordStyleUILibrary 
