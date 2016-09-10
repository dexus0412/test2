registerPostRoundEvent( eventFunc )
{
	if ( !isDefined( level.postRoundEvents ) )
		level.postRoundEvents = [];
	
	level.postRoundEvents[level.postRoundEvents.size] = eventFunc;
}

executePostRoundEvents()
{
	if ( !isDefined( level.postRoundEvents ) )
		return;
		
	for ( i = 0 ; i < level.postRoundEvents.size ; i++ )
	{
		[[level.postRoundEvents[i]]]();
	}
}
getKillcamWatch( attacker, eInflictor )
{
	if ( !isDefined( eInflictor ) )
		return attacker getEntityNumber();

	if ( eInflictor == attacker )
		return attacker getEntityNumber();
	
	if ( isDefined(eInflictor.killCamEnt) )
	{
		if ( eInflictor.killCamEnt == attacker )
			return attacker getEntityNumber();
			
		return self getEntityNumber();
	}
	
	if ( isDefined( eInflictor.script_gameobjectname ) && eInflictor.script_gameobjectname == "bombzone" )
		return self getEntityNumber();

	return self getEntityNumber();
}
resetOutcomeForAllPlayers()
{
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		player notify ( "reset_outcome" );
	}
}
isOneRound()
{		
	if ( level.roundLimit == 1 )
		return true;
	return false;
}