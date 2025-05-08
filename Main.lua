-- Main.lua
local BASE_URL = "https://raw.githubusercontent.com/SinnyTime/GaGv2/main/"

local function import(path)
	local src = game:HttpGet(BASE_URL .. path .. ".lua")
	local func = loadstring(src)
	assert(func, "❌ Failed to load: " .. path)
	return func()
end

-- 🧠 Load theme and files
local Theme = import("UI/Styles/Theme")
local MainUI = import("UI/MainUI")
local Loader = import("UI/Loader")

-- 🌱 Start loader
Loader(function()
	local ui = MainUI(Theme)

	-- 🎮 UI toggle with LeftControl
	local UIS = game:GetService("UserInputService")
	UIS.InputBegan:Connect(function(input, gpe)
		if not gpe and input.KeyCode == Enum.KeyCode.LeftControl then
			ui.GUI.Enabled = not ui.GUI.Enabled
		end
	end)

	print("🌱 Bloom UI built")
end)

return true
