local Infinity = require("Infinity")
local Cache = { }

local Index = 0

while true do
    local Result = Infinity:_Id()

    if Cache[Result] then
        return print("FOUND ID:", Result)
    else
        Cache[Result] = true
    end

    Index = Index + 1
    print(Index, Infinity:_Id())
end