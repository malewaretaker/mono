

local Framework = loadstring(game:HttpGet("https://raw.githubusercontent.com/howyougetcracked/gangstershit/main/framework"))()
local UIS = game:GetService("UserInputService")

local function TweenObject(object, style, speed, direction, info)
	game.TweenService:Create(object, TweenInfo.new(speed, style, direction), info):Play()
end
local function IndexExists(table, index)
	return table[index]~=nil
end
function CreateObject(className, properties)
	local instance = Instance.new(className)
	local parent
	for propertyName, propertyValue in pairs(properties) do
		if propertyName ~= "Parent" then
			instance[propertyName] = propertyValue
		else
			parent = propertyValue
		end
	end
	instance.Parent = parent
	return instance
end
for i,v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == 'Core' or v.Name == 'WM' then
		v:Destroy()
	end
end
if not isfolder('Mono') then
    makefolder('Mono')
	makefolder('Mono\\Data')
	makefolder('Mono\\Cache')
	makefolder('Mono\\Audio')
	makefolder('Mono\\Configuration')
	makefolder('Mono\\Mods')
	-- Begin
	writefile('Mono\\Mods\\readme.txt', [[
		Welcome!
		To make mods look at the Mono developer documentation.
	]])
	writefile('Mono\\Data\\readme.txt', [[
		Welcome!
		Do not touch anything as it can break your Mono Experience.
	]])
	writefile('Mono\\Data\\smile.txt', [[
		(<3)
		;stitch; x3
	]])
	writefile('Mono\\Cache\\readme.txt', [[
		Welcome!
		Do not touch anything as it can break your Mono Experience.
	]])
	writefile('Mono\\Audio\\readme.txt', [[
		Welcome!
		To create a playlist, make a new folder in this directory then drag in any .mp3 files.
		keep names short!
	]])
	writefile('Mono\\Audio\\smile.txt', [[
		<3
		https://open.spotify.com/track/3IznIgmXtrUaoPWpQTy5jB?si=7d83bde062a041be
		https://open.spotify.com/track/1T0J5syNHl7PGejYZt9qfZ?si=179344ecbeb248db
		https://open.spotify.com/track/6VHircgbkp9FEqW115ZcPh?si=4f96cdc7b6ca4894
		https://open.spotify.com/track/2z3I1eAwNZIVxNFAzYsdnS?si=1fe94afb75ea4304
	]])
	writefile('Mono\\Configuration\\readme.txt', [[
		Welcome!
		Drag in any .ACFG files in here if you would like Mono to recognize it.
	]])
	writefile('Mono\\readme.txt', [[
		== Thanks for purchasing Mono ==
			| https://open.spotify.com/track/3IznIgmXtrUaoPWpQTy5jB?si=7d83bde062a041be
	]])
end
local Library = {
	LibraryMetadata = {
		Name = "Mono"
	},
	Core = CreateObject("ScreenGui", {
		Name = "Core",	Parent = game.CoreGui,
	}),
	JSON = {
		WriteData = function(name, data)
			local file = 'Mono\\Data\\'..name..".json"
			writefile(file, game:GetService("HttpService"):JSONEncode(data))
		end,
		ReadData = function(name)
			local file = 'Mono\\Data\\'..name..".json"
			local raw_data = readfile(file)
    		local data = game:GetService("HttpService"):JSONDecode(raw_data)
    		return data
		end,
		DataExist = function(name)
			return isfile('Mono\\Data\\'..name..'.json')
		end
	},
	Framework = {
		AllowDragging = function(Object, Frame, Speed)
			local dragToggle = nil
			local dragSpeed = 0
			local dragInput = nil
			local dragStart = nil
			local dragPos = nil
			local Util = {
				Enabled = true
			}
			local function updateInput(input)
				if not Util.Enabled then return end
				local Delta = input.Position - dragStart
				local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
				game:GetService("TweenService"):Create(Frame, TweenInfo.new(Speed), {
					Position = Position
				}):Play()
			end
			Object.InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
					dragToggle = true
					dragStart = input.Position
					startPos = Frame.Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragToggle = false
						end
					end)
				end
			end)
			Object.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if input == dragInput and dragToggle then
					updateInput(input)
				end
			end)
			
			return Util
		end
	}
}
function Library.Init()
    local AllChildren = Library.Core:GetDescendants()
    for i,v in pairs (AllChildren) do 
        if v:IsA("ScrollingFrame") then 
            if v:FindFirstChildOfClass("UIListLayout") or v:FindFirstChildOfClass("UIGridLayout")then
                local Layout = v:FindFirstChildOfClass("UIListLayout") or v:FindFirstChildOfClass("UIGridLayout")
                local function UpdateSize(FrameInstance,LayoutInstance)
                    if FrameInstance and LayoutInstance then
                        local PaddingX = 0
                        local PaddingY = 0
                        if FrameInstance:FindFirstChildOfClass("UIPadding") then
                            local UIPadding = FrameInstance:FindFirstChildOfClass("UIPadding")
                            PaddingX += UIPadding.PaddingLeft.Offset
                            PaddingX += UIPadding.PaddingRight.Offset
                            PaddingY += UIPadding.PaddingBottom.Offset
                            PaddingY += UIPadding.PaddingTop.Offset
                        end
                        if FrameInstance.AutomaticCanvasSize == Enum.AutomaticSize.Y then
                            FrameInstance.CanvasSize = UDim2.new(0,0,0,LayoutInstance.AbsoluteContentSize.Y + PaddingY)
                        elseif FrameInstance.AutomaticCanvasSize == Enum.AutomaticSize.X then
                            FrameInstance.CanvasSize = UDim2.new(0,LayoutInstance.AbsoluteContentSize.X + PaddingX,0,0)
                        elseif FrameInstance.AutomaticCanvasSize == Enum.AutomaticSize.XY then
                            FrameInstance.CanvasSize = UDim2.new(0,LayoutInstance.AbsoluteContentSize.X + PaddingX,0,LayoutInstance.AbsoluteContentSize.Y + PaddingY)
                        end
                    end
                end
                UpdateSize(v,Layout)
                Layout.Changed:connect(function() UpdateSize(v,Layout) end)
                v:GetPropertyChangedSignal("AutomaticCanvasSize"):connect(function() UpdateSize(v,Layout) end)
            end
        end
    end
    
