-- UI/Loader.lua
return function(onFinished)
	local TweenService = game:GetService("TweenService")
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer

	local parent = gethui and gethui() or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

	-- 🌱 ScreenGui setup
	local gui = Instance.new("ScreenGui")
	gui.Name = "BloomLoader"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.Parent = parent

	-- 💻 Main Frame
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 320, 0, 100)
	frame.Position = UDim2.new(0.5, -160, 0.5, -50)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	frame.BackgroundTransparency = 0.1
	frame.ClipsDescendants = true
	frame.Parent = gui
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

	-- 🎀 UI Layout
	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 6)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Parent = frame

	-- ✨ Title
	local title = Instance.new("TextLabel")
	title.Text = "Welcome!"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 20
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, -20, 0, 24)
	title.TextXAlignment = Enum.TextXAlignment.Center
	title.LayoutOrder = 1
	title.Parent = frame

	-- ✨ Subtext
	local subtext = Instance.new("TextLabel")
	subtext.Text = "Powered by Bloom"
	subtext.Font = Enum.Font.Gotham
	subtext.TextSize = 16
	subtext.TextColor3 = Color3.fromRGB(170, 170, 170)
	subtext.BackgroundTransparency = 1
	subtext.Size = UDim2.new(1, -20, 0, 20)
	subtext.TextXAlignment = Enum.TextXAlignment.Center
	subtext.LayoutOrder = 2
	subtext.Parent = frame

	-- ✍️ Credit
	local credit = Instance.new("TextLabel")
	credit.Text = "Bloom Loader Engine"
	credit.Font = Enum.Font.Gotham
	credit.TextSize = 14
	credit.TextColor3 = Color3.fromRGB(160, 120, 255)
	credit.BackgroundTransparency = 1
	credit.Size = UDim2.new(1, -20, 0, 20)
	credit.TextXAlignment = Enum.TextXAlignment.Right
	credit.TextYAlignment = Enum.TextYAlignment.Bottom
	credit.LayoutOrder = 3
	credit.Parent = frame

	-- 🪄 Scale in animation
	frame.Size = UDim2.new(0, 0, 0, 0)
	TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 320, 0, 100)
	}):Play()

	-- ⏱️ Wait, then animate out
	task.delay(1.5, function()
		local outTween = TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1
		})
		outTween:Play()

		for _, child in ipairs(frame:GetChildren()) do
			if child:IsA("TextLabel") then
				TweenService:Create(child, TweenInfo.new(0.25), { TextTransparency = 1 }):Play()
			end
		end

		outTween.Completed:Wait()
		gui:Destroy()

		if typeof(onFinished) == "function" then
			onFinished()
		end
	end)
end
