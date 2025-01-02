local BlockSize = 2

local Anchor = true

local ChairsInvisible = true

local BuildDelay = 0.1 -- in seconds delay on block thingy (no lower than 0.05, safest 0.3)

-- JSON DATA OF BUILD USING ENCODER, PLACE WHAT YOU GET FROM THE CREATOR IN HERE -->
local BlockData = game:GetService("HttpService"):JSONDecode([[

]])



-- DO NOT EDIT UNLESS YOU KNOW WHAT YOU ARE DOING
_G.Event1 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("BuildingTool") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("BuildingTool")
_G.Event2 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("PaintingTool") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PaintingTool")
_G.Event3 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("ScalingTool") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("ScalingTool")
_G.Event4 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("PropertiesTool") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PropertiesTool")
local BuildEvent = _G.Event1:WaitForChild("RF")
local PaintingEvent = _G.Event2:WaitForChild("RF")
local ScalingTool = _G.Event3:WaitForChild("RF")
local PropertiesTool = _G.Event4:WaitForChild("SetPropertieRF")

local l__Positions__l = {
	X1 = -75, X2 = 75,
	Y1 = 5.60000038, Y2 = 2048,
	Z1 = -149, Z2 = 149,
}
local Teams = {
	blue = game:GetService("Workspace")["Really blueZone"],
	red = game:GetService("Workspace")["Really redZone"],
	black = game:GetService("Workspace").BlackZone,
	yellow = game:GetService("Workspace")["New YellerZone"],
	white = game:GetService("Workspace").WhiteZone,
	magenta = game:GetService("Workspace").MagentaZone,
	green = game:GetService("Workspace").CamoZone,
}
function Coloring(p1,p2) 
	return {
		{
			p2,
			Color3.new(unpack(p1)),
		}
	}
end
function Vecxtorer(p1)
	return Vector3.new(unpack(p1))
end
function CFramer(p1)
	return CFrame.new(unpack(p1))
end
function GetLimitPos(p1,p2)
	local u1 = l__Positions__l[p1 .. "1"]
	local u2 = l__Positions__l[p1 .. "2"]
	return math.clamp(p1,u1,u2)
end
function Event() 
	_G.Event1 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("BuildingTool") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("BuildingTool")
	_G.Event2 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("PaintingTool") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PaintingTool")
	_G.Event3 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("ScalingTool") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("ScalingTool")
	_G.Event4 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("PropertiesTool") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PropertiesTool")
	BuildEvent = _G.Event1:WaitForChild("RF")
	PaintingEvent = _G.Event2:WaitForChild("RF")
	ScalingTool = _G.Event3:WaitForChild("RF")
	PropertiesTool = _G.Event4:WaitForChild("SetPropertieRF")
end
function Team()
	return Teams[game.Players.LocalPlayer.Team.Name]
end
function BlockDat(p1)
	return game.Players.LocalPlayer:WaitForChild("Data"):WaitForChild(p1).Value
end
function CreateBlock()
	Event()
	local l_Team_l = Team()
	local l_InvisParts_l = {}
	for u1 = 1, #BlockData do
		local u2 = BlockData[u1]
		local u3,u4,u5,u6 = u2["Position"],u2["Material"],u2["Size"],u2["Color"]
		local u7 = nil;
		local u9 = game.Workspace.ChildAdded:Connect(function(u8)
			if u8.Name == u4 and u8:WaitForChild("Tag").Value == game.Players.LocalPlayer.Name then
				u7 = u8
			end
		end)
		local u10 = u2["Anchor"]
		if u10 == nil then
			u10 = true
		end
		BuildEvent:InvokeServer(
			u4,
			BlockDat(u4),
			l_Team_l,
			CFramer(u3),
			u10,
			BlockSize
		)
		repeat wait() until u7
		wait(BuildDelay)
		ScalingTool:InvokeServer(
			u7,
			Vecxtorer(u5),
			u7.PPart.CFrame
		)
		wait(BuildDelay)
		local u9 = Coloring(u6,u7)
		PaintingEvent:InvokeServer(u9)
		if not u2["Collision"] then
			wait(BuildDelay)
			PropertiesTool:InvokeServer(
				"Collision",
				{u7}
			)
		end
		if ChairsInvisible and (u4 == "Seat" or u2["Invisible"]) then
			l_InvisParts_l[#l_InvisParts_l + 1] = {u7,u2["Invisible"] or 4}
		end
	end
	if #l_InvisParts_l > 0 then
		for i1=1,4 do
			local l_ListTo_l = {}
			for i2 = 1,#l_InvisParts_l do
				if i1+1 > l_InvisParts_l[i2][2] then
					l_ListTo_l[#l_ListTo_l + 1] = l_InvisParts_l[i2][1]
				end
			end
			PropertiesTool:InvokeServer(
				"Transparency",
				l_ListTo_l
			)
			wait(BuildDelay)
		end
	end
	print("Finished!!!")
end
CreateBlock()