end
function Library.New()
	
	local FrameMain = CreateObject("Frame", {
		Name = "FrameMain",	Parent = Library.Core,	BackgroundColor3 = Color3.fromRGB(14, 13, 13),	BackgroundTransparency = 0.1,	ClipsDescendants = true,	Position = UDim2.new(0.0050041526556015015,0,0.42098766565322876,0),	Size = UDim2.new(0,565,0,436),	Transparency = 0.10000000149011612,
	})
	local UICorner = CreateObject("UICorner", {
		Parent = FrameMain,	CornerRadius = UDim.new(0,6),
	})
	local Sidebar = CreateObject("Frame", {
		Name = "Sidebar",	Parent = FrameMain,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(0,179,0,419),	Transparency = 1,
	})
	local UIListLayout = CreateObject("UIListLayout", {
		Parent = Sidebar,	HorizontalAlignment = Enum.HorizontalAlignment.Center,	Padding = UDim.new(0,4),
	})
	local AControlModule = CreateObject("Frame", {
		Name = "AControlModule",	Parent = Sidebar,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(0,179,0,22),	Transparency = 1,
	})
	local UIListLayout2 = CreateObject("UIListLayout", {
		Parent = AControlModule,	FillDirection = Enum.FillDirection.Horizontal,	SortOrder = Enum.SortOrder.LayoutOrder,	Padding = UDim.new(0,4),
	})
	local Exit = CreateObject("TextButton", {
		Name = "Exit",	Parent = AControlModule,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(0,7,1,0),	Font = Enum.Font.SourceSans,	Text = "",	TextColor3 = Color3.fromRGB(0,0,0),	TextSize = 14,
	})
	local Frame = CreateObject("Frame", {
		Parent = Exit,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(215,108,96),	BorderSizePixel = 0,	Position = UDim2.new(0.5,0,0.5,0),	Size = UDim2.new(0,6,0,6),
	})
	local UICorner2 = CreateObject("UICorner", {
		Parent = Frame,	CornerRadius = UDim.new(1,0),
	})
	local UIStroke = CreateObject("UIStroke", {
		Parent = Frame,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(215,108,96),	Thickness = 2,	Transparency = 0.8500000238418579,
	})
	local UIPadding = CreateObject("UIPadding", {
		Parent = AControlModule,	PaddingLeft = UDim.new(0,13),	PaddingTop = UDim.new(0,5),
	})
	local Minimize = CreateObject("TextButton", {
		Name = "Minimize",	Parent = AControlModule,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(0,7,1,0),	Font = Enum.Font.SourceSans,	Text = "",	TextColor3 = Color3.fromRGB(0,0,0),	TextSize = 14,
	})
	local Frame2 = CreateObject("Frame", {
		Parent = Minimize,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(233,196,104),	BorderSizePixel = 0,	Position = UDim2.new(0.5,0,0.5,0),	Size = UDim2.new(0,6,0,6),
	})
	local UICorner3 = CreateObject("UICorner", {
		Parent = Frame2,	CornerRadius = UDim.new(1,0),
	})
	local UIStroke2 = CreateObject("UIStroke", {
		Parent = Frame2,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(233,196,104),	Thickness = 2,	Transparency = 0.8500000238418579,
	})
	local Maximize = CreateObject("TextButton", {
		Name = "Maximize",	Parent = AControlModule,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(0,7,1,0),	Font = Enum.Font.SourceSans,	Text = "",	TextColor3 = Color3.fromRGB(0,0,0),	TextSize = 14,
	})
	local Frame3 = CreateObject("Frame", {
		Parent = Maximize,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(124,156,99),	BorderSizePixel = 0,	Position = UDim2.new(0.5,0,0.5,0),	Size = UDim2.new(0,6,0,6),
	})
	local UICorner4 = CreateObject("UICorner", {
		Parent = Frame3,	CornerRadius = UDim.new(1,0),
	})
	local UIStroke3 = CreateObject("UIStroke", {
		Parent = Frame3,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(174,218,138),	Thickness = 2,	Transparency = 0.8500000238418579,
	})
	local TextLabel = CreateObject("TextLabel", {
		Parent = AControlModule,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.19879518449306488,0,0,0),	Size = UDim2.new(-0.40361446142196655,200,1,0),	Font = Enum.Font.JosefinSans,	Text = "Mono",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 11,	TextTransparency = 0.75,	TextXAlignment = Enum.TextXAlignment.Right,
	})
	local UIPadding2 = CreateObject("UIPadding", {
		Parent = TextLabel,	PaddingBottom = UDim.new(0,-1),	PaddingRight = UDim.new(0,6),
	})
	local BSeparation = CreateObject("Frame", {
		Name = "BSeparation",	Parent = Sidebar,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9300000071525574,	BorderColor3 = Color3.fromRGB(27,42,53),	BorderSizePixel = 0,	Size = UDim2.new(1,0,0,1),	Transparency = 0.9300000071525574,
	})
	local CSearch = CreateObject("Frame", {
		Name = "CSearch",	Parent = Sidebar,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	BorderColor3 = Color3.fromRGB(27,42,53),	BorderSizePixel = 0,	Position = UDim2.new(0,0,0.07398568093776703,0),	Size = UDim2.new(1,0,0.069212406873703,1),	Transparency = 1,
	})
	local TextBox = CreateObject("TextBox", {
		Parent = CSearch,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9900000095367432,	Position = UDim2.new(0.5,0,0.5,0),	Size = UDim2.new(0.8999999761581421,0,0.9599999785423279,0),	ClearTextOnFocus = false,	Font = Enum.Font.SourceSans,	PlaceholderColor3 = Color3.fromRGB(149,149,149),	PlaceholderText = "Search...",	Text = "",	TextColor3 = Color3.fromRGB(202,202,202),	TextSize = 14,	TextWrapped = true,	TextXAlignment = Enum.TextXAlignment.Left,
	})
	
	local UICorner5 = CreateObject("UICorner", {
		Parent = TextBox,	CornerRadius = UDim.new(0,4),
	})
	local UIStroke4 = CreateObject("UIStroke", {
		Parent = TextBox,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.8999999761581421,
	})
	local UIPadding3 = CreateObject("UIPadding", {
		Parent = TextBox,	PaddingBottom = UDim.new(0,2),	PaddingLeft = UDim.new(0,30),	PaddingRight = UDim.new(0,25),
	})
	local search = CreateObject("ImageButton", {
		Name = "search",	Parent = TextBox,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundTransparency = 1,	LayoutOrder = 1,	Position = UDim2.new(-0.1437101662158966,0,0.5373134613037109,0),	Size = UDim2.new(0,10,0,10),	ZIndex = 2,	Image = "rbxassetid://3926305904",	ImageRectOffset = Vector2.new(964,324),	ImageRectSize = Vector2.new(36,36),
	})
	local close = CreateObject("ImageButton", {
		Name = "close",	Parent = TextBox,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundTransparency = 1,	Position = UDim2.new(1.0999622344970703,0,0.5373134613037109,0),	Size = UDim2.new(0,10,0,10),	ZIndex = 2,	Image = "rbxassetid://3926305904",	ImageRectOffset = Vector2.new(284,4),	ImageRectSize = Vector2.new(24,24),
	})
	local ETabs = CreateObject("Frame", {
		Name = "ETabs",	Parent = Sidebar,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	BorderColor3 = Color3.fromRGB(27,42,53),	BorderSizePixel = 0,	Position = UDim2.new(0,0,0.16706444323062897,0),	Size = UDim2.new(1,0,0.6634843945503235,1),	Transparency = 1,
	})
	local UIPadding4 = CreateObject("UIPadding", {
		Parent = ETabs,	PaddingTop = UDim.new(0,10),
	})
	local UIListLayout3 = CreateObject("UIListLayout", {
		Parent = ETabs,	HorizontalAlignment = Enum.HorizontalAlignment.Center,	SortOrder = Enum.SortOrder.LayoutOrder,	Padding = UDim.new(0,4),
	})
	local FSeparation = CreateObject("Frame", {
		Name = "FSeparation",	Parent = Sidebar,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9300000071525574,	BorderColor3 = Color3.fromRGB(27,42,53),	BorderSizePixel = 0,	Position = UDim2.new(0.11104323714971542,0,0.8424820899963379,0),	Size = UDim2.new(0.8389567136764526,0,0,1),	Transparency = 0.9300000071525574,
	})
	local GProfile = CreateObject("Frame", {
		Name = "GProfile",	Parent = Sidebar,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	BorderColor3 = Color3.fromRGB(27,42,53),	BorderSizePixel = 0,	Position = UDim2.new(0,0,0.8544152975082397,0),	Size = UDim2.new(1,0,0.14319808781147003,1),	Transparency = 1,
	})
	local UserProfileImage = CreateObject("ImageLabel", {
		Parent = GProfile,	BackgroundColor3 = Color3.fromRGB(22, 22, 22),	Position = UDim2.new(0.12849164009094238,0,0.16393440961837769,0),	Size = UDim2.new(0,23,0,23),	Image = "rbxassetid://7653253343",
	})
	local UICorner6 = CreateObject("UICorner", {
		Parent = UserProfileImage,	CornerRadius = UDim.new(1,0),
	})
	local UIStroke5 = CreateObject("UIStroke", {
		Parent = UserProfileImage,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(28,30,31),
	})
	local UserProfileNam = CreateObject("TextLabel", {
		Parent = GProfile,	AutomaticSize = Enum.AutomaticSize.X,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.29608938097953796,0,0.16393442451953888,0),	Size = UDim2.new(0,0,0,15),	Font = Enum.Font.SourceSans, Text = "User",	TextColor3 = Color3.fromRGB(229,229,229),	TextSize = 14,	TextWrapped = true,	TextXAlignment = Enum.TextXAlignment.Left,
	})
	local MonoBadgeIcon = CreateObject("ImageButton", {
		Name = "Icon",	Parent = UserProfileNam,	AnchorPoint = Vector2.new(0,0.5),	ImageTransparency = 0.3, BackgroundTransparency = 1,	Position = UDim2.new(1,-4,0.5349999761581421,0),	Size = UDim2.new(0,20,0,17),	ZIndex = 2,	Image = "rbxassetid://11773614430",
	})
	local UIGradient41341 = CreateObject("UIGradient", {
		Parent = MonoBadgeIcon,	Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(37, 182, 237)), ColorSequenceKeypoint.new(1, Color3.fromRGB(173, 62, 252))} ,	Offset = Vector2.new(0,0),
	})
	local TextLabel3 = CreateObject("TextLabel", {
		Parent = GProfile,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.29608938097953796,0,0.2950819730758667,0),	Size = UDim2.new(0,107,0,19),	Font = Enum.Font.SourceSans,	Text = "∞ days remaining",	TextColor3 = Color3.fromRGB(136,136,136),	TextSize = 12,	TextXAlignment = Enum.TextXAlignment.Left,
	})
	local DSeparation = CreateObject("Frame", {
		Name = "DSeparation",	Parent = Sidebar,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9300000071525574,	BorderColor3 = Color3.fromRGB(27,42,53),	BorderSizePixel = 0,	Size = UDim2.new(1,0,0,1),	Transparency = 0.9300000071525574,
	})
	local TabFrame = CreateObject("Frame", {
		Name = "TabFrame",	Parent = FrameMain,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.3168141543865204,0,0,0),	Size = UDim2.new(0,386,0,419),	Transparency = 1,
	})
	local UpperSection = CreateObject("Frame", {
		Name = "UpperSection",	Parent = TabFrame,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.0025906735099852085,0,0,0),	Size = UDim2.new(0,385,0,45),	Transparency = 1,
	})
	local TabSeparation = CreateObject("Frame", {
		Name = "TabSeparation",	Parent = UpperSection,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9300000071525574,	BorderColor3 = Color3.fromRGB(27,42,53),	BorderSizePixel = 0,	Position = UDim2.new(0,0,1,0),	Size = UDim2.new(1,0,0,1),	Transparency = 0.9300000071525574,
	})
	local Drag = CreateObject("ImageButton", {
		Name = "Drag",	Parent = UpperSection,	AnchorPoint = Vector2.new(0,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.9319999814033508,0,0.5,0),	Size = UDim2.new(0,10,0,10),	AutoButtonColor = false,	Image = "http://www.roblox.com/asset/?id=5172066892",	ImageTransparency = 0.5,
	})
	local TabTitle = CreateObject("TextLabel", {
		Name = "TabTitle",	Parent = UpperSection,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.04675324633717537,0,0,0),	Size = UDim2.new(0,182,0,46),	Font = Enum.Font.SourceSans,	Text = "Home",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 14,	TextTransparency = 0.25999999046325684,	TextXAlignment = Enum.TextXAlignment.Left,
	})
	
	local BSeparation2 = CreateObject("Frame", {
		Name = "BSeparation",	Parent = FrameMain,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9300000071525574,	BorderColor3 = Color3.fromRGB(27,42,53),	BorderSizePixel = 0,	Position = UDim2.new(0.3168141543865204,0,0,0),	Size = UDim2.new(0,1,1,0),	Transparency = 0.9300000071525574,
	})
	local ConfigurationalValues = CreateObject("Folder", {
		Name = "ConfigurationalValues",	Parent = MonoCore,
	})
	local Question = CreateObject("TextButton", {
		Name = "Question",	Parent = FrameMain,	BackgroundColor3 = Color3.fromRGB(0,0,0),	BackgroundTransparency = 0.6499999761581421,	Size = UDim2.new(0,565,0,419),	AutoButtonColor = false,	Font = Enum.Font.SourceSans,	Text = "",	TextColor3 = Color3.fromRGB(0,0,0),	TextSize = 14,
	})
	Question.Visible = false
	local UICorner = CreateObject("UICorner", {
		Parent = Question,	CornerRadius = UDim.new(0,6),
	})
	local YesQ = CreateObject("TextButton", {
		Name = "button1", Parent = Question,	AnchorPoint = Vector2.new(0.5,0.6000000238418579),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.949999988079071,	Position = UDim2.new(0.5,-57,0.5527446866035461,0),	Size = UDim2.new(0,109,0,27),	AutoButtonColor = false,	Font = Enum.Font.SourceSans,	Text = "YES",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 14,
	})
	local BTNC = CreateObject("UICorner", {
		Parent = YesQ,	CornerRadius = UDim.new(0,6),
	})
	local NoQ = CreateObject("TextButton", {
		Name = "button2", Parent = Question,	AnchorPoint = Vector2.new(0.5,0.6000000238418579),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.949999988079071,	Position = UDim2.new(0.5,57,0.5527446866035461,0),	Size = UDim2.new(0,109,0,27),	AutoButtonColor = false,	Font = Enum.Font.SourceSans,	Text = "NO",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 14,	TextTransparency = 0.4099999964237213,
	})
	local BTNC2 = CreateObject("UICorner", {
		Parent = NoQ,	CornerRadius = UDim.new(0,6),
	})
	local TextQ = CreateObject("TextLabel", {
		Name = "Title", Parent = Question,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.5,0,0.46050596237182617,0),	Size = UDim2.new(0,200,0,36),	Font = Enum.Font.SourceSans,Text = "Would to exit Mono?",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 17,
	})
	TextBox:GetPropertyChangedSignal('Text'):Connect(function()
		for i,v in pairs(TabFrame:GetDescendants()) do
			if v:IsA'Frame' and v.Parent.Name == 'Section' then
				if v.Name:lower():find(TextBox.Text:lower()) and v.Name~='PickColor' then
					v.Visible = true
				else
					v.Visible = false
				end
			end
		end
	end)
	local JSON = Library.JSON
	if not JSON.DataExist('ProfileData') then
		JSON.WriteData('ProfileData', {
			Name = "User",
			Image = "8036992934"
		})
	end
	if not JSON.DataExist('UIData') then
		JSON.WriteData('UIData', {
			Opacity = true
		})
	end
	if not JSON.DataExist('DragData') then
		JSON.WriteData('DragData', {
			Enabled = false
		})
	end
	local MainDrag = Library.Framework.AllowDragging(FrameMain, FrameMain, 0.3)
	
	local ProfileData = JSON.ReadData('ProfileData')
	local UIData = JSON.ReadData('UIData')
	local Dragging = JSON.ReadData('DragData')

	UserProfileNam.Text = ProfileData.Name:sub(1, 15)
	UserProfileImage.Image = 'rbxassetid://'..ProfileData.Image

	FrameMain.BackgroundTransparency = (UIData.Opacity and 0.1 or 0)
	FrameMain.BackgroundColor3 = (UIData.Opacity and Color3.fromRGB(14, 13, 13) or Color3.fromRGB(14, 14, 14))

	MainDrag.Enabled = Dragging.Enabled

	local Drag = Library.Framework.AllowDragging(Drag, FrameMain, 0.1)
	Drag.Enabled = true

	local TabName = TabTitle
	local WinHandle = {
		TabCount = 0,
		Exit = function()
			Library.Core:Destroy()
		end,
		ProfileData = ProfileData,
		UIData = UIData,
		DragData = Dragging.Enabled
	}
	local FullDrag

	function WinHandle.UpdateProfile(data)
		JSON.WriteData('ProfileData', data)
		UserProfileNam.Text = data.Name:sub(1, 15)
		UserProfileImage.Image = 'rbxassetid://'..data.Image
	end
	function WinHandle.UpdateWindowData(data)
		JSON.WriteData('UIData', data)
		FrameMain.BackgroundTransparency = (data.Opacity and 0.1 or 0)
		FrameMain.BackgroundColor3 = (data.Opacity and Color3.fromRGB(14, 13, 13) or Color3.fromRGB(14, 14, 14))
	end
	function WinHandle.UpdateTopData(data)
		JSON.WriteData('DragData', data)
		MainDrag.Enabled = data.Enabled
		WinHandle.DragData = data.Enabled
	end
	function WinHandle.AskQuestion(question, callback)
		local Clone = Question:Clone()
		Clone.Parent = FrameMain
		Clone.Title.Text = question
		Clone.button1.MouseButton1Down:Connect(function()
			Clone:Destroy()
			callback(true)
		end)
		Clone.button2.MouseButton1Down:Connect(function()
			Clone:Destroy()
			callback(false)
		end)
		Clone.Visible = true
	end
	local Minimizing = false
	local Minimized = false
	local Maximizing = false
	MainDrag.Enabled = false
	Minimize.MouseButton1Down:Connect(function()
		if Miniming or Maximizing then return end
		Minimized = true
		Minimizing = true
		TabFrame.Visible = false
		BSeparation2.Visible = false
		
		TweenObject(FrameMain, Enum.EasingStyle.Circular, 0.3, Enum.EasingDirection.Out, {
			Size = UDim2.new(0, 53, 0, 28)
		})
		wait(0.3)
		for i,v in pairs(Sidebar:GetChildren()) do
			if v:IsA'Frame' and v.Name~='AControlModule' then
				v.Visible = false
			end
		end
		MainDrag.Enabled = true
		Minimizing = false
	end)
	Maximize.MouseButton1Down:Connect(function()
		if Miniming or Maximizing then return end
		Maximizing = true
		Minimized = false
		MainDrag.Enabled = (WinHandle.DragData)
		TabFrame.Visible = true
		for i,v in pairs(Sidebar:GetChildren()) do
			if v:IsA'Frame' and v.Name~='AControlModule' then
				v.Visible = true
			end
		end
		TweenObject(FrameMain, Enum.EasingStyle.Circular, 0.3, Enum.EasingDirection.Out, {
			Size = UDim2.new(0, 565, 0, 419)
		})
		wait(0.3)
		
		BSeparation2.Visible = true
		
		Maximizing = false
	end)
	Exit.MouseButton1Down:Connect(function()
		if Minimized then
			WinHandle.Exit()
			return
		end
		WinHandle.AskQuestion('Are you sure you would like to exit Mono?', function(a)
			if a == true then
				WinHandle.Exit()
			end
		end)
	end)
	function WinHandle.Separator()
		local FSeparation = CreateObject("Frame", {
			Name = "FSeparation",	Parent = ETabs,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9300000071525574,	BorderColor3 = Color3.fromRGB(27,42,53),	BorderSizePixel = 0,	Position = UDim2.new(0.11104323714971542,0,0.8424820899963379,0),	Size = UDim2.new(0.8389567136764526,0,0,1),	Transparency = 0.9300000071525574,
		})
	end
	function WinHandle.Tab(name, img)
		WinHandle.TabCount = WinHandle.TabCount +  1
		local TabButton = CreateObject("TextButton", {
			Name = "TabButton",	Parent = ETabs,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.09612662345170975,0,0,0),	Size = UDim2.new(0.8077465891838074,0,0.014869890175759792,25),	AutoButtonColor = false,	Font = Enum.Font.SourceSans, Text = (name or "Tab"),	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 14,	TextTransparency = 0.7,	TextXAlignment = Enum.TextXAlignment.Left,
		})
		local UICorner = CreateObject("UICorner", {
			Parent = TabButton,	CornerRadius = UDim.new(0,4),
		})
		local UIPadding = CreateObject("UIPadding", {
			Parent = TabButton,	PaddingLeft = UDim.new(0,30),
		})
		local ImageLabel = CreateObject("ImageLabel", {
			Parent = TabButton,	BackgroundColor3 = Color3.fromRGB(255,255,255),	AnchorPoint = Vector2.new(0, 0.45), BackgroundTransparency = 1,	Position = UDim2.new(-0.16325347125530243,0,0.5,0),	Size = UDim2.new(0,12,0,12),	Image = (img or "http://www.roblox.com/asset/?id=11854792250"),	ImageTransparency = 0.7,
		})
		local Tab = CreateObject("Frame", {
			Name = "Tab",	Parent = TabFrame,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.018,0,0.122,0),	Size = UDim2.new(0,372,0,359),	Transparency = 1,
		})
		local Left = CreateObject("ScrollingFrame", {
			AutomaticCanvasSize = Enum.AutomaticSize.Y, Name = "Left",	Parent = Tab,	Active = true,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	BorderSizePixel = 0,	Size = UDim2.new(0.5,0,1,0),	Transparency = 1,	CanvasSize = UDim2.new(0,0,0,0),	ScrollBarImageColor3 = Color3.fromRGB(0,0,0),	ScrollBarThickness = 0,
		})
		local UIListLayout = CreateObject("UIListLayout", {
			Parent = Left,	SortOrder = Enum.SortOrder.LayoutOrder,	Padding = UDim.new(0,8),
		})
		local UIPadding = CreateObject("UIPadding", {
			Parent = Left,	PaddingLeft = UDim.new(0,5),	PaddingRight = UDim.new(0,5),	PaddingTop = UDim.new(0,5), PaddingBottom = UDim.new(0,5)
		})
		local Right = CreateObject("ScrollingFrame", {
		    AutomaticCanvasSize = Enum.AutomaticSize.Y, 	Name = "Right",	Parent = Tab,	Active = true,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	BorderSizePixel = 0,	Position = UDim2.new(0.5,0,0,0),	Size = UDim2.new(0.5,0,1,0),	Transparency = 1,	CanvasSize = UDim2.new(0,0,0,0),	ScrollBarImageColor3 = Color3.fromRGB(0,0,0),	ScrollBarThickness = 0,
		})
		local UIListLayout2 = CreateObject("UIListLayout", {
			Parent = Right,	SortOrder = Enum.SortOrder.LayoutOrder,	Padding = UDim.new(0,8),
		})
		local UIPadding2 = CreateObject("UIPadding", {
			Parent = Right,	PaddingLeft = UDim.new(0,5),	PaddingRight = UDim.new(0,5),	PaddingTop = UDim.new(0,5), PaddingBottom = UDim.new(0,5)
		})
		TabButton.MouseButton1Down:Connect(function()
			TabName.Text = name
			
			for i,v in pairs(TabFrame:GetChildren()) do
				if v:IsA'Frame' and v.Name == 'Tab' then
					v.Visible = false
				end
			end
			Tab.Visible = true
			for i,v in pairs(ETabs:GetChildren()) do
				if v:IsA'TextButton' and v.Name == 'TabButton' then
					TweenObject(v, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
						BackgroundTransparency = 1
					})
					TweenObject(v, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
						TextTransparency = 0.7
					})
					TweenObject(v.ImageLabel, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
						ImageTransparency = 0.7
					})
				end
			end
			TweenObject(TabButton, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
				BackgroundTransparency = 0.95
			})
			TweenObject(TabButton, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
				TextTransparency = 0.4
			})
			TweenObject(ImageLabel, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
				ImageTransparency = 0.4
			})
		end)
		local SectionHandle = {}
		function SectionHandle.Open()
			TabName.Text = name
			
			for i,v in pairs(TabFrame:GetChildren()) do
				if v:IsA'Frame' and v.Name == 'Tab' then
					v.Visible = false
				end
			end
			Tab.Visible = true
			for i,v in pairs(ETabs:GetChildren()) do
				if v:IsA'TextButton' and v.Name == 'TabButton' then
					TweenObject(v, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
						BackgroundTransparency = 1
					})
					TweenObject(v, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
						TextTransparency = 0.7
					})
					TweenObject(v.ImageLabel, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
						ImageTransparency = 0.7
					})
				end
			end
			TweenObject(TabButton, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
				BackgroundTransparency = 0.95
			})
			TweenObject(TabButton, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
				TextTransparency = 0.4
			})
			TweenObject(ImageLabel, Enum.EasingStyle.Circular, 0.1, Enum.EasingDirection.Out, {
				ImageTransparency = 0.4
			})
		end
		if WinHandle.TabCount == 1 then
			SectionHandle.Open()
		end
		function SectionHandle.Section(side)
			local Section = CreateObject("Frame", {
				Name = "Section",	Parent = (side == 'left' and Left or Right),	AutomaticSize = Enum.AutomaticSize.Y,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.949999988079071,	Size = UDim2.new(1,0,-0.11585041880607605,58),	Transparency = 0.949999988079071,
			})
			local UICorner = CreateObject("UICorner", {
				Parent = Section,	CornerRadius = UDim.new(0,4),
			})
			local UIStroke = CreateObject("UIStroke", {
				Parent = Section,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
			})
			local UIPadding = CreateObject("UIPadding", {
				Parent = Section,	PaddingBottom = UDim.new(0,5),	PaddingLeft = UDim.new(0,5),	PaddingRight = UDim.new(0,5),	PaddingTop = UDim.new(0,5),
			})
			local UIListLayout = CreateObject("UIListLayout", {
				Parent = Section,	SortOrder = Enum.SortOrder.LayoutOrder,	Padding = UDim.new(0,5),
			})
			local AssetHandler = {}
			function AssetHandler.Button(name, callback)
				local Button = CreateObject("Frame", {
					Name = name,	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0,0,0.6512274742126465,0),	Size = UDim2.new(1,0,0,35),	Transparency = 1,
				})
				local TextButton = CreateObject("TextButton", {
					Parent = Button,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9700000286102295,	Position = UDim2.new(0.4969879388809204,0,0.5,0),	Size = UDim2.new(0.949999988079071,0,0,23),	AutoButtonColor = false,	Font = Enum.Font.SourceSans,Text =name,	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 11,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding = CreateObject("UIPadding", {
					Parent = TextButton,	PaddingLeft = UDim.new(0,10),
				})
				local UICorner = CreateObject("UICorner", {
					Parent = TextButton,	CornerRadius = UDim.new(0,4),
				})
				local UIStroke = CreateObject("UIStroke", {
					Parent = TextButton,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
				})
				TextButton.MouseButton1Down:Connect(function()
					task.spawn(callback)
					TextButton.BackgroundTransparency = 0.96
					wait()
					TextButton.BackgroundTransparency = 0.9700000286102295
				end)
				local Handler = {
					Button = Button
				}
				return Handler
			end
			function AssetHandler.Slider(name, min, default, max, symbol, callback)

				local Slider = CreateObject("Frame", {
					Name = name,	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(1,0,0,30),	Transparency = 1,
				})
				local TextButton = CreateObject("TextButton", {
					Parent = Slider,	Text = name, TextTransparency =1, BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(1,0,1,0),	Font = Enum.Font.SourceSans,	Text = "",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 13,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding = CreateObject("UIPadding", {
					Parent = TextButton,	PaddingLeft = UDim.new(0,5),
				})
				local TextLabel = CreateObject("TextLabel", {
					Parent = TextButton,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.007000000216066837,0,0.06700000166893005,0),	Size = UDim2.new(0,38,0,24),	Font = Enum.Font.SourceSans,	Text = "FOV",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 12,	TextTransparency = 0.5,	TextWrapped = true,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				TextLabel.Text = name
				local BG = CreateObject("Frame", {
					Name = "BG",	Parent = TextButton,	AnchorPoint = Vector2.new(0,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.75,	BorderSizePixel = 0,	Position = UDim2.new(0.2850000560283661,0,0.5,0),	Size = UDim2.new(0,77,0,2),	Transparency = 0.75,
				})

				local Frame = CreateObject("Frame", {
					Parent = TextButton,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	BorderColor3 = Color3.fromRGB(27,42,53),	Position = UDim2.new(0.2800000011920929,0,0.30000001192092896,0),	Size = UDim2.new(0,77,0,12),	Transparency = 1,
				})
				
				local Ball = CreateObject("Frame", {
					Name = "Ball",	Parent = Frame,	AnchorPoint = Vector2.new(0,0.5),	BackgroundColor3 = Color3.fromRGB(198,198,198),	Position = UDim2.new(0,3,0.5,0),	Size = UDim2.new(0,10,0,10),
				})
				local UICorner = CreateObject("UICorner", {
					Parent = Ball,	CornerRadius = UDim.new(1,0),
				})
				local Amount = CreateObject("TextLabel", {
					Name = "Amount",	Parent = TextButton,	AnchorPoint = Vector2.new(0,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.949999988079071,	Position = UDim2.new(0.8009999990463257,0,0.5,0),	Size = UDim2.new(0,26,0,15),	Font = Enum.Font.SourceSans,	Text = "50",	TextColor3 = Color3.fromRGB(202,202,202),	TextSize = 10,	TextWrapped = true,
				})
				local UICorner2 = CreateObject("UICorner", {
					Parent = Amount,	CornerRadius = UDim.new(0,4),
				})
				local UIStroke = CreateObject("UIStroke", {
					Parent = Amount,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
				})
				local slider = Framework.PositionSlider(Frame, Ball, min, max, 0.1)
				slider:set(default)
				Amount.Text = default..symbol
				slider.Updated:connect(function(value)
					
					Amount.Text = value..symbol

                    task.spawn(function()
						pcall(function()
							callback(value)
						end)
					end)
				end)
				local Handle = {
					Update = function(num)
						oldcb = callback
						callback = nil
						slider:set(num)
						Amount.Text = num..symbol
						callback = oldcb
					end
				}
				return Handle
			end
			function AssetHandler.Keybind(name, Dkey, callback, onchanged)
				local Keybind = CreateObject("Frame", {
					Name =  name,	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(1,0,0,30),	Transparency = 1,
				})
				local TextButton = CreateObject("TextButton", {
					Parent = Keybind,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(1,0,1,0),	Font = Enum.Font.SourceSans,	Text = name,	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 13,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding = CreateObject("UIPadding", {
					Parent = TextButton,	PaddingLeft = UDim.new(0,5),
				})
				local Amount = CreateObject("TextLabel", {
					Name = "Amount",	Parent = TextButton,	AnchorPoint = Vector2.new(0.8899999856948853,0.5),	AutomaticSize = Enum.AutomaticSize.X,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.949999988079071,	Position = UDim2.new(0.9427019953727722,0,0.5,0),	Size = UDim2.new(0,3,0,15),	Font = Enum.Font.SourceSans,	Text = "End",	TextColor3 = Color3.fromRGB(202,202,202),	TextSize = 10,	TextWrapped = true,	TextXAlignment = Enum.TextXAlignment.Right,
				})
				local UICorner = CreateObject("UICorner", {
					Parent = Amount,	CornerRadius = UDim.new(0,4),
				})
				local UIStroke = CreateObject("UIStroke", {
					Parent = Amount,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
				})
				local UIPadding2 = CreateObject("UIPadding", {
					Parent = Amount,	PaddingLeft = UDim.new(0,5),	PaddingRight = UDim.new(0,5),
				})
				
				TextButton.MouseButton1Down:Connect(function()
					Amount.Text = "..."
				end)
				key = Framework.Keybind(TextButton, {Enum.KeyCode.Space, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.LeftShift, Enum.KeyCode.LeftControl, Enum.UserInputType.MouseMovement, Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2})
				
				key.Updated:connect(function(key)
					Amount.Text = tostring(key.Name)
					onchanged(key)
				end)
				Amount.Text = tostring(Dkey.Name)
				key.Pressed:connect(function()
					task.spawn(callback)
					Amount.BackgroundTransparency = 0.9
					wait()
					Amount.BackgroundTransparency = 0.9427019953727722
				end)
				
				key:set(Dkey or Enum.KeyCode.Q)
			end
			function AssetHandler.ColorPicker(name, preset, callback)
				local ColorPicker = CreateObject("Frame", {
					Name = name,	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0,0,0.7777777910232544,0),	Size = UDim2.new(1,0,0,38),	Transparency = 1,
				})
				local TextButton = CreateObject("TextButton", {
					Parent = ColorPicker,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9700000286102295,	Position = UDim2.new(0.5,0,0.5,0),	Size = UDim2.new(0.95,0,0.699999988079071,0),	AutoButtonColor = false,	Font = Enum.Font.SourceSans,	Text = "Color",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 11,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				TextButton.Text = name
				local UIPadding = CreateObject("UIPadding", {
					Parent = TextButton,	PaddingLeft = UDim.new(0,10),
				})
				local UICorner = CreateObject("UICorner", {
					Parent = TextButton,	CornerRadius = UDim.new(0,4),
				})
				local UIStroke = CreateObject("UIStroke", {
					Parent = TextButton,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
				})
				local Preview = CreateObject("ImageLabel", {
					Name = "Preview",	Parent = TextButton,	AnchorPoint = Vector2.new(0,0.5),	ImageColor3 = preset, BackgroundColor3 = preset,	BorderSizePixel = 0,	Position = UDim2.new(0.8610617518424988,0,0.5,0),	Size = UDim2.new(0,15,0,15),	ImageTransparency = 0.5,
				})
				local UIGradient = CreateObject("UIGradient", {
					Parent = Preview,	Color =  ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 152, 152))},	Rotation = 90,
				})
				local UICorner2 = CreateObject("UICorner", {
					Parent = Preview,	CornerRadius = UDim.new(0,4),
				})
				local Glow = CreateObject("UIStroke", {
					Parent = Preview,	Color = preset,	Thickness = 2.5,	Transparency = 0.8999999761581421,
				})
				callback(preset)
				-- Picker

				local PickColor = CreateObject("Frame", {
					Name = "PickColor",	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(1,0,0,70),	Transparency = 1, Visible = false
				})
				local Main = CreateObject("TextButton", {
					Name = "Main",	Parent = PickColor,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9700000286102295,	Position = UDim2.new(0.5,0,0.4338647127151489,0),	Size = UDim2.new(0.95,0,1,0),	AutoButtonColor = false,	Font = Enum.Font.SourceSans, Text = "",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 11,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding = CreateObject("UIPadding", {
					Parent = Main,	PaddingBottom = UDim.new(0,10),	PaddingLeft = UDim.new(0,10),	PaddingRight = UDim.new(0,10),	PaddingTop = UDim.new(0,10),
				})
				local UICorner = CreateObject("UICorner", {
					Parent = Main,	CornerRadius = UDim.new(0,4),
				})
				local UIStroke = CreateObject("UIStroke", {
					Parent = Main,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
				})
				local Darkness = CreateObject("ImageButton", {
					Name = "Darkness",	Parent = Main,	BackgroundColor3 = preset,	BorderSizePixel = 0,	Size = UDim2.new(0,54,0,54),	AutoButtonColor = false,	Image = "rbxassetid://2615689005",	ImageColor3 = Color3.fromRGB(255,255,255),
				})
				local UICorner2 = CreateObject("UICorner", {
					Parent = Darkness,
				})
				local UIStroke2 = CreateObject("UIStroke", {
					Parent = Darkness,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(53,53,53),	Thickness = 0.8999999761581421,
				})
				local Hue = CreateObject("ImageButton", {
					Name = "Hue",	Parent = Main,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BorderSizePixel = 0,	Position = UDim2.new(0.4636785387992859,0,0,0),	Size = UDim2.new(0,20,0,54),	AutoButtonColor = false,	Image = "rbxassetid://2615692420",
				})
				local UICorner3 = CreateObject("UICorner", {
					Parent = Hue,
				})
				local Confirm = CreateObject("TextButton", {
					Name = "Confirm",	Parent = Main,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9700000286102295,	Position = UDim2.new(0.8266811370849609,0,0.8837237358093262,0),	Size = UDim2.new(0.316885769367218,0,0.3674473762512207,0),	AutoButtonColor = false,	Font = Enum.Font.SourceSans,	Text = "CONFIRM",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 9,	TextTransparency = 0.5,
				})
				local UICorner4 = CreateObject("UICorner", {
					Parent = Confirm,	CornerRadius = UDim.new(0,4),
				})
				local UIStroke3 = CreateObject("UIStroke", {
					Parent = Confirm,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
				})
				local Preview2 = CreateObject("ImageLabel", {
					Name = "Preview",	Parent = Main,	AnchorPoint = Vector2.new(0,0.5),	BackgroundColor3 = preset,	BorderSizePixel = 0,	Position = UDim2.new(0.6678623557090759,0,0.2737500071525574,0),	Size = UDim2.new(0,41,0,27),	ImageTransparency = 0.5,
				})
				local UIGradient = CreateObject("UIGradient", {
					Parent = Preview2,	Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 152, 152))},	Rotation = 90,
				})
				local UICorner5 = CreateObject("UICorner", {
					Parent = Preview2,	CornerRadius = UDim.new(0,4),
				})
				TextButton.MouseButton1Down:Connect(function()
					PickColor.Visible = not PickColor.Visible
				end)
				
				local hue = Hue
				local glow = Glow
				local picker = Darkness
				local testFrame = Preview
				local testFrame2 = Preview2
				local huedown = false
				local wheeldown = false
				Confirm.MouseButton1Down:Connect(function()
					PickColor.Visible = false
					
				end)
				local white, black = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
				local colors = {Color3.new(1, 0, 0), Color3.new(1, 1, 0), Color3.new(0, 1, 0), 
					Color3.new(0, 1, 1), Color3.new(0, 0, 1), Color3.new(1, 0, 1), Color3.new(1, 0, 0)}
			
				hue.MouseMoved:connect(function(_, y)
					if huedown then
						local percent = (y-hue.AbsolutePosition.Y-36)/hue.AbsoluteSize.Y
						local num = math.max(1, math.min(7,
							math.floor(((percent*7+0.5)*100))/100 
							))
						local startC = colors[math.floor(num)]
						local endC = colors[math.ceil(num)]
						picker.BackgroundColor3 = startC:lerp(endC, num-math.floor(num)) or Color3.new(0, 0, 0)
					end	
				end)
			
				picker.MouseMoved:connect(function(x, y)
					if wheeldown then
						local xPercent = (x-picker.AbsolutePosition.X)/picker.AbsoluteSize.X
						local yPercent = (y-picker.AbsolutePosition.Y-36)/picker.AbsoluteSize.Y
						
						local color = white:lerp(picker.BackgroundColor3, xPercent):lerp(black, yPercent)
						testFrame.BackgroundColor3 = color
						glow.Color = color
						testFrame2.BackgroundColor3 = color
						callback(color)
					end
				end)
			
				hue.MouseButton1Down:Connect(function()
					huedown = true
				end)
				picker.MouseButton1Down:Connect(function()
					wheeldown = true
				end)
			
			
				UIS.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						wheeldown = false
						huedown = false
					end
				end)
			end
			function AssetHandler.Label(text)
				local Label = CreateObject("Frame", {
					Name = text,	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0,0,0.8191945552825928,0),	Size = UDim2.new(1,0,0,16),	Transparency = 1,
				})
				local TextButton = CreateObject("TextButton", {
					Parent = Label,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(1,0,1,0),	Font = Enum.Font.SourceSans,	Text = text,	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 13,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding = CreateObject("UIPadding", {
					Parent = TextButton,	PaddingLeft = UDim.new(0,5),
				})
				local Handler = {
					Update = function(text)
						TextButton.Text = text:sub(1, 30)
					end
				}
				return Handler
			end
			function AssetHandler.BigLabel(text)
				local Label = CreateObject("Frame", {
					Name = text,	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0,0,0.8191945552825928,0),	Size = UDim2.new(1,0,0,16),	Transparency = 1,
				})
				local TextButton = CreateObject("TextButton", {
					Parent = Label,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(1,0,1,0),	Font = Enum.Font.SourceSans,	Text = text,	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 15,	TextTransparency = 0.3,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding = CreateObject("UIPadding", {
					Parent = TextButton,	PaddingLeft = UDim.new(0,5),
				})
				local Handler = {
					Update = function(text)
						TextButton.Text = text:sub(1, 35)
					end
				}
				return Handler
			end
			function AssetHandler.Dropdown(name, default, list, callback)
				local Dropdown = CreateObject("Frame", {
					Name = name,	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0,0,0.7777777910232544,0),	Size = UDim2.new(1,0,0,38),	Transparency = 1,
				})
				local OpenBtn = CreateObject("TextButton", {
					Parent = Dropdown,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9700000286102295,	Position = UDim2.new(0.5,0,0.5,0),	Size = UDim2.new(0.949999988079071,0,0.699999988079071,0),	AutoButtonColor = false,	Font = Enum.Font.SourceSans,	Text = name.."...",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 11,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding = CreateObject("UIPadding", {
					Parent = OpenBtn,	PaddingLeft = UDim.new(0,10),
				})
				local UICorner = CreateObject("UICorner", {
					Parent = OpenBtn,	CornerRadius = UDim.new(0,4),
				})
				local UIStroke = CreateObject("UIStroke", {
					Parent = OpenBtn,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
				})
				local ImageLabel = CreateObject("ImageLabel", {
					Parent = OpenBtn,	AnchorPoint = Vector2.new(0,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.8610617518424988,0,0.5,0),	Size = UDim2.new(0,15,0,15),	Image = "http://www.roblox.com/asset/?id=11866733883",	ImageTransparency = 0.5,
				})
				
				local Dropper = CreateObject("Frame", {
					ClipsDescendants = true, Name = "Dropper",	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0,0,0.5938987731933594,0),	Size = UDim2.new(1,0,0,100),	Transparency = 1, Visible = false
				})
				local TextButton = CreateObject("TextButton", {
					ClipsDescendants, Parent = Dropper,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9700000286102295,	Position = UDim2.new(0.5,0,0.4338647127151489,2),	Size = UDim2.new(0.949999988079071,0,0.8679999709129333,0),	AutoButtonColor = false,	Font = Enum.Font.SourceSans,	Text = "",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 11,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding = CreateObject("UIPadding", {
					Parent = TextButton,	PaddingBottom = UDim.new(0,10),	PaddingLeft = UDim.new(0,10),	PaddingRight = UDim.new(0,10),	PaddingTop = UDim.new(0,10),
				})
				local UICorner = CreateObject("UICorner", {
					Parent = TextButton,	CornerRadius = UDim.new(0,4),
				})
				local UIStroke = CreateObject("UIStroke", {
					Parent = TextButton,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
				})
				local ScrollingFrame = CreateObject("ScrollingFrame", {
					ClipsDescendants = true, Parent = TextButton,	Active = true,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.5000001192092896,0,0.519342303276062,0),	Size = UDim2.new(1,0,0.9424876570701599,0),	Transparency = 1,	AutomaticCanvasSize = Enum.AutomaticSize.Y,	CanvasSize = UDim2.new(0,0,0,0),	ScrollBarImageColor3 = Color3.fromRGB(0,0,0),	ScrollBarThickness = 0,
				})
				local UIListLayout = CreateObject("UIListLayout", {
					Parent = ScrollingFrame,	HorizontalAlignment = Enum.HorizontalAlignment.Center,	SortOrder = Enum.SortOrder.LayoutOrder,	Padding = UDim.new(0,5),
				})
				local UIPadding3 = CreateObject("UIPadding", {
					Parent = ScrollingFrame,	PaddingBottom = UDim.new(0,1),	PaddingTop = UDim.new(0,1),
				})
				Dropper.Size = UDim2.new(1,0,0,0)
				OpenBtn.MouseButton1Down:Connect(function()
					Dropper.Visible = true
					TweenObject(Dropper, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
						Size = UDim2.new(1,0,0,100)
					})
				end)
				callback(default)
				for i,v in pairs(list) do
					local DropButton = CreateObject("TextButton", {
						Name = "DropButton",	Parent = ScrollingFrame,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = (v==default and 0.9 or 0.9700000286102295),	Position = UDim2.new(0.4870184361934662,0,0.18865394592285156,0),	Size = UDim2.new(0.974037230014801,-3,0,23),	AutoButtonColor = false,	Font = Enum.Font.SourceSans,	Text = v,	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 11,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
					})
					local UIPadding2 = CreateObject("UIPadding", {
						Parent = DropButton,	PaddingLeft = UDim.new(0,10),
					})
					local UICorner2 = CreateObject("UICorner", {
						Parent = DropButton,	CornerRadius = UDim.new(0,4),
					})
					local UIStroke2 = CreateObject("UIStroke", {
						Parent = DropButton,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
					})
					DropButton.MouseButton1Down:Connect(function()
						for i,v in pairs(ScrollingFrame:GetChildren()) do
							if v:IsA'TextButton' then
								TweenObject(v, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
									BackgroundTransparency = 0.9700000286102295
								})
							end
						end
						TweenObject(DropButton, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
							BackgroundTransparency = 0.9
						})
						TweenObject(Dropper, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
							Size = UDim2.new(1,0,0,0)
						})
						wait(0.1)
						Dropper.Visible = false
						callback(v)

					end)
				end
				local Set = {}
				function Set.Update(List)
					for i,v in pairs(ScrollingFrame:GetChildren()) do
						if v:IsA'TextButton' then
							v:Destroy()
						end
					end
					for i,v in pairs(list) do
						local DropButton = CreateObject("TextButton", {
							Name = "DropButton",	Parent = ScrollingFrame,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = (v==default and 0.9 or 0.9700000286102295),	Position = UDim2.new(0.4870184361934662,0,0.18865394592285156,0),	Size = UDim2.new(0.974037230014801,-3,0,23),	AutoButtonColor = false,	Font = Enum.Font.SourceSans,	Text = v,	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 11,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
						})
						local UIPadding2 = CreateObject("UIPadding", {
							Parent = DropButton,	PaddingLeft = UDim.new(0,10),
						})
						local UICorner2 = CreateObject("UICorner", {
							Parent = DropButton,	CornerRadius = UDim.new(0,4),
						})
						local UIStroke2 = CreateObject("UIStroke", {
							Parent = DropButton,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
						})
						DropButton.MouseButton1Down:Connect(function()
							for i,v in pairs(ScrollingFrame:GetChildren()) do
								if v:IsA'TextButton' then
									TweenObject(v, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
										BackgroundTransparency = 0.9700000286102295
									})
								end
							end
							TweenObject(DropButton, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
								BackgroundTransparency = 0.9
							})
							wait(0.3)
							Dropper.Visible = false
							callback(v)
	
						end)
					end
				end
				return Set
			end
			function AssetHandler.Textbox(name, preset, callback)
				local Textbox = CreateObject("Frame", {
					Name = name,	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0,0,0.7488034963607788,0),	Size = UDim2.new(1,0,0,50),	Transparency = 1,
				})
				local TextBox = CreateObject("TextBox", {
					Size = UDim2.new(0.95, 0,0, 23), Parent = Textbox,	AnchorPoint = Vector2.new(0.5,1),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9700000286102295,	Position = UDim2.new(0.5,0,0.8999999761581421,0),	Font = Enum.Font.SourceSans, PlaceholderText = preset,	Text = "",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 11,	TextStrokeColor3 = Color3.fromRGB(255,255,255),	TextTransparency = 0.5899999737739563,	TextWrapped = true,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding = CreateObject("UIPadding", {
					Parent = TextBox,	PaddingLeft = UDim.new(0,10),
				})
				local UIStroke = CreateObject("UIStroke", {
					Parent = TextBox,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Thickness = 1.2000000476837158,	Transparency = 0.925000011920929,
				})
				local UICorner = CreateObject("UICorner", {
					Parent = TextBox,	CornerRadius = UDim.new(0,4),
				})
				local TextButton = CreateObject("TextButton", {
					Parent = Textbox,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(1,0,0,20),	Font = Enum.Font.SourceSans,	Text = name,	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 13,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding2 = CreateObject("UIPadding", {
					Parent = TextButton,	PaddingLeft = UDim.new(0,5), PaddingBottom = UDim.new(0,10), PaddingTop = UDim.new(0,10),
				})
				TextBox.FocusLost:connect(function()
					callback(TextBox.Text)
				end)
			end
			function AssetHandler.Toggle(name, state, callback)
				local State = false
				local Toggle = CreateObject("Frame", {
					Name = name,	Parent = Section,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(1,0,0,30),	Transparency = 1,
				})
				Toggle.Name = name
				local TextButton = CreateObject("TextButton", {
					Parent = Toggle,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Size = UDim2.new(1,0,1,0),	Font = Enum.Font.SourceSans,	Text = name,	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 13,	TextTransparency = 0.5,	TextXAlignment = Enum.TextXAlignment.Left,
				})
				local UIPadding = CreateObject("UIPadding", {
					Parent = TextButton,	PaddingLeft = UDim.new(0,5),
				})
				local Splash = CreateObject("Frame", {
					Name = "Splash",	Parent = TextButton,	AnchorPoint = Vector2.new(0,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.8999999761581421,	Position = UDim2.new(0.7751553058624268,0,0.5,0),	Size = UDim2.new(0,30,0,15),	Transparency = 0.8999999761581421,
				})
				local UICorner = CreateObject("UICorner", {
					Parent = Splash,	CornerRadius = UDim.new(1,0),
				})
				local Frame = CreateObject("Frame", {
					Parent = Splash,	AnchorPoint = Vector2.new(0,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.6499999761581421,	Position = UDim2.new(0,3,0.5,0),	Size = UDim2.new(0,10,0,10),	Transparency = 0.6499999761581421,
				})
				local UICorner2 = CreateObject("UICorner", {
					Parent = Frame,	CornerRadius = UDim.new(1,0),
				})
				function Toggle()
					State = not State
					if State then
						TweenObject(Frame, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
							AnchorPoint = Vector2.new(1,0.5)
						})
						TweenObject(Frame, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
							Position = UDim2.new(1,-3, 0.5, 0)
						})
						TweenObject(Frame, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
							BackgroundTransparency = 0
						})
						TweenObject(Splash, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
							BackgroundTransparency = 0.8
						})
					else
						TweenObject(Frame, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
							AnchorPoint = Vector2.new(0,0.5)
						})
						TweenObject(Frame, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
							Position = UDim2.new(0, 3,0.5,0)
						})
						TweenObject(Frame, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
							BackgroundTransparency = 0.6499999761581421
						})
						TweenObject(Splash, Enum.EasingStyle.Linear, 0.1, Enum.EasingDirection.Out, {
							BackgroundTransparency = 0.8999999761581421
						})
					end
					task.spawn(function()
						callback(State)
					end)
				end
				if state then
					Toggle()
				end
				TextButton.MouseButton1Down:Connect(Toggle)
				local Customability = {}
				Customability.Toggle = Toggle
				Customability.StateToggle = function(state)
					if State ~= state then
						Toggle()
					end
				end
				return Customability
			end
			return AssetHandler
		end
		return SectionHandle
	end
	return WinHandle
