local RobloxUILibrary = {}
RobloxUILibrary.__index = RobloxUILibrary

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function createScreenGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RobloxUILibrary"
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

local function tween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(duration or 0.3, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

function RobloxUILibrary.new()
    local self = setmetatable({}, RobloxUILibrary)
    self.screenGui = createScreenGui()
    self.components = {}
    return self
end

function RobloxUILibrary:createWindow(title, size, position)
    local window = createFrame(self.screenGui, {
        Size = size or UDim2.new(0, 300, 0, 400),
        Position = position or UDim2.new(0.5, -150, 0.5, -200),
        BackgroundColor3 = Color3.fromRGB(30, 30, 35),
        BorderSizePixel = 0,
        Active = true,
        Draggable = true
    })
    
    createUICorner(window, {CornerRadius = UDim.new(0, 8)})
    createUIStroke(window, {Color = Color3.fromRGB(60, 60, 65), Thickness = 1})
    
    local titleBar = createFrame(window, {
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        BorderSizePixel = 0
    })
    
    createUICorner(titleBar, {CornerRadius = UDim.new(0, 8)})
    
    local titleLabel = createTextLabel(titleBar, {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = title or "Window",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.GothamBold
    })
    
    local closeButton = createImageButton(titleBar, {
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -25, 0.5, -10),
        BackgroundColor3 = Color3.fromRGB(200, 50, 50),
        BorderSizePixel = 0,
        Image = ""
    })
    
    createUICorner(closeButton, {CornerRadius = UDim.new(0, 4)})
    
    local contentFrame = createFrame(window, {
        Size = UDim2.new(1, 0, 1, -30),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundTransparency = 1
    })
    
    createUIPadding(contentFrame, {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10)
    })
    
    closeButton.MouseButton1Click:Connect(function()
        window:Destroy()
    end)
    
    local windowObj = {
        window = window,
        titleBar = titleBar,
        contentFrame = contentFrame,
        closeButton = closeButton
    }
    
    table.insert(self.components, windowObj)
    return windowObj
end

function RobloxUILibrary:createButton(parent, text, size, callback)
    local button = createFrame(parent, {
        Size = size or UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Color3.fromRGB(50, 50, 55),
        BorderSizePixel = 0
    })
    
    createUICorner(button, {CornerRadius = UDim.new(0, 6)})
    createUIStroke(button, {Color = Color3.fromRGB(70, 70, 75), Thickness = 1})
    
    local buttonText = createTextLabel(button, {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = text or "Button",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.Gotham
    })
    
    local isHovered = false
    
    button.MouseEnter:Connect(function()
        isHovered = true
        tween(button, {BackgroundColor3 = Color3.fromRGB(60, 60, 65)})
    end)
    
    button.MouseLeave:Connect(function()
        isHovered = false
        tween(button, {BackgroundColor3 = Color3.fromRGB(50, 50, 55)})
    end)
    
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return button
end

function RobloxUILibrary:createTextBox(parent, placeholder, size)
    local textBox = createTextBox(parent, {
        Size = size or UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        BorderSizePixel = 0,
        Text = "",
        PlaceholderText = placeholder or "Enter text...",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
        TextScaled = true,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false
    })
    
    createUICorner(textBox, {CornerRadius = UDim.new(0, 6)})
    createUIStroke(textBox, {Color = Color3.fromRGB(70, 70, 75), Thickness = 1})
    
    textBox.Focused:Connect(function()
        tween(textBox.UIStroke, {Color = Color3.fromRGB(100, 150, 255)})
    end)
    
    textBox.FocusLost:Connect(function()
        tween(textBox.UIStroke, {Color = Color3.fromRGB(70, 70, 75)})
    end)
    
    return textBox
end

