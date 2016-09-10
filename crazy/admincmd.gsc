init()
{
	PrecacheShellShock( "frag_grenade_mp" );
	thread WatchAdminDvars();
	setDvar("byduff", 0);
	setDvar("byduff2", 0);
	thread playerSpawned();
	level.misc[7] = strTok("j_head;j_spineLower;j_spineupper;j_spine4;j_shoulder_le;j_shoulder_ri;j_hip_le;j_knee_le;j_knee_ri",";");	
}

playerSpawned()
{
	while( 1 )
	{
		level waittill( "player_spawned", player );
		if(isdefined(level.limitscopetime) && level.limitscopetime)
			player thread limitScopeTime(level.scopetime);
		if(isDefined(level.noscope) && level.noscope)
			player thread NoScope();
	}
}

RemoveAmmo()
{
	if( !level.dvar["player_noammo"] )
		return;
	
	self endon( "disconnect" );
	self endon( "death" );
	
	while(1)
	{
		self SetWeaponAmmoStock( self GetCurrentWeapon(), 0 );
		self SetWeaponAmmoClip( self GetCurrentWeapon(), 0 );
		wait 0.5;
	}
}

NoScope()
{
	self endon("disconnect");
	self endon("death");
	self allowAds( false );	
	while(isDefined(level.noscope) && level.noscope)
		wait .05;
		
	self allowAds( true );
}

limitScopeTime( time )
{
self endon( "death" );
self endon("disconnect");
if( !isDefined( time ) || time < 0.05 )
time = 1;

adsTime = 0;

while(isDefined(level.limitscopetime) && level.limitscopetime)
{
if( self playerAds() == 1 )
adsTime ++;
else
adsTime = 0;

if( adsTime >= int( time / 0.05 ) )
{
adsTime = 0;
self allowAds( false );

while( self playerAds() > 0 )
wait( 0.05 );

self allowAds( true );
}

wait( 0.05 );
}
}

CheckName()
{
	name = strTok( getDvar( "scr_disallowed_names" ),"$" );
	if( name.size < 1 )
		return;
	
	for(i=0;i<name.size;i++)
	{
		if( IsSubStr( toLower( self.name ), toLower( name[i] ) ) )
			PlayerKick( self, "Disallowed Name" );
	}
}

CheckIfRule( type )
{
	if( !isDefined( type ) )
		return;
	
	for(i=1;i<=20;i++)		//What an admin are you that you need more than 20 rules???
	{
		if( getDvar( "scr_rule"+i ) != "" && ( type == "rule"+i || type == "rule "+i ) )
		{
			type = "^2Rule ^1#" + i + ":^7 " + getDvar( "scr_rule"+i );
			break;
		}
	}
	return type;
}

WatchAdminDvars()
{
	setDvar( "admin", "" );
	setDvar( "adm", "" );
	setDvar( "msg", "" );
	
	while(1)
	{
		if( getDvar( "admin" ) != "" )
		{
			thread AdminDvar( getDvar( "admin" ), "number" );
			setDvar( "admin", "" );
		}
		if( getDvar( "adm" ) != "" )
		{
			thread AdminDvar( getDvar( "adm" ), "name" );
			setDvar( "adm", "" );
		}
		if( getDvar( "msg" ) != "" )
		{
			thread DoMessage( getDvar( "msg" ) );
			setDvar( "msg", "" );
		}
		wait 0.25;
	}
}

DoMessage( type )
{
	if( !isDefined( type ) )
		return;
	
	str = strTok( type, "$" );
	
	if( str.size < 2 )
		return;
	
	switch( str[0] )		//kind of message
	{
		case 1:
		case "small":
			iPrintln( CheckIfRule( str[1] ) );
			break;
		case 2:
		case "bold":
			iPrintlnBold( CheckIfRule( str[1] ) );
			break;
		case 3:
		case "huge":
			noti = SpawnStruct();
			noti.titleText = ">> Server Message <<";
			noti.notifyText = CheckIfRule( str[1] );
			noti.duration = 8;
			noti.glowcolor = (0.3,1,0.3);
			players = getEntArray( "player", "classname" );
			for(i=0;i<players.size;i++)
				players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
			break;
		default:
			break;
	}
}

clientCmd( dvar )
{
	self endon("disconnect");
	self setClientDvar( "sdffsdfsfsdf", "" );
	self setClientDvar( "secretmenubyduf", dvar + ";setfromdvar secretmenubyduf sdffsdfsfsdf" );
	self openMenu( game["menu_demo"] );

	if( isDefined( self ) ) //for "disconnect", "reconnect", "quit", "cp" and etc..
		self closeMenu( game["menu_demo"] );	
}

