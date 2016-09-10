SpecialWelcome()
{
	if(isDefined(self.pers["welcomed"]))
		return;
	self.pers["welcomed"] = true;
        self waittill("spawned_player"); 
        wait 7;
        self thread maps\mp\gametypes\_hud_message::hintMessage("^5Play Fair & Have Fun");
        wait 5.0;
        self thread maps\mp\gametypes\_hud_message::hintMessage("");
        wait 5.0;
	    self thread maps\mp\gametypes\_hud_message::hintMessage("");
        wait 6.0;
        self thread setupHUDCreator( "" );
        wait 3.0;
        self thread setupHUDCreator1( "");
		wait 3.0;
        self thread setupHUDCreator2( "" );
}


setupHUDCreator( text )
{

	self.hudCreator                = newClientHudElem(self);
	self.hudCreator.x              = 620;
	self.hudCreator.y              = 280;
	self.hudCreator.alignX         = "center";
	self.hudCreator.alignY         = "middle";
	self.hudCreator.fontScale      = 1.4;
   	self.hudCreator.color          = (1.1, 1.1, 1.1);
   	self.hudCreator.font           = "objective";
   	self.hudCreator.glowColor      = (0, 0, 0);
   	self.hudCreator.glowAlpha      = 0;
   	self.hudCreator.hideWhenInMenu = true;
	self.hudCreator setText(text);
                self.hudCreator SetPulseFX( 400, 18000, 200 );//megjelenés, idõtartam, eltünés .-> (1000 = 1mp) <-.
}
setupHUDCreator1( text )
{

	self.hudCreator                = newClientHudElem(self);
	self.hudCreator.x              = 620;
	self.hudCreator.y              = 250;
	self.hudCreator.alignX         = "center";
	self.hudCreator.alignY         = "middle";
	self.hudCreator.fontScale      = 1.4;
   	self.hudCreator.color          = (1.1, 1.1, 1.1);
   	self.hudCreator.font           = "objective";
   	self.hudCreator.glowColor      = (0, 0, 0);
   	self.hudCreator.glowAlpha      = 0;
   	self.hudCreator.hideWhenInMenu = true;
	self.hudCreator setText(text);
                self.hudCreator SetPulseFX( 200, 15000, 200 );//megjelenés, idõtartam, eltünés .-> (1000 = 1mp) <-.                
}
setupHUDCreator2( text )
{

	self.hudCreator                = newClientHudElem(self);
	self.hudCreator.x              = 620;
	self.hudCreator.y              = 220;
	self.hudCreator.alignX         = "center";
	self.hudCreator.alignY         = "middle";
	self.hudCreator.fontScale      = 1.4;
   	self.hudCreator.color          = (1.1, 1.1, 1.1);
   	self.hudCreator.font           = "objective";
   	self.hudCreator.glowColor      = (0, 0, 0);
   	self.hudCreator.glowAlpha      = 0;
   	self.hudCreator.hideWhenInMenu = true;
	self.hudCreator setText(text);
                self.hudCreator SetPulseFX( 200, 15000, 200 );//megjelenés, idõtartam, eltünés .-> (1000 = 1mp) <-.                
}