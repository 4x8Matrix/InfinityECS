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

	function Clock:Resume(Routine, ...)
		local Success, Result = coroutine.resume(Routine, ...)

		if not Success then
			return error(string.format("%s\n%s", Result, debug.traceback(Routine)), math.huge)
		end
	end

    function Clock:Update(DeltaTime)
        DeltaTime = DeltaTime or 0

        self.Delta = (os.clock() - self._Clock) + DeltaTime

        for Index, TaskData in ipairs(self.Tasks) do
            if os.clock() - TaskData[2] >= TaskData[1] then
				self:Resume(TaskData[3], (((os.clock() - TaskData[2]) - TaskData[1]) + DeltaTime))

                table.remove(self.Tasks, Index)
            end
        end
    end

    function Clock:ResumeIn(Int)
        table.insert(self.Tasks, { Int or 1 / Infinity.SystemController.FPS; os.clock(); coroutine.running() })

        return coroutine.yield()
    end

    -- // Clock Functions
    function Clock.new()
        local self = setmetatable({ Id = Infinity:_Id(), Tasks = { } }, Clock)
        self._Clock = os.clock()

        return self
    end

    return Clock.new()
end