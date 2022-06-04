--[[
    Stream.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

-- // Pre-defined functions
local Sub = string.sub

-- // EOL functions
local FindInTable
function FindInTable(Array, TargetElement)
	for Index, Element in ipairs(Array) do
		if Element == TargetElement then
			return Index
		end
	end
end

return function(Infinity)
	local Stream = { Name = "Stream" }
	local WhitespaceBytes = { "\10", "\9", "\32" }

	-- // Functions
	function Stream:Previous(Int)
		return Sub(self.Source, self.Index - (Int or 1), self.Index)
	end

	function Stream:Skip(Int)
		self.Index = self.Index + (Int or 1)
		self.Char = Sub(self.Source, self.Index, self.Index)
		
		if self.Char == "" then
			self.Char = Infinity.Json.EosToken
		end
		
		if FindInTable(WhitespaceBytes, self.Char) then
			return self:Skip()
		end
	end

	function Stream:IsNext(...)
		local Characters = { ... }
		local NextChar = Sub(self.Source, self.Index + 1, self.Index + 1)
		
		if NextChar == "" then
			return Infinity.Json.EosToken
		end
		
		return FindInTable(Characters, NextChar) ~= nil
	end

	function Stream:Next(Whitespace)
		self.Index = self.Index + 1
		self.Char = Sub(self.Source, self.Index, self.Index)
		
		if self.Char == "" then
			self.Char = Infinity.Json.EosToken
		end
		
		if not Whitespace and FindInTable(WhitespaceBytes, self.Char) then
			return self:Next()
		end
		
		return self.Char
	end

	-- // Constructor
	function Stream.new(Source)
		return setmetatable({
			Source = Source,
			Index = 0, Char = ""
		}, { __index = Stream })
	end

	return Stream
end