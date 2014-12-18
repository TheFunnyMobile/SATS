
--	sats.lua

sats = sats or {}

if SERVER then

	AddCSLuaFile ()
	include ( "sats/init.lua" )
	
	MsgN ( "-----------------------------------" )
	MsgN ( "-- Snell's Admin Tracking System --" )
	MsgN ( "-----------------------------------" )

else
	include ( "sats/cl_init.lua" )
end
