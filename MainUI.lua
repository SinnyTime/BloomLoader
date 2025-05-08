-- MainUI.lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local Theme = require(script.Parent.Styles.Theme)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloomUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 460)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -230)
MainFrame.BackgroundColor3 = Theme.BackgroundColor
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
Instance.new("UICorner", MainFrame).CornerRadius = Theme.CornerRadius
MainFrame.Parent = ScreenGui

-- Dragging Support
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)
MainFrame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
MainFrame.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Topbar
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 40)
Topbar.BackgroundColor3 = Theme.SectionColor
Topbar.BorderSizePixel = 0
Topbar.Parent = MainFrame
Instance.new("UICorner", Topbar).CornerRadius = Theme.CornerRadius

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Theme.Font
Title.Text = "🌱 Bloom | Version: 2.0.0 | Bloom Management Portal"
Title.TextSize = 16
Title.TextColor3 = Theme.TextColor
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Topbar

-- Tab Selector
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 130, 1, -40)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.BackgroundColor3 = Theme.SectionColor
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

-- Main Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -130, 1, -40)
ContentArea.Position = UDim2.new(0, 130, 0, 40)
ContentArea.BackgroundColor3 = Theme.BackgroundColor
ContentArea.BorderSizePixel = 0
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame

-- Add a corner to content area for consistency
Instance.new("UICorner", ContentArea).CornerRadius = Theme.CornerRadius

-- Export
return {
	ScreenGui = ScreenGui,
	ContentArea = ContentArea,
	TabBar = TabBar,
}
