# System Class
An system is one of the three elements that build the ECS architecture; This class provides logic for the entities & components inside of the world. An example of this would be; Updating an AI Pathfinding Algorithm to push a block to the next point in 3D Space.

!!! Warning
	A system class needs to have a world; Without a world this system can no longer manipulate any entities or components
	It is very bad practice to create a system and use it as a service, api or an object to be used inside of Infinity.

# Properties
### Id
```
System.Id: String
```

Short Hexidecimal string used to assign an object a unique string for identification 

# Functions
### PreUpdate
```
System:PreUpdate(DeltaTime: Number): Boolean
```

PreUpdate is a validation function to validate calling `:OnUpdate`; This function is fired after every heartbeat (Avg: 60fps)
If PreUpdate returns false, or an answer in any way that represents a falsey statement, then the `:OnUpdate` function will be skipped.

A good use-case for this would be a system you only wanted to update each second, you could easily add in a block of code to fire this event after a second has passed.

!!! Information
	This function is designed to be overwritten; If your system is loop driven then you would overwrite this function.

---
### OnUpdate
```
System:OnUpdate(DeltaTime: Number): Any, Any, ...
```

OnUpdate will be called by the world object every heartbeat (Avg: 60fps)

Any returns will be fed directly into `:PostUpdate`

!!! Information
	This function is designed to be overwritten; If your system is loop driven then you would overwrite this function.

---
### PostUpdate
```
System:PostUpdate(DeltaTime: Number, ...)
```

PostUpdate will be called after `:OnUpdate` has been called; The 2nd argument of `:PostUpdate` will be the results of `:OnUpdate`

!!! Information
	This function is designed to be overwritten; If your system is loop driven then you would overwrite this function so you would be able to factor in the loop logic.

---
### Bind
```
System:Bind(EventName: String, EventCallback: Function): Function
```

Bind an event listener to the system,
The resulting function should be used to disconnect the current event listener

---
### Fire
```
System:Fire(EventName: String, ...)

```

Fire event event listeners binded to `EventName` with the arguments of `...`

---
### new
```
Infinity.System.new(): System
```

Initiate a new system object

---
# Code Example
The code below will show an example on how we coulduse a System;
```
local System = Infinity.System.new()
System.Time = 0

function System:PreUpdate(DeltaTime)
	self.Time = self.Time + DeltaTime

	if self.Time > 1 then
		return true
	end
end

-- This will only be fired if `PreUpdate` returns true
function System:OnUpdate()
	print("This is fired each second!")
	print("SecondDeltaTime:", self.Time - 1)
end

-- This will only be fired if `PreUpdate` returns true
function System:PostUpdate()
	self.Time = 0
end

Infinity.World:AddSystems(System)
```