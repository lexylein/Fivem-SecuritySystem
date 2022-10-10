Citizen.CreateThread( function()
updatePath = "/NoroLexStudio/Fivem-SecuritySystem" -- your git user/repo path
resourceName = "^1[security_system_scripts] ^0("..GetCurrentResourceName()..")" -- the resource name

function checkVersion(err,responseText, headers)
	curVersion = LoadResourceFile(GetCurrentResourceName(), "version") -- make sure the "version" file actually exists in your resource root!

	if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
		print("\n^3—————————————————————————————————| Attention |————————————————————————————————")
		print("\n"..resourceName.." is outdated. \nNewest Version: "..responseText.."\nYour Version: "..curVersion.."\nplease update it from https://github.com"..updatePath.."")
		print("\n^3—————————————————————————————————| Attention |————————————————————————————————\n^0")
	elseif tonumber(curVersion) > tonumber(responseText) then
		print("You somehow skipped a few versions of "..resourceName.." or the git went offline, if it's still online i advise you to update ( or downgrade? )")
	else
		print("\n"..resourceName.." is up to date, have fun! \n")
	end
	
end

PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version", checkVersion, "GET")
end)
