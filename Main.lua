local BASE_URL = "https://raw.githubusercontent.com/SinnyTime/GaGv2/main/"

local function import(name)
	local src = game:HttpGet(BASE_URL .. name .. ".lua")
	local module = loadstring(src)
	assert(module, "Failed to load module: " .. name)
	return module()
end

-- Load Theme + MainUI (these exist)
local Theme = import("UI/Styles/Theme")
local MainUI = import("UI/MainUI")

-- 🚫 Tabs not yet created, so we comment these out
-- local AutoBuyTab = import("Tabs/AutoBuy/AutoBuyTab")
-- local AutoCollectTab = import("Tabs/AutoCollect/AutoCollectTab")

-- 🚫 Don't call missing tabs
-- AutoBuyTab(MainUI.ContentArea)
-- AutoCollectTab(MainUI.ContentArea)

return true
