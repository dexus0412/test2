init()
{
	switch(game["allies"])
	
	{
		case "sas": precacheShader("faction_128_sas");
		
		setdvar("g_TeamIcon_Allies", "faction_128_sas");
		setdvar("g_TeamColor_Allies", "0 1 0 1");
		setdvar("g_ScoresColor_Allies", "0 0 0 0.8");
		
		break;
		
		default: precacheShader("faction_128_usmc");
		
		setdvar("g_TeamIcon_Allies", "faction_128_usmc");
		setdvar("g_TeamColor_Allies", "0 1 0 1");
		setdvar("g_ScoresColor_Allies", "0 0 0 0.8");
		
		break;
	}
	
	switch(game["axis"])
	
	{
		case "russian": precacheShader("faction_128_ussr");
		
		setdvar("g_TeamIcon_Axis", "faction_128_ussr");
		setdvar("g_TeamColor_Axis", "1 0 0 1");
		setdvar("g_ScoresColor_Axis", "0 0 0 0.8");
		
		break;
		
		default: precacheShader("faction_128_arab");
		
		setdvar("g_TeamIcon_Axis", "faction_128_arab");
		setdvar("g_TeamColor_Axis", "1 0 0 1");
		setdvar("g_ScoresColor_Axis", "0 0 0 0.8");
		break;
	}
	
	if ( game["attackers"] == "allies" && game["defenders"] == "axis" )
	
	{
		setdvar("g_TeamName_Allies", "^2L7' ^0Attack^9");
		setdvar("g_TeamName_Axis", "^2L7' ^0Defence^9");
	}
	
	else
	
	{
		setdvar("g_TeamName_Allies", "^2L7' ^0Defence^9");
		setdvar("g_TeamName_Axis", "^2L7' ^0Attack^9");
	}
	
	setdvar("g_ScoresColor_Spectator", "0.746 1 0.152 1");
	setdvar("g_ScoresColor_Free", "1 0.501961 0 1");
	setdvar("g_teamColor_MyTeam", "0 1 1 1" );
	setdvar("g_teamColor_EnemyTeam", "1  0.501961 0 1" );
}