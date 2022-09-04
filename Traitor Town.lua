local __namecall;
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
   local method = getnamecallmethod()
   if method == "FireServer" and self.IsA(self, "RemoteEvent") and self == game.GetService(game, "ReplicatedStorage").ServerEvents.Fall then
       return
   end  
   return __namecall(self, ...)
end)
local Workspace = game:GetService("Workspace")
local Ragdolls = Workspace:WaitForChild("Ragdolls")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

function CreateESPPart(Character, color)
local Box = Instance.new("Highlight")
Box.Name = Character.Name
Box.Adornee = Character
Box.FillColor = color
Box.FillTransparency = 0.6
Box.OutlineTransparency = 1
Box.Parent = CoreGui

local Overhead = Instance.new("BillboardGui")
Overhead.Name = Character.Name
Overhead.StudsOffsetWorldSpace = Vector3.new(0,2.5,0)
Overhead.Adornee = Character:WaitForChild("Head")
Overhead.Size = UDim2.new(0,100,0,100)
Overhead.AlwaysOnTop = true
Overhead.Parent = CoreGui

local TextLabel = Instance.new("TextLabel")
TextLabel.Text = Character.Name
TextLabel.Position = UDim2.new(0, 0, 0, -50)
TextLabel.Size = UDim2.new(0, 100, 0, 100)
TextLabel.Font = Enum.Font.SourceSansSemibold
TextLabel.TextSize = 20
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextStrokeTransparency = 0
TextLabel.BackgroundTransparency = 1
TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
TextLabel.Parent = Overhead
end

function loadCheck(chr)
if chr:FindFirstChild("Humanoid") then
CreateESPPart(chr,Color3.fromRGB(255,255,255))
end
end


local player = game.Players:GetPlayers()
for i = 1, #player do
if player[i].Name ~= game.Players.LocalPlayer.Name then
if workspace:FindFirstChild(player[i].Name) then
loadCheck(player[i].Character)
end
spawn(function()
player[i].CharacterAdded:Connect(function(character)
character:WaitForChild("UpperTorso")
loadCheck(character)
end)
end)
end
end

local function SetColor(Instance)
if Instance.FillColor == Color3.fromRGB(255, 165, 0) then
Instance.FillColor = Color3.fromRGB(255, 0, 0)
end
if Instance.FillColor == Color3.fromRGB(255, 255, 255) then
Instance.FillColor = Color3.fromRGB(255, 165, 0)
end
    if Instance.FillColor == Color3.fromRGB(0,255,0) then
Instance.FillColor = Color3.fromRGB(255, 255, 255)
end
end

local function SetTextColor(Instance)
if Instance.TextColor3 == Color3.fromRGB(255, 165, 0) then
Instance.TextColor3 = Color3.fromRGB(255, 0, 0)
end
if Instance.TextColor3 == Color3.fromRGB(255, 255, 255) then
Instance.TextColor3 = Color3.fromRGB(255, 165, 0)
end
    if Instance.TextColor3 == Color3.fromRGB(0,255,0) then
Instance.TextColor3 = Color3.fromRGB(255, 255, 255)
end
end

local function SetDetective(plr)
for i,v in pairs(CoreGui:GetChildren()) do
if v.Name == plr and v.ClassName == "Highlight" then
v.FillColor = Color3.fromRGB(8, 20, 206)
end
if v.Name == plr and v.ClassName == "BillboardGui" then
v.TextLabel.TextColor3 = Color3.fromRGB(8, 20, 206)
end
end
end
task.defer(function()
        game:GetService("ReplicatedStorage").ClientEvents.UpdateGameTeams.OnClientEvent:Connect(function(info)
            if typeof(info) == "table" then
                for i, v in pairs(info) do
                        if v == "Detective" then
                            SetDetective(i)
                        end
                    end
                end
          end)
    end)
local function removeEsp(name) 
local esp = CoreGui:GetChildren()
for i,v in pairs(esp) do
if name == v.Name then
v:Destroy()
end
end
end
Players.PlayerAdded:Connect(function(player)
player.CharacterAdded:Connect(function(character)
character:WaitForChild("UpperTorso")
loadCheck(character)
end)
Players.PlayerRemoving:Connect(function(plr)
removeEsp(plr.Name)
end)
end)


Ragdolls.ChildAdded:Connect(function(body)
local cd = body:WaitForChild("CorpseData")
local tm = cd:WaitForChild("Team")
local killer = cd:WaitForChild("KilledBy")
removeEsp(body.Name)
if tm.Value == "Innocent" then
if workspace:findFirstChild(killer.Value) then
local espparts = game.CoreGui:GetChildren()
for i = 1, #espparts do
if espparts[i].Name == tostring(killer.Value) and espparts[i]:IsA("Highlight") then
SetColor(espparts[i])
end
if espparts[i]:IsA("BillboardGui") and espparts[i].TextLabel.Text == tostring(killer.Value) then
SetTextColor(espparts[i].TextLabel)
end
end
end
end
if tm.Value == "Traitor" then
local espparts = game.CoreGui:GetChildren()
for i = 1, #espparts do
if espparts[i].Name == tostring(killer.Value) and espparts[i]:IsA("Highlight") then
espparts[i].FillColor = Color3.fromRGB(0,255,0)
end

if espparts[i]:IsA("BillboardGui") and espparts[i].TextLabel.Text == killer.Value then
espparts[i].TextLabel.TextColor3 = Color3.fromRGB(0,255,0)
end

end
end
end)
