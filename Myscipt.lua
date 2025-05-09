-- 📦 Charger Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

local Window = Rayfield:CreateWindow({
   Name = "Universal GUI | Dev: Spacyxxuu",
   LoadingTitle = "Chargement...",
   LoadingSubtitle = "Educational Script",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- Combat Tab
local Combat = Window:CreateTab("Combat", 4483362458)
local aimbotEnabled = false
local aimbotSmoothness = 0.1

Combat:CreateToggle({
   Name = "Aimbot (Head Lock)",
   CurrentValue = false,
   Callback = function(Value)
      aimbotEnabled = Value
   end
})

Combat:CreateSlider({
   Name = "Smoothness",
   Range = {0.01, 1},
   Increment = 0.01,
   CurrentValue = 0.1,
   Callback = function(Value)
      aimbotSmoothness = Value
   end
})

-- Aimbot Logic
RunService.RenderStepped:Connect(function()
   if aimbotEnabled then
      local closest, dist = nil, math.huge
      for _, player in pairs(Players:GetPlayers()) do
         if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local screenPos, visible = Camera:WorldToScreenPoint(head.Position)
            local mousePos = Vector2.new(Mouse.X, Mouse.Y)
            local headPos2D = Vector2.new(screenPos.X, screenPos.Y)
            local mag = (mousePos - headPos2D).Magnitude
            if mag < dist and visible then
               dist = mag
               closest = head
            end
         end
      end
      if closest then
         local cam = Camera.CFrame.Position
         local dir = (closest.Position - cam).Unit
         local newCF = CFrame.new(cam, cam + dir)
         Camera.CFrame = Camera.CFrame:Lerp(newCF, aimbotSmoothness)
      end
   end
end)

-- Player Mods
local PlayerMods = Window:CreateTab("Player Mods", 4483362458)

-- WalkSpeed
PlayerMods:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 150},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end
})

-- Infinite Jump
local infiniteJumpEnabled = false
PlayerMods:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
      infiniteJumpEnabled = Value
   end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
   if infiniteJumpEnabled and LocalPlayer.Character then
      LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- Fly (Toggle with E)
PlayerMods:CreateToggle({
   Name = "Fly (E pour activer)",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         loadstring(game:HttpGet("https://pastebin.com/raw/3TSCFJkZ"))()
      end
   end
})

-- ESP
local Visuals = Window:CreateTab("ESP", 4483362458)
local espEnabled = false

Visuals:CreateToggle({
   Name = "ESP",
   CurrentValue = false,
   Callback = function(Value)
      espEnabled = Value
   end
})

-- ESP Logic
RunService.RenderStepped:Connect(function()
   for _, player in pairs(Players:GetPlayers()) do
      if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
         if espEnabled then
            if not player.Character.Head:FindFirstChild("ESP") then
               local billboard = Instance.new("BillboardGui", player.Character.Head)
               billboard.Name = "ESP"
               billboard.Size = UDim2.new(0, 100, 0, 40)
               billboard.AlwaysOnTop = true
               local label = Instance.new("TextLabel", billboard)
               label.Size = UDim2.new(1, 0, 1, 0)
               label.BackgroundTransparency = 1
               label.Text = player.Name
               label.TextColor3 = Color3.fromRGB(255, 0, 0)
               label.TextStrokeTransparency = 0.5
            end
         else
            if player.Character.Head:FindFirstChild("ESP") then
               player.Character.Head.ESP:Destroy()
            end
         end
      end
   end
end)

-- UI Keybind
local UISettings = Window:CreateTab("UI Settings", 4483362458)
UISettings:CreateKeybind({
   Name = "Toggle UI",
   CurrentKeybind = "RightShift",
   HoldToInteract = false,
   Callback = function()
      Rayfield:Toggle()
   end,
})
