Main() 
{
	thread Rules();
}

Rules()
{
level endon("disconnect");

	if( isDefined( level.logoText ) )
		level.logoText destroy();

	level.logoText = newHudElem();
	level.logoText.y = 12;
	level.logoText.alignX = "center";
	level.logoText.alignY = "middle";
	level.logoText.horzAlign = "center_safearea";

	level.logoText.alpha = 0;
	level.logoText.sort = -3;
	level.logoText.fontScale = 1.8;
	level.logoText.archieved = true;

	for(;;)
	{
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^0Follow The Rules");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("^3Have Fun!");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText("");
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
	}
}