end
local OnGoingDino = false
function Library.DinoGame(restart)
	if OnGoingDino then return end
	OnGoingDino = true
	
	local function BoundaryCheck(gui1,gui2)
		local gui1_topLeft,gui1_bottomRight = gui1.AbsolutePosition, gui1.AbsolutePosition + gui1.AbsoluteSize
		local gui2_topLeft,gui2_bottomRight = gui2.AbsolutePosition, gui2.AbsolutePosition + gui2.AbsoluteSize
		return ((gui1_topLeft.x < gui2_bottomRight.x and gui1_bottomRight.x > gui2_topLeft.x) and (gui1_topLeft.y < gui2_bottomRight.y and gui1_bottomRight.y > gui2_topLeft.y))
	end
	local DinoFrame = CreateObject("Frame", {
		Name = "DinoFrame",	Parent = Library.Core,	BackgroundColor3 = Color3.fromRGB(16,17,18),	BackgroundTransparency = 0.10000000149011612,	Position = UDim2.new(0.5,0,0.5,0),	Size = UDim2.new(0,247,0,174),	Transparency = 0.10000000149011612, AnchorPoint = Vector2.new(0.5, 0.5)
	})
	if restart then
		DinoFrame.Position = restart
	end
	local UIStroke = CreateObject("UIStroke", {
		Parent = DinoFrame,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Thickness = 3,	Transparency = 0.8999999761581421,
	})
	local UICorner = CreateObject("UICorner", {
		Parent = DinoFrame,	CornerRadius = UDim.new(0,6),
	})
	local BSeparation = CreateObject("Frame", {
		Name = "BSeparation",	Parent = DinoFrame,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9300000071525574,	BorderColor3 = Color3.fromRGB(27,42,53),	BorderSizePixel = 0,	Position = UDim2.new(0,0,0.16091954708099365,0),	Size = UDim2.new(1,0,0,1),	Transparency = 0.9300000071525574,
	})
	local Exit = CreateObject("TextButton", {
		Name = "Exit",	Parent = DinoFrame,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9990000128746033,	Position = UDim2.new(0.04048582911491394,0,0.0019938151817768812,0),	Size = UDim2.new(0,13,0,27),	Font = Enum.Font.SourceSans,	Text = "",	TextColor3 = Color3.fromRGB(0,0,0),	TextSize = 14,
	})
	local Frame = CreateObject("Frame", {
		Parent = Exit,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(215,108,96),	BorderSizePixel = 0,	Position = UDim2.new(0.5,0,0.5,0),	Size = UDim2.new(0,6,0,6),
	})
	local UICorner2 = CreateObject("UICorner", {
		Parent = Frame,	CornerRadius = UDim.new(1,0),
	})
	local UIStroke2 = CreateObject("UIStroke", {
		Parent = Frame,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(215,108,96),	Thickness = 2,	Transparency = 0.8500000238418579,
	})
	local GameView = CreateObject("Frame", {
		Name = "GameView",	Parent = DinoFrame,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	ClipsDescendants = true,	Position = UDim2.new(0.04048582911491394,0,0.21751105785369873,0),	Size = UDim2.new(0,227,0,125),	Transparency = 1,
	})
	local UIStroke3 = CreateObject("UIStroke", {
		Parent = GameView,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(255,255,255),	Transparency = 0.9300000071525574,
	})
	local Cactus = CreateObject("Frame", {
		Name = "Cactus",	Parent = GameView,	BackgroundColor3 = Color3.fromRGB(73,109,68),	BorderSizePixel = 0,	Position = UDim2.new(1.2000000476837158,0,0.75,0),	Size = UDim2.new(0,8,0,14),
	})
	local Frame2 = CreateObject("Frame", {
		Parent = Cactus,	BackgroundColor3 = Color3.fromRGB(73,109,68),	BorderSizePixel = 0,	Position = UDim2.new(1.3684501647949219,0,-0.9579315185546875,0),	Size = UDim2.new(0,6,0,10),
	})
	local UICorner3 = CreateObject("UICorner", {
		Parent = Frame2,
	})
	local Frame3 = CreateObject("Frame", {
		Parent = Cactus,	BackgroundColor3 = Color3.fromRGB(73,109,68),	BorderSizePixel = 0,	Position = UDim2.new(-1.399999976158142,0,-0.9580000042915344,0),	Size = UDim2.new(0,8,0,12),
	})
	local UICorner4 = CreateObject("UICorner", {
		Parent = Frame3,
	})
	local Frame4 = CreateObject("Frame", {
		Parent = Cactus,	BackgroundColor3 = Color3.fromRGB(73,109,68),	BorderSizePixel = 0,	Position = UDim2.new(-0.10770797729492188,0,-1.5372663736343384,0),	Size = UDim2.new(0,8,0,28),
	})
	local UICorner5 = CreateObject("UICorner", {
		Parent = Frame4,
	})
	local Frame5 = CreateObject("Frame", {
		Parent = Cactus,	BackgroundColor3 = Color3.fromRGB(73,109,68),	BorderSizePixel = 0,	Position = UDim2.new(0.9293365478515625,0,-0.6194414496421814,0),	Rotation = 40,	Size = UDim2.new(0,6,0,14),
	})
	local UICorner6 = CreateObject("UICorner", {
		Parent = Frame5,
	})
	local Frame6 = CreateObject("Frame", {
		Parent = Cactus,	BackgroundColor3 = Color3.fromRGB(73,109,68),	BorderSizePixel = 0,	Position = UDim2.new(-0.8619213104248047,0,-0.5869554877281189,0),	Rotation = -40,	Size = UDim2.new(0,6,0,14),
	})
	local UICorner7 = CreateObject("UICorner", {
		Parent = Frame6,
	})
	local Frame7 = CreateObject("Frame", {
		Parent = GameView,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.6499999761581421,	BorderSizePixel = 0,	Position = UDim2.new(-0.07723575830459595,0,0.8620688319206238,0),	Size = UDim2.new(0,290,0,21),	Transparency = 0.6499999761581421,
	})
	local CloudRoot = CreateObject("Frame", {
		Name = "CloudRoot",	Parent = GameView,	BackgroundColor3 = Color3.fromRGB(189,190,190),	BorderSizePixel = 0,	Position = UDim2.new(1.100000023841858,0,0.15199999511241913,0),	Size = UDim2.new(0,49,0,12),
	})
	local UICorner8 = CreateObject("UICorner", {
		Parent = CloudRoot,	CornerRadius = UDim.new(1,0),
	})
	local Fragment = CreateObject("Frame", {
		Name = "Fragment",	Parent = CloudRoot,	BackgroundColor3 = Color3.fromRGB(189,190,190),	BorderSizePixel = 0,	Position = UDim2.new(0.2972218990325928,0,0.02866617776453495,0),	Size = UDim2.new(0,20,0,14),
	})
	local UICorner9 = CreateObject("UICorner", {
		Parent = Fragment,	CornerRadius = UDim.new(1,0),
	})
	local Fragment2 = CreateObject("Frame", {
		Name = "Fragment",	Parent = CloudRoot,	BackgroundColor3 = Color3.fromRGB(189,190,190),	BorderSizePixel = 0,	Position = UDim2.new(0.23599748313426971,0,-0.3879999816417694,0),	Size = UDim2.new(0,25,0,12),
	})
	local UICorner10 = CreateObject("UICorner", {
		Parent = Fragment2,	CornerRadius = UDim.new(1,0),
	})
	local Dino = CreateObject("ImageLabel", {
		Name = "Dino",	Parent = GameView,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.03964754939079285,0,0.5778261423110962,0),	Size = UDim2.new(0,38,0,35),	Image = "rbxassetid://11877365144",	ImageTransparency = 0.20000000298023224,
	})
	local Exit2 = CreateObject("TextButton", {
		Name = "Exit",	Parent = DinoFrame,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 0.9990000128746033,	Position = UDim2.new(0.09300000220537186,0,0.0020000000949949026,0),	Size = UDim2.new(0,13,0,27),	Font = Enum.Font.SourceSans,	Text = "",	TextColor3 = Color3.fromRGB(0,0,0),	TextSize = 14,
	})
	local Frame8 = CreateObject("Frame", {
		Parent = Exit2,	AnchorPoint = Vector2.new(0.5,0.5),	BackgroundColor3 = Color3.fromRGB(124,156,99),	BorderSizePixel = 0,	Position = UDim2.new(0.5,0,0.5,0),	Size = UDim2.new(0,6,0,6),
	})
	local UICorner11 = CreateObject("UICorner", {
		Parent = Frame8,	CornerRadius = UDim.new(1,0),
	})
	local UIStroke4 = CreateObject("UIStroke", {
		Parent = Frame8,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Color = Color3.fromRGB(174,218,138),	Thickness = 2,	Transparency = 0.8500000238418579,
	})
	local Drag = CreateObject("ImageButton", {
		Name = "Drag",	Parent = DinoFrame,	AnchorPoint = Vector2.new(0,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0.9239028096199036,0,0.08620689064264297,0),	Size = UDim2.new(0,10,0,10),	AutoButtonColor = false,	Image = "http://www.roblox.com/asset/?id=5172066892",	ImageTransparency = 0.5,
	})
	Library.Framework.AllowDragging(Drag, DinoFrame, 0.1)
	local Begin = false
	Exit.MouseButton1Down:Connect(function()
		restart = false
		OnGoingDino = false
		DinoFrame:Destroy()
	end)
	Exit2.MouseButton1Down:Connect(function()
		Begin = true
	end)
	repeat wait() until Begin
	local LastJumped = 0
	
	local function Jump()
		if LastJumped == 0 then
			LastJumped = 1
			delay(1, function()
				LastJumped = 0
			end)
			TweenObject(Dino, Enum.EasingStyle.Linear, 0.25, Enum.EasingDirection.Out, {
				Position = UDim2.new(0.03964754939079285, 0,0.114, 0)
			})
			wait(0.45)
			TweenObject(Dino, Enum.EasingStyle.Linear, 0.25, Enum.EasingDirection.In, {
				Position = UDim2.new(0.03964754939079285, 0,0.5778261423110962, 0)
			})
			
		end
	end
	game.UserInputService.InputBegan:Connect(function(Key, gpe)
		if gpe then return end
		if Key.KeyCode == Enum.KeyCode.Space then
			Jump()
		end
	end)
	task.spawn(function()
		while task.wait() do
			Dino.Image = 'rbxassetid://11877365935'
			wait(.1)
			Dino.Image = 'rbxassetid://11877365144'
			wait(.1)
		end
	end)
	task.spawn(function()
		while task.wait() do
			for i,v in pairs(Cactus:GetChildren()) do
				if v:IsA'Frame' then
					if BoundaryCheck(Dino, v) then
						DinoFrame:Destroy()
						OnGoingDino = false
						Library.DinoGame(DinoFrame.Position)
					end
				end
			end
		end
	end)
	task.spawn(function()
		wait(3)
		while task.wait() do
			Cactus.Position = UDim2.new(1.2000000476837158,0,0.75,0)
			TweenObject(Cactus, Enum.EasingStyle.Linear, 2, Enum.EasingDirection.In, {
				Position = UDim2.new(-1.2000000476837158,0,0.75,0)
			})
			wait(1 + math.random(1, 2))
		end
	end)
	task.spawn(function()
		while task.wait() do
			local RandomY = (math.random(100, 300)*0.001)
			CloudRoot.Position = UDim2.new(1.1, 0,RandomY, 0)
			TweenObject(CloudRoot, Enum.EasingStyle.Linear, 4, Enum.EasingDirection.In, {
				Position = UDim2.new(-1.1, 0,RandomY, 0)
			})
			wait(4)
		end
	end)
