local player = game.Players.LocalPlayer
local MPS = game:GetService("MarketplaceService")

local UI = script.Parent.ScreenGui
local Frame = UI.Frame
local SkipStageButton:TextButton = Frame.TextButton
local ShopButton:TextButton = SkipStageButton.TextButton

local ShopUI:Frame = UI.Shop
local CoilButton:TextButton = ShopUI.Coil
local AdminButton:TextButton = ShopUI.Admin
local SwordButton:TextButton = ShopUI.Sword
local CarpetButton:TextButton = ShopUI.Carpet
local ExitButton:TextButton = ShopUI.Exit

ExitButton.MouseButton1Click:Connect(function()
    ShopUI.Visible = false
end)

SkipStageButton.MouseButton1Click:Connect(function()
    MPS:PromptProductPurchase(player,1583311950)
end)

ShopButton.MouseButton1Click:Connect(function()
    ShopUI.Visible = not(ShopUI.Visible)
end)

CoilButton.MouseButton1Click:Connect(function()
    MPS:PromptGamePassPurchase(player,209384276)
end)

AdminButton.MouseButton1Click:Connect(function()
    MPS:PromptGamePassPurchase(player,209383796)
end)

SwordButton.MouseButton1Click:Connect(function()
    MPS:PromptGamePassPurchase(player,209384414)
end)

CarpetButton.MouseButton1Click:Connect(function()
    MPS:PromptGamePassPurchase(player,209384690)
end)
