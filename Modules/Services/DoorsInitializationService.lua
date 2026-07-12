-- Services --
local CollectionService = game:GetService("CollectionService")
local ServerStorage = game:GetService("ServerStorage")

-- Modules --
local Classes = ServerStorage.Modules.Classes
local Storage = ServerStorage.Modules.Storage

-- Door classes --
local ClickDoor = require(Classes.Door.ClickDoor)
local AutomaticDoor = require(Classes.Door.AutomaticDoor)

-- Storage Modules --
local DoorStorage = require(Storage.DoorStorage)

local DoorsInitializationService = {}

-- Aux function to register doors
function RegisterDoors(tag: string, class)
	for _, model in ipairs(CollectionService:GetTagged(tag)) do
		-- Creates the respective doors objects
		local doorObject = class.new(model)
		-- Stores the new object in DoorStorage
		DoorStorage.RegisterDoor(doorObject)
	end
end

function DoorsInitializationService.Init()
	-- Init the ClickDoors
	RegisterDoors("ClickDoor", ClickDoor)
	
	-- Init the AutomaticDoors
	RegisterDoors("AutomaticDoor", AutomaticDoor)
end

return DoorsInitializationService
