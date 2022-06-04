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
		for Name, Component in pairs(self.Components) do
			Component:Destroy()
			self.Components[Name] = nil
		end

		setmetatable(self, { __mode = "kv" })
    end

	function Entity:FromJSON(JSONString)
		local JSONEntity = Infinity.Json:DecodeJSON(JSONString)

		return Entity.new(
			Infinity.ComponentBuilder.new(JSONEntity.Components):Build(), 
			JSONEntity.Name
		)
	end

	function Entity:ToJSON()
		local JSONEntity = { Name = self.Name, Components = { } }

		for Name, Component in pairs(self.Components) do
			JSONEntity.Components[Name] = Component._Data
		end

		return Infinity.Json:EncodeJSON(JSONEntity)
	end

    function Entity:Iter()
        local Index, Key, Value = 0, nil, nil

        return function()
            Key, Value = next(self.Components, Key)
            Index = Index + 1

            return Key, Value
        end
    end

    function Entity:AddComponent(Component)
        self.Components[Component.Name] = Component

        Infinity.EntityManager:Manage(self)
    end

	function Entity:AddComponents(...)
		for _, Component in ipairs({ ... }) do
			self.Components[Component.Name] = Component
		end

		Infinity.EntityManager:Manage(self)
    end

    function Entity:RemoveComponent(Name)
        self.Components[Name] = nil

        Infinity.EntityManager:Manage(self)
    end

	function Entity:RemoveComponents(...)
		for _, Name in ipairs({ ... }) do
			self.Components[Name]:Destroy()
			self.Components[Name] = nil

			Infinity.EntityManager:Manage(self)
		end
    end

	function Entity:GetComponent(Name)
		return self.Components[Name]
	end

    function Entity:GetComponentsFromType(Type)
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
            self:AddComponent(Component, ComponentName)
        end

        Infinity.EntityManager:Manage(self)

        return self
    end

    return Entity
end