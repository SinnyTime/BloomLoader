local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("BloomIntro") then CoreGui.BloomIntro:Destroy() end

local introGui = Instance.new("ScreenGui", CoreGui)
introGui.Name = "BloomIntro"
introGui.IgnoreGuiInset = true
introGui.ResetOnSpawn = false
introGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local introFrame = Instance.new("Frame", introGui)
introFrame.Size = UDim2.new(0, 340, 0, 140)
introFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
introFrame.AnchorPoint = Vector2.new(0.5, 0.5)
introFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 20)
introFrame.BackgroundTransparency = 1
Instance.new("UICorner", introFrame).CornerRadius = UDim.new(0, 10)

TweenService:Create(introFrame, TweenInfo.new(0.5), {
	BackgroundTransparency = 0.2
}):Play()

local introTitle = Instance.new("TextLabel", introFrame)
introTitle.AnchorPoint = Vector2.new(0.5, 0)
introTitle.Position = UDim2.new(0.5, 0, 0, 32)
introTitle.Size = UDim2.new(1, -40, 0, 28)
introTitle.Text = "Bloom Loader"
introTitle.Font = Enum.Font.GothamBlack
introTitle.TextColor3 = Color3.fromRGB(180, 120, 255)
introTitle.TextTransparency = 1
introTitle.TextSize = 22
introTitle.BackgroundTransparency = 1

local powered = Instance.new("TextLabel", introFrame)
powered.Size = UDim2.new(0, 200, 0, 18)
powered.Position = UDim2.new(1, -210, 1, -38)
powered.Text = "Powered by"
powered.Font = Enum.Font.Gotham
powered.TextColor3 = Color3.fromRGB(200, 200, 200)
powered.TextTransparency = 1
powered.TextSize = 14
powered.BackgroundTransparency = 1
powered.TextXAlignment = Enum.TextXAlignment.Right

local domain = Instance.new("TextLabel", introFrame)
domain.Size = UDim2.new(0, 200, 0, 18)
domain.Position = UDim2.new(1, -210, 1, -20)
domain.Text = "BloomLoader.com"
domain.Font = Enum.Font.Gotham
domain.TextColor3 = Color3.fromRGB(140, 100, 255)
domain.TextTransparency = 1
domain.TextSize = 14
domain.BackgroundTransparency = 1
domain.TextXAlignment = Enum.TextXAlignment.Right

