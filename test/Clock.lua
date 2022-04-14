local Infinity = require("Infinity")

coroutine.wrap(function()
    local DeltaTime = Infinity.SystemClock:ResumeIn(5)

    print("Resumed: ", DeltaTime)
end)()

while true do
    Infinity.SystemClock:Update(1)
end