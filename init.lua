--[[
    UnitTests.lua

    @Author: AsynchronousMatrix
    @Licence: ...


]]--

-- // Package
package.path = package.path .. ";source\\?.lua"

-- // Variables
local UnitTests = { "System" } -- { "Component", "Entity", "System", "World" }

-- // Logic
local FailCount, SuccessCount = 0, 0

print("<< -- = TEST = -- >>")

for _, UnitName in ipairs(UnitTests) do
    print("\nUnit: " .. UnitName)
    print("------------------")

    local Success, Result = pcall(require, "test\\" .. UnitName)

    if not Success then
        print(string.format("[Unit][%s]: Fail [%s]", UnitName, Result))

        FailCount = FailCount + 1
    else
        SuccessCount = SuccessCount + 1
    end
end

-- // Log
print("<< -- = TEST = -- >>\n")
print(string.format("[Success Count]:%d \n[Fail Count]:%d", SuccessCount, FailCount))