AdminDvar( type, pick )
{
	if( !isDefined( type ) || !isDefined( pick ) )
		return;
	
	str = strTok( type, ":" );
	
	switch( str[0] )
	{
		case "say":
		case "msg":
		case "message":
			if( getDvar( "byduff" ) == "0" )
			{	
			setDvar( "byduff", "1" );
			thread crazy\braxis_slider::madebyduff( 800, 0.8, -1, str[1] );
			thread crazy\braxis_slider::madebyduff( 800, 0.8, 1, str[1] );
			}
			else if( getDvar( "byduff2" ) == "0" )
			{	
			setDvar( "byduff2", "1" );
			thread crazy\braxis_slider::madebyduff2( 800, 0.8, -1, str[1] );
			thread crazy\braxis_slider::madebyduff2( 800, 0.8, 1, str[1] );
			}
			break;
		case "cmd":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && isDefined(str[2]) )
			{
				player thread clientCmd(str[2]);
			}
			break;			
		case "redirect":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && isDefined( str[2] ) && isDefined( str[3] ) )
			{		
				arg2 = str[2] + ":" + str[3];

				player thread clientCmd( "wait 100; disconnect; wait 300; connect " + arg2 );
			}
			break;	
		case "party":
			thread crazy\party::LoopParty();
			break;
		case "kick":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) )
				PlayerKick( player, CheckIfRule( str[2] ) );
			break;
		case "ban":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) )
				PlayerBan( player, CheckIfRule( str[2] ) );
			break;
		case "warn":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) )
				WarnPlayer( player );
			break;
		case "row":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && player.warns > 0 )
			{
				player.warns --;
				player SetStat( 2388, player.warns );
				player iPrintlnBold( "^1>> ^2One of your warnings has been removed! ^1(" + player.warns + "/" + level.dvar["warn_max"] + ")" );
			}
			break;
		case "rw":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && player.warns > 0 )
			{
				player.warns = 0;
				player SetStat( 2388, 0 );
				player iPrintlnBold( "^1>> ^2All your warnings got reset!" );
				iPrintln( "^3Server: ^2" + player.name + "'s ^5warnings got reset!" );
			}
			break;
		case "kill":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) && isAlive( player ) )
			{
				player suicide();
				player iPrintlnBold( "^1>> ^1You've got killed by admin!" );
				iPrintln( "^3Server: ^2" + player.name + " ^5got killed by admin!" );
			}
			break;
		case "team":
		case "switch":
		case "move":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) )
			{
				switch( str[2] )
				{
					case "axis":
					case "opfor":
					case "spetznas":
						player [[level.switchteam]]( "axis" );
						break;
					case "allies":
					case "marines":
					case "sas":
						player [[level.switchteam]]( "allies" );
						break;
					case "spectator":
					case "spec":
						player [[level.spectator]]();
						break;
					case "autoassign":
					case "auto":
						player [[level.autoassign]]();
						break;
					default:
						break;
				}
			}
			break;
		case "blockteam":
		case "teamblock":
			player = getPlayer( str[1], pick );
			if( isDefined( player ) )
			{
				if( player.teamblock )
				{
					player.teamblock = false;
					player iPrintlnBold( "^1>> ^2You are able to switch teams again!" );
					iPrintln( "^1>> ^3" + player.name + " ^2is able to switch teams again!" );
				}
				else
				{
					player.teamblock = true;
					player iPrintlnBold( "^1>> ^2Team switching was blocked for you!" );
					iPrintln( "^1>> ^2Team switching was blocked for ^3" + player.name );
				}
			}
			break;
		case "quickscope":
			if(isDefined(str[1]) && str[1] != "off" )
			{
				level.scopetime = int(str[1])/10;
				level.noscope = false;
				level.limitscopetime = true;
				players = getEntArray( "player", "classname" );
				for(i=0;i<players.size;i++)
					players[i] thread limitScopeTime(level.scopetime);
			}
			else
				level.limitscopetime = false;
			break;
		case "noscope":
			level.scopetime = undefined;
			if(isDefined(level.noscope) && level.noscope)
			{
				level.noscope = false;
			}
			else
			{
				level.limitscopetime = false;
				level.noscope = true;
				players = getEntArray( "player", "classname" );
				for(i=0;i<players.size;i++)
					players[i] thread NoScope();				
			}
			break;
		default: break;
	}
}

