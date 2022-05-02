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

        local Data = rawget(self, "_Data")
        local DataType = type(Data)

        return (DataType == "table" and Data[Index]) or nil
    end

    function Component:__tostring()
        return string.format("Component [ %s ]", self.Name or self.Id)
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
        self._Data = self._Data .. (type(val) == "function" and val(self._Data)) or val
    end

    function Component:Inc(val)
        self._Data = self._Data + (type(val) ~= "function" and val) or val(self._Data)
    end

    function Component:Is(...)
        local States = { ... }

        for _, State in ipairs(States) do
            if State == self._Data then return State end
        end
    end

    function Component:Iter()
        local Index, Key, value = 0, nil, nil

        return function()
            local DataType = type(self._Data)

            if DataType ~= "table" then
                if Index ~= 0 then
                    return nil
                else
                    Index = Index + 1

                    return 1, self._Data
                end
            end

            Key, value = next(self._Data, Key)
            Index = Index + 1

            return Key, value
        end
    end

    function Component:Set(val)
        self._Data = (type(val) ~= "function" and val) or val(self._Data)
    end

	function Component:Get(val)
        return self._Data
    end

    function Component:Equal(Target)
        return self.Id == Target.Id
    end

    function Component:Type()
        return type(self._Data)
    end

    function Component.new(Data, ComponentName)
        return setmetatable({ _Data = Data, Id = Infinity:_Id(), Name = ComponentName }, Component)
    end

    return Component
end