local players = game:GetService('Players')
local dataStore = game:GetService('DataStoreService')
local sessionData = dataStore:GetDataStore("ObbyData")

local PlayerManager = {}
local data = {}

local playerAdded = Instance.new('BindableEvent')
local playerRemoving = Instance.new('BindableEvent')

PlayerManager.PlayerAdded = playerAdded.Event
PlayerManager.PlayerRemoving = playerRemoving.Event

local function setupLeaderstats(value)
	local leaderstats = Instance.new('Folder')
	leaderstats.Name = "leaderstats"
	
	local Level = Instance.new('IntValue')
	Level.Name = "Level"
	Level.Parent = leaderstats
	Level.Value = value
	
	return leaderstats
end




local function LoadData(key)
	local success, result = pcall(function()
		return sessionData:GetAsync(key)
	end)
	if not success then
		warn(result)
	end
	
	return success, result
	
end

local function SaveData(key,data)
	local success, result = pcall(function()
		sessionData:SetAsync(key, data)
	end)
	if not success then
		warn(result)
	end
	return success
end



function PlayerManager.Start()
	
	for _, player in ipairs(players:GetPlayers()) do
		coroutine.wrap(PlayerManager.OnPlayerAdded)(player)
	end
	
	
	players.PlayerAdded:Connect(PlayerManager.OnPlayerAdded)
	players.PlayerRemoving:Connect(PlayerManager.OnPlayerRemoving)
	
	
	
	game:BindToClose(PlayerManager.OnClose)
end

function PlayerManager.UpdateLevel(player,amount)
	if game:GetService('RunService'):IsClient() then
		return
	end

	data[player.UserId].Level += amount
	local leaderstats = player:FindFirstChild('leaderstats')
	if leaderstats then
		local Level = leaderstats:FindFirstChild('Level')
		if Level then
			Level.Value += amount

		end
	else
		warn("No leaderstats?")
	end

end


function PlayerManager.SetLevel(player,total,instance)
	if game:GetService('RunService'):IsClient() then
		return
	end
	
	data[player.UserId].Level = total
	local leaderstats = player:FindFirstChild('leaderstats')
	if leaderstats then
		local Level = leaderstats:FindFirstChild('Level')
		if Level then
			Level.Value = total
			
		end
	else
		warn("No leaderstats?")
	end
	player.RespawnLocation = instance
end

function PlayerManager.GetLevel(player:Player)
	local level = data[player.UserId]
	if level then
		return level.Level
	else
		return nil
	end
	
end





function PlayerManager.OnPlayerRemoving(player)
	playerRemoving:Fire(player)
	
	SaveData(player.UserId,data[player.UserId])
	
end


function PlayerManager.OnPlayerAdded(player)
	player.CharacterAdded:Connect(function(char)
		PlayerManager.onCharacterAdded(player,char)
	end)
	local success, v = LoadData(player.UserId)
	
	data[player.UserId] = success and v or {
		Level = 0
	}
	local leaderstats = setupLeaderstats(PlayerManager.GetLevel(player))
	leaderstats.Parent = player
	task.wait(1)
	playerAdded:Fire(player)


	
end

function PlayerManager.onCharacterAdded(player:Player,char:Model)
	local humanoid = char:FindFirstChild('Humanoid')
	if humanoid then
		humanoid.Died:Connect(function()
			task.wait(players.RespawnTime)
			player:LoadCharacter()
		end)
	end
end

function PlayerManager.OnClose()
	--if game:GetService('RunService'):IsStudio() then
	--	return
	--end
	
	for _, player in ipairs(players:GetPlayers()) do
		coroutine.wrap(SaveData)(player.UserId, data[player.UserId])
	end
end




return PlayerManager