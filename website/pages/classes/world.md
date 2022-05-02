# World Class
The world class is essentially a container for all systems, entities and components, the world class will push events, handle system clocks and manage the environment of your project. 
Imagine the world being a space, inside this space will be your systems & entities which work hand-in-hand together in order to achieve something.

Another way of looking at a world, would be a Unity Scene, it allows you to store a package inside of one container, this container can then be manipulated in the future.

!!! Info 
	If roblox is the environment the framework is being ran in, then the World class will be constructed during runtime of the Infinity Module.
	For more information please visit `Classes` -> `Infinity`

# Properties
### Name
```
World.Name: String
```

The given name of a World object

---
### Id
```
World.Id: String
```

Short Hexidecimal string used to assign an object a unique string for identification 

# Functions
### AddEntities
```
World:AddEntities(EntityA: EntityObject, EntityB: EntityObject, ...)
```

Add a list of Entities into the world registry

---
### AddSystems
```
World:AddSystems(SystemA: SystemObject, SystemB: SystemObject, ...)
```

Add a list of Systems into the world registry

---
### GetEntitiesFromArchetype
```
World:GetEntitiesFromArchetype(Archetype: ArchetypeObject): { [Number]: EntityObject }
```

Returns a collection of entity object which match the archetype specified

---
### GetEntitiesFromComponents
```
World:GetEntitiesFromComponents(ComponentA: ComponentObject, ComponentB: ComponentObject): { [Number]: EntityObject }
```

Returns a collection of entity object which match the components specified

---
### GetEntitiesFromName
```
World:GetEntitiesFromName(Name: String): { [Number]: EntityObject }
```

Returns a collection of entity object which match the name specified

---
### SetState
```
World:SetState(State: Boolean)
```

Set the world state to active/inactive; When the world is inactive, all of the worlds systems, entities and components become idle.

---
### Push
```
World:Push(EventName: String, ...)
```

Push an event to all systems binded to the world

---
### Update
```
World:Update(DeltaTime: Number)
```

Update all systems binded to the world

---
### Destroy
```
World:Destroy()
```

Destroy all systems, entities and components. Then remove itself from the programs memory

---
### new
```
Infinity.World.new(Entities: { [Number]: EntityObject }, Name: String)
```

Initiate a new world object

!!! Warning
	If Infinity is being ran on a roblox environment, `Infinity.World` will be a WorldObject, it is not advised to create a new world object over the default world which will automaically be created.

# Code Sample
In the below example, we create one player and three bad guys inside of the same world.
```
local WorldObject = Infinity.World.new({
	Infinity.Entity.new({
		Infinity.Component.new("SuperCoolName", "ObjectName")
	}, "Player"),

	Infinity.Entity.new({
		Infinity.Component.new("SuperCoolName", "ObjectName")
	}, "BadGuy"),
	Infinity.Entity.new({
		Infinity.Component.new("SuperCoolName", "ObjectName")
	}, "BadGuy"),
	Infinity.Entity.new({
		Infinity.Component.new("SuperCoolName", "ObjectName")
	}, "BadGuy")
})
```

What our systems should do is then add logic to these entities and components; For example a System would collect all entities with the name "Player" and have it take 5 HP from all bad guys.