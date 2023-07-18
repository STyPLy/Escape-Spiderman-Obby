local MarketplaceService = game:GetService('MarketplaceService')
local Players = game.Players
local PlayerManager = require(game:GetService("ServerStorage").Modules.PlayerManager)
local productFunctions = {}
local ObbyCourse = workspace:WaitForChild("Obby")
local DS = game:GetService('DataStoreService')
local robuxLeaderboard = DS:GetOrderedDataStore('RobuxLeaderboard')
local ServerStorage = game:GetService("ServerStorage")

local function FindLevelInstance(Level)
    for _,instance in pairs(ObbyCourse:GetDescendants()) do
        if instance:GetAttribute("Level") == Level then
            return instance
        end
    end
    return nil
end

productFunctions[1583311950] = function(reciept,player)
	
	local robuxSpent = reciept["CurrencySpent"]
	local Level = PlayerManager.GetLevel(player)
	if Level then
		local instance = FindLevelInstance(Level+1).Checkpoint
		PlayerManager.SetLevel(player,Level+1,instance)
		player:LoadCharacter()
	else
		warn("Failed to get Level!")
	end

	local success, err = pcall(function()
		robuxLeaderboard:SetAsync(player.UserId, robuxLeaderboard:GetAsync(player.UserId) + robuxSpent)
	end)
	if success then
		print('Saved')
	else
		warn('Not Saved!**', err)
	end
end

productFunctions[1583455553] = function(reciept,player)
	local robuxSpent = reciept["CurrencySpent"]
	local success, err = pcall(function()
		robuxLeaderboard:SetAsync(player.UserId, robuxLeaderboard:GetAsync(player.UserId) + robuxSpent)
	end)
	if success then
		print('Saved')
	else
		warn('Not Saved!**', err)
	end
end

productFunctions[1583455551] = function(reciept,player)
	local robuxSpent = reciept["CurrencySpent"]
	local success, err = pcall(function()
		robuxLeaderboard:SetAsync(player.UserId, robuxLeaderboard:GetAsync(player.UserId) + robuxSpent)
	end)
	if success then
		print('Saved')
	else
		warn('Not Saved!**', err)
	end
end

productFunctions[1583455552] = function(reciept,player)
	local robuxSpent = reciept["CurrencySpent"]
	local success, err = pcall(function()
		robuxLeaderboard:SetAsync(player.UserId, robuxLeaderboard:GetAsync(player.UserId) + robuxSpent)
	end)
	if success then
		print('Saved')
	else
		warn('Not Saved!**', err)
	end
end

productFunctions[1583455550] = function(reciept,player)
	local robuxSpent = reciept["CurrencySpent"]
	local success, err = pcall(function()
		robuxLeaderboard:SetAsync(player.UserId, robuxLeaderboard:GetAsync(player.UserId) + robuxSpent)
	end)
	if success then
		print('Saved')
	else
		warn('Not Saved!**', err)
	end
end

productFunctions["coil"] = function(player:Player,character)
	local coil = ServerStorage.Gear["Gravity Coil"]:Clone()
	coil.Parent = player.Backpack
	local startergear = ServerStorage.Gear["Gravity Coil"]:Clone()
	startergear.Parent = player.StarterGear
end

productFunctions["sword"] = function(player,character)
	local sword = ServerStorage.Gear["ClassicSword"]:Clone()
	sword.Parent = player.Backpack
	local startergear = ServerStorage.Gear["ClassicSword"]:Clone()
	startergear.Parent = player.StarterGear
end

productFunctions["carpet"] = function(player,character)
	local carpet = ServerStorage.Gear["FlyingCarpet"]:Clone()
	carpet.Parent = player.Backpack
	local startergear = ServerStorage.Gear["FlyingCarpet"]:Clone()
	startergear.Parent = player.StarterGear
end

productFunctions["admin"] = function(player,character)
	
end

game.Players.PlayerAdded:Connect(function(player)
	local tbl = {}
		tbl["coil"]= MarketplaceService:UserOwnsGamePassAsync(player.UserId,209384276)
		tbl["carpet"] = MarketplaceService:UserOwnsGamePassAsync(player.UserId,209384690)
		tbl["sword"] = MarketplaceService:UserOwnsGamePassAsync(player.UserId,209384414)
		tbl["admin"] = MarketplaceService:UserOwnsGamePassAsync(player.UserId,209383796)
		
		for name,value in pairs(tbl) do
			if value or player.Name == "spoopmoop" then
				productFunctions[name](player,nil)
			end
			
		end
	
end)


local function processReceipt(receiptInfo)

	local userId = receiptInfo.PlayerId

	local productId = receiptInfo.ProductId


	local player = Players:GetPlayerByUserId(userId)

	if player then

		-- Get the handler function associated with the developer product ID and attempt to run it

		local handler = productFunctions[productId]

		local success, result = pcall(handler, receiptInfo, player)

		if success then

			-- The player has received their benefits!

			-- return PurchaseGranted to confirm the transaction.

			return Enum.ProductPurchaseDecision.PurchaseGranted

		else

			warn("Failed to process receipt:", receiptInfo, result)

		end

	end


	-- the player's benefits couldn't be awarded.

	-- return NotProcessedYet to try again next time the player joins.

	return Enum.ProductPurchaseDecision.NotProcessedYet

end


-- Set the callback; this can only be done once by one script on the server!

MarketplaceService.ProcessReceipt = processReceipt