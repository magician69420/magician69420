local Configs = {
	saveCalls = false,
	maxCallsSaved = 1000,
	saveOnlyLastCall = true,
	maxTableDepth = 100,
	minimizeBind = Enum.KeyCode.RightAlt,
	newFunctionMethod = true,
	blacklistedNames = {}
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/magican69420/magican69420/main/engospy/source.lua"))(Configs)