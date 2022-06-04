# Entity Class
An entity is one of the three elements that build the ECS architecture; They are the instances in your project. An entity instance is essentially a collection of components, binding multiple things together in order to create a more complicated object

# Properties
### Name
```
Entity.Name: String
```

The given name of a Entity object

---
### Id
```
Entity.Id: String
```

Short Hexidecimal string used to assign an object a unique string for identification 

---
### Archetype
```
Entity.Archetype: Archetype
```

The archetype profile which matches this entity

---
### Components
```
Entity.Components = { [String]: ComponentObject }
```

Dictionary of all components related to the Entity

!!! Warning
	Never write data to the Components Table; This will cause serve problems when it comes to archetypes and entity components.

# Functions
### Destroy
```
Entity:Destroy()
```

Destroys all components attached to the entity object, then will proceed in removing itself from the programs memory.

---
### FromJSON
```
Entity.FromJSON(string): Entity
```

initiates a new entity object from the json string

---
### ToJSON
```
Entity:ToJSON(): string
```

serialises the entity into a JSON string

---
### Iter
```
Entity:Iter()
```

Iterate through the Entities components

```
for ComponentName, Component in Entity:Iter() do
	print(ComponentName, Component)
end
```

---
### AddComponent
```
Entity:AddComponent(Component)
```

Adds a single component to the entities registry

---
### AddComponents
```
Entity:AddComponents(ComponentA, ComponentB, ...)
```

Adds a multiple components to the entities registry

---
### RemoveComponent
```
Entity:RemoveComponent(ComponentName)
```

Removes a single component from the entities registry

---
### RemoveComponents
```
Entity:RemoveComponents(ComponentAName, ComponentBName, ...)
```

Removes a multiple components from the entities registry

---
### GetComponent
```
Entity:GetComponent(ComponentName)
```

Returns the component with the name `ComponentName`

---
### GetComponentsFromType
```
Entity:GetComponentsFromType(Type: String)
```

Construct an array with all entity components that have the specific type
---
### Extend
```
Entity:Extend()
```

Create a replica entity, however, the child entity will have a Super reference

---
### new
```
Infinity.Entity.new(ComponentsArray: { [Number]: ComponentObject }, Name: String)
```

Initiate a new Entity object

# Code Sample
Below will be an example of a player entity

```
local PlayerObject = Infinity.Entity.new({
	Infinity.Component.new("SuperCoolName", "PlayerName")
})
```