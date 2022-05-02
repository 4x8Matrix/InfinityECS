# Service Class
A service is more of a standalone system; It's purpose is to provide you with ways to easily add functions & properties in world systems, for an example; You might want to create a Sound Service to manipulate and handle how sound would occur in your project.

!!! Info
	Using a system as a standalone service is very bad practice, a system is not designed for that usage, however, a service is.

# Functions
### new
```
Infinity.Service.new(Data: { [Any]: Any })
```

Create a new infinity service, the first parameter is used to define what should already be inside of the service; As an example:

```
Infinity.Service.new({ Name = "MyServiceName" })
```
# Code Example
Below is an example on how we might code the structure to play some sounds in our project;

ScriptA: 
```
local SoundService = Infinity.Service.new({ Name = "SoundService" })

function SoundService:PlaySoundFromSource(Source)
	--<...>
end
```

ScriptB:
```
local SoundService = Infinity:GetService("SoundService") -- we could also do: Infinity.SoundService
local function OnDeath()
	SoundService:PlaySoundFromSource("Assets/DeathSoundEffect.mp3")

	--<...>
end
```