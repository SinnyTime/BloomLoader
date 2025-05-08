return function(Theme)
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")

	local safeParent = gethui and gethui() or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

	local existing = safeParent:FindFirstChild("BloomUI")
	if existing then existing:Destroy() end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "BloomUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = safeParent

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 620, 0, 480)
	MainFrame.Position = UDim2.new(0.5, -310, 0.5, -240)
	MainFrame.AnchorPoint = Vector2.new(0.5, 0)
	MainFrame.BackgroundColor3 = Theme.BackgroundColor
	MainFrame.BorderSizePixel = 0
	MainFrame.Visible = false
	MainFrame.ClipsDescendants = true
	MainFrame.Parent = ScreenGui
	Instance.new("UICorner", MainFrame).CornerRadius = Theme.CornerRadius

	local Shadow = Instance.new("ImageLabel")
	Shadow.Name = "Shadow"
	Shadow.Image = "rbxassetid://1316045217"
	Shadow.ImageTransparency = 0.6
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
	Shadow.Size = UDim2.new(1, 60, 1, 60)
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.BackgroundTransparency = 1
	Shadow.ZIndex = -1
	Shadow.Parent = MainFrame

	local Topbar = Instance.new("Frame")
	Topbar.Name = "Topbar"
	Topbar.Size = UDim2.new(1, 0, 0, 40)
	Topbar.BackgroundColor3 = Theme.SectionColor
	Topbar.BorderSizePixel = 0
	Topbar.Parent = MainFrame

	local TopbarButton = Instance.new("TextButton")
	TopbarButton.Name = "TopbarButton"
	TopbarButton.Size = UDim2.new(1, 0, 1, 0)
	TopbarButton.BackgroundTransparency = 1
	TopbarButton.Text = ""
	TopbarButton.AutoButtonColor = false
	TopbarButton.Parent = Topbar

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Size = UDim2.new(1, -80, 1, 0)
	Title.Position = UDim2.new(0, 10, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Font = Theme.Font
	Title.TextSize = 16
	Title.TextColor3 = Theme.TextColor
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Text = "🌱 Bloom | Version: (Checking...) | Bloom Management Portal"
	Title.Parent = Topbar

	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 24, 0, 24)
	CloseBtn.Position = UDim2.new(1, -30, 0, 8)
	CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	CloseBtn.Text = "X"
	CloseBtn.TextColor3 = Color3.new(1, 1, 1)
	CloseBtn.Font = Theme.Font
	CloseBtn.TextSize = 14
	CloseBtn.Parent = Topbar
	Instance.new("UICorner", CloseBtn).CornerRadius = Theme.CornerRadius

	local MinBtn = Instance.new("TextButton")
	MinBtn.Size = UDim2.new(0, 24, 0, 24)
	MinBtn.Position = UDim2.new(1, -60, 0, 8)
	MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	MinBtn.Text = "-"
	MinBtn.TextColor3 = Color3.new(1, 1, 1)
	MinBtn.Font = Theme.Font
	MinBtn.TextSize = 16
	MinBtn.Parent = Topbar
	Instance.new("UICorner", MinBtn).CornerRadius = Theme.CornerRadius

	local UpdateLabel = Instance.new("TextLabel")
	UpdateLabel.Name = "UpdateLabel"
	UpdateLabel.Size = UDim2.new(0, 200, 1, 0)
	UpdateLabel.Position = UDim2.new(1, -290, 0, 0)
	UpdateLabel.BackgroundTransparency = 1
	UpdateLabel.TextXAlignment = Enum.TextXAlignment.Right
	UpdateLabel.TextWrapped = true
	UpdateLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
	UpdateLabel.TextSize = 14
	UpdateLabel.Font = Theme.Font
	UpdateLabel.Text = ""
	UpdateLabel.Parent = Topbar

	local TabBar = Instance.new("Frame")
	TabBar.Name = "TabBar"
	TabBar.Size = UDim2.new(0, 130, 1, -40)
	TabBar.Position = UDim2.new(0, 0, 0, 40)
	TabBar.BackgroundColor3 = Theme.SectionColor
	TabBar.BorderSizePixel = 0
	TabBar.Parent = MainFrame

	local TabLayout = Instance.new("UIListLayout")
	TabLayout.Padding = UDim.new(0, 8)
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	TabLayout.Parent = TabBar

	local ContentArea = Instance.new("Frame")
	ContentArea.Name = "ContentArea"
	ContentArea.Size = UDim2.new(1, -130, 1, -40)
	ContentArea.Position = UDim2.new(0, 130, 0, 40)
	ContentArea.BackgroundColor3 = Theme.BackgroundColor
	ContentArea.BorderSizePixel = 0
	ContentArea.Parent = MainFrame

	local isMinimized = false

	MinBtn.MouseButton1Click:Connect(function()
		if not isMinimized then
			isMinimized = true
			ContentArea.Visible = false
			TabBar.Visible = false
			MinBtn.Text = "+"
			TweenService:Create(MainFrame, TweenInfo.new(0.3), {
				Size = UDim2.new(0, 620, 0, 40)
			}):Play()
		else
			isMinimized = false
			MinBtn.Text = "-"
			TweenService:Create(MainFrame, TweenInfo.new(0.3), {
				Size = UDim2.new(0, 620, 0, 480)
			}):Play()
			task.delay(0.3, function()
				ContentArea.Visible = true
				TabBar.Visible = true
			end)
		end
	end)

	CloseBtn.MouseButton1Click:Connect(function()
		TweenService:Create(MainFrame, TweenInfo.new(0.2), {
			BackgroundTransparency = 1,
			Position = MainFrame.Position + UDim2.new(0, 0, -0.1, 0)
		}):Play()
		task.delay(0.2, function()
			ScreenGui:Destroy()
		end)
	end)

	local function makeDraggable(target, handle)
		local dragging, dragStart, startPos = false

		handle.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				dragStart = input.Position
				startPos = target.Position
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				local delta = input.Position - dragStart
				target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)
	end

	makeDraggable(MainFrame, TopbarButton)

	-- Startup Animation
	MainFrame.Visible = true
	MainFrame.Size = UDim2.new(0, 100, 0, 50)
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
		Size = UDim2.new(0, 620, 0, 480),
		Position = UDim2.new(0.5, -310, 0.5, -240)
	}):Play()

	-- Tabs
	local currentTab, currentBtn = nil, nil
	local function switchTab(tabModule, btn)
		if btn == currentBtn then return end
		if currentTab then
			TweenService:Create(currentTab, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
			task.delay(0.2, function() currentTab:Destroy() end)
		end

		local success, tab = pcall(function()
			return loadstring(game:HttpGet("https://raw.githubusercontent.com/SinnyTime/GaGv2/main/" .. tabModule .. ".lua"))()
		end)

		if success and typeof(tab) == "function" then
			currentTab = Instance.new("Frame")
			currentTab.Size = UDim2.new(1, 0, 1, 0)
			currentTab.BackgroundTransparency = 1
			currentTab.BackgroundColor3 = Theme.BackgroundColor
			currentTab.Parent = ContentArea
			tab(currentTab, Theme)
			TweenService:Create(currentTab, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()

			if currentBtn then currentBtn.BackgroundColor3 = Theme.SectionColor end
			currentBtn = btn
			currentBtn.BackgroundColor3 = Theme.HighlightColor
		else
			warn("Failed to load tab:", tabModule)
		end
	end

	for _, tabInfo in ipairs({
		{ name = "Home", module = "UI/Tabs/Home/HomeTab" }
	}) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -20, 0, 36)
		btn.Text = tabInfo.name
		btn.BackgroundColor3 = Theme.SectionColor
		btn.TextColor3 = Theme.TextColor
		btn.Font = Theme.Font
		btn.TextSize = 14
		btn.AutoButtonColor = false
		btn.Parent = TabBar
		Instance.new("UICorner", btn).CornerRadius = Theme.CornerRadius

		btn.MouseEnter:Connect(function()
			if btn ~= currentBtn then
				TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.HoverColor }):Play()
			end
		end)

		btn.MouseLeave:Connect(function()
			if btn ~= currentBtn then
				TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.SectionColor }):Play()
			end
		end)

		btn.MouseButton1Click:Connect(function()
			switchTab(tabInfo.module, btn)
		end)
	end

	task.delay(0.35, function()
	for _, child in ipairs(TabBar:GetChildren()) do
		if child:IsA("TextButton") and child.Text == "Home" then
			switchTab("UI/Tabs/Home/HomeTab", child)
			break
		end
	end
end)

