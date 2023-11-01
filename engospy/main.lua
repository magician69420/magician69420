local Configs = {
	saveCalls = false,
	maxCallsSaved = 1000,
	saveOnlyLastCall = true,
	maxTableDepth = 100,
	minimizeBind = Enum.KeyCode.RightAlt,
	newFunctionMethod = true,
	blacklistedNames = {}
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/magician69420/magician69420/main/engospy/source.lua"))(Configs)