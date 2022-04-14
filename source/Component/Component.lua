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
    function Component:Concat(val)
        self._Data = self._Data .. (type(val) ~= "function" and val) or val(self._Data)
    end

    function Component:Inc(val)
        self._Data = self._Data + (type(val) ~= "function" and val) or val(self._Data)
    end

    function Component:Is(val)
        local States = { (type(val) ~= "function" and val) or val(self._Data) }

        for _, state in ipairs(States) do
            if state == self._Data then return true end
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

    function Component:Extend(Data)
        local DataType, localDataType = type(Data), type(self._Data)
        local Component

        assert(DataType == localDataType, string.format("Argument #1, Expected type %s, got %s", DataType, localDataType))

        Component = Component.new(Data)
        Component.super = self

        if DataType == "table" then
            Component:Set(fillTable(Data, self._Data))
        end

        return Component
    end

    function Component:Equal(Target)
        return self.Id == Target.Id
    end

    function Component:Type()
        return type(self._Data)
    end

    function Component.new(Data)
        return setmetatable({ _Data = Data, Id = Infinity:_Id() }, Component)
    end

    return Component
end