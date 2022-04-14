--[[
    SystemClock.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
    local Clock = { Name = "Clock" }

    -- // Meta Methods
    function Clock:__index(Index)
        return Clock[Index]
    end

    function Clock:__tostring()
        return self.Name
    end

    function Clock:Update(DeltaTime)
        DeltaTime = DeltaTime or 0

        self.Delta = (os.clock() - self._Clock) + DeltaTime

        for Index, YieldingThreadData in ipairs(self.Yielding) do
            if os.clock() - YieldingThreadData.Clock >= YieldingThreadData.Int then
                coroutine.resume(YieldingThreadData.Thread, (YieldingThreadData.Int - (os.clock() - YieldingThreadData.Clock) + DeltaTime))

                table.remove(self.Yielding, Index)
            end
        end
    end

    function Clock:ResumeIn(Int)
        table.insert(self.Yielding, { Int = Int; Clock = os.clock(); Thread = coroutine.running() })

        return coroutine.yield()
    end

    -- // Clock Functions
    function Clock.new()
        local self = setmetatable({ Id = Infinity:_Id(), Yielding = { } }, Clock)

        self._Clock = os.clock()

        return self
    end

    return Clock.new()
end