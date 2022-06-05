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
    function Query:StrictResult(Entities)
        for Index, Entity in ipairs(Entities) do
            for _, QueryComponentName in ipairs(self.Components) do
                local EntityIllegal

                for ComponentName, _ in pairs(Entity.Components) do
                    if QueryComponentName ~= ComponentName then
                        EntityIllegal = true

                        break
                    end
                end

                if EntityIllegal then
                    table.remove(Entities, Index)
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

                if EntityIllegal then
                    table.remove(Entities, Index)
                end
            end
        end

        return Entities
    end

    function Query:GetResult()
        local Entities = { }

        for _, Entity in ipairs((self._World and self._World._Entities) or Infinity._Entities) do
			local IsEntityNameValid = false

			for _, EntityName in ipairs(self.Names) do
				if Entity.Name == EntityName then
					if self.FilterCallback then
						if self.FilterCallback(Entity) then
							table.insert(Entities, Entity)
							
							break
						end
					else
						table.insert(Entities, Entity)

						break
					end
					
					IsEntityNameValid = true
				end
			end

			if not IsEntityNameValid then
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
        end

        return (self.IsStrict and self:StrictResult(Entities)) or Entities
    end

    function Query:Strict()
        self.IsStrict = true

        return self
    end

    function Query:Unstrict()
        self.IsStrict = false

        return self
    end
    
    function Query:FromName(...)
		for _, EntityName in ipairs({ ... }) do
			table.insert(self.Names, EntityName)
		end

        return self
    end

	function Query:FromComponents(...)
		for _, ComponentName in ipairs({ ... }) do
			table.insert(self.Components, ComponentName)
		end

        return self
	end

    function Query:Filter(Callback)
        self.FilterCallback = Callback

        return self
    end

    function Query.new(World)
        local self = setmetatable({ Id = Infinity:_Id(); _World = World }, Query)

        self.IsStrict = false
        self.Components = { }
		self.Names = { }

        if Infinity.IsRoblox then
            self._World = Infinity.World
        end

        return self
    end

    return Query
end