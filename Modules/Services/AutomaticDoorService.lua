-- Services --
local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

-- Modules --
local Storage = ServerStorage.Modules.Storage

-- Door Storage --
local DoorStorage = require(Storage.DoorStorage)

local AutomaticDoorService = {}
-- Table to store the AutomaticDoor connections
local connections = {}

-- Aux function to get player
function GetPlayerFromHit(hit: BasePart)
	-- To filter
	if hit.Name ~= "HumanoidRootPart" then return nil end

	-- Get the character
	local character = hit.Parent
	if not character then return nil end
	
	return Players:GetPlayerFromCharacter(character)
end

-- Start function
function AutomaticDoorService.Start()
	-- Get the door object in DoorStorage
	for model, doorObject in pairs(DoorStorage.Doors) do
		-- Filter for only automatic doors
		if not CollectionService:HasTag(model, "AutomaticDoor") then continue end
		
		local trigger = model.Parent:FindFirstChild("Trigger") :: BasePart?
		if not trigger then
			warn(("Trigger not found for '%s' model"):format(model.Name))
			continue
		end
		
		local playersInside = {}
		
		local triggerTouchedConnection = trigger.Touched:Connect(function(hit: BasePart)	
			
			local player = GetPlayerFromHit(hit)
			if not player then return end
			
			-- If is the same player, it will return
			if playersInside[player] then return end
			
			-- Put the player in the playersInside table
			playersInside[player] = true
			
			doorObject:Open()
		end)

		local triggerTouchedEndedConnection = trigger.TouchEnded:Connect(function(hit: BasePart)
			
      local player = GetPlayerFromHit(hit)
			if not player then return end
			
			-- Removes the player from playersInside table
			playersInside[player] = nil
			
			-- If there is not any player, close the door
			if next(playersInside) == nil then
				doorObject:Close()
			end
		end)
		
		connections[model] = {
			Touched = triggerTouchedConnection,
			TouchEnded = triggerTouchedEndedConnection,
		}
	end
end

return AutomaticDoorService
