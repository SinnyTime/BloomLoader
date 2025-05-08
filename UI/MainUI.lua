return function(Theme)
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")

	local safeParent = gethui and gethui() or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

	local existing = safeParent:FindFirstChild("BloomUI")
	if existing then existing:Destroy() end
	local oldHandle = safeParent:FindFirstChild("FloatingHandle")
	if oldHandle then oldHandle:Destroy() end
	
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
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Theme.BackgroundColor
	MainFrame.BorderSizePixel = 0
	MainFrame.Visible = false
	MainFrame.ClipsDescendants = true
	MainFrame.Parent = ScreenGui
	Instance.new("UICorner", MainFrame).CornerRadius = Theme.CornerRadius

	-- Animated Drag Handle Below UI
	local FloatingHandle = Instance.new("TextButton")
	FloatingHandle.Size = UDim2.new(0, 120, 0, 6)
	FloatingHandle.Position = UDim2.new(0.5, -60, 0, 0)
	FloatingHandle.Visible = false
	FloatingHandle.AnchorPoint = Vector2.new(0.5, 0.5)
	FloatingHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	FloatingHandle.BackgroundTransparency = 0.4
	FloatingHandle.Text = ""
	FloatingHandle.AutoButtonColor = false
	FloatingHandle.ZIndex = 3
	FloatingHandle.Parent = ScreenGui
	Instance.new("UICorner", FloatingHandle).CornerRadius = UDim.new(1, 0)

	-- Create TabBar and ContentArea
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
	TopbarButton.Active = true
	TopbarButton.AutoButtonColor = false
	TopbarButton.Name = "TopbarButton"
	TopbarButton.Size = UDim2.new(1, 0, 1, 0)
	TopbarButton.BackgroundTransparency = 1
	TopbarButton.Text = ""
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
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = Theme.CornerRadius
	UICorner.Parent = CloseBtn

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
	UpdateLabel.TextXAlignment = Enum.TextXAlignment.Right
	UpdateLabel.TextWrapped = true
	UpdateLabel.BackgroundTransparency = 1
	UpdateLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
	UpdateLabel.TextSize = 14
	UpdateLabel.Font = Theme.Font
	UpdateLabel.Text = ""
	UpdateLabel.Parent = Topbar

	local MinimizedFrame = Instance.new("TextButton")
	MinimizedFrame.Text = "🌱 Bloom"
	MinimizedFrame.Size = UDim2.new(0, 180, 0, 40)
	MinimizedFrame.Position = UDim2.new(0.5, -90, 0.5, -20)
	MinimizedFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MinimizedFrame.BackgroundColor3 = Theme.SectionColor
	MinimizedFrame.TextColor3 = Theme.TextColor
	MinimizedFrame.Font = Theme.Font
	MinimizedFrame.TextSize = 16
	MinimizedFrame.Visible = false
	MinimizedFrame.Parent = ScreenGui
	Instance.new("UICorner", MinimizedFrame).CornerRadius = Theme.CornerRadius

local DragHandleBottom = Instance.new("TextButton")
DragHandleBottom.Size = UDim2.new(0, 100, 0, 5)
DragHandleBottom.Position = UDim2.new(0.5, -50, 1, -5)
DragHandleBottom.AnchorPoint = Vector2.new(0.5, 1)
DragHandleBottom.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DragHandleBottom.BackgroundTransparency = 0.2
DragHandleBottom.Text = ""
DragHandleBottom.AutoButtonColor = false
DragHandleBottom.ZIndex = 3
DragHandleBottom.Parent = MainFrame
local CornerBottom = Instance.new("UICorner", DragHandleBottom)
CornerBottom.CornerRadius = UDim.new(1, 0)

-- Drag hover effects
local function addHoverEffect(handle)
	handle.MouseEnter:Connect(function()
		TweenService:Create(handle, TweenInfo.new(0.15), {
			Size = UDim2.new(0, 120, 0, 7),
			BackgroundTransparency = 0.1
		}):Play()
	end)
	handle.MouseLeave:Connect(function()
		TweenService:Create(handle, TweenInfo.new(0.15), {
			Size = UDim2.new(0, 100, 0, 5),
			BackgroundTransparency = 0.2
		}):Play()
	end)
end

addHoverEffect(DragHandleBottom)

-- Dragging
local function makeDraggable(targetFrame, handle)
	local dragging = false
	local dragStart, startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = targetFrame.Position
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
			targetFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

makeDraggable(MainFrame, DragHandleBottom)

local dragging = false
local dragStart, startPos

FloatingHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
	if dragging and dragStart and startPos then
		local delta = UserInputService:GetMouseLocation() - dragStart
		local newPos = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
		-- Animate UI to follow bar
		TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = newPos
		}):Play()
		-- Snap bar to stay under frame
		FloatingHandle.Position = UDim2.new(0.5, -60, 0, MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y + 10)
	end
end)

local CurrentTab = nil
	
