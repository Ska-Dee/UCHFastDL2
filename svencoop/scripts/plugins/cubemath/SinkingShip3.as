
void PluginInit(){
	g_Module.ScriptInfo.SetAuthor( "CubeMath" );
	g_Module.ScriptInfo.SetContactInfo( "steamcommunity.com/id/CubeMath" );
	
	g_Scheduler.SetInterval( "CheckPlayerSinking", 0.1 );
}

void CheckPlayerSinking(){
	for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ pEntity = g_EntityFuncs.Instance( i );
		
		if( pEntity !is null && pEntity.GetClassname() == "deadplayer") {
			switch(pEntity.pev.movetype){
			case MOVETYPE_TOSS:
				if(pEntity.pev.speed < 10.0){
					pEntity.pev.origin.z += 20.0;
					pEntity.pev.velocity.z -= 128.0;
					pEntity.pev.movetype = 5;
					pEntity.pev.movetype = MOVETYPE_FLY;
				}
				break;
			case MOVETYPE_FLY:
				if(pEntity.pev.speed < 1.0){
					pEntity.pev.velocity = Vector(0,0,0);
					pEntity.pev.avelocity = Vector(0,0,0);
					pEntity.pev.speed = 0.0;
					pEntity.pev.movetype = MOVETYPE_NOCLIP;
				}else{
					pEntity.pev.speed = pEntity.pev.speed * 0.95;
				}
				break;
			}
		}
	}
}
