# Component Class
A component is one of the three elements that build the ECS architecture; This is a piece of data used to influence the behaviour of an entity, world or system.

# Properties
### Name
```
Component.Name: String
```

The given name of a component object

---
### Id
```
Component.Id: String
```

Short Hexidecimal string used to assign an object a unique string for identification 

# Functions
### Destroy
```
Component:Destroy(): nil
```

Used to remove a component; Invalidate the component so it's use is no longer valid

---
### Concat
```
Component:Concat(Source: String)
```

Will attempt to perform a concentration operation on the data the component is storing

!!! Warning
	If you attempt to do this on an illegal type; Such as a table then this function will raise an exception.

---
### Inc
```
Component:Inc(Int: Number)
```

Will attempt to perform an increment operation on the data the component is storing 

---
### Is
```
Component:Is(...: Any): Any | nil
```

Will compare the data the component is storing to all variations inside of the parameters

```
local Component = Infinity.Component.new("MyRawDataValue")

print(Component:Is("MyDataValue")) -- > nil
print(Component:Is("MyRawDataValue")) -- > MyRawDataValue
print(Component:Is("MyDataValue", "MyRawDataValue")) -- > MyRawDataValue
```

---
### Iter
```
Component:Iter(): (Any, Any) | nil
```

Will attempt to iterate through the data the component is storing

```
local Component = Infinity.Component.new({ "Abc", "123" })

for Index, Value in Component:Iter() do
	print(Index, Value)
end

--[[
	1 Abc
	2 123
]]--
```

---
### Set
```
Component:Set(Value: Any)
```

Will attempt to set the value of the component, overwriting any previous values.

---
### Type
```
Component:Type(): String
```

Return the type of data that it is storing, for example a component could be storing a string, userdata, number etc

---
### Equal
```
Component:Equal(Component: Component): Boolean
```

Attempt to compare the two component objects, not the data.

---
### new
```
Component.new(Value: Any, Name: String): Component
```

Constructor for component objects, this is how you'll create components.

# Code Example
Below is a code example on how we could use some of the above functions;

```
local HealthComponent = Infinity.Component.new(100, "Health")
local MaxHealthComponent = Infinity.Component.new(100, "MaxHealth")

local function TakeDamage(Damage: Int)
	HealthComponent:Inc(-Damage)

	if HealthComponent:Get() < MaxHealthComponent:Get() then
		print("Entity has died!")

		Infinity:Sleep(5)
		HealthComponent:Set(MaxHealthComponent:Get())
	end
end
```