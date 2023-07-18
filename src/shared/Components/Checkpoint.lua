local Checkpoint = {}
local PlayerManager = require(script.Parent.Parent.PlayerManager)
Checkpoint.__index = Checkpoint

function Checkpoint.new(Obby,instance)
    local self = setmetatable({},Checkpoint)
    self.Instance = instance
    self.Obby = Obby
    self.SpawnLocation = self.Instance.Checkpoint
    return self
end

function Checkpoint:Init()
    self.SpawnLocation.Touched:Connect(function(...)
        self:Touched(...)
        
    end)
end

function Checkpoint:Touched(hit:BasePart)
	local Level = self.Instance:GetAttribute("Level")
	local humanoid = hit.Parent.Parent:FindFirstChild('Humanoid') or hit.Parent:FindFirstChild('Humanoid')
	local plr
	if humanoid then
		plr = game.Players:GetPlayerFromCharacter(humanoid.Parent)
		if plr then
			local currentLevel:number = PlayerManager.GetLevel(plr)
			if currentLevel ~= nil then
				if (currentLevel + 1) == Level then
					PlayerManager.SetLevel(plr, Level, self.SpawnLocation)
					
				end
			end
			
		end
		
	else
		return nil
	end
	
	
	
end

return Checkpoint