end
function Library.Watermark()

	local WM = CreateObject("ScreenGui", {
		Name = "WM",	Parent = game.CoreGui,	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,	IgnoreGuiInset = true,	ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
	})
	local Frame = CreateObject("Frame", {
		Parent = WM,	AnchorPoint = Vector2.new(0.5,0),	BackgroundColor3 = Color3.fromRGB(16,17,18),	BackgroundTransparency = 0.10000000149011612,	BorderSizePixel = 0,	ClipsDescendants = true,	Position = UDim2.new(0.5,0,0.009999999776482582,0),	Size = UDim2.new(0,64,0,29),	Transparency = 0.10000000149011612,
	})
	local TextLabel = CreateObject("TextLabel", {
		Parent = Frame,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0,25,0,0),	Size = UDim2.new(-2.78125,200,1,0),	Font = Enum.Font.JosefinSans,	Text = "Mono",	TextColor3 = Color3.fromRGB(255,255,255),	TextSize = 11,	TextTransparency = 0.4399999976158142,	TextXAlignment = Enum.TextXAlignment.Left,
	})
	local UIPadding = CreateObject("UIPadding", {
		Parent = TextLabel,	PaddingBottom = UDim.new(0,-1),	PaddingRight = UDim.new(0,6),
	})
	local Frame2 = CreateObject("Frame", {
		Parent = Frame,	BackgroundColor3 = Color3.fromRGB(255,255,255),	BorderSizePixel = 0,	Size = UDim2.new(1,0,0,1),
	})
	local UIGradient = CreateObject("UIGradient", {
		Parent = Frame2,	Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(37, 182, 237)), ColorSequenceKeypoint.new(1, Color3.fromRGB(173, 62, 252))} ,	Offset = Vector2.new(1,0),
	})
	local ImageLabel = CreateObject("ImageLabel", {
		Parent = Frame,	AnchorPoint = Vector2.new(0,0.5),	BackgroundColor3 = Color3.fromRGB(255,255,255),	BackgroundTransparency = 1,	Position = UDim2.new(0,2,0.5,0),	Size = UDim2.new(0,25,0,25),	Image = "rbxassetid://11773614430",	ImageTransparency = 0.4000000059604645,
	})
	local UIGradient2 = CreateObject("UIGradient", {
		Parent = ImageLabel,	Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(37, 182, 237)), ColorSequenceKeypoint.new(1, Color3.fromRGB(173, 62, 252))},	Offset = Vector2.new(0,0),
	})
	local UIStroke = CreateObject("UIStroke", {
		Parent = Frame,	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,	Thickness = 2.299999952316284,	Transparency = 0.8500000238418579,
	})
	
	task.spawn(function()
		while task.wait() do
			UIGradient.Rotation = 180

			TweenObject(UIGradient, Enum.EasingStyle.Circular, 2.5, Enum.EasingDirection.Out, {
				Offset = Vector2.new(-1,0)
			})

			wait(2.5)
			UIGradient.Rotation = 0
			UIGradient.Offset = Vector2.new(1,0)
			TweenObject(UIGradient, Enum.EasingStyle.Circular, 2.5, Enum.EasingDirection.Out, {
				Offset = Vector2.new(-1,0)
			})
			wait(2.5)
			UIGradient.Offset = Vector2.new(1,0)
		end
	end)
	return WM
end


return Library
