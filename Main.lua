-- Game Services --
local ServerStorage = game:GetService("ServerStorage")

-- Modules --
local Services = ServerStorage.Modules.Services

-- Services --
local DoorsInitializationService = require(Services.DoorsInitializationService)
local ClickDoorService = require(Services.ClickDoorService)
local AutomaticDoorService = require(Services.AutomaticDoorService)

-- Main Script--

-- Initialize all Doors
DoorsInitializationService.Init()

-- Start the ClickDoorService
ClickDoorService.Start()

-- Start the AutomaticDoorService
AutomaticDoorService.Start()
