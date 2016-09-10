init()
{
	// Enabled
	crazy\_eventmanager::init();
	thread crazy\ninja_serverfile::init();
	thread crazy\_precache::init();
	thread crazy\splash::init();
	thread crazy\cmd::main();
	thread crazy\_dvar::setupDvars();
	//thread crazy\_antiaimbot::init();
	thread crazy\_welcome::init();
    thread crazy\_welcome2::init();
	thread crazy\_antiafk::init();
	//thread crazy\_advertisement::init();
    thread crazy\_advertisement1::init();
	//thread crazy\_srvbrowser::init();
	//thread crazy\_clock::init();
	//thread crazy\_maxfps::init();
	//thread crazy\_serverfull::init();
	//thread crazy\_togglebinds::init();
	thread crazy\_roundmusic::init();
    thread crazy\_health::main();
	if(level.gametype == "sd")
	{
		thread crazy\_walls::main();
	}
	
	// Disabled
	if(level.gametype != "sd")
	{
		thread crazy\fieldorders::init();
		thread crazy\_missions::init();
	}
	// thread crazy\_act::main();
	 thread crazy\bots::addTestClients();
	// thread crazy\_killstreak::init();
	
	thread weather();
	level thread onPlayerConnect();
	
	
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		player thread onDisconnect();
		player thread onPlayerSpawned();
	}
}
onDisconnect()
{
	self waittill("disconnect");
}
onPlayerSpawned()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");
		self setClientDvars( "fx_drawclouds" , 1, "r_drawsun", 1 );
	}
}

weather()
{	
	level._effect[ "rain_heavy_mist" ]	= loadFX( "" );
	level._effect[ "lightning" ]		= loadFX( "" );
	level._effect[ "snow_light" ]	 	= loadFX( "" );
	level._effect[ "snow_wind" ]	 	= loadFX( "" );
	//thread snow();
	//thread rain();
}

snow()
{
	fxObj = spawnFx( level._effect[""], getWeatherOrigin() + (0,0,200) );
	triggerFx( fxObj, -15 );
}
rain()
{
	fxObj = spawnFx( level._effect[""], getWeatherOrigin() + (0,0,200) );
	triggerFx( fxObj, -15 );
	
	fxObjX = spawnFx( level._effect["lightning"], getWeatherOrigin() + (0,0,200) );
	triggerFx( fxObjX, -15 );
}

getWeatherOrigin()
{
	pos = (0,0,0);

	if(level.script == "mp_crossfire")
		pos = (5000, -3000, 0);
	if(level.script == "mp_cluster")
		pos = (-2000, 3500, 0);
	if(level.script == "mp_overgrown")
		pos = (200, -2500, 0);
		
	return pos;
}
	
	