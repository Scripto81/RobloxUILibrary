local AdvancedRobloxUILibrary = {}
AdvancedRobloxUILibrary.__index = AdvancedRobloxUILibrary

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
    screenGui.Name = "AdvancedRobloxUILibrary"
    screenGui.Parent = CoreGui
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
    for key, value in pairs(properties) do
        imageButton[key] = value
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

local function createUIGradient(parent, properties)
    local uiGradient = Instance.new("UIGradient")
    for key, value in pairs(properties) do
        uiGradient[key] = value
    end
    uiGradient.Parent = parent
    return uiGradient
end

local function createUIPadding(parent, properties)
    local uiPadding = Instance.new("UIPadding")
    for key, value in pairs(properties) do
        uiPadding[key] = value
    end
    uiPadding.Parent = parent
    return uiPadding
end

local function createUISizeConstraint(parent, properties)
    local uiSizeConstraint = Instance.new("UISizeConstraint")
    for key, value in pairs(properties) do
        uiSizeConstraint[key] = value
    end
    uiSizeConstraint.Parent = parent
    return uiSizeConstraint
end

local function createUIAspectRatioConstraint(parent, properties)
    local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    for key, value in pairs(properties) do
        uiAspectRatioConstraint[key] = value
    end
    uiAspectRatioConstraint.Parent = parent
    return uiAspectRatioConstraint
end

