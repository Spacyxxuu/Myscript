-- UI lib simple (style moderne + tabs)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI creation
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "TPGui"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 300)
Main.Position = UDim2.new(0.5, -250, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Visible = true
Main.Active = true
Main.Draggable = true

-- RightShift toggle
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Text = "ZYPHERION | Teleport"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- Player Dropdown
local Dropdown = Instance.new("TextButton", Main)
Dropdown.Size = UDim2.new(0, 200, 0, 30)
Dropdown.Position = UDim2.new(0, 20, 0, 60)
Dropdown.Text = "Select Player"
Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Player list frame
local ListFrame = Instance.new("ScrollingFrame", Main)
ListFrame.Size = UDim2.new(0, 200, 0, 100)
ListFrame.Position = UDim2.new(0, 20, 0, 100)
ListFrame.Visible = false
ListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

Dropdown.MouseButton1Click:Connect(function()
    ListFrame.Visible = not ListFrame.Visible
    ListFrame:ClearAllChildren()
    local y = 0
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local Btn = Instance.new("TextButton", ListFrame)
            Btn.Size = UDim2.new(1, 0, 0, 25)
            Btn.Position = UDim2.new(0, 0, 0, y)
            Btn.Text = plr.Name
            Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.MouseButton1Click:Connect(function()
                Dropdown.Text = plr.Name
                Dropdown:SetAttribute("SelectedPlayer", plr.Name)
                ListFrame.Visible = false
            end)
            y = y + 30
        end
    end
    ListFrame.CanvasSize = UDim2.new(0, 0, 0, y)
end)

-- Teleport Button
local TPButton = Instance.new("TextButton", Main)
TPButton.Size = UDim2.new(0, 200, 0, 30)
TPButton.Position = UDim2.new(0, 20, 0, 220)
TPButton.Text = "Téléporter
