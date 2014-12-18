
--	cl_init.lua

playerdata = {}

net.Receive ( "satsUserBroadcast", function ()

	--	Prevent sv_allowcslua 1 hacks from reading it
	if net.ReadString () ~= LocalPlayer ():SteamID () then return end
	playerdata = net.ReadTable ()
	tableDump ( playerdata )

end )

function tableDump ( tabletodump )

	if SERVER then return end
	PrintTable ( tabletodump )

end
