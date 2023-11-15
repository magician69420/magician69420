local NEVERLOSE = loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/NEVERLOSE-UI-Nightly/main/source.lua"))()

-- Change Theme --
NEVERLOSE:Theme("original") -- [ dark , nightly , original ]
------------------

local players = game:GetService('Players')
local lplr = players.LocalPlayer
local lastCF, stop, heartbeatConnection
local Window = NEVERLOSE:AddWindow("Rise","VERSION PRIVATE")
local Notification = NEVERLOSE:Notification()

Notification.MaxNotifications = 6
local createnotification = function(title, text, delay)
	--icon = icon or "info"
	title = title or "Notification"
	text = text or "Test Notification"
	delay = delay
	Notification:Notify("info", title, text, delay)
end
local createwarning = function(title, text, delay)
	title = title or "Notification"
	text = text or "Test Notification"
	delay = delay
	Notification:Notify("warning", title, text, delay)
end

Window:AddTabLabel('Main')
local createTab = function(name,icon)
	return Window:AddTab(name,icon)
end
local ExampleTab = Window:AddTab('Main','home') -- [ads , list , folder , earth , locked , home , mouse , user]
local Misc = createTab("Misc","locked")
local Example = ExampleTab:AddSection('AnticheatBypass',"left")
local SpeedBoater = Misc:AddSection("SpeedBoats", "right")
local FastAttacker = ExampleTab:AddSection("FastAttack", "right")
local WaterWalker = Misc:AddSection("Walk on Water","left")
local Settings = {
	['FastAttack'] = ExampleTab:AddSection('FastAttack Settings', 'left')
}
coderunning = {}
local run = function(code, name)
	code()
	table.insert(coderunning, name)
end
run(function()
	local function start()
		heartbeatConnection = game:GetService('RunService').Heartbeat:Connect(function()
			if stop then
				return 
			end 
			lastCF = lplr.Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame
		end)
		lplr.Character:FindFirstChildOfClass('Humanoid').RootPart:GetPropertyChangedSignal('CFrame'):Connect(function()
			stop = true
			lplr.Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame = lastCF
			game:GetService('RunService').Heartbeat:Wait()
			stop = false
		end)		
		lplr.Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
				heartbeatConnection:Disconnect()
		end)
	end
	Example:AddToggle("AnticheatBypass",false,function(val)
		if val then
			lplr.CharacterAdded:Connect(function(character)
				repeat 
					game:GetService('RunService').Heartbeat:Wait() 
				until character:FindFirstChildOfClass('Humanoid')
				repeat 
					game:GetService('RunService').Heartbeat:Wait() 
				until character:FindFirstChildOfClass('Humanoid').RootPart
				start()
			end)
			start()
		else
			heartbeatConnection:Disconnect()
		end
	end)
end, "AnticheatBypass")
run(function() 
	local speedValue = 375
	--SpeedBoater:AddLabel("Speed Boats")
	SpeedBoater:AddButton('Set Boats Speed',function()
		for i,v in pairs(game.Workspace.Boats:GetChildren()) do
			v.VehicleSeat.MaxSpeed = speedValue
		end
	end)
	SpeedBoater:AddSlider('Speed',1,500,375,function(val)
		speedValue = val
	end)
end, "SpeedBoats")
run(function() 
	local FastAttackEnabled = false
	local SuperFastMode = false -- Change to true if you want Super Super Super Fast attack (Like instant kill) but it will make the game kick you more than normal mode
	local cdDelay = 0.175
	local CbFw = debug.getupvalues(require(lplr.PlayerScripts.CombatFramework))
	local CbFw2 = CbFw[2]
	function GetCurrentBlade() 
		local p13 = CbFw2.activeController
		local ret = p13.blades[1]
		if not ret then return end
		while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
		return ret
	end
	function AttackNoCD() 
		local AC = CbFw2.activeController
		for i = 1, 1 do 
			local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(lplr.Character,{lplr.Character.HumanoidRootPart},60)
			local cac = {}
			local hash = {}
			for k, v in pairs(bladehit) do
				if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
					table.insert(cac, v.Parent.HumanoidRootPart)
					hash[v.Parent] = true
				end
			end
			bladehit = cac
			if #bladehit > 0 then
				local u8 = debug.getupvalue(AC.attack, 5)
				local u9 = debug.getupvalue(AC.attack, 6)
				local u7 = debug.getupvalue(AC.attack, 4)
				local u10 = debug.getupvalue(AC.attack, 7)
				local u12 = (u8 * 798405 + u7 * 727595) % u9
				local u13 = u7 * 798405
				(function()
					u12 = (u12 * u9 + u13) % 1099511627776
					u8 = math.floor(u12 / u9)
					u7 = u12 - u8 * u9
				end)()
				u10 = u10 + 1
				debug.setupvalue(AC.attack, 5, u8)
				debug.setupvalue(AC.attack, 6, u9)
				debug.setupvalue(AC.attack, 4, u7)
				debug.setupvalue(AC.attack, 7, u10)
				pcall(function()
					for k, v in pairs(AC.animator.anims.basic) do
						v:Play()
					end
				end)
				if lplr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then 
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
					game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "") 
				end
			end
		end
	end
	local cac
	FastAttacker:AddToggle('FastAttack',false,function(val)
		FastAttackEnabled = val
		if FastAttackEnabled then
			Settings['FastAttack']:Show()
			if SuperFastMode then 
				cac=task.wait
			else
				cac=wait
			end
			while FastAttackEnabled do
				cac(cdDelay)
				AttackNoCD()
			end
		else
			Settings['FastAttack']:Hide()
		end
	end)
	Settings['FastAttack']:Hide()
	FastAttacker:AddToggle('Super Fast Mode',false,function(val)
		SuperFastMode = val
		if SuperFastMode then
			createwarning("WARNING", "Super Fast Mode Sometime Can Kick you please trying to use it without getting kick",10)
		else
			return
		end
	end)
	local DelayValue = {0, 0.05, 0.08, 0.10, 0.15, 0.175}
	function cdCheck()
		return cdDelay == 0 or cdDelay == 0.05 or cdDelay == 0.08 or cdDelay == 0.10
	end
	Settings['FastAttack']:AddDropdown('Cooldown',DelayValue,0.175,function(val)
		cdDelay = val
		if cdCheck() then
			createwarning("WARNING", "YOU CAN GET KICK AFTER STARTED FROM 0.08 - 0 PLEASE USE IT WITHOUT GETTING KICK",7)
		end
	end)
end,"FastAttack")

run(function()
	local old_size_of_water = {}
	table.insert(old_size_of_water, game.Workspace.Map["WaterBase-Plane"].Size)
	WaterWalker:AddToggle("Walk on water",true,function(val)
		if val then
			while val do
				wait()
				game.Workspace.Map["WaterBase-Plane"].Size = Vector3.new(2048, 114, 2048)
			end
		else
			game.Workspace.Map["WaterBase-Plane"].Size = Vector3.new(old_size_of_water)
		end
	end)
end,"Water_Walker.real")
