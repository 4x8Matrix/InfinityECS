--[[
    Decoder.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

-- // Pre-defined functions
local Insert = table.insert
local Format = string.format
local Lower = string.lower
local Find = string.find

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
	local Decoder = { Name = "Decoder" }
	local Literals = { "t", "f", "n" }

	-- // Functions
	function Decoder.Error(Stream, Message, Previous)
		return error(Format("%s [%s ???]", Message, Previous or Stream:Previous(5)))
	end

	function Decoder.Assert(State, ...)
		if not State then
			Decoder.Error(...)
		end
	end

	function Decoder.DecodeChunk(Stream)
		local Char = Stream.Char
		local IsLiteral = FindInTable(Literals, Char)
		
		if IsLiteral then
			return Decoder.DecodeLiteral(Stream)
		else
			if Char == "\"" then
				return Decoder.DecodeString(Stream)
			elseif Char == "{" then
				return Decoder.DecodeObject(Stream)
			elseif Char == "[" then
				return Decoder.DecodeArray(Stream)
			elseif Find(Char, "%d") then
				return Decoder.DecodeNumber(Stream)
			elseif Char == Infinity.Json.EosToken then
				return false
			end	
		end
	end

	function Decoder.DecodeNumber(Stream)
		local Buff = Stream.Char
		local Char
		
		while true do
			Char = Stream:Next()
			
			if not Find(Char, "%d") and Lower(Char) ~= "e" then
				return tonumber(Buff)
			else
				Buff = Buff .. Char	
			end
		end
	end

	function Decoder.DecodeString(Stream)
		local Buff = ""
		local Char
		
		while true do
			Char = Stream:Next(true)

			if Char == "\\" then
				if Stream:IsNext("\"") then
					Stream:Next(true)
				end
				
				Buff = Buff .. "\""
			elseif Char == Infinity.Json.EosToken then
				return Decoder.Error(Stream, "Unfinished String", Buff)
			elseif Char == "\"" then
				Stream:Skip()
				
				return Buff
			else
				Buff = Buff .. Char	
			end
		end
	end

	function Decoder.DecodeLiteral(Stream)
		if Stream.Char == "t" then
			Stream:Skip(4)
			return true
		elseif Stream.Char == "n" then
			Stream:Skip(4)
			return nil
		elseif Stream.Char == "f" then
			Stream:Skip(5)
			return false
		end
	end

	function Decoder.DecodeObject(Stream)
		local LuaJSONObject = { }
		local Key, Value
		
		Stream:Skip() -- skip "{"
		
		while true do
			if Stream.Char == "}" then
				Stream:Skip()
				
				return LuaJSONObject
			elseif Stream.Char == Infinity.Json.EosToken then
				return Decoder.Error(Stream, "Unfinished Object")
			else
				Decoder.Assert(Stream.Char == "\"", Stream, "Expected \"")
				Key = Decoder.DecodeString(Stream)
				Decoder.Assert(Stream.Char == ":", Stream, "Expected :")

				Stream:Skip()
				Value = Decoder.DecodeChunk(Stream)
				
				if Stream.Char == "," then
					Stream:Skip()
				end

				LuaJSONObject[Key] = Value	
			end
		end
	end

	function Decoder.DecodeArray(Stream)
		local LuaJSONArray = { }
		local Value
		
		Stream:Skip()
		
		while true do
			if Stream.Char == "]" then
				Stream:Skip()
				
				return LuaJSONArray
			elseif Stream:IsNext(Infinity.Json.EosToken) then
				return Decoder.Error(Stream, "Unfinished Array")
			elseif Stream.Char == "," then
				Stream:Skip()
			end
			
			Value = Decoder.DecodeChunk(Stream)
			Insert(LuaJSONArray, Value)
		end
	end

	return Decoder
end