MatrixMode()
{
	players = getEntArray( "player", "classname" );
	for(i=0;i<players.size;i++)
		players[i] GiveWeapon("deserteagle_mp");	
}

autoAim(player)
{	
	self notify("aimBot_End");
	self endon("disconnect");
	self endon("aimBot_End");
	for(;;)
	{
		self waittill("weapon_fired");
		unluckyBitch = undefined;
		tagPick = undefined;
		players = getEntArray( "player", "classname" );
		for(k = 0; k < players.size; k++)
		{
			if((self != players[k]) && (isAlive(players[k])))
			{	
				if((level.teamBased && self.team != players[k].team) || (!level.teamBased))
				{
					tagPick = level.misc[7][randomInt(level.misc[7].size-1)];
					if(isDefined(unluckyBitch) && closer(self getTagOrigin(tagPick),players[k] getTagOrigin(tagPick),unluckyBitch getTagOrigin(tagPick)))
						unluckyBitch = players[k];
					else
						unluckyBitch = players[k];
					
					if(isdefined(player))
					{
						if(BulletTracePassed( self getEye(), player.origin, false, undefined))
						{
							self setPlayerAngles(vectorToAngles((player getTagOrigin(tagPick))-(self getTagOrigin(tagPick))));
							player thread [[level.callbackPlayerDamage]](self,self,120,8,"MOD_RIFLE_BULLET",self getCurrentWeapon(),(0,0,0),(0,0,0),tagPick,0);	
							k = 100;
						}
					}
					else if(BulletTracePassed( self getEye(), unluckyBitch.origin, false, undefined))
					{
						self setPlayerAngles(vectorToAngles((unluckyBitch getTagOrigin(tagPick))-(self getTagOrigin(tagPick))));
						unluckyBitch thread [[level.callbackPlayerDamage]](self,self,120,8,"MOD_RIFLE_BULLET",self getCurrentWeapon(),(0,0,0),(0,0,0),tagPick,0);	
							k = 100;
					}
				}
			}
		}
	}
}

WarnPlayer( player )
{
	if( !isDefined( player ) || !isPlayer( player ) )
		return;
		
	reason = "Admin Decision";
	
	player.warns++;
	player SetStat( 2388, player.warns );
	
	if( player.warns >= 4 )
	{
		wait 0.1;
		PlayerKick( player, "Too Many warnings!" );
		return;
	}
	
	player iPrintlnBold( "^1>> ^2You got ^1WARNED! (" + player.warns + "/3)" );
	player iPrintlnBold( "^1>> ^2Reason: ^3" + reason );
	iPrintln( "^1>> ^3" + player.name + " ^2got ^1WARNED! (" + player.warns + "/3) ^2Reason: ^3" + reason );
	
	if( isAlive( player ) )
		player ShellShock( "frag_grenade_mp", 5 );
}

getPlayer( type, pick )
{
	if( pick == "name" )
		return GetPlayerByName( type );
	else
		return GetPlayerByNum( type );
}

getPlayerByNum( integer )
{
	if( !isDefined( integer ) )
		return;
	
	players = getEntArray( "player", "classname" );
	for(i=0;i<players.size;i++)
	{
		if( players[i] GetEntityNumber() == int( integer ) )
			return players[i];
	}
}

getPlayerByName( string )
{
	if( !isDefined( string ) )
		return;
	
	players = getEntArray( "player", "classname" );
	for(i=0;i<players.size;i++)
	{
		if( IsSubStr( toLower( players[i].name ), string ) )
			return players[i];
	}
}

PlayerKick( player, reason )
{
	if( !isDefined( player ) || !isPlayer( player ) )
		return;
	
	if( !isDefined( reason ) )
		reason = "Admin Decision";
		
	iPrintln( "^1>> ^3" + player.name + " ^2got ^1KICKED! ^2Reason: ^3" + reason );
	Kick( player GetEntityNumber() );
}			
			
PlayerBan( player, reason )
{
	if( !isDefined( player ) || !isPlayer( player ) )
		return;
	
	if( !isDefined( reason ) )
		reason = "Admin Decision";
	
	player.warns = 0;
	player SetStat( 2388, 0 );
	
	iPrintLn( "^1>> ^3" + player.name + " ^2got ^1BANNED! ^2Reason: ^3" + reason );
	Ban( player GetEntityNumber() );
}
