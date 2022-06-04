--[[
    Json.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
	local Json = { Name = "Json", EosToken = "<EOS>" }

	local JsonEncoder = Infinity:ImportModule("Json\\Encoder")(Infinity)
	local JsonDecoder = Infinity:ImportModule("Json\\Decoder")(Infinity)

	local Stream = Infinity:ImportModule("Json\\Stream")(Infinity)

	-- // Functions
	function Json:EncodeJSON(Data)
		if type(Data) == "table" then
			return JsonEncoder.EncodeObject(Data)
		else
			return JsonEncoder.EncodeChunk(Data)
		end
	end

	function Json:DecodeJSON(String)
		local JSONStream = Stream.new(String)
		JSONStream:Skip()

		return JsonDecoder.DecodeChunk(JSONStream)
	end

	return Json
end