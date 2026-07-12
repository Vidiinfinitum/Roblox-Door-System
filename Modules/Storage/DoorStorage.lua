-- This module exists to stores the Door objects. It can register new doors and get them as well.
local DoorStorage = {}

DoorStorage.Doors = {}

-- Function to register a Door object
function DoorStorage.RegisterDoor(doorObject)
	DoorStorage.Doors[doorObject.Model] = doorObject
end

-- Function to get a Door object
function DoorStorage.GetDoor(model: Model)
	return DoorStorage.Doors[model]
end

return DoorStorage
