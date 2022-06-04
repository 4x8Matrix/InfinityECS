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
    function SystemController:OnClockUpdate(...)
        for _, World in ipairs(Infinity._Worlds) do
            if World._Active then
                World:Update(...)
            end
        end
    end

    function SystemController:InitWatchdogThread()
        return coroutine.wrap(function()
            while self.Active do
                local DeltaTime = Infinity.SystemClock:ResumeIn(1 / self.FPS)

                self:OnClockUpdate(DeltaTime)
            end
        end)
    end

    function SystemController.new()
        local self = setmetatable({ Id = Infinity:_Id() }, SystemController)

        self.Active = true
        self.FPS = 60

        self.ClockWrappedCoroutine = self:InitWatchdogThread()
        self.ClockWrappedCoroutine()

        return self
    end

    return SystemController.new()
end