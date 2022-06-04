local Infinity = require("Infinity")
local MyWorld = Infinity.World.new({ 
    Infinity.Entity.new(
        Infinity.ComponentBuilder.new({
            Component0 = { x = 0, y = 0, z = 0 };
            Component1 = { x = 0, y = 0, z = 0 };
            Component2 = { x = 0, y = 0, z = 0 };
            Component3 = { x = 0, y = 0, z = 0 };
            Component4 = { x = 0, y = 0, z = 0 };
        }):Build()
    )
})

local Query = Infinity.Query.new(MyWorld)
    :Strict()
    :Find("Component0")
    :GetResult()

for i, v in pairs(Query) do 
    print(i, v)
end