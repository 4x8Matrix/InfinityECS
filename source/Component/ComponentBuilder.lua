--[[
    ComponentBuilder.lua

    @Author: AsynchronousMatrix
    @Licence: ...
]]--

return function(Infinity)
    -- // Variables
    local ComponentBuilder = { Name = "ComponentBuilder" }

    -- // Meta Methods
    function ComponentBuilder:__index(Index)
        return ComponentBuilder[Index]
    end

    function ComponentBuilder:__tostring()
        return self.Name
    end

    -- // Functions
    function ComponentBuilder:Build()
        local Components = { }

        for ComponentName, ComponentValue in pairs(self._Components) do
            Components[ComponentName] = Infinity.Component.new(ComponentValue)
            Components[ComponentName].Name = ComponentName
        end

        return Components
    end

    function ComponentBuilder:Update(Components)
        for ComponentName, ComponentValue in pairs(Components) do
            self._Components[ComponentName] = ComponentValue
        end
    end

    function ComponentBuilder.new(Components)
        return setmetatable({ _Components = Components, Id = Infinity:_Id() }, ComponentBuilder)
    end

    return ComponentBuilder
end