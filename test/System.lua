local Infinity = require("Infinity")

local World0 = Infinity.World.new({ Infinity.Entity.new(Infinity.ComponentBuilder.new({ Component0 = { x = 0, y = 0, z = 0 } }):Build()) })
local System = Infinity.System.new()

function System:OnUpdate(...)
    print("SystemUpdate:", ...)
end

World0:AddSystem(System)
World0:SetState(true)

while true do
    Infinity.SystemClock:Update()
end