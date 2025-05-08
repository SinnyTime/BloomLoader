local BASE_URL = "https://raw.githubusercontent.com/SinnyTime/GaGv2/main/"

local function import(name)
	local src = game:HttpGet(BASE_URL .. name .. ".lua")
	local module = loadstring(src)
	assert(module, "Failed to load module: " .. name)
	return module()
end

-- Load Theme + MainUI
local Theme = import("UI/Styles/Theme")
local MainUI = import("UI/MainUI")

-- Load Tabs
local AutoBuyTab = import("Tabs/AutoBuy/AutoBuyTab")
local AutoCollectTab = import("Tabs/AutoCollect/AutoCollectTab")
-- Add more tabs here...

-- Inject Tabs into UI
AutoBuyTab(MainUI.ContentArea)
AutoCollectTab(MainUI.ContentArea)
-- Later we’ll add tab switching buttons too

return true
