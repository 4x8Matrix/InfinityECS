--[[
    EntityObject.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
    local Entity = { Name = "Entity" }

    -- // Meta Methods
    function Entity:__index(Index)
        if Entity[Index] then return Entity[Index] end

        local Components = rawget(self, "Components")

        return Components[Index]
    end

    function Entity:__tostring()
        return string.format("Entity [ %s ]", self.Name or self.Id)
    end

    -- // Entity Functions
    function Entity:Destroy() end

    function Entity:Iter()
        local Index, Key, Value = 0, nil, nil

        return function()
            Key, Value = next(self.Components, Key)
            Index = Index + 1

            return Key, Value
        end
    end

    function Entity:AddComponents(ComponentDict)
        for Name, Component in pairs(ComponentDict) do
            self.Components[Name] = Component
        end

        Infinity.EntityManager:Manage(self)
    end

    function Entity:RemoveComponent(Name)
        self.Components[Name] = nil

        Infinity.EntityManager:Manage(self)
    end

    function Entity:GetComponentOf(Type)
        local Components = { }

        assert(Type ~= nil, "Expected Argument #1 Type")

        for Index, Component in pairs(self.Components) do
            if Component:Type() == Type then
                Components[Index] = Component
            end
        end

        return Components
    end

    function Entity.new(ComponentsDict)
        local self = setmetatable({ Id = Infinity:_Id(), Components = ComponentsDict or { } }, Entity)
        table.insert(Infinity._Entities, self)
        Infinity.EntityManager:Manage(self)


        return self
    end

    return Entity
end