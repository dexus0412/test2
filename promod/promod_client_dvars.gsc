main()
{
	self setClientDvars( 	"aim_automelee_enabled", 0,
							"aim_automelee_range", 0,
							"dynent_active", 0,
							"snaps", 30,
							"rate", 25000,
							"cl_maxpackets", 100,
							"cg_nopredict", 0 );

	self setClientDvars(	"sm_enable", 0,
							"r_dlightLimit", 0,
							"r_lodscalerigid", 1,
							"r_lodscaleskinned", 1,
							"cg_drawcrosshairnames", 0,
							"cg_viewzsmoothingmin", 1,
							"cg_viewzsmoothingmax", 16,
							"cg_viewzsmoothingtime", 0.1,
							"cg_huddamageiconheight", 64,
							"cg_huddamageiconwidth", 128,
							"r_filmtweakInvert", 0 );

	self setClientDvars(	"r_zfeather", 0,
							"r_smc_enable", 0,
							"r_distortion", 0,
							"r_desaturation", 0,
							"r_specularcolorscale", 0,
							"fx_drawclouds", 0,
							"r_fog", 0 );

	wait .05;

	if ( isDefined( self ) )
		self thread promod\config::main();
}