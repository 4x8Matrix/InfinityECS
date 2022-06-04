# Component Builder Class
The component builder class offers a flexible and easy way to build a multitude components; for example, this could be for bulk component generation or nested components in entity generation.

# Properties
### Id
```
ComponentBuilder.Id: String
```

Short Hexidecimal string used to assign an object a unique string for identification 
# Functions
### Build
```
ComponentBuilder:Build(): { [Number]: Component }
```

Build the array of components. 

```
local Components = Infinity.ComponentBuilder.new({
	ComponentName = "ComponentValue"
}):Build()

--[[
	{
		Component -- Value: "ComponentValue", Name: "ComponentName"
	}
]]

```

---
### Update
```
ComponentBuilder:Update(ComponentDict: { [String]: Any })
```

Will append the ComponentDict to internal components; When calling `:Build` these components will be appended onto the array of components

```
local ComponentBuilder = Infinity.ComponentBuilder.new({
	ComponentName = "ComponentValue"
}):Update({
	ComponentName2 = "ComponentValue2"
})
```

---
### new
```
Infinity.ComponentBuilder.new(ComponentDict: { [String]: Any }): ComponentBuilder
```

Initiate a new ComponentBuilder object; The first parameter is all the components you would like to initially add.

---
# Code Example
```
local PlayerObject = Infinity.Entity.new(
	Infinity.ComponentBuilder.new({
		IsLoaded = false,
		DataLoaded = false,
		Data = { }
	})
)

--[[
PlayerObject Entity will have the components; 

- IsLoaded
- DataLoaded
- Data

All three of these will be ComponentObjects/
]]--
```