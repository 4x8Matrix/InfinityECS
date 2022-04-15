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
    function Entity:Destroy() 
    
    end

    function Entity:Iter()
        local Index, Key, Value = 0, nil, nil

        return function()
            Key, Value = next(self.Components, Key)
            Index = Index + 1

            return Key, Value
        end
    end

    function Entity:AddComponent(Name, Value)
        self.Components[Name] = Infinity.Component.new(Value._Data)

        Infinity.EntityManager:Manage(self)
    end

    function Entity:RemoveComponent(Name)
        self.Components[Name] = nil

        Infinity.EntityManager:Manage(self)
    end

    function Entity:GetComponentFromType(Type)
        local Components = { }

        assert(Type ~= nil, "Expected Argument #1 Type")

        for Index, Component in pairs(self.Components) do
            if Component:Type() == Type then
                Components[Index] = Component
            end
        end

        return Components
    end

    function Entity:Extend(...)
        local EntityExtended = Entity.new(self.Components, self.Name)
        EntityExtended.Super = self

        return EntityExtended
    end

    function Entity.new(Components, Name)
        local self = setmetatable({ Id = Infinity:_Id(), Components = { }, Name = Name }, Entity)
        
        table.insert(Infinity._Entities, self)
        for ComponentName, Component in pairs(Components) do
            self:AddComponent(ComponentName, Component)
        end

        Infinity.EntityManager:Manage(self)

        return self
    end

    return Entity
end