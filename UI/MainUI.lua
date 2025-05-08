return function(Theme)
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")

	local safeParent = gethui and gethui() or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

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
	MainFrame.Parent = ScreenGui
	Instance.new("UICorner", MainFrame).CornerRadius = Theme.CornerRadius

	-- Bottom Drag Handle
	local DragHandle = Instance.new("Frame")
	DragHandle.Size = UDim2.new(0, 100, 0, 5)
	DragHandle.Position = UDim2.new(0.5, -50, 1, -6)
	DragHandle.AnchorPoint = Vector2.new(0.5, 1)
	DragHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DragHandle.BackgroundTransparency = 0.2
	DragHandle.ZIndex = 3
	DragHandle.Parent = MainFrame
	Instance.new("UICorner", DragHandle).CornerRadius = UDim.new(1, 0)

	-- Dragging Logic (global mouse-based)
	local function makeDraggable(frame)
		local dragging = false
		local dragStart, startPos

		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				dragStart = input.Position
				startPos = frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				local delta = input.Position - dragStart
				frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
					startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)
	end

	task.delay(0.05, function()
		MainFrame.Visible = true
		MainFrame.BackgroundTransparency = 1
		MainFrame.Size = UDim2.new(0, 100, 0, 50)
		MainFrame.Position = UDim2.new(0.5, -50, 0.5, -25)
		TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 620, 0, 480),
			Position = UDim2.new(0.5, -310, 0.5, -240),
			BackgroundTransparency = 0
		}):Play()
	end)

	-- Topbar
	local Topbar = Instance.new("Frame")
	Topbar.Name = "Topbar"
	Topbar.Size = UDim2.new(1, 0, 0, 40)
	Topbar.BackgroundColor3 = Theme.SectionColor
	Topbar.BorderSizePixel = 0
	Topbar.Parent = MainFrame
	Instance.new("UICorner", Topbar).CornerRadius = Theme.CornerRadius

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Size = UDim2.new(1, -80, 1, 0)
	Title.Position = UDim2.new(0, 10, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Font = Theme.Font
	Title.TextSize = 16
	Title.TextColor3 = Theme.TextColor
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Text = "🌱 Bloom | Version: 2.0.0 | Bloom Management Portal"
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

	CloseBtn.MouseButton1Click:Connect(function()
		MainFrame.Visible = false
		ScreenGui:Destroy()
	end)

	MinBtn.MouseButton1Click:Connect(function()
		MinimizedFrame.Position = MainFrame.Position + UDim2.new(0, 0, 0, 240)
		MainFrame.Visible = false
		MinimizedFrame.Visible = true
	end)

	MinimizedFrame.MouseButton1Click:Connect(function()
		MainFrame.Position = MinimizedFrame.Position - UDim2.new(0, 0, 0, 240)
		MainFrame.Visible = true
		MinimizedFrame.Visible = false
	end)

	-- Sidebar & Tabs
	local TabBar = Instance.new("Frame")
	TabBar.Name = "TabBar"
	TabBar.Size = UDim2.new(0, 130, 1, -40)
	TabBar.Position = UDim2.new(0, 0, 0, 40)
	TabBar.BackgroundColor3 = Theme.SectionColor
	TabBar.BorderSizePixel = 0
	TabBar.Parent = MainFrame
	Instance.new("UICorner", TabBar).CornerRadius = Theme.CornerRadius

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
	Instance.new("UICorner", ContentArea).CornerRadius = Theme.CornerRadius

	local CurrentTab = nil
	local tabs = {
		{ name = "Home", module = "Tabs/Home/HomeTab" },
		{ name = "AutoBuy", module = "Tabs/AutoBuy/AutoBuyTab" },
		{ name = "AutoCollect", module = "Tabs/AutoCollect/AutoCollectTab" },
	}

	local function switchTab(tabModule)
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
		else
			warn("❌ Failed to load tab:", tabModule)
		end
	end

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

		local corner = Instance.new("UICorner")
		corner.CornerRadius = Theme.CornerRadius
		corner.Parent = btn

		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.HoverColor }):Play()
		end)

		btn.MouseLeave:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.SectionColor }):Play()
		end)

		btn.MouseButton1Click:Connect(function()
			switchTab(tabInfo.module)
		end)
	end

	-- Load Default Tab
	switchTab("Tabs/Home/HomeTab")

	-- Enable dragging
	makeDraggable(MainFrame)
	makeDraggable(MinimizedFrame)
	makeDraggable(DragHandle)

	return {
		GUI = ScreenGui,
		MainFrame = MainFrame,
		Topbar = Topbar,
		TabBar = TabBar,
		ContentArea = ContentArea,
	}
end