local function StartIntro(callback)
	TweenService:Create(introTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
	TweenService:Create(powered, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
	TweenService:Create(domain, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

	wait(2.5)

	TweenService:Create(introTitle, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	TweenService:Create(powered, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	TweenService:Create(domain, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	TweenService:Create(introFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()

	wait(0.5)
	introGui:Destroy()
	if callback then callback() end
end

local function StartMainUI()
	local gui = Instance.new("ScreenGui", CoreGui)
	gui.Name = "BloomMainUI"
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local mainFrame = Instance.new("Frame", gui)
	mainFrame.Size = UDim2.new(0, 460, 0, 260)
	mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
	mainFrame.BackgroundTransparency = 1
	mainFrame.Visible = false
	mainFrame.BorderSizePixel = 0
	Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

    local topBar = Instance.new("Frame", mainFrame)
	topBar.Name = "TopBar"
	topBar.Size = UDim2.new(1, 0, 0, 34)
	topBar.BackgroundColor3 = Color3.fromRGB(40, 0, 80)
	topBar.BorderSizePixel = 0
	Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 12)

	local mainTitle = Instance.new("TextLabel", topBar)
	mainTitle.Size = UDim2.new(1, -80, 1, 0)
	mainTitle.Position = UDim2.new(0, 12, 0, 0)
	mainTitle.Text = "Bloom | Version 1.0.0 | discord.gg/uujKAYdCnN"
	mainTitle.Font = Enum.Font.GothamBold
	mainTitle.TextColor3 = Color3.fromRGB(200, 120, 255)
	mainTitle.TextSize = 14
	mainTitle.BackgroundTransparency = 1
	mainTitle.TextXAlignment = Enum.TextXAlignment.Left

	local close = Instance.new("TextButton", topBar)
	close.Size = UDim2.new(0, 32, 0, 32)
	close.Position = UDim2.new(1, -38, 0, 1)
	close.Text = "×"
	close.Font = Enum.Font.GothamBold
	close.TextSize = 20
	close.TextColor3 = Color3.fromRGB(255, 255, 255)
	close.BackgroundTransparency = 1
	close.BorderSizePixel = 0

	local minimize = Instance.new("TextButton", topBar)
	minimize.Size = UDim2.new(0, 32, 0, 32)
	minimize.Position = UDim2.new(1, -72, 0, 1)
	minimize.Text = "-"
	minimize.Font = Enum.Font.GothamBold
	minimize.TextSize = 20
	minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
	minimize.BackgroundTransparency = 1
	minimize.BorderSizePixel = 0

	local fullSize = UDim2.new(0, 720, 0, 440)
	local isMinimized = false
	local restoreBtn

	close.MouseButton1Click:Connect(function()
		TweenService:Create(mainFrame, TweenInfo.new(0.3), {
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 460, 0, 260)
		}):Play()
		task.delay(0.3, function()
			gui:Destroy()
		end)
	end)

	minimize.MouseButton1Click:Connect(function()
		if isMinimized then return end
		isMinimized = true
		TweenService:Create(mainFrame, TweenInfo.new(0.3), {
			Position = UDim2.new(1.5, 0, 0.5, 0)
		}):Play()

		restoreBtn = Instance.new("TextButton", gui)
		restoreBtn.Text = "Bloom"
		restoreBtn.Font = Enum.Font.GothamBold
		restoreBtn.TextSize = 14
		restoreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		restoreBtn.Size = UDim2.new(0, 80, 0, 32)
		restoreBtn.Position = UDim2.new(1, -100, 0.5, -16)
		restoreBtn.AnchorPoint = Vector2.new(0.5, 0.5)
		restoreBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 80)
		restoreBtn.BackgroundTransparency = 1
		restoreBtn.TextTransparency = 1
		Instance.new("UICorner", restoreBtn).CornerRadius = UDim.new(0, 8)

		TweenService:Create(restoreBtn, TweenInfo.new(0.4), {
			BackgroundTransparency = 0,
			TextTransparency = 0
		}):Play()

		restoreBtn.MouseButton1Click:Connect(function()
			restoreBtn:Destroy()
			TweenService:Create(mainFrame, TweenInfo.new(0.3), {
				Position = UDim2.new(0.5, 0, 0.5, 0)
			}):Play()
			isMinimized = false
		end)
	end)

	task.delay(0.1, function()
		mainFrame.Visible = true
		TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
			Size = fullSize,
			BackgroundTransparency = 0.2
		}):Play()
	end)

	local dragging, dragInput, dragStart, startPos
	topBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	topBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			mainFrame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

    	-- Tabs
	local tabButtons = {}
	local tabs = {"Home", "Main", "Inventory", "Shop", "Miscellaneous", "Settings"}

	local tabFrame = Instance.new("Frame", mainFrame)
	tabFrame.Size = UDim2.new(0, 140, 1, -34)
	tabFrame.Position = UDim2.new(0, 0, 0, 34)
	tabFrame.BackgroundColor3 = Color3.fromRGB(25, 0, 40)
	tabFrame.BackgroundTransparency = 0.3
	tabFrame.BorderSizePixel = 0
	Instance.new("UICorner", tabFrame).CornerRadius = UDim.new(0, 8)

	local layout = Instance.new("UIListLayout", tabFrame)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 4)

	local contentFrame = Instance.new("Frame", mainFrame)
	contentFrame.Size = UDim2.new(1, -140, 1, -34)
	contentFrame.Position = UDim2.new(0, 140, 0, 34)
	contentFrame.BackgroundColor3 = Color3.fromRGB(25, 0, 40)
	contentFrame.BackgroundTransparency = 0.3
	contentFrame.BorderSizePixel = 0
	Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 8)

	local function setActiveTab(tabName)
		for _, v in ipairs(contentFrame:GetChildren()) do
			if v:IsA("Frame") then v.Visible = false end
		end
		for name, btn in pairs(tabButtons) do
			btn.TextColor3 = Color3.fromRGB(160, 140, 200)
		end
		if tabButtons[tabName] then
			tabButtons[tabName].TextColor3 = Color3.fromRGB(200, 160, 255)
		end
		if contentFrame:FindFirstChild(tabName) then
			contentFrame[tabName].Visible = true
		end
	end

	for _, name in ipairs(tabs) do
		local btn = Instance.new("TextButton", tabFrame)
		btn.Size = UDim2.new(1, -10, 0, 30)
		btn.Position = UDim2.new(0, 5, 0, 0)
		btn.BackgroundTransparency = 1
		btn.TextColor3 = Color3.fromRGB(160, 140, 200)
		btn.Font = Enum.Font.GothamMedium
		btn.TextSize = 15
		btn.Text = name
		btn.AutoButtonColor = false
		btn.BorderSizePixel = 0

		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(200, 160, 255)}):Play()
		end)
		btn.MouseLeave:Connect(function()
			if not contentFrame:FindFirstChild(name).Visible then
				TweenService:Create(btn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(160, 140, 200)}):Play()
			end
		end)
		btn.MouseButton1Click:Connect(function()
			setActiveTab(name)
		end)

		tabButtons[name] = btn
	end

