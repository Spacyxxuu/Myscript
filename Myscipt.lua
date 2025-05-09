-- LocalScript placed in StarterPlayer -> StarterPlayerScripts

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = game.Workspace.CurrentCamera
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

-- Variables pour l'état actuel du jeu
local noClipEnabled = false
local infiniteJumpEnabled = false
local flyEnabled = false
local walkSpeed = 16
local flySpeed = 50
local espEnabled = false

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

-- NoClip Toggle
local noClipButton = Instance.new("TextButton")
noClipButton.Size = UDim2.new(1, 0, 0, 40)
noClipButton.Position = UDim2.new(0, 0, 0.1, 0)
noClipButton.Text = "Toggle NoClip"
noClipButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
noClipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noClipButton.TextSize = 18
noClipButton.Parent = mainFrame

-- WalkSpeed Slider
local walkSpeedSlider = Instance.new("TextBox")
walkSpeedSlider.Size = UDim2.new(0.8, 0, 0, 40)
walkSpeedSlider.Position = UDim2.new(0.1, 0, 0.2, 0)
walkSpeedSlider.PlaceholderText = "WalkSpeed: 16"
walkSpeedSlider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
walkSpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedSlider.TextSize = 18
walkSpeedSlider.Parent = mainFrame

-- Infinite Jump Toggle
local infiniteJumpButton = Instance.new("TextButton")
infiniteJumpButton.Size = UDim2.new(1, 0, 0, 40)
infiniteJumpButton.Position = UDim2.new(0, 0, 0.3, 0)
infiniteJumpButton.Text = "Infinite Jump"
infiniteJumpButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
infiniteJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
infiniteJumpButton.TextSize = 18
infiniteJumpButton.Parent = mainFrame

-- Fly Toggle
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(1, 0, 0, 40)
flyButton.Position = UDim2.new(0, 0, 0.4, 0)
flyButton.Text = "Toggle Fly"
flyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextSize = 18
flyButton.Parent = mainFrame

-- ESP Toggle
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(1, 0, 0, 40)
espButton.Position = UDim2.new(0, 0, 0.5, 0)
espButton.Text = "Toggle ESP"
espButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.TextSize = 18
espButton.Parent = mainFrame

-- Functions pour chaque fonctionnalité

-- NoClip
local function toggleNoClip()
    noClipEnabled = not noClipEnabled
    if noClipEnabled then
        -- Activer NoClip
        player.Character.HumanoidRootPart.CanCollide = false
    else
        -- Désactiver NoClip
        player.Character.HumanoidRootPart.CanCollide = true
    end
end

-- WalkSpeed
walkSpeedSlider.FocusLost:Connect(function()
    local speed = tonumber(walkSpeedSlider.Text)
    if speed and speed >= 0 and speed <= 100 then
        walkSpeed = speed
        player.Character.Humanoid.WalkSpeed = walkSpeed
    end
end)

-- Infinite Jump
local function toggleInfiniteJump()
    infiniteJumpEnabled = not infiniteJumpEnabled
    if infiniteJumpEnabled then
        -- Permettre un saut infini
        player.Character.Humanoid.Jumping:Connect(function()
            if infiniteJumpEnabled then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            end
        end)
    end
end

-- Fly
local function toggleFly()
    flyEnabled = not flyEnabled
    if flyEnabled then
        -- Activer le vol
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = camera.CFrame.LookVector * flySpeed
        bodyVelocity.Parent = player.Character.HumanoidRootPart
    else
        -- Désactiver le vol
        for _, obj in pairs(player.Character.HumanoidRootPart:GetChildren()) do
            if obj:IsA("BodyVelocity") then
                obj:Destroy()
            end
        end
    end
end

-- ESP
local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        -- Activer ESP
        for _, targetPlayer in pairs(game.Players:GetChildren()) do
            if targetPlayer ~= player then
                local espBox = Instance.new("BillboardGui")
                espBox.Adornee = targetPlayer.Character.Head
                espBox.Size = UDim2.new(0, 100, 0, 100)
                espBox.AlwaysOnTop = true
                espBox.Parent = targetPlayer.Character.Head

                local box = Instance.new("Frame")
                box.Size = UDim2.new(1, 0, 1, 0)
                box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                box.BackgroundTransparency = 0.5
                box.Parent = espBox
            end
        end
    else
        -- Désactiver ESP
        for _, targetPlayer in pairs(game.Players:GetChildren()) do
            for _, espObject in pairs(targetPlayer.Character.Head:GetChildren()) do
                if espObject:IsA("BillboardGui") then
                    espObject:Destroy()
                end
            end
        end
    end
end

-- Connexions des boutons
noClipButton.MouseButton1Click:Connect(toggleNoClip)
infiniteJumpButton.MouseButton1Click:Connect(toggleInfiniteJump)
flyButton.MouseButton1Click:Connect(toggleFly)
espButton.MouseButton1Click:Connect(toggleESP)

-- Vitesse de marche
player.Character.Humanoid.WalkSpeed = walkSpeed
