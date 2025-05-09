-- LocalScript placed in StarterPlayer -> StarterPlayerScripts

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

-- Variables pour l'état actuel
local espSize = 100
local espColor = Color3.fromRGB(255, 0, 0)
local guiVisible = true

-- Créer un GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Roblox Hacks"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleLabel.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.3, 0, 0, 40)
toggleButton.Position = UDim2.new(0.7, 0, 0, 0)
toggleButton.Text = "X"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 18
toggleButton.Parent = mainFrame

-- Fonction pour déplacer le GUI
local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Fonction pour ouvrir/fermer le GUI avec Shift droit
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.RightShift then
        guiVisible = not guiVisible
        mainFrame.Visible = guiVisible
    end
end)

-- Modification de la taille et couleur de l'ESP
local espSizeSlider = Instance.new("TextBox")
espSizeSlider.Size = UDim2.new(0.8, 0, 0, 40)
espSizeSlider.Position = UDim2.new(0.1, 0, 0.2, 0)
espSizeSlider.PlaceholderText = "ESP Size: 100"
espSizeSlider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
espSizeSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
espSizeSlider.TextSize = 18
espSizeSlider.Parent = mainFrame

local espColorButton = Instance.new("TextButton")
espColorButton.Size = UDim2.new(1, 0, 0, 40)
espColorButton.Position = UDim2.new(0, 0, 0.3, 0)
espColorButton.Text = "Change ESP Color"
espColorButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
espColorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espColorButton.TextSize = 18
espColorButton.Parent = mainFrame

-- Fonction pour mettre à jour la taille de l'ESP
espSizeSlider.FocusLost:Connect(function()
    local size = tonumber(espSizeSlider.Text)
    if size and size >= 50 and size <= 200 then
        espSize = size
    end
end)

-- Fonction pour changer la couleur de l'ESP
espColorButton.MouseButton1Click:Connect(function()
    local colorPicker = Instance.new("Color3Value")
    colorPicker.Value = espColor
    colorPicker.Name = "ESP Color"
    colorPicker.Parent = mainFrame
    
    local colorPickerFrame = Instance.new("Frame")
    colorPickerFrame.Size = UDim2.new(0, 200, 0, 200)
    colorPickerFrame.Position = UDim2.new(0.5, -100, 0.5, -100)
    colorPickerFrame.BackgroundColor3 = espColor
    colorPickerFrame.Parent = screenGui

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 50, 0, 30)
    closeButton.Position = UDim2.new(0.5, -25, 0.5, -100)
    closeButton.Text = "Close"
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 18
    closeButton.Parent = colorPickerFrame

    closeButton.MouseButton1Click:Connect(function()
        colorPickerFrame:Destroy()
    end)

    colorPickerFrame.MouseButton1Click:Connect(function(input)
        colorPickerFrame.BackgroundColor3 = input.Position
        espColor = input.Position
    end)
end)

-- Fonction d'ESP
local function enableESP()
    for _, targetPlayer in pairs(game.Players:GetChildren()) do
        if targetPlayer ~= player then
            local espBox = Instance.new("BillboardGui")
            espBox.Adornee = targetPlayer.Character.Head
            espBox.Size = UDim2.new(0, espSize, 0, espSize)
            espBox.AlwaysOnTop = true
            espBox.Parent = targetPlayer.Character.Head

            local box = Instance.new("Frame")
            box.Size = UDim2.new(1, 0, 1, 0)
            box.BackgroundColor3 = espColor
            box.BackgroundTransparency = 0.5
            box.Parent = espBox
        end
    end
end

-- Fonction pour activer/désactiver l'ESP
local espEnabled = false
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(1, 0, 0, 40)
espButton.Position = UDim2.new(0, 0, 0.4, 0)
espButton.Text = "Toggle ESP"
espButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.TextSize = 18
espButton.Parent = mainFrame

espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        enableESP()
    else
        -- Désactiver l'ESP
        for _, targetPlayer in pairs(game.Players:GetChildren()) do
            for _, espObject in pairs(targetPlayer.Character.Head:GetChildren()) do
                if espObject:IsA("BillboardGui") then
                    espObject:Destroy()
                end
            end
        end
    end
end)
