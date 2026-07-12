-- Services --
local TweenService = game:GetService("TweenService")

local Interactable = require(game:GetService("ServerStorage").Modules.Classes.Interactable)

local Door = {}
Door.__index = Door

-- Sets the Door class as an "object" of the Interactable class
setmetatable(Door, {__index = Interactable})

-- Creates the Door type
export type Door = Interactable.Interactable & {
	Opened: boolean,
	OpenAngle: number,
	CloseCFrame: CFrame,
	OpenCFrame: CFrame,
	Tween: Tween?,
	OpenDuration: number,
	
	_TweenTo: (self: Door, goal: CFrame) -> (),
	Open: (self: Door) -> (),
	Close: (self: Door) -> (),
	Toggle: (self: Door) -> (),
}

-- Constructor method for the Door class
function Door.new(model: Model): Door
	local self = setmetatable(Interactable.new(model) :: Door, Door)
	
	self.Opened = false
	self.OpenAngle = (model:GetAttribute("OpenAngle") :: number?) or -105
	self.CloseCFrame = model:GetPivot()
	self.OpenCFrame = self.CloseCFrame * CFrame.Angles(0, math.rad(self.OpenAngle), 0)
	self.Tween = nil
	self.OpenDuration = (model:GetAttribute("OpenDuration") :: number?) or 1.5
	
	return self
end

-- Method to handle the Door object tween
function Door:_TweenTo(goal: CFrame)
	if self.Tween then
		self.Tween:Cancel()
	end
	
	-- Creates an aux value to use it in the tween
	local aux = Instance.new("CFrameValue")
	aux.Value = self.Model:GetPivot()
	
	-- Here will happen the actual "Door object animation"
	aux:GetPropertyChangedSignal("Value"):Connect(function()
		self.Model:PivotTo(aux.Value)
	end)
	
	-- Tween to just change the aux value
	self.Tween = TweenService:Create(
		aux,
		TweenInfo.new(self.OpenDuration),
		{Value = goal}
	)
	
	-- To destroy the aux value and it's connection as it completed it's objective
	self.Tween.Completed:Once(function()
			aux:Destroy()
	end)

	self.Tween:Play()
end

-- Method to open the Door object
function Door:Open()
	
	if self.Opened then
		return
	end
	
	self.Opened = true
	self:_TweenTo(self.OpenCFrame)
end

-- Method to close the Door object
function Door:Close()
	
	if not self.Opened then
		return
	end
	
	self.Opened = false
	self:_TweenTo(self.CloseCFrame)
end

-- Method to handle the toggle process in the Door object
function Door:Toggle()
	if self.Opened then
		self:Close()
	else
		self:Open()
	end
end

return Door
