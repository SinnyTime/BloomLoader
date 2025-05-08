-- Main.lua (clean, tested injection)
local BASE_URL = "https://raw.githubusercontent.com/SinnyTime/GaGv2/main/"

local function import(path)
	local src = game:HttpGet(BASE_URL .. path .. ".lua")
	local func = loadstring(src)
	assert(func, "❌ Failed to load: " .. path)
	return func()
end

-- Load Theme + UI Builder
local Theme = import("UI/Styles/Theme")
local MainUI = import("UI/MainUI")

-- 👇 THIS LINE BUILDS THE UI ON INJECTION
local ui = MainUI(Theme)

-- Optional: Show console confirmation
print("🌱 Bloom UI built")

-- Optional toggle with LeftControl
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.LeftControl then
		ui.GUI.Enabled = not ui.GUI.Enabled
	end
end)

return true
