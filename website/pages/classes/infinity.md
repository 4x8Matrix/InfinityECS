# Infinity Class
Infinity is the base class which ties together the different objects which make up the ECS architecture, to essentially put it simple; This is going to be the direct point of access for what Infinity has to offer.

!!! Info
	In the case of roblox, we have to make some slight changes to the initialization pipeline in order to maintain performance & simplicity. When ran inside of a roblox environment, things which you would have to implement yourself are no longer needed, this is what we do;

	- Initiate a world object; re-define `World` in infinity to be this newly created world object. (In roblox, you never seem to have more than one world.)
	- Initiate a RenderStepped or Stepped loop to call `Infinity:Update()`

# Properties
### IsRoblox
```
Infinity.IsRoblox: Boolean
```

True if the scripts environment is running under a roblox game instance

---
### Script
```
Infinity.Script: userdata | nil
```

If `Infinity.IsRoblox` is active then `Infinity.Script` will be a reference to the roblox script instance

---
### IsServer
```
Infinity.IsServer: Boolean | nil
```

If `Infinity.IsRoblox` is active then `Infinity.IsServer` then this will define if the framework is ran on the server or client.

# Classes
### World
```
Infinity.World: World
```

Reference to the Infinity World Object

---
### Query
```
Infinity.Query: Query
```

Reference to the Infinity Query Object

---
### Service
```
Infinity.Service: Service
```

Reference to the Infinity Service Object

---
### Component
```
Infinity.Component: Component
```

Reference to the Infinity Component Object

---
### ComponentBuilder
```
Infinity.ComponentBuilder: ComponentBuilder
```

Reference to the Infinity ComponentBuilder Object

---
### EntityManager
```
Infinity.EntityManager: EntityManager
```

Reference to the Infinity EntityManager Object

---
### Archetype
```
Infinity.Archetype: EntityArchetype
```

Reference to the Infinity EntityArchetype Object

---
### Entity
```
Infinity.Entity: Entity
```

Reference to the Infinity Entity Object

---
### System
```
Infinity.System: System
```

Reference to the Infinity System Object

---
### SystemController
```
Infinity.SystemController: SystemController
```

Reference to the Infinity SystemController Object
# Functions
### GetService
```
Infinity:GetService(ServiceName: String)
```

Attempt to grab either an Infinity Service or Roblox Service through it's ServiceName

---
### Update
```
Infinity:Update(DeltaTime: Number)
```

Update the internal InfinityClock, this should only be called when Infinity is not being ran under a roblox environment; 
It is recomended to call the `Update` function each render, heartbeat or step inside of your program. 

# Code Sample
Below is a demo on how Love could run Infinity
```
local Infinity = require(".../Infinity")

function love.draw()
	Infinity:Update()
end
```