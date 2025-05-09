-- 📦 Charger Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

-- 🎮 Variables utiles
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 🪟 Fenêtre principale
local Window = Rayfield:CreateWindow({
   Name = "Zypherion | Universal",
   LoadingTitle = "Chargement...",
   LoadingSubtitle = "Script par Spacyxxuu",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

-- 🔫 Onglet Combat
local Combat = Window:CreateTab("Combat", 4483362458)
Combat:CreateToggle({
   Name = "Aimbot (à coder)",
   CurrentValue = false,
   Callback = function(Value)
      print("Aimbot activé :", Value)
   end
})

Combat:CreateSlider({
   Name = "Smoothness",
   Range = {0.1, 1},
   Increment = 0.1,
   CurrentValue = 0.5,
   Callback = function(Value)
      print("Smoothness :", Value)
   end
})

-- 👁️ Onglet Visuals
local Visuals = Window:CreateTab("Visuals", 4483362458)

Visuals:CreateToggle({
   Name = "Afficher ESP (à coder)",
   CurrentValue = false,
   Callback = function(Value)
      print("ESP activé :", Value)
   end
})

Visuals:CreateSlider({
   Name = "Taille ESP",
   Range = {1, 10},
   Increment = 1,
   CurrentValue = 5,
   Callback = function(Value)
      print("Taille ESP :", Value)
   end
})

Visuals:CreateColorPicker({
   Name = "Couleur ESP",
   Color = Color3.fromRGB(0, 0, 255),
   Callback = function(Value)
      print("Couleur ESP :", Value)
   end
})

-- 🧍 Onglet Player Mods
local PlayerMods = Window:CreateTab("Player Mods", 4483362458)

PlayerMods:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 100},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end
})

PlayerMods:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         _G.InfiniteJump = true
         game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfiniteJump and LocalPlayer.Character then
               LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
         end)
      else
         _G.InfiniteJump = false
      end
   end
})

PlayerMods:CreateToggle({
   Name = "Fly (E pour activer)",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         loadstring(game:HttpGet("https://pastebin.com/raw/3TSCFJkZ"))() -- Fly Script, E pour toggle
      end
   end
})

PlayerMods:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Callback = function(Value)
      local RunService = game:GetService("RunService")
      if Value then
         _G.noclip = true
         RunService.Stepped:Connect(function()
            if _G.noclip and LocalPlayer.Character then
               for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                  if part:IsA("BasePart") and part.CanCollide == true then
                     part.CanCollide = false
                  end
               end
            end
         end)
      else
         _G.noclip = false
      end
   end
})

-- Téléportation
local playerNames = {}
for _, plr in pairs(Players:GetPlayers()) do
   if plr ~= LocalPlayer then
      table.insert(playerNames, plr.Name)
   end
end

PlayerMods:CreateDropdown({
   Name = "Téléportation",
   Options = playerNames,
   CurrentOption = "",
   Callback = function(selected)
      local target = Players:FindFirstChild(selected)
      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
         LocalPlayer.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
      end
   end
})

-- ⚙️ Onglet UI Settings
local UISettings = Window:CreateTab("UI Settings", 4483362458)

UISettings:CreateKeybind({
   Name = "Toggle UI",
   CurrentKeybind = "RightShift",
   HoldToInteract = false,
   Callback = function()
      Rayfield:Toggle()
   end,
})
