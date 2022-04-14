local Infinity = require("Infinity")

Infinity.Entity.new(
    Infinity.ComponentBuilder.new({
        Component0 = { x = 0, y = 0, z = 0 };
        Component2 = true;
    }):Build()
).Name = "Entity1"

Infinity.Entity.new(
    Infinity.ComponentBuilder.new({
        Component0 = { x = 0, y = 0, z = 0 };
    }):Build()
).Name = "Entity2"

local QueryResult = Infinity.Query.new():Find({"Component0", "Component2"}):Filter(function(Entity, Component)
    print("----")
    print("Filter:", Entity, Component)

    return true
end):GetResult()

for i, v in pairs(QueryResult) do print(v) end