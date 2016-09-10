//Script borrowed from CoDJumper blocker script.
init()
{

	level.anticamptime = getDvar("scr_anticamptime");
	setDvar("scr_anticamptime", "30");
	level.anticamptime = getDvarInt("scr_anticamptime");

	level.anticampdist = getDvar("scr_anticampdist");
	setDvar("scr_anticampdist", "30");

	self endon( "death" );
	self endon( "disconnect" );
	self endon( "game_ended" );

	self iprintln("^1Anticamp Van!!!!");

	self.count = 0;
	self.warned = 0;

while(isPlayer(self) && self.sessionstate=="playing" && isAlive(self)) //&& self.pers["team"] == "allies" || self.pers["team"] == "axis")
{
	// Calculate current speed
	self.oldpos = self.origin;
	wait 1;
	self.newpos = self.origin;
	self.speed = distance(self.oldpos,self.newpos);

	if (self.speed < getDvarInt("scr_anticampdist")) // Default 200
	{
		self.camp = 1;
		self.camper = 0;
	}
	else
	{
		self.camp = 0;
		self.warned = 0;
		if(self.camper == 1) // havnt done anything wrong continue on.
			{
				self.camper = 0;
			}
	}
		
	if(self.camper == 0)
	{
		// Check for campers
		if(self.camp == 1) 
		{
			self.count++;
		}
		else
		{
			self.count = 0;
		}
		
		if(self.count>=level.anticamptime - 15)
		{
			if(self.warned == 0) //&& self.pers["team"] == "allies" || self.pers["team"] == "axis")
			{
				notifyData = spawnStruct();
				notifyData.titleText = " ^1C .A .M .P .E .R";
				notifyData.notifyText = "^2" + (self.name);
				notifyData.notifyText2 = "^1You have ^215 ^1seconds to ^3Move!";
				notifyData.glowColor = (0, 0, 1);
				notifyData.sound = "camper";
				notifyData.duration = 13;
			
				maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
				iprintln(self.name, " ^3Camper!");

				/*self iprintlnBold("^1You are ^3Camper!");
				iprintln(self.name, " ^3Camper!");
				self playLocalSound("camper");		
				self iprintlnBold("^1You have ^215 ^1seconds to ^3Move!");*/
				self.warned = 1;
			}
		}
				
		if(self.count>=level.anticamptime)
		{
			while(isPlayer(self) && self.sessionstate=="playing")
			//if(self.pers["team"] == "allies" || self.pers["team"] == "axis")
			{
				self.camper = 1;
				/*notifyData = spawnStruct();
				notifyData.titleText = "^2" + (self.name);
				notifyData.notifyText = "^1You were ^3Killed ^1for ^3Camping!";
				notifyData.glowColor = (0, 0, 1);
				notifyData.sound = "crybaby";
				notifyData.duration = 13;
			
				maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
				iprintln(self.name, " ^3Camper!");
				iprintln(self.name, " ^1was ^3Killed ^1for ^3Camping.");
				self playLocalSound("crybaby");

				self iprintlnBold("^1You were ^3Killed ^1for ^3Camping.");
				self playLocalSound("crybaby");

				iprintln(self.name, " ^1was ^3Killed ^1for ^3Camping.");
				self playLocalSound("crybaby");*/

				self suicide();
				self.count = 0;
			}
				//thread init();

		}
	}
}
}