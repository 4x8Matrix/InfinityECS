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

```

???

---
### Query
```

```

???

---
### Service
```

```

???

---
### Component
```

```

???

---
### ComponentBuilder
```

```

???

---
### EntityManager
```

```

???

---
### Archetype
```

```

???

---
### Entity
```

```

???

---
### System
```

```

???

---
### SystemController
```

```

???
# Functions
### GetService
```

```

???

---
### Update
```

```

???

# Code Sample