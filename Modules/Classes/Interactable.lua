local Interactable = {}
Interactable.__index = Interactable

-- Creates the Interactable type
export type Interactable = {
	Model: Model,
	Enabled: boolean,
	MaxDistance: number,
	
	Enable: (self: Interactable) -> (),
	Disable: (self: Interactable) -> (),
	CanInteract: (self: Interactable, player: Player) -> boolean,
}

-- Constructor method for the Interactable class
function Interactable.new(model: Model): Interactable
	local self = setmetatable({} :: Interactable, Interactable)
	
	self.Model = model
	self.Enabled = true
	self.MaxDistance = (model:GetAttribute("MaxDistance") :: number?) or 10
	
	return self
end

-- Method to enable the Interactable object
function Interactable:Enable()
	self.Enable = true
end

-- Method to disable the Interactable object
function Interactable:Disable()
	self.Enable = false
end

-- Method to get if the Interactable object can be interacted
function Interactable:CanInteract(player: Player)
	
	if not self.Enabled then
		return false
	end
	
	local character = player.Character
	if not character then
		return false
	end
	
	local root = character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not root then
		return false
	end
	
	local distance = (root.Position - self.Model:GetPivot().Position).Magnitude
	
	return distance <= self.MaxDistance
end

return Interactable