-- 🔽 Place update check block HERE
-- Update check loop
local function checkForUpdates()
	local success, result = pcall(function()
		return game:HttpGet("https://raw.githubusercontent.com/SinnyTime/GaGv2/main/VERSION.txt")
	end)

	if success and result then
		local latest = string.match(result, "[%d%.]+")
		if latest then
			local currentVersion = Title.Text:match("Version:%s*([%d%.]+)")
			if currentVersion and latest ~= currentVersion then
				UpdateLabel.Text = "⚠️ v" .. latest .. " update"
				UpdateLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
				UpdateLabel.TextXAlignment = Enum.TextXAlignment.Center
				UpdateLabel.TextScaled = true
				UpdateLabel.Font = Theme.Font
				UpdateLabel.TextWrapped = true
				UpdateLabel.TextSize = 10
				UpdateLabel.TextStrokeTransparency = 0.5
				UpdateLabel.TextTransparency = 0

				local reloadClick = Instance.new("TextButton")
				reloadClick.BackgroundTransparency = 1
				reloadClick.Size = UpdateLabel.Size
				reloadClick.Position = UpdateLabel.Position
				reloadClick.Text = ""
				reloadClick.Parent = Topbar

				reloadClick.MouseButton1Click:Connect(function()
					ScreenGui:Destroy()
					loadstring(game:HttpGet("https://raw.githubusercontent.com/SinnyTime/GaGv2/main/Main.lua"))()
				end)
			else
				UpdateLabel.Text = "✅ Bloom is up to date!"
			end
		else
			UpdateLabel.Text = "⚠️ Error reading version"
		end
	else
		UpdateLabel.Text = "⚠️ Failed to check updates"
	end
end

task.spawn(function()
	while true do
		checkForUpdates()
		task.wait(30)
	end
end)


task.spawn(function()
	while true do
		checkForUpdates()
		task.wait(30)
	end
end)

-- 🔽 Then your return block
return {
	GUI = ScreenGui,
	MainFrame = MainFrame,
	Topbar = Topbar,
	TabBar = TabBar,
	ContentArea = ContentArea,
}
