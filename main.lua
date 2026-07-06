print("Server Crasher V1, Made by Duckycash.")
if not game:IsLoaded() then
	game.Loaded:Wait()
end

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CrashPanelGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local BackgroundFrame = Instance.new("Frame")
BackgroundFrame.Name = "BackgroundFrame"
BackgroundFrame.Size = UDim2.new(0, 500, 0, 300)
BackgroundFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
BackgroundFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BackgroundFrame.BackgroundTransparency = 0
BackgroundFrame.Active = true
BackgroundFrame.Draggable = true
BackgroundFrame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 6)
FrameCorner.Parent = BackgroundFrame

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Color3.fromRGB(255, 255, 255)
FrameStroke.Thickness = 1
FrameStroke.Transparency = 0
FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FrameStroke.Parent = BackgroundFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 80)
TitleLabel.Position = UDim2.new(0, 0, 0, 15)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Crash Server"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextTransparency = 0
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.TextSize = 48
TitleLabel.Parent = BackgroundFrame

local CrashButton = Instance.new("TextButton")
CrashButton.Name = "CrashButton"
CrashButton.Size = UDim2.new(0, 240, 0, 60)
CrashButton.Position = UDim2.new(0.5, -120, 0.5, -20)
CrashButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
CrashButton.BackgroundTransparency = 0
CrashButton.Text = "CRASH SERVER"
CrashButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CrashButton.TextTransparency = 0
CrashButton.Font = Enum.Font.SourceSans
CrashButton.TextSize = 22
CrashButton.Parent = BackgroundFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = CrashButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
ButtonStroke.Thickness = 2
ButtonStroke.Transparency = 0
ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ButtonStroke.Parent = CrashButton

local CancelButton = Instance.new("TextButton")
CancelButton.Name = "CancelButton"
CancelButton.Size = UDim2.new(0, 240, 0, 60)
CancelButton.Position = UDim2.new(0.5, -120, 0.5, -20)
CancelButton.BackgroundColor3 = Color3.fromRGB(135, 0, 0)
CancelButton.BackgroundTransparency = 0
CancelButton.Text = "CANCEL"
CancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CancelButton.TextTransparency = 0
CancelButton.Font = Enum.Font.SourceSans
CancelButton.TextSize = 22
CancelButton.Visible = false
CancelButton.Parent = BackgroundFrame

local CancelCorner = Instance.new("UICorner")
CancelCorner.CornerRadius = UDim.new(0, 6)
CancelCorner.Parent = CancelButton

local CancelStroke = Instance.new("UIStroke")
CancelStroke.Color = Color3.fromRGB(255, 255, 255)
CancelStroke.Thickness = 2
CancelStroke.Transparency = 0
CancelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CancelStroke.Parent = CancelButton

local NoteLabel = Instance.new("TextLabel")
NoteLabel.Name = "NoteLabel"
NoteLabel.Size = UDim2.new(1, -40, 0, 50)
NoteLabel.Position = UDim2.new(0, 20, 1, -70)
NoteLabel.BackgroundTransparency = 1
NoteLabel.Text = "Note: This will crash the whole\nserver by lagging the server."
NoteLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
NoteLabel.TextTransparency = 0
NoteLabel.Font = Enum.Font.SourceSans
NoteLabel.TextSize = 16
NoteLabel.TextWrapped = true
NoteLabel.Parent = BackgroundFrame

local isRunning = false
local isVisible = true
local isTweening = false

local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function setUIVisibilityState(visible)
	BackgroundFrame.Visible = true
	CrashButton.Visible = not isRunning
	CancelButton.Visible = isRunning

	local targetAlpha = visible and 0 or 1
	local targetTextAlpha = visible and 0 or 1

	local tweens = {
		TweenService:Create(BackgroundFrame, tweenInfo, {BackgroundTransparency = targetAlpha}),
		TweenService:Create(FrameStroke, tweenInfo, {Transparency = targetAlpha}),
		TweenService:Create(TitleLabel, tweenInfo, {TextTransparency = targetTextAlpha}),
		TweenService:Create(NoteLabel, tweenInfo, {TextTransparency = targetTextAlpha}),
		TweenService:Create(CrashButton, tweenInfo, {BackgroundTransparency = targetAlpha, TextTransparency = targetTextAlpha}),
		TweenService:Create(ButtonStroke, tweenInfo, {Transparency = targetAlpha}),
		TweenService:Create(CancelButton, tweenInfo, {BackgroundTransparency = targetAlpha, TextTransparency = targetTextAlpha}),
		TweenService:Create(CancelStroke, tweenInfo, {Transparency = targetAlpha})
	}

	for _, t in ipairs(tweens) do
		t:Play()
	end

	tweens[1].Completed:Connect(function()
		if not visible then
			BackgroundFrame.Visible = false
		end
		isTweening = false
	end)
end

local function generatePart(name)
	local part = Instance.new("Part")
	part.Name = name 
	part.Anchored = false
	part.CanCollide = true     -- Enabled so they collide with each other
	part.Transparency = 0.2
	part.Size = Vector3.new(2, 2, 2)
	
	local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if root then
		part.Position = root.Position + Vector3.new(math.random(-15,15), math.random(10,25), math.random(-15,15))
	else
		part.Position = Vector3.new(math.random(-50,50), 50, math.random(-50,50))
	end
	
	part.Parent = Workspace
end

CrashButton.MouseButton1Click:Connect(function()
	if isRunning or not isVisible or isTweening then return end
	
	isRunning = true
	
	CrashButton.Visible = false
	CancelButton.Visible = true
	
	coroutine.wrap(function()
		while isRunning do
			for i = 1, 9 do
				generatePart("p")
			end
			task.wait()
		end
	end)()
end)

CancelButton.MouseButton1Click:Connect(function()
	if not isRunning or not isVisible or isTweening then return end
	
	isRunning = false
	
	CancelButton.Visible = false
	CrashButton.Visible = true
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.LeftControl then
		if isTweening then return end
		isTweening = true
		isVisible = not isVisible
		setUIVisibilityState(isVisible)
	end
end)