
--	ulx_sats.lua

CATEGORY_NAME = "SATS"

--	Add SteamID To List
function ulx.satsAdd ( calling_ply, steamid )

	if !sats:userCheck ( steamid ) then
		sats:userAdd ( steamid )
	else
		ULib.tsayError( calling_ply, "Allreaddy being watched" )
		return
	end
	
	ulx.fancyLogAdmin ( calling_ply, true, "#A added #s to the tracking list", steamid )

end

local satsAdd = ulx.command ( CATEGORY_NAME, "ulx awatch", ulx.satsAdd, "!watch", true )
satsAdd:addParam { type = ULib.cmds.StringArg, hint="STEAM_" }
satsAdd:defaultAccess ( ULib.ACCESS_SUPERADMIN )
satsAdd:help ( "Add's a SteamID to the tracking list" )

--	Removes SteamIDs from List
function ulx.satsRemove ( calling_ply, steamid )

	if sats:userCheck ( steamid ) then
		sats:userRemove ( steamid )
	else
		ULib.tsayError( calling_ply, "Not being watched" )
		return
	end
	
	ulx.fancyLogAdmin ( calling_ply, true, "#A removed #s from the tracking list", steamid )

end

local satsRemove = ulx.command ( CATEGORY_NAME, "ulx aunwatch", ulx.satsRemove, "!unwatch", true )
satsRemove:addParam { type = ULib.cmds.StringArg, hint="STEAM_" }
satsRemove:defaultAccess ( ULib.ACCESS_SUPERADMIN )
satsRemove:help ( "Add's a SteamID to the tracking list" )

--	Fetch Information
function ulx.satsFetch ( calling_ply, steamid, year, month )

	if !IsValid ( calling_ply ) then
		return
	end
	
	sats:userBroadcast ( calling_ply, steamid, year, month )
	
	ulx.fancyLogAdmin ( calling_ply, true, "#A is viewing #s's information for (#s/#s)", steamid, year, month )
	
end

local satsFetch = ulx.command ( CATEGORY_NAME, "ulx afetch", ulx.satsFetch, "!fetch", true )
satsFetch:addParam { type = ULib.cmds.StringArg, hint="STEAM_" }
satsFetch:addParam { type = ULib.cmds.StringArg, hint="YEAR (XXXX)" }
satsFetch:addParam { type = ULib.cmds.StringArg, hint="MONTH (MM)" }
satsFetch:defaultAccess ( ULib.ACCESS_SUPERADMIN )
satsFetch:help ( "Print Information to Console" )
