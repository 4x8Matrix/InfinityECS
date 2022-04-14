--[[
    SystemController.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
    local SystemController = { Name = "SystemController" }

    -- // Meta Methods
    function SystemController:__index(Index)
        return SystemController[Index]
    end

    function SystemController:__tostring()
        return self.Name
    end

    -- // SystemController Functions
    function SystemController.new()
        local self = setmetatable({ Id = Infinity:_Id() }, SystemController)

        return self
    end

    return SystemController.new()
end