-- Home tab content
local home = Instance.new("Frame", contentFrame)
home.Name = "Home"
home.Size = UDim2.new(1, 0, 1, 0)
home.BackgroundTransparency = 1
home.Visible = false

-- 🌟 Header
local header = Instance.new("TextLabel", home)
header.Text = "Bloom Loader v1.0.0"
header.Size = UDim2.new(1, -40, 0, 32)
header.Position = UDim2.new(0.5, 0, 0, 20)
header.AnchorPoint = Vector2.new(0.5, 0)
header.BackgroundTransparency = 1
header.Font = Enum.Font.GothamBlack
header.TextSize = 22
header.TextColor3 = Color3.fromRGB(200, 120, 255)
header.TextXAlignment = Enum.TextXAlignment.Center

-- 💫 Credits
local credits = Instance.new("TextLabel", home)
credits.Text = "Created By: Bloom   |   Credits: Bliss"
credits.Size = UDim2.new(1, -40, 0, 20)
credits.Position = UDim2.new(0.5, 0, 0, 60)
credits.AnchorPoint = Vector2.new(0.5, 0)
credits.BackgroundTransparency = 1
credits.Font = Enum.Font.Gotham
credits.TextSize = 14
credits.TextColor3 = Color3.fromRGB(190, 160, 255)
credits.TextXAlignment = Enum.TextXAlignment.Center

-- 📝 Changelogs
local changelogs = Instance.new("TextLabel", home)
changelogs.Text = "Changelog:\n- UI Launched\n- Sidebar built\n- Intro screen finished"
changelogs.Size = UDim2.new(1, -40, 0, 80)
changelogs.Position = UDim2.new(0.5, 0, 0, 100)
changelogs.AnchorPoint = Vector2.new(0.5, 0)
changelogs.BackgroundTransparency = 1
changelogs.Font = Enum.Font.Gotham
changelogs.TextSize = 13
changelogs.TextColor3 = Color3.fromRGB(180, 140, 220)
changelogs.TextWrapped = true
changelogs.TextYAlignment = Enum.TextYAlignment.Top
changelogs.TextXAlignment = Enum.TextXAlignment.Center


	setActiveTab("Home")

    -- Utility to generate empty tab frames with placeholder text
local function createPlaceholderTab(tabName)
	local frame = Instance.new("Frame", contentFrame)
	frame.Name = tabName
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1
	frame.Visible = false

	local label = Instance.new("TextLabel", frame)
	label.Text = tabName .. " - Coming Soon..."
	label.Size = UDim2.new(1, -40, 1, -40)
	label.Position = UDim2.new(0.5, 0, 0.5, 0)
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.TextColor3 = Color3.fromRGB(180, 140, 220)
	label.TextWrapped = true
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.TextXAlignment = Enum.TextXAlignment.Center
end

-- Generate all placeholder tabs
for _, name in ipairs(tabs) do
	if name ~= "Home" then
		createPlaceholderTab(name)
	end
end
end
StartIntro(StartMainUI)
