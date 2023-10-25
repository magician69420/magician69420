print("HttpSpy Loaded!")
local plr = game:GetService("Players").LocalPlayer
local old;
old = hookfunction(request, newcclosure(function(newreq)
	if newreq.Url:find("discord") or newreq.Url:find("webhook") then
		print(newreq.Url)
		print("\n")
		print(newreq.Url)
		setclipboard(newreq.Url)
		warn("Blocked webhook!")
		return
	end
	return old(newreq)
end))


local old;
old = hookfunction(game.HttpGet, newcclosure(function(olgame, url)
	if url:find("pastebin") then
		url = url:gsub("pastebin","pastebinp")
	elseif url:find("process") then
		warn(url)
	end
	print(url)
	setclipboard(url)
	print(url)
	print("\n")
	return old(olgame, url)
end))

setreadonly(getrawmetatable(game), false)

local mt = getrawmetatable(game) or getmetatable(game)
local __oldnamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
	local args = {...}
	local namecallmethod = getnamecallmethod()
	
	if self == plr and string.lower(namecallmethod) == "kick" or namecallmethod == "Kick" then
		warn("the script trying to kick you")
		wait(math.huge)
		return nil
 	end
 	return __oldnamecall(self, unpack(args))
end)

setreadonly(getrawmetatable(game), true)