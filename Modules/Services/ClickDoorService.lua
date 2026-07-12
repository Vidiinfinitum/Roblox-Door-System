-- Services --
local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")

-- Modules --
local Storage = ServerStorage.Modules.Storage

-- Door Storage --
local DoorStorage = require(Storage.DoorStorage)

local ClickDoorService = {}
-- Table to store the ClickDoor connections
local connections = {}

-- Start function
function ClickDoorService.Start()
	-- Get the door object in DoorStorage
	for model, doorObject in pairs(DoorStorage.Doors) do
		-- Filter for only click doors
		if not CollectionService:HasTag(model, "ClickDoor") then continue end
	
		local clickDetector = model:FindFirstChildWhichIsA("ClickDetector", true) :: ClickDetector?
		if not clickDetector then 
			warn(("ClickDetector not found for '%s' model"):format(model.Name))
			continue
		end
		
		local doorConnection = clickDetector.MouseClick:Connect(function(player: Player)
			doorObject:Interact(player)
		end)
		
		-- Stores the door connection
		connections[model] = doorConnection
	end
end

return ClickDoorService 
