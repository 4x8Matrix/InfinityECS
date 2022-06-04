--[[
    Encoder.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

-- // Pre-defined functions
local Format = string.format
local Sub = string.sub

-- // EOL functions
local IsDictionary
IsDictionary = function(Table)
	local Length = #Table
	local Count = 0
	
	for Index, Value in next, Table do
		Count = Count + 1
		
		if Count > Length then
			return true
		end
	end
end

return function(Infinity)
	local Encoder = { Name = "Encoder" }

	-- // Functions
	function Encoder.EncodeChunk(Value)
		local ValueType = type(Value)
		
		if ValueType == "number" or ValueType == "boolean" then
			return tostring(Value)
		elseif ValueType == "string" then
			return Format("\"%s\"", Value)
		elseif ValueType == "table" then
			return Encoder.EncodeObject(Value)
		else
			return "NULL"
		end
	end

	function Encoder.EncodeObject(Table)
		local IsTableDictionary = IsDictionary(Table)
		local ObjectStr = IsTableDictionary and "{" or "["
		
		local LineToAppend = ""
		
		for Index, Value in next, Table do
			if LineToAppend ~= "" then
				ObjectStr = ObjectStr .. LineToAppend
			end
			
			if IsTableDictionary then
				LineToAppend = Format("\"%s\":%s,", tostring(Index), Encoder.EncodeChunk(Value))
			else
				LineToAppend = Format("%s,", Encoder.EncodeChunk(Value))
			end
		end
		
		return ObjectStr .. Sub(LineToAppend, 0, -2) .. ((IsTableDictionary and "}") or "]")
	end

	return Encoder
end