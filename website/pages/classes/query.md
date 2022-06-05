# Query Class
The query class is an object which can be used to collect entities within the world that contain certain components. This class is useful for going through a huge amount of entities in a world without having significant performance issues. 

the query class can return two types of arrays, strict arrays and non-strict arrays; Strict arrays will be entities which have only the components in demand, non-strict arrays are entities which have those components and more.

# Properties
### Id
```
Query.Id: String
```

Short Hexidecimal string used to assign an object a unique string for identification 

# Functions
### GetResult
```
Query:GetResult(): { [Number]: EntityObjects }
```

Computes and returns the result of the query.

---
### Strict
```
Query:Strict(): QueryObject
```

Sets the query mode to strict.

---
### Unstrict
```
Query:Unstrict(): QueryObject
```

Sets the query mode to unstrict.


---
### FromName
```
Query:FromName(EntityAName: String, EntityBName: String, ...): QueryObject
```

Append a list of entity names to be queried

---
### FromComponents
```
Query:FromComponents(ComponentAName: String, ComponentBName: String, ...): QueryObject
```

Append a list of component names to be queried 

---
### Find
```
Query:Find(ComponentAName: String, ComponentBName: String, ...): QueryObject
```

Append the ComponentNames to the internal query registry

!!! Warning
	This method has recently been deprecated, please use `Query.FromComponents` instead!

---
### Filter
```
Query:Filter(Callback: Function): QueryObject
```

Create a translating function to help identify what entities you want as a result of this query.

```
local Query = Infinity.Query.new(Infinity.World):Filter(function(Entity, Component)
	if Entity.Name == "SpecialCaseEntity" then
		-- We dont want to include the special case, however it has all the same components that we're searching for.

		return false
	else
		return true
	end
end)

```

---
### new
```
Infinity.Query.new(Infinity.World)
```

Initiate a new query object, you need to specify what world you'd want to run the query object in.

---
# Code Example
An example of getting all entities in a world that have a specific component.
```
local Component = Infinity.Component.new("Data", "ComponentExample")
local World = Infinity.World.new({ 
	Infinity.Entity.new(
		{ Component },
		"EntityName"
	)
}, "MyWorld")

-- <...>

local Entities = Infinity.Query.new(World):Find("ComponentExample"):Filter(function(Entity)
	return Entity.Name == EntityName
end):GetResult()

print(Entities[1]) -- > EntityName, the entity we created on our third line.
```