-- Tabs/Home/HomeTab.lua
return function(parent, theme)
	-- Clear any existing content
	for _, child in ipairs(parent:GetChildren()) do
		if not child:IsA("UICorner") then
			child:Destroy()
		end
	end

	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 1, 0)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 10)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = container

	local title = Instance.new("TextLabel")
	title.Text = "🌱 Bloom"
	title.Font = theme.Font
	title.TextSize = 28
	title.TextColor3 = theme.AccentColor
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(0, 400, 0, 40)
	title.TextXAlignment = Enum.TextXAlignment.Center
	title.Parent = container

	local subtitle = Instance.new("TextLabel")
	subtitle.Text = "Welcome to Bloom v2.0.0"
	subtitle.Font = theme.Font
	subtitle.TextSize = 20
	subtitle.TextColor3 = theme.TextColor
	subtitle.BackgroundTransparency = 1
	subtitle.Size = UDim2.new(0, 400, 0, 30)
	subtitle.TextXAlignment = Enum.TextXAlignment.Center
	subtitle.Parent = container

	local description = Instance.new("TextLabel")
	description.Text = "Your all-in-one automation toolkit for Grow a Garden."
	description.Font = theme.Font
	description.TextSize = 16
	description.TextColor3 = theme.TextColor
	description.BackgroundTransparency = 1
	description.Size = UDim2.new(0, 420, 0, 24)
	description.TextXAlignment = Enum.TextXAlignment.Center
	description.Parent = container

	local spacer = Instance.new("TextLabel")
	spacer.Size = UDim2.new(0, 0, 0, 10)
	spacer.BackgroundTransparency = 1
	spacer.Text = ""
	spacer.Parent = container

	local version = Instance.new("TextLabel")
	version.Text = "🛠️ Script Version: 2.0.0"
	version.Font = theme.Font
	version.TextSize = 14
	version.TextColor3 = theme.TextColor
	version.BackgroundTransparency = 1
	version.Size = UDim2.new(0, 400, 0, 20)
	version.TextXAlignment = Enum.TextXAlignment.Center
	version.Parent = container

	local updated = Instance.new("TextLabel")
	updated.Text = "📅 Updated: May 7, 2025"
	updated.Font = theme.Font
	updated.TextSize = 14
	updated.TextColor3 = theme.TextColor
	updated.BackgroundTransparency = 1
	updated.Size = UDim2.new(0, 400, 0, 20)
	updated.TextXAlignment = Enum.TextXAlignment.Center
	updated.Parent = container

	local author = Instance.new("TextLabel")
	author.Text = "👤 Made by: SinnyTime"
	author.Font = theme.Font
	author.TextSize = 14
	author.TextColor3 = theme.TextColor
	author.BackgroundTransparency = 1
	author.Size = UDim2.new(0, 400, 0, 20)
	author.TextXAlignment = Enum.TextXAlignment.Center
	author.Parent = container
end
