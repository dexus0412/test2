init()
{
	if (getDvar("g_gametype") == "sd")
	{
	level.oldName = Getdvar( "sv_original_hostname" );
	while(1)
	{
    	newName = level.oldName + "^5Legion 7 ^2Promod LIVE ^0[ ^2A^0ttack: ^2" +game["teamScores"]["allies"] + " ^0] ^0[ ^2D^0efence: ^2" +game["teamScores"]["axis"] + " ^0] " + "^0[ ^2Round: ^2 " +game["roundsplayed"] + " ^0]";
    	SetDvar( "sv_hostname", newName  );
	wait 1;
	} }



	if (getDvar("g_gametype") == "war")
	{
                level.oldName = Getdvar( "sv_original_hostname" );
	while(1)
	{
	timePassed=(getTime()-level.startTime)/1000/60;
    	newName = level.oldName + "^0[ ^2A^7ttack: ^2" +game["teamScores"]["allies"] + " ^0] ^0[ ^2D^0efence: ^2" +game["teamScores"]["axis"] + " ^0] " + "^0[ ^2T^0ime Left: ^2 " + (getdvarint("scr_war_timelimit") - int(timePassed)) + " ^0]";
    	SetDvar( "sv_hostname", newName  );
	wait 1;
	} }
}
