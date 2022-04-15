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

    -- // Functions
    function WorldObject:AddEntity(EntityObject)
        assert(getmetatable(EntityObject).Name == "Entity", "Expected Argument #1 EntityObject")

        table.insert(self._Entities, EntityObject:Extend())
    end

    function WorldObject:AddSystem(SystemObject)
        assert(getmetatable(SystemObject).Name == "System", "Expected Argument #1 SystemObject")

        table.insert(self._Systems, SystemObject)
    end

    function WorldObject:GetEntitiesFromArchetype(Archetype)
        local Entities = { }
        
        for _, Entity in ipairs(self._Entities) do
            if Entity.Archetype.Id == Archetype.Id then
                table.insert(Entities, Entity)
            end
        end

        return Entities
    end

    function WorldObject:GetEntitiesFromComponents(Components)
        local Entities = { }
        
        for _, Entity in ipairs(self._Entities) do
            for _, TargetComponent in ipairs(Components) do
                local HasComponent = false

                for _, Component in ipairs(Entity.Components) do
                    if TargetComponent.Name == Component.Name then
                        HasComponent = true

                        table.insert(Entities, Entity)
                        break
                    end
                end

                if HasComponent then 
                    break 
                end
            end
        end

        return Entities
    end

    function WorldObject:GetEntitiesFromName(EntityName)
        local Entities = { }
        
        for _, Entity in ipairs(self._Entities) do
            if Entity.Name == EntityName then
                table.insert(Entities, Entity)
            end
        end

        return Entities
    end

    function WorldObject:SetState(State)
        if State then
            if Infinity.ActiveWorld then
                Infinity.ActiveWorld:SetState(false)
            end

            Infinity.ActiveWorld = self
        end

        self._Active = State
    end

    function WorldObject:Push(Event, ...)
        for _, System in ipairs(self._Systems) do
            System.World = self
            
            if System[Event] then
                System[Event](System, ...)
            end
        end
    end

    function WorldObject:Update(DeltaTime)
        for _, System in ipairs(self._Systems) do
            System.World = self

            if System:PreUpdate(DeltaTime) then
                System:PostUpdate(
                    DeltaTime,
                    System:OnUpdate(DeltaTime)
                )
            end
        end
    end

    function WorldObject:Destroy(...)
        self:Push("OnDestroy", ...)

        for _, Entity in ipairs(self._Entities) do
            Entity:Destroy()
        end
    end

    function WorldObject.new(Entities, WorldName)
        local self = setmetatable({
            _Entities = { },
            _Systems = { }, Id = Infinity:_Id(),
            _Active = false, Name = WorldName
        }, WorldObject)

        table.insert(Infinity._Worlds, self)
        for _, Entity in ipairs(Entities) do
            self:AddEntity(Entity)
        end

        return self
    end

    return WorldObject
end