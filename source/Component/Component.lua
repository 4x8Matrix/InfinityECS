--[[
    Component.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
    -- // Variables
    local Component = { Name = "Component" }

    -- // Meta Methods
    function Component:__index(Index)
        if Component[Index] then return Component[Index] end

        local Data = rawget(self, "Data")
        local DataType = type(Data)

        return (DataType == "table" and Data[Index]) or nil
    end

    function Component:__tostring()
        return string.format("Component [ %s ]", self.Name or self.Id)
    end

	function Component:__div(Value)
		return self.Data / Value
	end
	
	function Component:__mul(Value)
		return self.Data * Value
	end
	
	function Component:__sub(Value)
		return self.Data - Value
	end
	
	function Component:__add(Value)
		return self.Data + Value
	end

	function Component:__lt(Value)
		return self.Data < Value
	end

	function Component:__le(Value)
		return self.Data <= Value
	end

    -- // EOL Functions
    local fillTable do
        fillTable = function(tbl0, tbl1)
            for Index, Object in pairs(tbl1) do
                if tbl0[Index] then
                    if type(tbl0[Index]) == "table" then
                        fillTable(tbl0[Index], Object)
                    end
                else
                    tbl0[Index] = Object
                end
            end

            return tbl0
        end
    end

    -- // Functions
	function Component:Destroy()
		setmetatable(self, { __mode = "kv" })
	end

    function Component:Concat(val)
		val = (type(val) == "function" and val(self.Data)) or val
		
		self:Update(val)
        self.Data = self.Data .. val
    end

    function Component:Increment(val)
		val = self.Data + ((type(val) == "function" and val(self.Data)) or val)

		self:Update(val)
        self.Data = self.Data + val
    end

	function Component:Decrement(val)
		val = self.Data - ((type(val) == "function" and val(self.Data)) or val)

		self:Update(val)
        self.Data = self.Data + val
    end

	function Component:Update(Value)
		for _, ReplicatorCallback in ipairs(self._Replicators) do
			ReplicatorCallback(self.Data, Value)
		end
	end

	function Component:Replicator(Callback)
		table.insert(self._Replicators, Callback)

		return function()
			for Index, Object in ipairs(self._Replicators) do
				if Object == Callback then
					table.remove(self._Replicators, Index)

					return
				end
			end
		end
	end

    function Component:Is(...)
        local States = { ... }

        for _, State in ipairs(States) do
            if State == self.Data then return State end
        end
    end

    function Component:Iter()
        local Index, Key, value = 0, nil, nil

        return function()
            local DataType = type(self.Data)

            if DataType ~= "table" then
                if Index ~= 0 then
                    return nil
                else
                    Index = Index + 1

                    return 1, self.Data
                end
            end

            Key, value = next(self.Data, Key)
            Index = Index + 1

            return Key, value
        end
    end

    function Component:Set(val)
		self:Update(val)
        self.Data = (type(val) ~= "function" and val) or val(self.Data)
    end

	function Component:Get(val)
        return self.Data
    end

    function Component:Equal(Target)
        return self.Id == Target.Id
    end

    function Component:Type()
        return type(self.Data)
    end

    function Component.new(Data, ComponentName)
        return setmetatable({ Data = Data, Id = Infinity:_Id(), Name = ComponentName, _Replicators = { }}, Component)
    end

    return Component
end