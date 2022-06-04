There are two supported ways to install InfinityECS, however you can also add Infinity as a Git Submodule for your project.
both of the below methods require you to download the latest [GitHub Releases](https://github.com/4x8Matrix/InfinityECS/releases)

## Studio - rbxm binary
1. Download the latest rbxm binary from releases
2. Insert the rbxm into roblox studio
3. Move the model into a suitable location

## Filesystem - zip archive
1. Download the latest zip Archive from releases
2. Extract the *source* folder from the Zip Archive into your workspace
3. Rename the *source* folder to Infinity

---

## Git - submodule & rojo
CLI Installation:
```
git submodule add https://github.com/4x8Matrix/InfinityECS.git
```

Rojo Configuration:
```
"ReplicatedStorage": {
	...
	
	"InfinityECS": { "$path": "Submodules/InfinityECS/source" },

	...
}
```