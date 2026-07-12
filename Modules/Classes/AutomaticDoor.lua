-- Get Door class
local Door = require(game:GetService("ServerStorage").Modules.Classes.Door.Door)

local AutomaticDoor = {}
AutomaticDoor.__index = AutomaticDoor

-- Sets the AutomaticDoor class as an "object" of the Door class
setmetatable(AutomaticDoor, {__index = Door}) 

-- Creates the AutomaticDoor type
export type AutomaticDoor = Door.Door

-- Constructor method for AutomaticDoor class
function AutomaticDoor.new(model: Model): AutomaticDoor
	local self = setmetatable(Door.new(model) :: AutomaticDoor, AutomaticDoor)

	return self
end

return AutomaticDoor
