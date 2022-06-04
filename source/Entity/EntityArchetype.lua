--[[
    EntityArchetype.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
    local EntityArchetype = { Name = "EntityArchetype" }

    -- // Meta Methods
    function EntityArchetype:__index(Index)
        return EntityArchetype[Index]
    end

    function EntityArchetype:__tostring()
        return self.Name
    end

    -- // EntityArchetype Functions
    function EntityArchetype:Contains(ComponentTypes)
        if #self.Types ~= #ComponentTypes then return false end

        for _, Type in ipairs(ComponentTypes) do
            for _, LocalType in ipairs(self.Types) do
                if LocalType ~= Type then
                    return false
                end
            end
        end

        return true
    end

    function EntityArchetype:Has(ComponentType)
        for _, Type in ipairs(self.Types) do
            if ComponentType == Type then
                return true
            end
        end
    end

    function EntityArchetype.new(Types)
        local self = setmetatable({ Id = Infinity:_Id(), Types = Types }, EntityArchetype)

        return self
    end

    return EntityArchetype
end