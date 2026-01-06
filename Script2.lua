-- RAYFIELD UI
-- Para pruebas locales. Si usas Studio sin loadstring, tendrás que meter Rayfield como ModuleScript.

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- ===== CONFIG INICIAL =====
local JumpValue = 80
local SpeedValue = 24

local function getHumanoid()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("Humanoid")
end

-- ===== WINDOW =====
local Window = Rayfield:CreateWindow({
	Name = "Test Controls",
	LoadingTitle = "Rayfield UI",
	LoadingSubtitle = "No es magia, es optimización",
	ConfigurationSaving = {
		Enabled = false
	}
})

-- ===== TAB MOVIMIENTO =====
local MovementTab = Window:CreateTab("Movimiento", 4483362458)

MovementTab:CreateSlider({
	Name = "Fuerza de Salto",
	Range = {50, 150},
	Increment = 1,
	Suffix = "JumpPower",
	CurrentValue = JumpValue,
	Callback = function(Value)
		JumpValue = Value
		getHumanoid().JumpPower = JumpValue
	end,
})

MovementTab:CreateButton({
	Name = "Saltar",
	Callback = function()
		local hum = getHumanoid()
		hum.JumpPower = JumpValue
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end,
})

MovementTab:CreateSlider({
	Name = "Velocidad",
	Range = {8, 50},
	Increment = 1,
	Suffix = "WalkSpeed",
	CurrentValue = SpeedValue,
	Callback = function(Value)
		SpeedValue = Value
		getHumanoid().WalkSpeed = SpeedValue
	end,
})

-- ===== TAB FPS =====
local FPSTab = Window:CreateTab("FPS", 4483362458)

FPSTab:CreateButton({
	Name = "FPS BOOST",
	Callback = function()
		-- Lighting barato
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 1e6
		Lighting.EnvironmentDiffuseScale = 0
		Lighting.EnvironmentSpecularScale = 0

		-- Apaga efectos caros
		for _, v in ipairs(Lighting:GetChildren()) do
			if v:IsA("PostEffect") then
				v.Enabled = false
			end
		end

		-- Optimiza partes
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				obj.Material = Enum.Material.Plastic
				obj.Reflectance = 0
			end
		end
	end,
})
