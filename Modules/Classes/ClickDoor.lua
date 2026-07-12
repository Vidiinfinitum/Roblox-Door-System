-- Get Door class
local Door = require(game:GetService("ServerStorage").Modules.Classes.Door.Door)

local ClickDoor = {}
ClickDoor.__index = ClickDoor

-- Sets the ClickDoor class as an "object" of the Door class
setmetatable(ClickDoor, {__index = Door})

-- Creates the ClickDoor type
export type ClickDoor = Door.Door & {
	Interact: (self: ClickDoor, player: Player) -> ()
}

-- Constructor method for the ClickDoor class
function ClickDoor.new(model: Model): ClickDoor
	local self = setmetatable(Door.new(model) :: ClickDoor, ClickDoor)
  
	return self
end

-- Method to handle the ClickDoor object interaction by the player
function ClickDoor:Interact(player: Player)
	if self:CanInteract(player) then
		self:Toggle()
	end
end

return ClickDoor
