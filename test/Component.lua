local Infinity = require("Infinity")
local Component = Infinity.Component.new({ abc = 123 })

for Index, Value in Component:Iter() do
    print(Index, Value)
end