--[[
    System.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
    local System = { Name = "System" }

    -- // Meta Methods
    function System:__index(Index)
        return System[Index]
    end

    function System:__tostring()
        return self.Name
    end

    -- // System Functions
    function System.new()
        local self = setmetatable({ Id = Infinity:_Id() }, System)

        return self
    end

    return System.new()
end