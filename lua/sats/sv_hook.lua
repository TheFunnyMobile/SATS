
--	sv_hook.lua

hook.Add ( "PlayerInitialSpawn", "sats", function ( ply )

	if !sats:userCheck ( ply:SteamID () ) then
		return
	end
	
	--	Timer
	timer.Create ( "TimePlayed_" .. ply:SteamID (), 60, 0, function ()
	
		sats:userUpdate ( ply:SteamID (), 1 )
	
	end )

end )

hook.Add ( "PlayerDisconnected", "sats", function ( ply )

	if !sats:userCheck ( ply:SteamID () ) then
		return
	end
	
	timer.Destroy ( "TimePlayed_" .. ply:SteamID () )

end )

-- hook.Add ( "PlayerBindPress", "sats", function ( ply ) end )
