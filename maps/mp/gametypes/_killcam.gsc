#include maps\mp\gametypes\_hud_util;
init()
{
	precacheString( &"PLATFORM_PRESS_TO_SKIP");
	precacheString( &"PLATFORM_PRESS_TO_RESPAWN");
	precacheShader("white");
	level.killcam = maps\mp\gametypes\_tweakables::getTweakableValue("game", "allowkillcam");
	if (level.killcam) setArchive(true);
}
killcam(attackerNum, killcamentity, sWeapon, predelay, offsetTime, respawn, maxtime, perks, attacker)
{
	self endon("disconnect");
	self endon("spawned");
	level endon("game_ended");
	self setclientdvar("last_killcam", 0);
	if (attackerNum < 0) return;
	if (!respawn) camtime = 5;
	else if (sWeapon == "frag_grenade_mp" || sWeapon == "frag_grenade_short_mp") camtime = 4.5;
	else camtime = 2.5;
	if (isdefined(maxtime))
	{
		if (camtime > maxtime) camtime = maxtime;
		if (camtime < 0.05) camtime = 0.05;
	}
	postdelay = 2;
	killcamlength = camtime + postdelay;
	if (isdefined(maxtime) && killcamlength > maxtime)
	{
		if (maxtime < 2) return;
		if (maxtime - camtime >= 1) postdelay = maxtime - camtime;
		else
		{
			postdelay = 1;
			camtime = maxtime - 1;
		}
		killcamlength = camtime + postdelay;
	}
	killcamoffset = camtime + predelay;
	self notify("begin_killcam", getTime());
	self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.killcamentity = killcamentity;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = offsetTime;
	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", true);
	self allowSpectateTeam("none", true);
	wait 0.05;
	if (self.archivetime <= predelay)
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		return;
	}
	self.killcam = true;
	if (!isdefined(self.kc_skiptext))
	{
		self.kc_skiptext = newClientHudElem(self);
		self.kc_skiptext.archived = false;
		self.kc_skiptext.x = 0;
		self.kc_skiptext.alignX = "center";
		self.kc_skiptext.alignY = "bottom";
		self.kc_skiptext.horzAlign = "center_safearea";
		self.kc_skiptext.vertAlign = "bottom";
		self.kc_skiptext.sort = 1;
		self.kc_skiptext.font = "objective";
		self.kc_skiptext.foreground = true;
		self.kc_skiptext.y = -28;
		self.kc_skiptext.fontscale = 2;
	}
	if (respawn) self.kc_skiptext setText( &"PLATFORM_PRESS_TO_RESPAWN");
	else self.kc_skiptext setText( &"PLATFORM_PRESS_TO_SKIP");
	self.kc_skiptext.alpha = 1;
	if (!isdefined(self.kc_timer))
	{
		self.kc_timer = createFontString( "default", 2.0 );
		self.kc_timer setPoint( "BOTTOM", undefined, 0, -7 );
		self.kc_timer.archived = false;
		self.kc_timer.foreground = true;
	}
	self.kc_timer.alpha = 1;
	self.kc_timer setTenthsTimer(camtime);
	self thread spawnedKillcamCleanup();
	self thread endedKillcamCleanup();
	self thread waitSkipKillcamButton();
	self thread waitKillcamTime();
	self waittill("end_killcam");
	self endKillcam();
	self.sessionstate = "dead";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
}
waitKillcamTime()
{
	self endon("disconnect");
	self endon("end_killcam");
	wait(self.killcamlength - 0.05);
	self notify("end_killcam");
}
waitSkipKillcamButton()
{
	self endon("disconnect");
	self endon("end_killcam");
	while (self useButtonPressed()) wait 0.05;
	while (!(self useButtonPressed())) wait 0.05;
	self notify("end_killcam");
}
endKillcam()
{
	if (isDefined(self.kc_skiptext)) self.kc_skiptext.alpha = 0;
	if (isDefined(self.kc_timer)) self.kc_timer.alpha = 0;
	self.killcam = undefined;
	self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
}
spawnedKillcamCleanup()
{
	self endon("end_killcam");
	self endon("disconnect");
	self waittill("spawned");
	self endKillcam();
}
spectatorKillcamCleanup(attacker)
{
	self endon("end_killcam");
	self endon("disconnect");
	attacker endon("disconnect");
	attacker waittill("begin_killcam", attackerKcStartTime);
	waitTime = max(0, (attackerKcStartTime - self.deathTime) - 50);
	wait waitTime;
	self endKillcam();
}
endedKillcamCleanup()
{
	self endon("end_killcam");
	self endon("disconnect");
	level waittill("game_ended");
	self endKillcam();
}