-- Tab highlighting
local currentSelectedBtn = nil
local function switchTab(tabModule, btn)
	if currentSelectedBtn == btn then return end
	if not ContentArea or not ContentArea:IsDescendantOf(ScreenGui) then
		warn("❌ ContentArea missing. Cannot load tab.")
		return
	end

	if CurrentTab then
		TweenService:Create(CurrentTab, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
		task.delay(0.2, function()
			if CurrentTab then CurrentTab:Destroy() end
		end)
	end

	local success, tab = pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/SinnyTime/GaGv2/main/" .. tabModule .. ".lua"))()
	end)

	if success and typeof(tab) == "function" then
		CurrentTab = Instance.new("Frame")
		CurrentTab.BackgroundTransparency = 1
		CurrentTab.Size = UDim2.new(1, 0, 1, 0)
		CurrentTab.BackgroundColor3 = Theme.BackgroundColor
		CurrentTab.Parent = ContentArea
		tab(CurrentTab, Theme)
		TweenService:Create(CurrentTab, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()

		if currentSelectedBtn then
			currentSelectedBtn.BackgroundColor3 = Theme.SectionColor
		end
		currentSelectedBtn = btn
		currentSelectedBtn.BackgroundColor3 = Theme.HighlightColor
	else
		warn("❌ Failed to load tab:", tabModule)
	end
end

local tabs = {
	{ name = "Home", module = "UI/Tabs/Home/HomeTab" }
}

for _, tabInfo in ipairs(tabs) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 36)
	btn.Text = tabInfo.name
	btn.BackgroundColor3 = Theme.SectionColor
	btn.TextColor3 = Theme.TextColor
	btn.Font = Theme.Font
	btn.TextSize = 14
	btn.AutoButtonColor = false
	btn.Parent = TabBar
	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = Theme.CornerRadius

	btn.MouseEnter:Connect(function()
		if btn ~= currentSelectedBtn then
			TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.HoverColor }):Play()
		end
	end)

	btn.MouseLeave:Connect(function()
		if btn ~= currentSelectedBtn then
			TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.SectionColor }):Play()
		end
	end)

	btn.MouseButton1Click:Connect(function()
		switchTab(tabInfo.module, btn)
	end)
end

task.delay(0.35, function()
	local firstTab
	for _, child in ipairs(TabBar:GetChildren()) do
		if child:IsA("TextButton") and child.Text == "Home" then
			firstTab = child
			break
		end
	end
	if firstTab then
		switchTab("UI/Tabs/Home/HomeTab", firstTab)
	else
		warn("❌ Couldn't find 'Home' tab to set as default.")
	end
end)

-- Improved minimize/maximize
local isMinimized = false

MinBtn.MouseButton1Click:Connect(function()
	if not isMinimized then
		isMinimized = true
		MinBtn.Text = "+"
		TweenService:Create(MainFrame, TweenInfo.new(0.3), {
			Size = UDim2.new(0, 620, 0, 40)
		}):Play()
		ContentArea.Visible = false
		TabBar.Visible = false
		DragHandleBottom.Visible = false
		FloatingHandle.Visible = false
	else
		isMinimized = false
		MinBtn.Text = "-"
		TweenService:Create(MainFrame, TweenInfo.new(0.3), {
			Size = UDim2.new(0, 620, 0, 480)
		}):Play()
		task.delay(0.3, function()
			ContentArea.Visible = true
			TabBar.Visible = true
			DragHandleBottom.Visible = true
			FloatingHandle.Visible = true
			task.delay(0.35, function()
				FloatingHandle.Position = UDim2.new(0.5, -60, 0, MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y + 10)
			end)
		end)
	end
end)

CloseBtn.MouseButton1Click:Connect(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.2), { BackgroundTransparency = 1, Position = MainFrame.Position + UDim2.new(0, 0, -0.1, 0) }):Play()
	task.delay(0.2, function()
		ScreenGui:Destroy()
	end)
end)

	-- Update check loop (permanent notification)
local function checkForUpdates()
	local success, result = pcall(function()
		return game:HttpGet("https://raw.githubusercontent.com/SinnyTime/GaGv2/main/VERSION.txt")
	end)

	if success and result then
		local latest = string.match(result, "[%d%.]+")
		if latest then
			local currentVersion = Title.Text:match("Version:%s*([%d%.]+)")
			Title.Text = "🌱 Bloom | Version: " .. latest .. " | Bloom Management Portal"

			if currentVersion and latest ~= currentVersion then
				UpdateLabel.Text = "⚠️ Update " .. latest .. " available"
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

DragHandleBottom.Visible = true
MainFrame.Visible = true
FloatingHandle.Visible = false

MainFrame.BackgroundTransparency = 1
MainFrame.Size = UDim2.new(0, 100, 0, 50)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
	Size = UDim2.new(0, 620, 0, 480),
	Position = UDim2.new(0.5, -310, 0.5, -240),
	BackgroundTransparency = 0
}):Play()

task.delay(0.4, function()
	FloatingHandle.Position = UDim2.new(0.5, -60, 0, MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y + 10)
	FloatingHandle.Visible = true
end)

return {
	GUI = ScreenGui,
	MainFrame = MainFrame,
	Topbar = Topbar,
	TabBar = TabBar,
	ContentArea = ContentArea,
}
end
