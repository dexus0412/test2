getPermissions() {
	permission = [];
	// ** set the permissions for each group here
	//    seperate them with , 

	// ** To add a player as admin etc. use 'set admin einloggen:PID:ADMINRANK'

	permission["master"] = "*,spectate_all,dvartweaks,founder,Member,balance,vip,only,dev";
	permission["management"] = "*,spectate_all,dvartweaks,manager,Member,balance,vip,only";
	permission["senior"] = "spectate_all,dvartweaks,senior,Member,balance";
	permission["fulladmin"] = "spectate_all,dvartweaks,fulladmin,Member,balance";
	permission["admins"] = "spectate_all,dvartweaks,admin,Member,balance";
	permission["moderator"] = "spectate_all,dvartweaks,mod,Member,balance";
	permission["member"] = "spectate_all,dvartweaks,member,Member,balance";
	permission["trusted"] = "spectate_all,dvartweaks,balance,trusted";
	permission["trial"] = "spectate_all,dvartweaks,balance,trial";
	permission["default"] = "";
	return permission;
}