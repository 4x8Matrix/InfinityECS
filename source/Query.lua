--[[
    Query.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
    local Query = { Name = "Query" }

    -- // Meta Methods
    function Query:__index(Index)
        return Query[Index]
    end

    function Query:__tostring()
        return self.Name
    end

    -- // Entity Functions
    function Query:GetResult()
        local Entities = { }

        for _, Entity in ipairs(Infinity._Entities) do
            for ComponentName, Component in pairs(Entity.Components) do
                local ComponentInEntity

                for _, QueryComponentName in ipairs(self.Components) do
                    if ComponentName == QueryComponentName then
                        if self.FilterCallback then
                            if self.FilterCallback(Entity, Component) then
                                ComponentInEntity = true
                                break
                            end
                        else
                            ComponentInEntity = true
                            break
                        end
                    end
                end

                if ComponentInEntity then
                    table.insert(Entities, Entity)

                    break
                end
            end
        end

        if self.Strict then
            local StrictEntities = { }

            for _, Entity in ipairs(Entities) do
                for _, QueryComponentName in ipairs(self.Components) do
                    local EntityIllegal

                    for ComponentName, _ in pairs(Entity.Components) do
                        if QueryComponentName ~= ComponentName then
                            EntityIllegal = true

                            break
                        end
                    end

                    if not EntityIllegal then
                        table.insert(StrictEntities, Entity)
                    end
                end

                for ComponentName, _ in pairs(Entity.Components) do
                    local EntityIllegal

                    for _, QueryComponentName in ipairs(self.Components) do
                        if QueryComponentName ~= ComponentName then
                            EntityIllegal = true

                            break
                        end
                    end

                    if not EntityIllegal then
                        table.insert(StrictEntities, Entity)
                    end
                end
            end
        
            Entities = StrictEntities
        end

        return Entities
    end

    function Query:Strict()
        self.Strict = true

        return self
    end

    function Query:Unstrict()
        self.Strict = false

        return self
    end
    
    function Query:Find(ComponentNames)
        if type(ComponentNames) ~= "table" then 
            table.insert(self.Components, ComponentNames)
        else
            for _, ComponentName in ipairs(ComponentNames) do
                table.insert(self.Components, ComponentName)
            end
        end

        return self
    end

    function Query:Filter(Callback)
        self.FilterCallback = Callback

        return self
    end

    function Query.new()
        local self = setmetatable({ Id = Infinity:_Id() }, Query)

        self.Strict = true
        self.Components = { }

        return self
    end

    return Query
end