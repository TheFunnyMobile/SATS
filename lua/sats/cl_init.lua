
--	cl_init.lua

-- ty Kyle my vgui senpai

playerdata = {}

net.Receive ( "satsUserBroadcast", function ()

	
	local strS = string.Explode ( "split", net.ReadString () )
	playerdata = net.ReadTable ()
	
	if strS[1] ~= LocalPlayer ():SteamID () then
		playerdata = {}
		return
	end
	
	DisplayInformation ( playerdata, strS[2], strS[3], strS[4] )

end )

function DisplayInformation ( td, sid, year, month )

	local DermaPanel = vgui.Create ( "DFrame" )
	DermaPanel:SetPos ( 25,25 )
	DermaPanel:SetSize ( 480, 400 )
	DermaPanel:SetTitle ( string.format ( "%s - %s/%s", sid, year, month ) )
	DermaPanel:SetVisible ( true )
	DermaPanel:SetDraggable ( true )
	DermaPanel:ShowCloseButton ( true )
	DermaPanel:MakePopup ()
	
	local DermaListView = vgui.Create ( "DListView" )
	DermaListView:SetParent ( DermaPanel )
	DermaListView:SetPos ( 25, 35 )
	DermaListView:SetSize ( 430, 350 )
	DermaListView:SetMultiSelect ( false )
	DermaListView:AddColumn ( "SteamID" )
	DermaListView:AddColumn ( "Day" )
	DermaListView:AddColumn ( "Minutes" )
	DermaListView:AddColumn ( "Cumulative" )
	
	local cumulative = 0
	
	local function addZero ( value )
	
		if tonumber ( value ) < 10 then
			return "0" .. tostring ( value )
		else
			return tostring ( value )
		end
	
	end
	
	for i=1, 31 do
	
		-- SteamID
		local steamid = sid
		
		-- Day
		local day = i
		
		-- Minutes
		local minutes = td[ string.format ( "y%sm%sd%i", year, addZero ( month ), addZero ( i ) ) ] or "00"

		-- Cumulative
		cumulative = cumulative + tonumber ( minutes )
		
		DermaListView:AddLine ( steamid, day, minutes, cumulative )
		
	end
	
end

