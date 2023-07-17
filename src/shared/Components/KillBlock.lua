local Players = game:GetService("Players")
local KillBlock = {}
KillBlock.__index = KillBlock

function KillBlock.new(Obby,instance)
    local self = setmetatable({},KillBlock)
    self.Instance = instance
    self.Obby = Obby
    self.Debounce = {}
    return self
end

function KillBlock:Init()
    self.Instance.Touched:Connect(function(...)
        self:Touched(...)
    end)
end

function KillBlock:Touched(hitPart:Part)
    local character = hitPart:FindFirstAncestorOfClass("Model")
    
    if character then
        local humanoid:Humanoid = character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid:TakeDamage(humanoid.Health)
        end
    end
end

return KillBlock