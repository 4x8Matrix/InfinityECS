--[[
	Infinity.lua

	@Author: AsynchronousMatrix
	@Licence: ...

	This module initializes ECS architecture for the Infinity Framework;
		- Initializes SystemController
		- Initializes SubSystems

		- Initializes EntityArchetype
		- Initializes EntityManager
		- Initializes EntityObject

		- Initializes Component
]]--

-- // Variables
local Infinity = { Name = "Infinity ECS", Version = "2.0" }
local Environment = getfenv()

-- // Meta Methods
function Infinity:__index(Index) return Infinity[Index] end
function Infinity:__tostring() return Infinity.Name end

-- // Functions
function Infinity:ImportModule(ModuleFullName, IsFolder)
	if self.IsRoblox then
		local Module = self.Script

		for _, ModuleChild in ipairs(string.split(ModuleFullName, "\\")) do
			Module = Module[ModuleChild]
		end

		return require(Module)
	else
		if IsFolder then
			ModuleFullName = ModuleFullName .. "\\init"
		end

		return require(ModuleFullName)
	end
end

function Infinity:Update(...)
	self.SystemClock:Update(...)
end

function Infinity:GetService(ServiceName, Async)
	if self._Cache[ServiceName] then
		return self._Cache[ServiceName]
	else
		if Async then
			self._Cache[ServiceName] = self[ServiceName]

			repeat
				task.wait()
				self._Cache[ServiceName] = self[ServiceName]
			until self._Cache[ServiceName]
		end

		self._Cache[ServiceName] = self[ServiceName] or (Environment.game and Environment.game:GetService(ServiceName))
	end

	return self._Cache[ServiceName]
end

function Infinity:Sleep(Int)
	return self.SystemClock:ResumeIn(Int)
end

function Infinity:_Hex(Size)
	local HexValues = ""

	for Index = 1, Size do
		if Index ~= Size then
			HexValues = HexValues .. ("%x"):format(math.random(0, 15))
		else
			return HexValues .. ("%x"):format(math.random(8, 11))
		end
	end
end

function Infinity:_Id()
	return ("%s-%s"):format(
		self:_Hex(16), self:_Hex(5)
	)
end

function Infinity.new()
	local self = setmetatable({
		IsRoblox = _VERSION == "Luau";
		Script = Environment.script;

		_Cache = { };
		
		_Entities = { };
		_Worlds = { };
	}, Infinity)

	self.Json = self:ImportModule("Json", true)(self)

	self.World = self:ImportModule("World")(self)
	self.Query = self:ImportModule("Query")(self)
	self.Service = self:ImportModule("Service")(self)

	self.Component = self:ImportModule("Component\\Component")(self)
	self.ComponentBuilder = self:ImportModule("Component\\ComponentBuilder")(self)

	self.EntityManager = self:ImportModule("Entity\\EntityManager")(self)
	self.Archetype = self:ImportModule("Entity\\EntityArchetype")(self)
	self.Entity = self:ImportModule("Entity\\EntityObject")(self)

	self.SystemClock = self:ImportModule("System\\SystemClock")(self)
	self.System = self:ImportModule("System\\SystemObject")(self)
	
	self.SystemController = self:ImportModule("System\\SystemController")(self)

	if self.IsRoblox then
		local RunService = self:GetService("RunService")

		self.World = self.World.new({ }, "Default")
		self.World:SetState(true)

		self.IsServer = RunService:IsServer()
		self.UpdateConnection = ((self.IsServer and RunService.Stepped) or RunService.RenderStepped):Connect(function(DeltaTime)
			self:Update(DeltaTime)
		end)
	end

	return self
end

return Infinity.new()
