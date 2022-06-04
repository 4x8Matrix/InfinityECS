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
    function System:PreUpdate() return true end
    function System:OnUpdate() end
    function System:PostUpdate() end

    function System:Bind(EventName, EventCallback)
        if not self._EventBinds[EventName] then
            self._EventBinds[EventName] = { }
        end

        table.insert(self._EventBinds[EventName], EventCallback)

        return function()
            for Index, Callback in ipairs(self._EventBinds) do
                if Callback == EventCallback then
                    table.remove(self._EventBinds, Index)
                
                    return
                end
            end
        end
    end

    function System:Fire(EventName, ...)
        if not self._EventBinds[EventName] then return end

        for _, Callback in ipairs(self._EventBinds[EventName]) do
            Callback(...)
        end
    end

    function System.new()
        local self = setmetatable({ Id = Infinity:_Id(), _EventBinds = { } }, System)

        return self
    end

    return System
end