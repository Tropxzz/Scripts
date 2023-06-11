print(game:GetService("RbxAnalyticsService"):GetClientId().." Is ur clientId dont be worried")
print("This might have not worked because of the new shitty chat.")
local plr = game.Players.LocalPlayer
local char = plr.Character
local hum = char:WaitForChild("Humanoid")
local health = hum.Health
local Walkspeed = hum.WalkSpeed
local jumppower = hum.JumpPower
local chatEvents = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
local messageDoneFiltering = chatEvents:WaitForChild("OnMessageDoneFiltering")
local TeleportService = game:GetService("TeleportService")
local _L = {}
local Players = game:GetService("Players")
local IYMouse = plr:GetMouse()
_L.timestamp = tick()
local FLYING = false
local QEfly = true
local flyspeed = 1
local vehicleflyspeed = 1
local cooldown = 1 -- in seconds
local spamming = false
local speaker = game.Players.LocalPlayer -- define the speaker variable here

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Change the Y component to adjust the spinning speed

local spinningEnabled = false

local function enableSpinning()
    spinningEnabled = true
    bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Change the Y component to adjust the spinning speed
end

local function disableSpinning()
    spinningEnabled = false
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
end

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    bodyVelocity.Parent = humanoid.RootPart
end

local function onCharacterRemoving(character)
    bodyVelocity.Parent = nil
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(onCharacterAdded)
    player.CharacterRemoving:Connect(onCharacterRemoving)
end)

game.Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        onCharacterRemoving(player.Character)
    end
end)

function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

function getstring(begin)
	local start = begin-1
	local AA = '' for i,v in pairs(cargs) do
		if i > start then
			if AA ~= '' then
				AA = AA .. ' ' .. v
			else
				AA = AA .. v
			end
		end
	end
	return AA
end


local function chat2(message)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, 'All'); -- FireServer (<string> Message, <string> Channel) 
    end

local floatName = randomString()

function isNumber(str)
	if tonumber(str) ~= nil or str == 'inf' then
		return true
	end
end


function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end


function sFLY(vfly)
	repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until IYMouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = getRoot(Players.LocalPlayer.Character)
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end


local function chat(send, message)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, send)

end


messageDoneFiltering.OnClientEvent:Connect(function(message, plr)
    local player = game.Players:FindFirstChild(message.FromSpeaker)
    local message = message.Message or ""
    if string.sub(string.lower(message), 1, #("!goto")) == "!goto" then
        local Split = string.split(message, " ")
        local player = nil
        for i, v in next, game:GetService("Players"):GetPlayers() do
            if v.Name:lower():sub(1,#Split[2]) == Split[2]:lower() then
                game:GetService("Players").LocalPlayer.Character:MoveTo(v.Character.PrimaryPart.Position)
                return
            end
        end
        elseif message == "!Crash" then
    while true do

        end
          elseif message == "!Fly" then
	NOFLY()
	wait()
	sFLY()
	if args[1] and isNumber(args[1]) then
		flyspeed = args[1]
	end
    elseif message == "!Unfly" then
        	NOFLY()
     end
     if message == "!Reset" then
     char.Humanoid.Health = 0
     elseif message == "!Freeze" then
      char.HumanoidRootPart.Anchored = true
      elseif message == "!Thaw" or "!Unfreeze" then
          char.HumanoidRootPart.Anchored = false
          end
 if message:sub(1, 6) == "!Spam " then
            if not spamming then
                spamming = true
                local spamMessage = message:sub(7)
                while spamming == true do
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(spamMessage, "All")
                    wait(cooldown)
                end
            else
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("You are already spamming!", "All")
            end
             elseif message == "!Unspam" then
            spamming = false
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Spamming stopped.", "All")
elseif message:sub(1, #("!Walkspeed")) == "!Walkspeed" then
    local walkSpeed = tonumber(message:sub(#("!walkspeed") + 1):match("%d+"))
    if walkSpeed then
        player.Character.Humanoid.WalkSpeed = walkSpeed
        chat2("Walk speed set to " .. walkSpeed .. " for " .. player.Name)
    else
        chat2("Invalid walk speed.")
    end
    elseif message:sub(1, #("!Jumppower")) == "!Jumppower" then
    local Jumppower = tonumber(message:sub(#("!Jumppower") + 1):match("%d+"))
    if Jumppower then
        player.Character.Humanoid.JumpPower = Jumppower
        chat2("Jumppower set to " .. Jumppower .. " for " .. player.Name)
    else
        chat2("Invalid Jumppower.")
    end
elseif message == "!Spin" then
	local spinSpeed = 20
	local Spin = Instance.new("BodyAngularVelocity")
	Spin.Name = "Spinning"
	Spin.Parent = getRoot(speaker.Character)
	Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	Spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
    elseif message == "!Unspin" then
        	for i,v in pairs(getRoot(speaker.Character):GetChildren()) do
		if v.Name == "Spinning" then
			v:Destroy()
		end
    end
elseif message:sub(1, 10) == "!Spectate " then
    local playerName = message:sub(11)
    local player = game.Players:FindFirstChild(playerName)
    
    if not player then
        -- Player not found, attempt to find partial matches in names and display names
        for _, p in ipairs(game.Players:GetPlayers()) do
            if string.find(p.Name:lower(), playerName:lower()) or string.find(p.DisplayName:lower(), playerName:lower()) then
                player = p
                break
            end
        end
    end
    
    if player then
        -- Spectate the player
        -- Replace the following code with your spectate implementation
        local camera = game.Workspace.CurrentCamera
        camera.CameraSubject = player.Character.Humanoid
    else
        -- Player not found
        -- Handle the case where the specified player does not exist
        print("Player not found: " .. playerName)
    end
    elseif string.sub(message, 1, 12) == "!Timechange " then
            local time = string.sub(message, 13)
            game.Lighting.TimeOfDay = time
            chat2("If this didnt work. Please enter in this format H or H:MM, M = minutes. H = hours")
         elseif message == "!Night" then
             game.Lighting.TimeOfDay = "0:00"
             elseif message == "!Day" then
                 game.Lighting.TimeOfDay = "15:00"
                 elseif message == "!Credits" then
                     chat("All", "Made by Tropxz.")
                     chat("All", "This script is called OmniAdmin you should use it.")
                     chat("All", ""..game.Players.LocalPlayer.Name.."'s Client Id is "..game:GetService("RbxAnalyticsService"):GetClientId())
end           
end)

    chat("All", "Loaded in " .. string.format("%.5f", tick() - _L.timestamp) .. " seconds. See more projects on GitHub from Tropxzz")

print("Client is online.")