roundwinningkill(attackerNum, killcamentity, sWeapon, perks, attacker, victim, round)
{
	self endon("disconnect");
	self setclientdvar("last_killcam", 1);
	predelay = 1;		// Time after the Kill
	camtime = 8;		// Full Time for the Cam
	postdelay = 16;		// Time bevore the kill
	killcamlength = 8;
	killcamoffset = camtime + predelay;
	self notify ( "begin_killcam", getTime() );
	
	self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.killcamentity = killcamentity;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = 3;
	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", true);
	self allowSpectateTeam("none", true);
	wait 0.05;
	self.killcam = true;
	
			if(!isDefined(self.top_fk_shader))
			{
				self CreateFKMenu(victim , attacker, round);
			}
			else
			{
				self.fk_title.alpha = 1;
				self.fk_title_low.alpha = 1;
				self.top_fk_shader.alpha = 0.5;
				self.bottom_fk_shader.alpha = 0.5;
				self.credits.alpha = 0.2;
			}
	
	
	self thread waitKillcamTime();
	self waittill("end_killcam");
	self endKillcam();
	self.sessionstate = "dead";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
}
CreateFKMenu( victim , attacker, round)
{

    self.bottom_fk_shader = newClientHudElem(self);
    self.bottom_fk_shader.elemType = "shader";
    self.bottom_fk_shader.y = 368;
    self.bottom_fk_shader.archived = false;
    self.bottom_fk_shader.horzAlign = "fullscreen";
    self.bottom_fk_shader.vertAlign = "fullscreen";
    self.bottom_fk_shader.sort = 0; 
    self.bottom_fk_shader.foreground = true;
    self.bottom_fk_shader.color	= (.15, .15, .15);
    self.bottom_fk_shader setShader("white",640,60);
    
    self.fk_title = newClientHudElem(self);
    self.fk_title.archived = false;
    self.fk_title.y = 45;
    self.fk_title.x = 0;
    self.fk_title.y = -55;
    self.fk_title.alignX = "center";
    self.fk_title.alignY = "bottom";
    self.fk_title.horzAlign = "center_safearea";
    self.fk_title.vertAlign = "bottom";
    self.fk_title.sort = 1; // force to draw after the bars
    self.fk_title.font = "objective";
    self.fk_title.fontscale = 3;
    self.fk_title.foreground = true;
    self.fk_title.shadown = 1;
    
    self.fk_title_low = newClientHudElem(self);
    self.fk_title_low.archived = false;
    self.fk_title_low.x = 0;
    self.fk_title_low.y = -90;
    self.fk_title_low.alignX = "center";
    self.fk_title_low.alignY = "bottom";
    self.fk_title_low.horzAlign = "center_safearea";
    self.fk_title_low.vertAlign = "bottom";
    self.fk_title_low.sort = 1; // force to draw after the bars
    self.fk_title_low.font = "objective";
    self.fk_title_low.fontscale = 1.4;
    self.fk_title_low.foreground = true;
        
    self.fk_title.alpha = 1;
    self.fk_title_low.alpha = 1;
    self.top_fk_shader.alpha = 0.5;
    self.bottom_fk_shader.alpha = 0.5;
	
	
    self.fk_title_low setText(attacker.name + " killed " + victim.name);
    
	if(round == level.roundLimit)
		self.fk_title setText("GAME WINNING KILL");
	else
		self.fk_title setText("ROUND WINNING KILL");
}