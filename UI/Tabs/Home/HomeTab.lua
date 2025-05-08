-- Tabs/Home/HomeTab.lua
return function(parent, theme)
	local TweenService = game:GetService("TweenService")

	-- Clear existing tab content (except UICorner)
	for _, child in ipairs(parent:GetChildren()) do
		if not child:IsA("UICorner") then
			child:Destroy()
		end
	end

	-- Container frame
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 1, 0)
	container.BackgroundTransparency = 1
	container.Name = "HomeContainer"
	container.Parent = parent

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 12)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = container

	-- 🌿 Title
	local title = Instance.new("TextLabel")
	title.Text = "🌱 Bloom"
	title.Font = theme.Font
	title.TextSize = 32
	title.TextColor3 = theme.AccentColor
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(0, 480, 0, 40)
	title.TextXAlignment = Enum.TextXAlignment.Center
	title.TextYAlignment = Enum.TextYAlignment.Center
	title.TextTransparency = 1
	title.Parent = container

	-- 💬 Subtitle
	local subtitle = Instance.new("TextLabel")
	subtitle.Text = "Welcome to Bloom v2.0.0"
	subtitle.Font = theme.Font
	subtitle.TextSize = 20
	subtitle.TextColor3 = theme.TextColor
	subtitle.BackgroundTransparency = 1
	subtitle.Size = UDim2.new(0, 480, 0, 26)
	subtitle.TextXAlignment = Enum.TextXAlignment.Center
	subtitle.TextTransparency = 1
	subtitle.Parent = container

	-- 📖 Description
	local description = Instance.new("TextLabel")
	description.Text = "Your all-in-one automation toolkit for Grow a Garden."
	description.Font = theme.Font
	description.TextSize = 16
	description.TextColor3 = theme.TextColor
	description.BackgroundTransparency = 1
	description.Size = UDim2.new(0, 500, 0, 24)
	description.TextXAlignment = Enum.TextXAlignment.Center
	description.TextTransparency = 1
	description.Parent = container

	-- Spacer
	local spacer = Instance.new("Frame")
	spacer.Size = UDim2.new(0, 0, 0, 8)
	spacer.BackgroundTransparency = 1
	spacer.Parent = container

	-- ℹ️ Version Info
	local infoLines = {
		"🛠️ Script Version: 2.0.0",
		"📅 Updated: May 7, 2025",
		"👤 Made by: SinnyTime"
	}

	for _, text in ipairs(infoLines) do
		local label = Instance.new("TextLabel")
		label.Text = text
		label.Font = theme.Font
		label.TextSize = 14
		label.TextColor3 = theme.TextColor
		label.BackgroundTransparency = 1
		label.Size = UDim2.new(0, 400, 0, 20)
		label.TextXAlignment = Enum.TextXAlignment.Center
		label.TextTransparency = 1
		label.Parent = container

		TweenService:Create(label, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			TextTransparency = 0
		}):Play()
	end

	-- ✨ Animate Fade In
	local elements = { title, subtitle, description }

	for i, el in ipairs(elements) do
		task.delay(i * 0.05, function()
			TweenService:Create(el, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				TextTransparency = 0
			}):Play()
		end)
	end
end
