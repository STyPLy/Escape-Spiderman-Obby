local Conveyor = {}
Conveyor.__index = Conveyor

function Conveyor.new(Obby,instance)
    local self = setmetatable({},Conveyor)
    self.Instance = instance
    self.Obby = Obby
    self.Speed = self.Instance:GetAttribute("Speed")
    return self
end

function Conveyor:Init()
    task.spawn(function()
        repeat
            self.Instance.AssemblyLinearVelocity = self.Instance.CFrame.LookVector * self.Speed
        until self.Instance.AssemblyLinearVelocity == self.Instance.CFrame.LookVector * self.Speed
    end)
end



return Conveyor