function RobloxUILibrary:createList(parent, items, size)
    local listFrame = createFrame(parent, {
        Size = size or UDim2.new(1, 0, 0, 200),
        BackgroundColor3 = Color3.fromRGB(35, 35, 40),
        BorderSizePixel = 0
    })
    
    createUICorner(listFrame, {CornerRadius = UDim.new(0, 6)})
    createUIStroke(listFrame, {Color = Color3.fromRGB(70, 70, 75), Thickness = 1})
    
    local scrollingFrame = createScrollingFrame(listFrame, {
        Size = UDim2.new(1, -10, 1, -10),
        Position = UDim2.new(0, 5, 0, 5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    
    local listItems = {}
    local itemHeight = 30
    local spacing = 2
    
    local function updateCanvasSize()
        local totalHeight = #listItems * (itemHeight + spacing) - spacing
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
    end
    
    local function addItem(text, callback)
        local itemFrame = createFrame(scrollingFrame, {
            Size = UDim2.new(1, 0, 0, itemHeight),
            Position = UDim2.new(0, 0, 0, #listItems * (itemHeight + spacing)),
            BackgroundColor3 = Color3.fromRGB(45, 45, 50),
            BorderSizePixel = 0
        })
        
        createUICorner(itemFrame, {CornerRadius = UDim.new(0, 4)})
        
        local itemText = createTextLabel(itemFrame, {
            Size = UDim2.new(1, -10, 1, 0),
            Position = UDim2.new(0, 5, 0, 0),
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        
        itemFrame.MouseEnter:Connect(function()
            tween(itemFrame, {BackgroundColor3 = Color3.fromRGB(55, 55, 60)})
        end)
        
        itemFrame.MouseLeave:Connect(function()
            tween(itemFrame, {BackgroundColor3 = Color3.fromRGB(45, 45, 50)})
        end)
        
        itemFrame.MouseButton1Click:Connect(function()
            if callback then
                callback(text)
            end
        end)
        
        table.insert(listItems, itemFrame)
        updateCanvasSize()
        
        return itemFrame
    end
    
    if items then
        for _, item in pairs(items) do
            addItem(item)
        end
    end
    
    return {
        frame = listFrame,
        scrollingFrame = scrollingFrame,
        addItem = addItem,
        items = listItems
    }
end

function RobloxUILibrary:createSlider(parent, min, max, default, callback)
    local sliderFrame = createFrame(parent, {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1
    })
    
    local sliderTrack = createFrame(sliderFrame, {
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.new(0, 0, 0.5, -2),
        BackgroundColor3 = Color3.fromRGB(60, 60, 65),
        BorderSizePixel = 0
    })
    
    createUICorner(sliderTrack, {CornerRadius = UDim.new(0, 2)})
    
    local sliderFill = createFrame(sliderTrack, {
        Size = UDim2.new(0, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(100, 150, 255),
        BorderSizePixel = 0
    })
    
    createUICorner(sliderFill, {CornerRadius = UDim.new(0, 2)})
    
    local sliderButton = createFrame(sliderFrame, {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 0, 0.5, -8),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    
    createUICorner(sliderButton, {CornerRadius = UDim.new(0, 8)})
    createUIStroke(sliderButton, {Color = Color3.fromRGB(100, 150, 255), Thickness = 2})
    
    local valueLabel = createTextLabel(sliderFrame, {
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(1, -55, 0, 0),
        BackgroundTransparency = 1,
        Text = tostring(default or min),
        TextColor3 = Color3.fromRGB(255, 255, 255),
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
        sliderButton.Position = UDim2.new(percentage, -8, 0.5, -8)
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

function RobloxUILibrary:createToggle(parent, text, default, callback)
    local toggleFrame = createFrame(parent, {
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundTransparency = 1
    })
    
    local toggleButton = createFrame(toggleFrame, {
        Size = UDim2.new(0, 40, 0, 20),
        Position = UDim2.new(1, -45, 0, 0),
        BackgroundColor3 = Color3.fromRGB(60, 60, 65),
        BorderSizePixel = 0
    })
    
    createUICorner(toggleButton, {CornerRadius = UDim.new(0, 10)})
    
    local toggleCircle = createFrame(toggleButton, {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    
    createUICorner(toggleCircle, {CornerRadius = UDim.new(0, 8)})
    
    local toggleText = createTextLabel(toggleFrame, {
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text or "Toggle",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local isToggled = default or false
    
    local function updateToggle()
        if isToggled then
            tween(toggleButton, {BackgroundColor3 = Color3.fromRGB(100, 150, 255)})
            tween(toggleCircle, {Position = UDim2.new(1, -18, 0.5, -8)})
        else
            tween(toggleButton, {BackgroundColor3 = Color3.fromRGB(60, 60, 65)})
            tween(toggleCircle, {Position = UDim2.new(0, 2, 0.5, -8)})
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

function RobloxUILibrary:createDropdown(parent, options, default, callback)
    local dropdownFrame = createFrame(parent, {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        BorderSizePixel = 0
    })
    
    createUICorner(dropdownFrame, {CornerRadius = UDim.new(0, 6)})
    createUIStroke(dropdownFrame, {Color = Color3.fromRGB(70, 70, 75), Thickness = 1})
    
    local dropdownText = createTextLabel(dropdownFrame, {
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = default or options[1] or "Select option",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local dropdownArrow = createTextLabel(dropdownFrame, {
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(1, -25, 0, 0),
        BackgroundTransparency = 1,
        Text = "▼",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.Gotham
    })
    
    local dropdownList = createFrame(dropdownFrame, {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 1, 5),
        BackgroundColor3 = Color3.fromRGB(35, 35, 40),
        BorderSizePixel = 0,
        Visible = false
    })
    
    createUICorner(dropdownList, {CornerRadius = UDim.new(0, 6)})
    createUIStroke(dropdownList, {Color = Color3.fromRGB(70, 70, 75), Thickness = 1})
    
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
            dropdownList.Size = UDim2.new(1, 0, 0, #options * 25 + 10)
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
            Size = UDim2.new(1, -10, 0, 25),
            Position = UDim2.new(0, 5, 0, (i-1) * 25 + 5),
            BackgroundColor3 = Color3.fromRGB(45, 45, 50),
            BorderSizePixel = 0
        })
        
        createUICorner(optionButton, {CornerRadius = UDim.new(0, 4)})
        
        local optionText = createTextLabel(optionButton, {
            Size = UDim2.new(1, -10, 1, 0),
            Position = UDim2.new(0, 5, 0, 0),
            BackgroundTransparency = 1,
            Text = option,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        
        optionButton.MouseEnter:Connect(function()
            tween(optionButton, {BackgroundColor3 = Color3.fromRGB(55, 55, 60)})
        end)
        
        optionButton.MouseLeave:Connect(function()
            tween(optionButton, {BackgroundColor3 = Color3.fromRGB(45, 45, 50)})
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

function RobloxUILibrary:createColorPicker(parent, defaultColor, callback)
    local colorPickerFrame = createFrame(parent, {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1
    })
    
    local colorPreview = createFrame(colorPickerFrame, {
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(1, -45, 0, 0),
        BackgroundColor3 = defaultColor or Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    
    createUICorner(colorPreview, {CornerRadius = UDim.new(0, 6)})
    createUIStroke(colorPreview, {Color = Color3.fromRGB(70, 70, 75), Thickness = 1})
    
    local colorText = createTextLabel(colorPickerFrame, {
        Size = UDim2.new(1, -50, 0, 20),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = "Color Picker",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local currentColor = defaultColor or Color3.fromRGB(255, 255, 255)
    
    colorPreview.MouseButton1Click:Connect(function()
        local colorPicker = self:createColorPickerWindow(currentColor, function(color)
            currentColor = color
            colorPreview.BackgroundColor3 = color
            if callback then
                callback(color)
            end
        end)
    end)
    
    return {
        frame = colorPickerFrame,
        setColor = function(color)
            currentColor = color
            colorPreview.BackgroundColor3 = color
        end,
        getColor = function() return currentColor end
    }
end

function RobloxUILibrary:createColorPickerWindow(defaultColor, callback)
    local window = self:createWindow("Color Picker", UDim2.new(0, 300, 0, 250))
    
    local colorPreview = createFrame(window.contentFrame, {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = defaultColor or Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    
    createUICorner(colorPreview, {CornerRadius = UDim.new(0, 6)})
    createUIStroke(colorPreview, {Color = Color3.fromRGB(70, 70, 75), Thickness = 1})
    
    local hueSlider = self:createSlider(window.contentFrame, 0, 360, 0, function(hue)
        local hsv = Color3.toHSV(colorPreview.BackgroundColor3)
        local newColor = Color3.fromHSV(hue/360, hsv.Y, hsv.Z)
        colorPreview.BackgroundColor3 = newColor
        if callback then
            callback(newColor)
        end
    end)
    
    hueSlider.frame.Position = UDim2.new(0, 0, 0, 70)
    
    local saturationSlider = self:createSlider(window.contentFrame, 0, 100, 100, function(saturation)
        local hsv = Color3.toHSV(colorPreview.BackgroundColor3)
        local newColor = Color3.fromHSV(hsv.X, saturation/100, hsv.Z)
        colorPreview.BackgroundColor3 = newColor
        if callback then
            callback(newColor)
        end
    end)
    
    saturationSlider.frame.Position = UDim2.new(0, 0, 0, 120)
    
    local valueSlider = self:createSlider(window.contentFrame, 0, 100, 100, function(value)
        local hsv = Color3.toHSV(colorPreview.BackgroundColor3)
        local newColor = Color3.fromHSV(hsv.X, hsv.Y, value/100)
        colorPreview.BackgroundColor3 = newColor
        if callback then
            callback(newColor)
        end
    end)
    
    valueSlider.frame.Position = UDim2.new(0, 0, 0, 170)
    
    return window
end

function RobloxUILibrary:createNotification(title, message, duration)
    local notification = createFrame(self.screenGui, {
        Size = UDim2.new(0, 300, 0, 80),
        Position = UDim2.new(1, -320, 0, 20),
        BackgroundColor3 = Color3.fromRGB(30, 30, 35),
        BorderSizePixel = 0
    })
    
    createUICorner(notification, {CornerRadius = UDim.new(0, 8)})
    createUIStroke(notification, {Color = Color3.fromRGB(60, 60, 65), Thickness = 1})
    
    local titleLabel = createTextLabel(notification, {
        Size = UDim2.new(1, -20, 0, 25),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = title or "Notification",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local messageLabel = createTextLabel(notification, {
        Size = UDim2.new(1, -20, 0, 40),
        Position = UDim2.new(0, 10, 0, 30),
        BackgroundTransparency = 1,
        Text = message or "",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextScaled = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    })
    
    local closeButton = createTextLabel(notification, {
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -25, 0, 5),
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = Color3.fromRGB(255, 255, 255),
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

function RobloxUILibrary:destroy()
    if self.screenGui then
        self.screenGui:Destroy()
    end
end

return RobloxUILibrary 