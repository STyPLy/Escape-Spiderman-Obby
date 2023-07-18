local TweenService = game:GetService("TweenService")
local Stairs = {}
Stairs.__index = Stairs

local function FadeIn(instance)
    local tinfo = TweenInfo.new(1)
    local goal = {}
    goal.Transparency = 0

    return TweenService:Create(instance,tinfo,goal)
end

local function FadeOut(instance)
    local tinfo = TweenInfo.new(1)
    local goal = {}
    goal.Transparency = 1

    return TweenService:Create(instance,tinfo,goal)
end

function Stairs.new(Obby,instance)
    local self = setmetatable({},Stairs)
    self.Instance = instance
    self.Obby = Obby
    return self
end

function Stairs:Init()
    for _,instance in pairs(self.Instance:GetDescendants()) do
        if instance:IsA("BasePart") or instance:IsA("Part") then
            instance.Touched:Connect(function()
                self:Touched(instance)
            end)
        end
        
    end
end


function Stairs:Touched(instance)
    task.spawn(function()
        FadeOut(instance):Play()
        task.wait(1)
        instance.CanCollide = false
        task.wait(3)
        FadeIn(instance):Play()
        task.wait(1)
        instance.CanCollide = true
    end)
    
end

return Stairs