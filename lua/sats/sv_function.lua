
--	sv_function.lua

function sats:userAdd ( steamid )

	steamid = string.upper ( steamid )
	local fileTable = {}
	
	if file.Exists ( "sats/__players.txt", "DATA" ) then
	
		fileTable = util.JSONToTable ( file.Read ( "sats/__players.txt", "DATA" ) )
	
	else
	
		file.CreateDir ( "sats" )
	
	end
	
	for _, v in pairs ( fileTable or {} ) do
	
		if v == steamid then
			return
		end
	
	end
	
	table.insert ( fileTable, string.upper ( steamid ) )
	
	local jsonInfo = util.TableToJSON ( fileTable )
	file.Write ( "sats/__players.txt", jsonInfo )

end

function sats:userRemove ( steamid )
	
	steamid = string.upper ( steamid )
	
	if !file.Exists ( "sats/__players.txt", "DATA" ) then
		return
	end
	
	local fileTable = util.JSONToTable ( file.Read ( "sats/__players.txt", "DATA" ) )
	
	for i=1, #fileTable do
		if fileTable[i] == string.upper ( steamid ) then
			table.remove ( fileTable, i )
		end
	end
	
	local jsonInfo = util.TableToJSON ( fileTable )
	file.Write ( "sats/__players.txt", jsonInfo )
	
end

function sats:userCheck ( steamid )
	
	steamid = string.upper ( steamid )
	
	if !file.Exists ( "sats/__players.txt", "DATA" ) then
		return false
	end
	
	local fileTable = util.JSONToTable ( file.Read ( "sats/__players.txt", "DATA" ) )
	
	for i=1, #fileTable do
	
		if fileTable[i] == string.upper ( steamid ) then
			return true
		end
	
	end
	
	return false
	
end

function sats:userUpdate ( steamid, minutes )

	steamid = string.upper ( steamid )
	
	if !sats:userCheck ( steamid ) then
		return
	end
	
	local f = "sats/" .. string.gsub ( steamid, ":", "sc" ) .. ".txt"
	local t = {}
	local cTable = os.date ( "y%Ym%md%d" )
	
	if !file.Exists ( f, "DATA" ) then
	
		t[cTable] = minutes
		file.Write ( f, util.TableToJSON ( t ) )
		
	else
	
		t = util.JSONToTable ( file.Read ( f, "DATA" ) )
		t[cTable] = t[cTable] or 0
		t[cTable] = t[cTable] + minutes
		
		file.Write ( f, util.TableToJSON ( t ) )
	
	end
	
end

function sats:userBroadcast ( ply, steamid, year, month )

	steamid = string.upper ( steamid )
	
	if !sats:userCheck ( steamid ) then
		return
	end
	
	local f = "sats/" .. string.gsub ( steamid, ":", "sc" ) .. ".txt"
	local ttable = util.JSONToTable ( file.Read ( f ) )
	
	net.Start ( "satsUserBroadcast" )
		net.WriteString ( ply:SteamID () .. "split" .. steamid .. "split" .. year .. "split" .. month )
		net.WriteTable ( ttable )
	net.Broadcast ()

end
