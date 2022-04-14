local Infinity = require("Infinity")
local Entity = Infinity.Entity.new(
    Infinity.ComponentBuilder.new({
        Component0 = { x = 0, y = 0, z = 0 };
        Component1 = { x = 0, y = 0, z = 0 };
        Component2 = { x = 0, y = 0, z = 0 };
        Component3 = { x = 0, y = 0, z = 0 };
        Component4 = { x = 0, y = 0, z = 0 };
    }):Build()
)

for Index, Value in Entity:Iter() do
    print(Index, Value)
end