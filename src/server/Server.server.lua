local ServerStorage = game:GetService("ServerStorage")
local Modules = ServerStorage.Modules
local ObbyScript = require(Modules.Obby)
local PlayerManager = require(Modules.PlayerManager)
local ObbyCourse = workspace:WaitForChild("Obby")

PlayerManager.Start()

local Obby = ObbyScript.new()
Obby:Init()

local function FindLevelInstance(Level)
    for _,instance in pairs(ObbyCourse:GetDescendants()) do
        if instance:GetAttribute("Level") == Level then
            return instance
        end
    end
    return nil
end

local function RandomSpawn()
    local spawns = workspace.Spawns:GetChildren()
    return spawns[math.random(1,#spawns)]
end

PlayerManager.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Wait()
    local char = player.Character
    local HRP = char:FindFirstChild("HumanoidRootPart")
    if HRP then
        HRP.CFrame = RandomSpawn().CFrame
    end
    task.wait(1)
    local Level = PlayerManager.GetLevel(player)
    local location = FindLevelInstance(Level)
    if location then
        player.RespawnLocation = location.Checkpoint
        player:LoadCharacter()
    end
    
end)