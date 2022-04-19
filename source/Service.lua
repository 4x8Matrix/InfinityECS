--[[
    Service.lua

    @Author: AsynchronousMatrix
    @Licence: ...

    Help produce useful API's for Infinities vast systems, A service is an immutable singleton which can be initiated to provide API's programmers would like to deploy into the framework itself
    An example of this could be a Net Service, a Service to help simplify the Network side of Lua, Luau
]]--

return function(Infinity)
    local Service = { Name = "Service" }

    -- // Meta Methods
    function Service:__index(Index)
        return Service[Index]
    end

    function Service:__tostring()
        return string.format("Service [ %s ]", self.Name or self.Id)
    end

    -- // Functions
    function Service.new(Data)
        local self = setmetatable(Data or { }, Service)
        self.Id = Infinity:_Id()
        
        Infinity[self.Name] = self

        return self
    end

    return Service
end