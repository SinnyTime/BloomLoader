return function(parent, theme)
	local TweenService = game:GetService("TweenService")

	for _, child in ipairs(parent:GetChildren()) do
		if not child:IsA("UICorner") then
			child:Destroy()
		end
	end

	local container = Instance.new("Frame")
	container.Name = "HomeContainer"
	container.Size = UDim2.new(1, 0, 1, 0)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 10)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = container

	-- 🌱 Title
	local title = Instance.new("TextLabel")
	title.Text = "🌱 Bloom"
	title.Font = theme.Font
	title.TextSize = 32
	title.TextColor3 = theme.AccentColor
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(0, 480, 0, 40)
	title.TextXAlignment = Enum.TextXAlignment.Center
	title.TextTransparency = 1
	title.Parent = container

	-- Subtitle (we’ll update this later with actual version info)
	local subtitle = Instance.new("TextLabel")
	subtitle.Text = "Fetching version..."
	subtitle.Font = theme.Font
	subtitle.TextSize = 20
	subtitle.TextColor3 = theme.TextColor
	subtitle.BackgroundTransparency = 1
	subtitle.Size = UDim2.new(0, 480, 0, 26)
	subtitle.TextXAlignment = Enum.TextXAlignment.Center
	subtitle.TextTransparency = 1
	subtitle.Parent = container

	local desc = Instance.new("TextLabel")
	desc.Text = "Your all-in-one automation toolkit for Grow a Garden."
	desc.Font = theme.Font
	desc.TextSize = 16
	desc.TextColor3 = theme.TextColor
	desc.BackgroundTransparency = 1
	desc.Size = UDim2.new(0, 500, 0, 24)
	desc.TextXAlignment = Enum.TextXAlignment.Center
	desc.TextTransparency = 1
	desc.Parent = container

	-- Spacer
	local spacer = Instance.new("Frame")
	spacer.Size = UDim2.new(0, 0, 0, 8)
	spacer.BackgroundTransparency = 1
	spacer.Parent = container

	-- ℹ️ Info Labels (dynamic)
	local versionInfo = Instance.new("TextLabel")
	versionInfo.Text = "🛠️ Loading version..."
	versionInfo.Font = theme.Font
	versionInfo.TextSize = 14
	versionInfo.TextColor3 = theme.TextColor
	versionInfo.BackgroundTransparency = 1
	versionInfo.Size = UDim2.new(0, 400, 0, 20)
	versionInfo.TextXAlignment = Enum.TextXAlignment.Center
	versionInfo.TextTransparency = 1
	versionInfo.Parent = container

	local creditInfo = Instance.new("TextLabel")
	creditInfo.Text = "👤 Made by: SinnyTime"
	creditInfo.Font = theme.Font
	creditInfo.TextSize = 14
	creditInfo.TextColor3 = theme.TextColor
	creditInfo.BackgroundTransparency = 1
	creditInfo.Size = UDim2.new(0, 400, 0, 20)
	creditInfo.TextXAlignment = Enum.TextXAlignment.Center
	creditInfo.TextTransparency = 1
	creditInfo.Parent = container

	-- 📜 Changelog container
	local changelogTitle = Instance.new("TextLabel")
	changelogTitle.Text = "📜 Recent Changes"
	changelogTitle.Font = theme.Font
	changelogTitle.TextSize = 18
	changelogTitle.TextColor3 = theme.AccentColor
	changelogTitle.BackgroundTransparency = 1
	changelogTitle.Size = UDim2.new(0, 400, 0, 24)
	changelogTitle.TextXAlignment = Enum.TextXAlignment.Center
	changelogTitle.TextTransparency = 1
	changelogTitle.Parent = container

	local changelogBox = Instance.new("TextLabel")
	changelogBox.Text = "Loading changelog..."
	changelogBox.Font = theme.Font
	changelogBox.TextSize = 14
	changelogBox.TextColor3 = theme.TextColor
	changelogBox.BackgroundTransparency = 1
	changelogBox.TextWrapped = true
	changelogBox.TextYAlignment = Enum.TextYAlignment.Top
	changelogBox.TextXAlignment = Enum.TextXAlignment.Center
	changelogBox.Size = UDim2.new(0, 460, 0, 100)
	changelogBox.TextTransparency = 1
	changelogBox.Parent = container

	-- ✨ Fade in sequence
	local fadeGroup = { title, subtitle, desc, versionInfo, creditInfo, changelogTitle, changelogBox }
	for i, obj in ipairs(fadeGroup) do
		task.delay(i * 0.05, function()
			TweenService:Create(obj, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
		end)
	end

	-- 🌐 Fetch version
	task.spawn(function()
		local success, version = pcall(function()
			return game:HttpGet("https://raw.githubusercontent.com/SinnyTime/GaGv2/main/VERSION.txt")
		end)

		if success and version then
			version = string.match(version, "[%d%.]+") or "Unknown"
			subtitle.Text = "Welcome to Bloom v" .. version
			versionInfo.Text = "🛠️ Script Version: " .. version
		else
			subtitle.Text = "Failed to load version"
			versionInfo.Text = "🛠️ Script Version: Unknown"
		end
	end)

	-- 🌐 Fetch changelog
	task.spawn(function()
		local success, log = pcall(function()
			return game:HttpGet("https://raw.githubusercontent.com/SinnyTime/GaGv2/main/CHANGELOG.txt")
		end)

		if success and log then
			local entries = log:split("\n")
			local recent = {}
			for i = 1, math.min(5, #entries) do
				table.insert(recent, "• " .. entries[i])
			end
			changelogBox.Text = table.concat(recent, "\n")
		else
			changelogBox.Text = "Unable to load changelog."
		end
	end)
end
