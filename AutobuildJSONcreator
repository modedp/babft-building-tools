local v = {} 
local v1 = game.Workspace:FindFirstChild("build") -- YOUR BUILD HERE!!! 
local getsize = false
local meshpartreplaceauto=true
local v2 = {
	[Enum.Material.Fabric] = "FabricBlock",
	[Enum.Material.Brick] = "BrickBlock",
	[Enum.Material.Granite] = "ObsidianBlock",
	[Enum.Material.DiamondPlate] = "TitaniumBlock",
	[Enum.Material.Marble] = "MarbleBlock",
	[Enum.Material.Concrete] = "ConcreteBlock",
	[Enum.Material.Metal] = "MetalBlock",
	[Enum.Material.CorrodedMetal] = "RustedBlock",
	[Enum.Material.Cobblestone] = "StoneBlock",
	[Enum.Material.Glass] = "GlassBlock",
	[Enum.Material.Wood] = "WoodBlock",
	[Enum.Material.WoodPlanks] = "WoodBlock",
	[Enum.Material.SmoothPlastic] = "PlasticBlock",
	[Enum.Material.Ice] = "IceBlock",
	[Enum.Material.Neon] = "NeonBlock",
	[Enum.Material.Slate] = "CoalBlock",
	[Enum.Material.Foil] = "BouncyBlock",
	[Enum.Material.Grass] = "GrassBlock",
	[Enum.Material.Sand] = "SandBlock",
	[Enum.Material.Plastic] = "PlasticBlock",
}
local v3 = Vector3.new(-75,5.6,-149)
local v4 = game:GetService("HttpService")
local v5 = {}
local Debris = game:GetService("Debris")
function RemoveItem(I)
	Debris:AddItem(I,0)
end
function MeshPartReplace(MP)
	local MDRDat = {
		P = MP.Parent,
		O = MP.Offset,
		S = MP.Scale,
		T = Enum.PartType["Block"]
	}
	if MDRDat.S == Vector3.new(1,1,1) then
		MP:Destroy()
		return
	end
	game:GetService("RunService").Heartbeat:Wait()
	local NewMesh = Instance.new("Part")
	NewMesh.Reflectance = MDRDat.P.Reflectance
	NewMesh.Transparency = MDRDat.P.Transparency
	NewMesh.Name = MDRDat.P.Name
	NewMesh.CanCollide = MDRDat.P.CanCollide
	NewMesh.Color = MDRDat.P.Color
	NewMesh.Anchored = MDRDat.P.Anchored
	NewMesh.Size = MDRDat.S * MDRDat.P.Size
	NewMesh.CFrame = MDRDat.P.CFrame
	NewMesh.Position = NewMesh.Position + MDRDat.O
	NewMesh.Parent = MDRDat.P.Parent
	NewMesh.Shape = MDRDat.T
	if NewMesh.BottomSurface == Enum.SurfaceType.Inlet then
		NewMesh.BottomSurface = Enum.SurfaceType.Smooth
	end
	if NewMesh.TopSurface == Enum.SurfaceType.Studs then
		NewMesh.TopSurface = Enum.SurfaceType.Smooth
	end
	RemoveItem(MP.Parent)
	return 
end
for _,u1 in pairs(v1:GetDescendants()) do 
	if u1:IsA("Part") then
		local u2 = v2[u1.Material]
		if u2 == nil then 
			print(u1, u1.Material, "No block for that! Change material!")
			return
		end
		if v5[u2] == nil then
			v5[u2] = 0
		end
		if u1:IsA("Seat") then
			u2 = "Seat"
		elseif u1:IsA("WedgePart") then
			u2 = "Wedge"
		elseif u1:IsA("TrussPart") then
			u2 = "Truss"
		elseif u1:IsA("CornerWedgePart") then
			u2 = "CornerWedge"
		end
		local u3 = u1.Position
		local u4 = (u1.CFrame - u1.Position) + u3
		local u5 = {u1.Size.X,u1.Size.Y,u1.Size.Z}
		local u6 = nil
		if u1.Transparency ~= 0 then
			u6 = math.ceil(math.floor((u1.Transparency * 100) / 12.5)/2)
		end
		if getsize then
			v5[u2] = v5[u2] + (u5[1]/2)*(u5[3]/2)*(u5[2]/2)
		end
		local u7 = {
			Size = u5,
			Color = {u1.Color.R,u1.Color.G,u1.Color.B},
			Position = {u1.CFrame:GetComponents()},
			Material = u2,
			Invisible = u6
		}
		if not u1.CanCollide then
			u7["Collision"] = false
		end
		if not u1.Anchored then
			u7["Anchor"] = false
		end	
		v[#v + 1] = u7
	elseif u1:IsA("SpecialMesh") and meshpartreplaceauto then
		MeshPartReplace(u1)
	end
end
if getsize then
	print(v5)
	return
end
print(v4:JSONEncode(v)) -- Copy this from studio output.
