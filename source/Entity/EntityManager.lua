--[[
    EntityManager.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
    local EntityManager = { Name = "EntityManager" }

    -- // Meta Methods
    function EntityManager:__index(Index)
        return EntityManager[Index]
    end

    function EntityManager:__tostring()
        return self.Name
    end

    -- // EntityManager Functions
    function EntityManager:GetArchetypeFromComponents(ComponentTypes)
        for _, Archetype in ipairs(self.Archetypes) do
            if Archetype:Contains(ComponentTypes) then
                return Archetype
            end
        end
    end

    function EntityManager:Archetype(ComponentTypes)
        local Archetype = self:GetArchetypeFromComponents(ComponentTypes)

        if Archetype then 
            return Archetype
        else
            table.insert(self.Archetypes, Infinity.Archetype.new(ComponentTypes))
            return self.Archetypes[#self.Archetypes]
        end
    end

    function EntityManager:ToType(ComponentList)
        local Types, RTypes = { }, { }

        for _, Component in pairs(ComponentList) do
            local ComponentType = Component:Type()

            if not RTypes[ComponentType] then
                RTypes[ComponentType] = true

                table.insert(Types, ComponentType)
            end
        end

        return Types
    end

    function EntityManager:Manage(Entity)
        Entity.Archetype = self:Archetype(self:ToType(Entity.Components))
    end

    function EntityManager.new()
        local self = setmetatable({ Archetypes = { }, Id = Infinity:_Id() }, EntityManager)

        return self
    end

    return EntityManager.new()
end