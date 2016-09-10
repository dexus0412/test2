init()
{


		if( !isDefined( self.pers["saywelcome"] ) )
		{
			self.pers["saywelcome"] = true;
			//self thread msg( 800, 1, -1, "Welcome " + self.name );
			//self thread msg( 800, 1, 1, "Welcome " + self.name );
		
			self thread crazy\braxis_slider::madebyduff( 800, 1, -1, "^3Bienvenido ^0" + self.name + "^7!");
			self thread crazy\braxis_slider::madebyduff( 800, 1, 1, "^3Bienvenido ^0" + self.name + "^7!");
		

		}	


}

