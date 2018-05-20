
/**
*	Sets the Limit of the dead Bodies per Player.
*/
uint limit_bodies_per_player = 3;

final class PlayerData {
	/**
	*	Player dead bodies.
	*/
	array<CBaseEntity@> m_bodies;
	
	/**
	*	Player was Alive?
	*/
	bool m_flLastIsAlive = false;
	
	PlayerData(){
		m_flLastIsAlive = false;
	}
}

array<PlayerData@> g_PlayerData;

class cycler2 : ScriptBaseAnimating {
	bool KeyValue( const string& in szKey, const string& in szValue ) {
		return BaseClass.KeyValue( szKey, szValue );
	}
	
	void Precache() {
		BaseClass.Precache();
		// g_Game.PrecacheModel( self.pev.model );
	}
	
	void Spawn() {
		self.Precache();
		
		g_EntityFuncs.SetModel( self, self.pev.model );
		g_EntityFuncs.SetOrigin( self, self.pev.origin );
		
		self.InitBoneControllers();
		
		self.pev.solid = SOLID_NOT;
		self.pev.movetype = MOVETYPE_NONE;
		self.pev.framerate = 1.0f;
		self.pev.health = 80000; // no cycler should die
		self.pev.rendermode = 0;
		self.pev.renderamt = 255.0f;
		
		self.pev.nextthink += 0.1;
		
		self.ResetSequenceInfo();
		
		SetThink( ThinkFunction( Think2 ) );
	}
	
	void Think2(){
		if(self.pev.rendermode == 2){
			self.pev.renderamt -= 1.0f;
			if(self.pev.renderamt < 1.0f){
				g_EntityFuncs.Remove( self );
			}
		}
		self.pev.nextthink += 0.1;
	}
}

void pvpBodiesThink(){
	CBasePlayer@ pPlayer = null;
	
	for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer ){
		@pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );
	   
		if( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		PlayerData@ plyData = @g_PlayerData[iPlayer-1];
		
		if( pPlayer.IsAlive() ){
			if(!plyData.m_flLastIsAlive) plyData.m_flLastIsAlive = true;
		}else{
			if(plyData.m_flLastIsAlive) {
				plyData.m_flLastIsAlive = false;
				
				if(pPlayer.pev.effects != EF_NODRAW){
					KeyValueBuffer@ pInfo = g_EngineFuncs.GetInfoKeyBuffer(pPlayer.edict());
					
					//Host_Error: PF_precache_model_I: 'models/player/myPlyModel/myPlyModel.mdl' Precache can only be done in spawn functions
					//Good luck at precaching all the custom models. (Pretty much impossible)
					// string modStr = "models/player/" + pInfo.GetValue("model") + "/" + pInfo.GetValue("model") + ".mdl";
					
					string posStr = "" + pPlayer.pev.origin.x + " " + pPlayer.pev.origin.y + " " + pPlayer.pev.origin.z;
					string angStr = "" + pPlayer.pev.angles.x + " " + pPlayer.pev.angles.y + " " + pPlayer.pev.angles.z;
					string modStr = "" + pPlayer.pev.model;
					string seqStr = "" + pPlayer.pev.sequence;
					string fraStr = "" + pPlayer.pev.frame;
					string topColStr = "" + (pPlayer.pev.colormap % 256);
					string botColStr = "" + ((pPlayer.pev.colormap / 256) % 256);
					string skinStr = "" + pPlayer.pev.skin;
					string bodyStr = "" + pPlayer.pev.body;
					
					dictionary keyvalues = {
						{ "model", modStr },
						{ "health", "50" },
						{ "gag", "-1" },
						{ "origin", posStr },
						{ "angles", angStr },
						{ "topcolor", topColStr },
						{ "bottomcolor", botColStr },
						{ "sequence", seqStr },
						{ "skin", skinStr },
						{ "body", bodyStr },
						{ "frame", "0" },
						{ "spawnflags", "384" }
					};
					CBaseEntity@ pEntity = g_EntityFuncs.CreateEntity("cycler2", keyvalues);
					// CBaseEntity@ pEntity = g_EntityFuncs.Create("cycler2", pPlayer.pev.origin, pPlayer.pev.angles, false);
					
					// pEntity.pev.sequence = pPlayer.pev.sequence;
					// pEntity.pev.frame = 0.0f;
					// pEntity.pev.skin = pPlayer.pev.skin;
					// pEntity.pev.body = pPlayer.pev.body;
					pEntity.pev.angles = pPlayer.pev.angles;
					pEntity.pev.colormap = pPlayer.pev.colormap;
					
					//Why is it not possible to modify the Animation of the monster_Generic?
					
					// pMonEntity.StopAnimation();
					// pMonEntity.ResetSequenceInfo();
					
					plyData.m_bodies.insertLast(pEntity);
					
					if(plyData.m_bodies.size() > limit_bodies_per_player){
						if(plyData.m_bodies !is null){
							plyData.m_bodies[0].pev.rendermode = 2;
						}
						plyData.m_bodies.removeAt(0);
					}
				}
			}
		}
	}
}

void PluginInit(){
	g_Module.ScriptInfo.SetAuthor( "CubeMath" );
	g_Module.ScriptInfo.SetContactInfo( "steamcommunity.com/id/CubeMath" );

	g_PlayerData.resize( g_Engine.maxClients );
	
	//In case the plugin is being reloaded, fill in the list manually to account for it. Saves a lot of console output.
	for( int iPlayer = 0; iPlayer < g_Engine.maxClients; ++iPlayer ){
		PlayerData data();
		@g_PlayerData[ iPlayer ] = @data;
	}
	
	g_Scheduler.SetInterval( "pvpBodiesThink", 0.1 );
}

void MapInit(){
	g_CustomEntityFuncs.RegisterCustomEntity( "cycler2", "cycler2" );

	//maxplayers normally can't be changed at runtime, but if that ever changes, we are fucked.
	g_PlayerData.resize( g_Engine.maxClients );

	for( int iPlayer = 0; iPlayer < g_Engine.maxClients; ++iPlayer ){
		PlayerData data();
		@g_PlayerData[ iPlayer ] = @data;
	}
	
}
