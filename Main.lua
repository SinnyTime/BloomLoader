local BASE_URL = "https://raw.githubusercontent.com/SinnyTime/GaGv2/main/"

local function import(name)
	local src = game:HttpGet(BASE_URL .. name .. ".lua")
	local module = loadstring(src)
	assert(module, "Failed to load module: " .. name)
	return module
end

-- Load Theme and pass it into MainUI
local Theme = import("UI/Styles/Theme")()
local MainUI = import("UI/MainUI")(Theme)

-- Tabs not yet ready
-- local AutoBuyTab = import("Tabs/AutoBuy/AutoBuyTab")
-- AutoBuyTab(MainUI.ContentArea)

return true
