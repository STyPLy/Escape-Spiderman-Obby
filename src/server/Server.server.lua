local BadgeService = game:GetService("BadgeService")
local PhysicsService = game:GetService("PhysicsService")
local ServerStorage = game:GetService("ServerStorage")
local Teams = game:GetService("Teams")
local Modules = ServerStorage.Modules
local ObbyScript = require(Modules.Obby)
local PlayerManager = require(Modules.PlayerManager)
local ObbyCourse = workspace:WaitForChild("Obby")

-- Disable Player Collision
PhysicsService:RegisterCollisionGroup("Player")
PhysicsService:CollisionGroupSetCollidable("Player", "Player", false)

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


PlayerManager.PlayerAdded:Connect(function(player)
    player.Team = Teams.Escaping
    BadgeService:AwardBadge(player.UserId,2148764102)
    local Level = PlayerManager.GetLevel(player)
    local location = FindLevelInstance(Level)
    if location then
        player.RespawnLocation = location.Checkpoint
        player:LoadCharacter()
    else
        
        
    end
    
end)