local function tween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(duration or 0.3, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

local function createShadow(parent)
    local shadow = createFrame(parent, {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = -1
    })
    
    createUICorner(shadow, {CornerRadius = UDim.new(0, 8)})
    createUIStroke(shadow, {Color = Color3.fromRGB(0, 0, 0), Thickness = 0, Transparency = 0.5})
    
    return shadow
end

function AdvancedRobloxUILibrary.new()
    local self = setmetatable({}, AdvancedRobloxUILibrary)
    self.screenGui = createScreenGui()
    self.components = {}
    self.windows = {}
    self.theme = {
        primary = Color3.fromRGB(45, 45, 55),
        secondary = Color3.fromRGB(35, 35, 45),
        accent = Color3.fromRGB(100, 150, 255),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(200, 200, 200),
        border = Color3.fromRGB(60, 60, 70),
        success = Color3.fromRGB(100, 200, 100),
        warning = Color3.fromRGB(255, 200, 100),
        error = Color3.fromRGB(255, 100, 100)
    }
    return self
end

function AdvancedRobloxUILibrary:createWindow(title, size, position)
    local window = createFrame(self.screenGui, {
        Size = size or UDim2.new(0, 400, 0, 500),
        Position = position or UDim2.new(0.5, -200, 0.5, -250),
        BackgroundColor3 = self.theme.primary,
        BorderSizePixel = 0,
        Active = true,
        Draggable = true
    })
    
    createUICorner(window, {CornerRadius = UDim.new(0, 12)})
    createUIStroke(window, {Color = self.theme.border, Thickness = 1})
    createShadow(window)
    
    local titleBar = createFrame(window, {
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = self.theme.secondary,
        BorderSizePixel = 0
    })
    
    createUICorner(titleBar, {CornerRadius = UDim.new(0, 12)})
    
    local titleLabel = createTextLabel(titleBar, {
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = title or "Window",
        TextColor3 = self.theme.text,
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local closeButton = createImageButton(titleBar, {
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -30, 0.5, -12.5),
        BackgroundColor3 = self.theme.error,
        BorderSizePixel = 0,
        Image = ""
    })
    
    createUICorner(closeButton, {CornerRadius = UDim.new(0, 6)})
    
    local minimizeButton = createImageButton(titleBar, {
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -60, 0.5, -12.5),
        BackgroundColor3 = self.theme.warning,
        BorderSizePixel = 0,
        Image = ""
    })
    
    createUICorner(minimizeButton, {CornerRadius = UDim.new(0, 6)})
    
    local contentFrame = createFrame(window, {
        Size = UDim2.new(1, 0, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundTransparency = 1
    })
    
    createUIPadding(contentFrame, {
        PaddingLeft = UDim.new(0, 15),
        PaddingRight = UDim.new(0, 15),
        PaddingTop = UDim.new(0, 15),
        PaddingBottom = UDim.new(0, 15)
    })
    
    local isMinimized = false
    
    closeButton.MouseButton1Click:Connect(function()
        window:Destroy()
    end)
    
    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            tween(window, {Size = UDim2.new(0, 400, 0, 40)})
            contentFrame.Visible = false
        else
            tween(window, {Size = size or UDim2.new(0, 400, 0, 500)})
            contentFrame.Visible = true
        end
    end)
    
    local windowObj = {
        window = window,
        titleBar = titleBar,
        contentFrame = contentFrame,
        closeButton = closeButton,
        minimizeButton = minimizeButton,
        isMinimized = isMinimized
    }
    
    table.insert(self.components, windowObj)
    table.insert(self.windows, windowObj)
    return windowObj
end

function AdvancedRobloxUILibrary:createTabSystem(parent, tabs)
    local tabSystem = createFrame(parent, {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    })
    
    local tabButtons = createFrame(tabSystem, {
        Size = UDim2.new(1, 0, 0, 35),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = self.theme.secondary,
        BorderSizePixel = 0
    })
    
    createUICorner(tabButtons, {CornerRadius = UDim.new(0, 8)})
    
    local tabContent = createFrame(tabSystem, {
        Size = UDim2.new(1, 0, 1, -45),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundTransparency = 1
    })
    
    local tabPages = {}
    local activeTab = nil
    
    for i, tabName in pairs(tabs) do
        local tabButton = createFrame(tabButtons, {
            Size = UDim2.new(1/#tabs, -5, 1, -5),
            Position = UDim2.new((i-1)/#tabs, 0, 0, 0),
            BackgroundColor3 = self.theme.primary,
            BorderSizePixel = 0
        })
        
        createUICorner(tabButton, {CornerRadius = UDim.new(0, 6)})
        
        local tabText = createTextLabel(tabButton, {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = self.theme.textSecondary,
            TextScaled = true,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Center
        })
        
        local tabPage = createFrame(tabContent, {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = i == 1
        })
        
        tabPages[tabName] = {
            button = tabButton,
            page = tabPage,
            text = tabText
        }
        
        if i == 1 then
            activeTab = tabName
            tween(tabButton, {BackgroundColor3 = self.theme.accent})
            tween(tabText, {TextColor3 = self.theme.text})
        end
        
        tabButton.MouseButton1Click:Connect(function()
            if activeTab ~= tabName then
                -- Hide current tab
                tabPages[activeTab].page.Visible = false
                tween(tabPages[activeTab].button, {BackgroundColor3 = self.theme.primary})
                tween(tabPages[activeTab].text, {TextColor3 = self.theme.textSecondary})
                
                -- Show new tab
                tabPages[tabName].page.Visible = true
                tween(tabPages[tabName].button, {BackgroundColor3 = self.theme.accent})
                tween(tabPages[tabName].text, {TextColor3 = self.theme.text})
                
                activeTab = tabName
            end
        end)
    end
    
    return {
        frame = tabSystem,
        pages = tabPages,
        activeTab = activeTab
    }
end

function AdvancedRobloxUILibrary:createSection(parent, title, size)
    local section = createFrame(parent, {
        Size = size or UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = self.theme.secondary,
        BorderSizePixel = 0
    })
    
    createUICorner(section, {CornerRadius = UDim.new(0, 8)})
    createUIStroke(section, {Color = self.theme.border, Thickness = 1})
    
    local sectionTitle = createTextLabel(section, {
        Size = UDim2.new(1, -20, 0, 25),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = title or "Section",
        TextColor3 = self.theme.text,
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local sectionContent = createFrame(section, {
        Size = UDim2.new(1, -20, 1, -35),
        Position = UDim2.new(0, 10, 0, 30),
        BackgroundTransparency = 1
    })
    
    createUIPadding(sectionContent, {
        PaddingTop = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 5)
    })
    
    return {
        frame = section,
        content = sectionContent,
        title = sectionTitle
    }
end

function AdvancedRobloxUILibrary:createButton(parent, text, size, callback, style)
    style = style or "primary"
    
    local buttonColors = {
        primary = {bg = self.theme.accent, hover = Color3.fromRGB(120, 170, 255)},
        secondary = {bg = self.theme.secondary, hover = Color3.fromRGB(45, 45, 55)},
        success = {bg = self.theme.success, hover = Color3.fromRGB(120, 220, 120)},
        warning = {bg = self.theme.warning, hover = Color3.fromRGB(255, 220, 120)},
        error = {bg = self.theme.error, hover = Color3.fromRGB(255, 120, 120)}
    }
    
    local button = createFrame(parent, {
        Size = size or UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = buttonColors[style].bg,
        BorderSizePixel = 0
    })
    
    createUICorner(button, {CornerRadius = UDim.new(0, 8)})
    createUIStroke(button, {Color = self.theme.border, Thickness = 1})
    
    local buttonText = createTextLabel(button, {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = text or "Button",
        TextColor3 = self.theme.text,
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    
    local isHovered = false
    
    button.MouseEnter:Connect(function()
        isHovered = true
        tween(button, {BackgroundColor3 = buttonColors[style].hover})
        tween(button, {Size = size and (size + UDim2.new(0, 2, 0, 2)) or UDim2.new(1, 2, 0, 37)})
    end)
    
    button.MouseLeave:Connect(function()
        isHovered = false
        tween(button, {BackgroundColor3 = buttonColors[style].bg})
        tween(button, {Size = size or UDim2.new(1, 0, 0, 35)})
    end)
    
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return button
end

function AdvancedRobloxUILibrary:createTextBox(parent, placeholder, size, callback)
    local textBox = createTextBox(parent, {
        Size = size or UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = self.theme.primary,
        BorderSizePixel = 0,
        Text = "",
        PlaceholderText = placeholder or "Enter text...",
        TextColor3 = self.theme.text,
        PlaceholderColor3 = self.theme.textSecondary,
        TextScaled = true,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false
    })
    
    createUICorner(textBox, {CornerRadius = UDim.new(0, 8)})
    createUIStroke(textBox, {Color = self.theme.border, Thickness = 1})
    
    textBox.Focused:Connect(function()
        tween(textBox.UIStroke, {Color = self.theme.accent, Thickness = 2})
    end)
    
    textBox.FocusLost:Connect(function()
        tween(textBox.UIStroke, {Color = self.theme.border, Thickness = 1})
        if callback then
            callback(textBox.Text)
        end
    end)
    
    return textBox
end

function AdvancedRobloxUILibrary:createSlider(parent, min, max, default, callback, label)
    local sliderFrame = createFrame(parent, {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1
    })
    
    if label then
        local labelText = createTextLabel(sliderFrame, {
            Size = UDim2.new(1, 0, 0, 20),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = label,
            TextColor3 = self.theme.text,
            TextScaled = true,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left
        })
    end
    
    local sliderTrack = createFrame(sliderFrame, {
        Size = UDim2.new(1, 0, 0, 6),
        Position = UDim2.new(0, 0, 0, label and 25 or 0),
        BackgroundColor3 = self.theme.primary,
        BorderSizePixel = 0
    })
    
    createUICorner(sliderTrack, {CornerRadius = UDim.new(0, 3)})
    createUIStroke(sliderTrack, {Color = self.theme.border, Thickness = 1})
    
    local sliderFill = createFrame(sliderTrack, {
        Size = UDim2.new(0, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = self.theme.accent,
        BorderSizePixel = 0
    })
    
    createUICorner(sliderFill, {CornerRadius = UDim.new(0, 3)})
    
    local sliderButton = createFrame(sliderFrame, {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0, 0, 0, label and 25 or 0),
        BackgroundColor3 = self.theme.text,
        BorderSizePixel = 0
    })
    
    createUICorner(sliderButton, {CornerRadius = UDim.new(0, 9)})
    createUIStroke(sliderButton, {Color = self.theme.accent, Thickness = 2})
    
    local valueLabel = createTextLabel(sliderFrame, {
        Size = UDim2.new(0, 60, 0, 20),
        Position = UDim2.new(1, -65, 0, label and 25 or 0),
        BackgroundTransparency = 1,
        Text = tostring(default or min),
        TextColor3 = self.theme.text,
        TextScaled = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    local currentValue = default or min
    local isDragging = false
    
    local function updateSlider(value)
        currentValue = math.clamp(value, min, max)
        local percentage = (currentValue - min) / (max - min)
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderButton.Position = UDim2.new(percentage, -9, 0, label and 25 or 0)
        valueLabel.Text = tostring(math.floor(currentValue))
        
        if callback then
            callback(currentValue)
        end
    end
    
    sliderButton.MouseButton1Down:Connect(function()
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
            local sliderPos = sliderTrack.AbsolutePosition
            local sliderSize = sliderTrack.AbsoluteSize
            local relativeX = (mousePos.X - sliderPos.X) / sliderSize.X
            local percentage = math.clamp(relativeX, 0, 1)
            local value = min + (max - min) * percentage
            updateSlider(value)
        end
    end)
    
    updateSlider(currentValue)
    
    return {
        frame = sliderFrame,
        setValue = updateSlider,
        getValue = function() return currentValue end
    }
end

function AdvancedRobloxUILibrary:createToggle(parent, text, default, callback)
    local toggleFrame = createFrame(parent, {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1
    })
    
    local toggleButton = createFrame(toggleFrame, {
        Size = UDim2.new(0, 45, 0, 25),
        Position = UDim2.new(1, -50, 0.5, -12.5),
        BackgroundColor3 = self.theme.primary,
        BorderSizePixel = 0
    })
    
    createUICorner(toggleButton, {CornerRadius = UDim.new(0, 12.5)})
    createUIStroke(toggleButton, {Color = self.theme.border, Thickness = 1})
    
    local toggleCircle = createFrame(toggleButton, {
        Size = UDim2.new(0, 19, 0, 19),
        Position = UDim2.new(0, 3, 0.5, -9.5),
        BackgroundColor3 = self.theme.text,
        BorderSizePixel = 0
    })
    
    createUICorner(toggleCircle, {CornerRadius = UDim.new(0, 9.5)})
    
    local toggleText = createTextLabel(toggleFrame, {
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text or "Toggle",
        TextColor3 = self.theme.text,
        TextScaled = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local isToggled = default or false
    
    local function updateToggle()
        if isToggled then
            tween(toggleButton, {BackgroundColor3 = self.theme.accent})
            tween(toggleCircle, {Position = UDim2.new(1, -22, 0.5, -9.5)})
        else
            tween(toggleButton, {BackgroundColor3 = self.theme.primary})
            tween(toggleCircle, {Position = UDim2.new(0, 3, 0.5, -9.5)})
        end
    end
    
    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        updateToggle()
        if callback then
            callback(isToggled)
        end
    end)
    
    updateToggle()
    
    return {
        frame = toggleFrame,
        setValue = function(value)
            isToggled = value
            updateToggle()
        end,
        getValue = function() return isToggled end
    }
end

function AdvancedRobloxUILibrary:createDropdown(parent, options, default, callback)
    local dropdownFrame = createFrame(parent, {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = self.theme.primary,
        BorderSizePixel = 0
    })
    
    createUICorner(dropdownFrame, {CornerRadius = UDim.new(0, 8)})
    createUIStroke(dropdownFrame, {Color = self.theme.border, Thickness = 1})
    
    local dropdownText = createTextLabel(dropdownFrame, {
        Size = UDim2.new(1, -35, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = default or options[1] or "Select option",
        TextColor3 = self.theme.text,
        TextScaled = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local dropdownArrow = createTextLabel(dropdownFrame, {
        Size = UDim2.new(0, 25, 1, 0),
        Position = UDim2.new(1, -30, 0, 0),
        BackgroundTransparency = 1,
        Text = "▼",
        TextColor3 = self.theme.text,
        TextScaled = true,
        Font = Enum.Font.Gotham
    })
    
    local dropdownList = createFrame(dropdownFrame, {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 1, 5),
        BackgroundColor3 = self.theme.secondary,
        BorderSizePixel = 0,
        Visible = false
    })
    
    createUICorner(dropdownList, {CornerRadius = UDim.new(0, 8)})
    createUIStroke(dropdownList, {Color = self.theme.border, Thickness = 1})
    
    local isOpen = false
    local selectedOption = default or options[1]
    
    local function updateDropdown()
        dropdownText.Text = selectedOption
        if callback then
            callback(selectedOption)
        end
    end
    
    local function toggleDropdown()
        isOpen = not isOpen
        if isOpen then
            dropdownList.Visible = true
            dropdownList.Size = UDim2.new(1, 0, 0, #options * 30 + 10)
            tween(dropdownArrow, {Rotation = 180})
        else
            dropdownList.Size = UDim2.new(1, 0, 0, 0)
            tween(dropdownArrow, {Rotation = 0})
            wait(0.2)
            dropdownList.Visible = false
        end
    end
    
    for i, option in pairs(options) do
        local optionButton = createFrame(dropdownList, {
            Size = UDim2.new(1, -10, 0, 30),
            Position = UDim2.new(0, 5, 0, (i-1) * 30 + 5),
            BackgroundColor3 = self.theme.primary,
            BorderSizePixel = 0
        })
        
        createUICorner(optionButton, {CornerRadius = UDim.new(0, 6)})
        
        local optionText = createTextLabel(optionButton, {
            Size = UDim2.new(1, -10, 1, 0),
            Position = UDim2.new(0, 5, 0, 0),
            BackgroundTransparency = 1,
            Text = option,
            TextColor3 = self.theme.text,
            TextScaled = true,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        
        optionButton.MouseEnter:Connect(function()
            tween(optionButton, {BackgroundColor3 = self.theme.accent})
        end)
        
        optionButton.MouseLeave:Connect(function()
            tween(optionButton, {BackgroundColor3 = self.theme.primary})
        end)
        
        optionButton.MouseButton1Click:Connect(function()
            selectedOption = option
            updateDropdown()
            toggleDropdown()
        end)
    end
    
    dropdownFrame.MouseButton1Click:Connect(toggleDropdown)
    
    updateDropdown()
    
    return {
        frame = dropdownFrame,
        setValue = function(value)
            selectedOption = value
            updateDropdown()
        end,
        getValue = function() return selectedOption end
    }
end

function AdvancedRobloxUILibrary:createNotification(title, message, duration, type)
    type = type or "info"
    
    local notificationColors = {
        info = {bg = self.theme.accent, border = self.theme.accent},
        success = {bg = self.theme.success, border = self.theme.success},
        warning = {bg = self.theme.warning, border = self.theme.warning},
        error = {bg = self.theme.error, border = self.theme.error}
    }
    
    local notification = createFrame(self.screenGui, {
        Size = UDim2.new(0, 350, 0, 90),
        Position = UDim2.new(1, -370, 0, 20),
        BackgroundColor3 = notificationColors[type].bg,
        BorderSizePixel = 0
    })
    
    createUICorner(notification, {CornerRadius = UDim.new(0, 12)})
    createUIStroke(notification, {Color = notificationColors[type].border, Thickness = 2})
    createShadow(notification)
    
    local titleLabel = createTextLabel(notification, {
        Size = UDim2.new(1, -20, 0, 25),
        Position = UDim2.new(0, 15, 0, 10),
        BackgroundTransparency = 1,
        Text = title or "Notification",
        TextColor3 = self.theme.text,
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local messageLabel = createTextLabel(notification, {
        Size = UDim2.new(1, -20, 0, 40),
        Position = UDim2.new(0, 15, 0, 35),
        BackgroundTransparency = 1,
        Text = message or "",
        TextColor3 = self.theme.text,
        TextScaled = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    })
    
    local closeButton = createTextLabel(notification, {
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -30, 0, 10),
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = self.theme.text,
        TextScaled = true,
        Font = Enum.Font.GothamBold
    })
    
    closeButton.MouseButton1Click:Connect(function()
        notification:Destroy()
    end)
    
    if duration then
        spawn(function()
            wait(duration)
            notification:Destroy()
        end)
    end
    
    return notification
end

function AdvancedRobloxUILibrary:destroy()
    if self.screenGui then
        self.screenGui:Destroy()
    end
end

return AdvancedRobloxUILibrary 
