local CollectionService = game:GetService("CollectionService")
local Components = script.Parent.Components
local Course:Model = workspace.Obby

local Obby = {}
Obby.__index = Obby

function Obby.new()
    local self = setmetatable({},Obby)
    self._topicEvent = Instance.new("BindableEvent")
    return self
end

function Obby:Init()
    for i,instance in pairs(Course:GetDescendants()) do
        self:AddComponents(instance)
    end
end

function Obby:PublishTopic(topicName, ...)
	self._topicEvent:Fire(topicName, ...)
end

function Obby:SubscribeTopic(topicName, callback)
	local connection = self._topicEvent.Event:Connect(function(name,...)
		if name == topicName then
			callback(...)

		end
	end)
	return connection
end



function Obby:AddComponents(instance:Instance)
	for _, tag in ipairs(CollectionService:GetTags(instance)) do
		local component = Components:FindFirstChild(tag)

		if component then
			self:CreateComponent(instance,component)
		end
	end
end


function Obby:CreateComponent(instance:Instance, component:ModuleScript)
	local module = require(component)
	local comp = module.new(self,instance)

	comp:Init()
end

return Obby