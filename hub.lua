-- RHTU Hub - Delta Executor Script -- Features: Toggle UI, WalkSpeed slider, NoClip, FOV, ESP, Aimbot, Rainbow Border, Player actions

local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local Camera = workspace.CurrentCamera local RunService = game:GetService("RunService") local UIS = game:GetService("UserInputService")

-- GUI local ScreenGui = Instance.new("ScreenGui", game.CoreGui) ScreenGui.Name = "RHTU_Hub"

local Frame = Instance.new("Frame", ScreenGui) Frame.Size = UDim2.new(0, 400, 0, 300) Frame.Position = UDim2.new(0.5, -200, 0.5, -150) Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) Frame.Active = true Frame.Draggable = true

local rainbowBorder = Instance.new("UIStroke", Frame) rainbowBorder.Thickness = 3 rainbowBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Toggle UI Button local toggleBtn = Instance.new("TextButton", ScreenGui) toggleBtn.Size = UDim2.new(0, 100, 0, 30) toggleBtn.Position = UDim2.new(0, 10, 0, 10) toggleBtn.Text = "Toggle UI" toggleBtn.MouseButton1Click:Connect(function() Frame.Visible = not Frame.Visible end)

-- WalkSpeed local speedSlider = Instance.new("TextBox", Frame) speedSlider.Position = UDim2.new(0, 10, 0, 10) speedSlider.Size = UDim2.new(0, 100, 0, 25) speedSlider.PlaceholderText = "Speed 1-100" speedSlider.FocusLost:Connect(function() local val = tonumber(speedSlider.Text) if val then LocalPlayer.Character.Humanoid.WalkSpeed = math.clamp(val, 1, 100) end end)

-- NoClip local noclip = false UIS.InputBegan:Connect(function(input) if input.KeyCode == Enum.KeyCode.N then noclip = not noclip end end) RunService.Stepped:Connect(function() if noclip and LocalPlayer.Character then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end end end end)

-- FOV Switch local fov120 = true local fovBtn = Instance.new("TextButton", Frame) fovBtn.Position = UDim2.new(0, 120, 0, 10) fovBtn.Size = UDim2.new(0, 100, 0, 25) fovBtn.Text = "Toggle FOV" fovBtn.MouseButton1Click:Connect(function() fov120 = not fov120 Camera.FieldOfView = fov120 and 120 or 60 end)

-- ESP local function createESP(plr) if plr == LocalPlayer then return end local Billboard = Instance.new("BillboardGui", plr.Character:FindFirstChild("Head")) Billboard.Size = UDim2.new(0, 200, 0, 50) Billboard.AlwaysOnTop = true Billboard.Name = "ESP"

local nameTag = Instance.new("TextLabel", Billboard)
nameTag.Size = UDim2.new(1, 0, 1, 0)
nameTag.Text = plr.Name .. " | HP: " .. math.floor(plr.Character.Humanoid.Health) .. " | " .. math.floor((plr.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "s"
nameTag.TextSize = 10
nameTag.BackgroundTransparency = 1
nameTag.TextColor3 = Color3.new(1,1,1)

end

for _, p in pairs(Players:GetPlayers()) do p.CharacterAdded:Connect(function() wait(1) createESP(p) end) end Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() wait(1) createESP(p) end) end)

-- Aimbot local aimbotTarget = nil UIS.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton2 then local closestDist, closestPlayer = math.huge, nil for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then local dist = (Camera.CFrame.Position - p.Character.Head.Position).Magnitude if dist < closestDist then closestDist = dist closestPlayer = p end end end aimbotTarget = closestPlayer end end) RunService.RenderStepped:Connect(function() if aimbotTarget and aimbotTarget.Character and aimbotTarget.Character:FindFirstChild("Head") then Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimbotTarget.Character.Head.Position) end end)

-- Player Actions local inputBox = Instance.new("TextBox", Frame) inputBox.Position = UDim2.new(0, 10, 0, 50) inputBox.Size = UDim2.new(0, 150, 0, 25) inputBox.PlaceholderText = "Player Name"

local function getTargetPlayer() return Players:FindFirstChild(inputBox.Text) end

local teleportBtn = Instance.new("TextButton", Frame) teleportBtn.Position = UDim2.new(0, 10, 0, 80) teleportBtn.Size = UDim2.new(0, 100, 0, 25) teleportBtn.Text = "Teleport" teleportBtn.MouseButton1Click:Connect(function() local plr = getTargetPlayer() if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character:SetPrimaryPartCFrame(plr.Character.HumanoidRootPart.CFrame) end end)

local viewBtn = Instance.new("TextButton", Frame) viewBtn.Position = UDim2.new(0, 120, 0, 80) viewBtn.Size = UDim2.new(0, 100, 0, 25) viewBtn.Text = "View" viewBtn.MouseButton1Click:Connect(function() local plr = getTargetPlayer() if plr and plr.Character and plr.Character:FindFirstChild("Head") then Camera.CameraSubject = plr.Character.Head end end)

local sitBtn = Instance.new("TextButton", Frame) sitBtn.Position = UDim2.new(0, 230, 0, 80) sitBtn.Size = UDim2.new(0, 100, 0, 25) sitBtn.Text = "HeadSit" sitBtn.MouseButton1Click:Connect(function() local plr = getTargetPlayer() if plr and plr.Character and plr.Character:FindFirstChild("Head") then LocalPlayer.Character:SetPrimaryPartCFrame(plr.Character.Head.CFrame * CFrame.new(0, 1.5, 0)) end end)

-- Rainbow border loop spawn(function() while true do for i = 0, 1, 0.01 do rainbowBorder.Color = ColorSequence.new(Color3.fromHSV(i, 1, 1)) wait(0.02) end end end)

print("RHTU Hub Loaded")  

