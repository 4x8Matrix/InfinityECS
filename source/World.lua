--[[
    World.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
    local WorldObject = { Name = "World" }

    -- // Meta Methods
    function WorldObject:__index(Index)
        return WorldObject[Index]
    end

    function WorldObject:__tostring()
        return string.format("World [ %s ]", self.Name or self.Id)
    end

    -- // Entity Functions
    function WorldObject:AddEntity() end
    function WorldObject:AddEntities() end
    function WorldObject:RemoveEntity() end
    function WorldObject:ClearEntities() end

    -- // System Functions
    function WorldObject:AddSystem() end
    function WorldObject:AddSystems() end
    function WorldObject:RemoveSystem() end
    function WorldObject:ClearSystems() end

    -- // Update Functions
    function WorldObject:Update() end
    function WorldObject:Destroy() end

    function WorldObject.new(Components)
        local self = setmetatable({
            _Components = Components or { },
            _Systems = { }, Id = Infinity:_Id()
        }, WorldObject)

        return self
    end

    return WorldObject
end