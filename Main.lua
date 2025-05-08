local BASE_URL = "https://raw.githubusercontent.com/SinnyTime/GaGv2/main/"

local function import(name)
	local src = game:HttpGet(BASE_URL .. name .. ".lua")
	local module = loadstring(src)
	assert(module, "Failed to load module: " .. name)
	return module()
end

-- 🧠 Theme + MainUI
local Theme = import("UI/Styles/Theme")
local MainUI = import("UI/MainUI")

-- 🛠️ Build UI
local ui = MainUI(Theme)

-- 🎮 UI Toggle
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.LeftControl then
		ui.GUI.Enabled = not ui.GUI.Enabled
	end
end)

return true
