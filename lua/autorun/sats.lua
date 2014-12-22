
--	sats.lua

sats = sats or {}

if SERVER then

	AddCSLuaFile ()
	include ( "sats/init.lua" )
	
	MsgN ( "\n-----------------------------------" )
	MsgN ( "-- Snell's Admin Tracking System --" )
	MsgN ( "-----------------------------------\n" )

else
	include ( "sats/cl_init.lua" )
end
