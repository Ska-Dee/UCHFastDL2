int dropper_weapon_box_counter = 0;
int dropper_weapon_box_counter_max = 300;

void PluginInit(){
	g_Module.ScriptInfo.SetAuthor( "CubeMath" );
	g_Module.ScriptInfo.SetContactInfo( "steamcommunity.com/id/CubeMath" );
	
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @ClientSayDropper );
}

HookReturnCode ClientSayDropper(SayParameters@ pParams){
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	
	const CCommand@ pArguments = pParams.GetArguments();
	string str = pArguments[0];
	str.ToUppercase();
	
	if( str == "DROPAMMO" ){
		pParams.ShouldHide = true;
		
		string ammoName1 = "";
		string ammoName2 = "";
		
		//Default
		if ( pPlayer.pev.viewmodel == "models/v_medkit.mdl" ) ammoName1 = "health";
		if ( pPlayer.pev.viewmodel == "models/v_9mmhandgun.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/v_357.mdl" ) ammoName1 = "357";
		if ( pPlayer.pev.viewmodel == "models/v_desert_eagle.mdl" ) ammoName1 = "357";
		if ( pPlayer.pev.viewmodel == "models/v_uzi.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/v_9mmAR.mdl" ) {ammoName1 = "9mm"; ammoName2 = "ARgrenades";}
		if ( pPlayer.pev.viewmodel == "models/v_shotgun.mdl" ) ammoName1 = "buckshot";
		if ( pPlayer.pev.viewmodel == "models/v_crossbow.mdl" ) ammoName1 = "bolts";
		if ( pPlayer.pev.viewmodel == "models/v_m16a2.mdl" ) {ammoName1 = "556"; ammoName2 = "ARgrenades";}
		if ( pPlayer.pev.viewmodel == "models/v_rpg.mdl" ) ammoName1 = "rockets";
		if ( pPlayer.pev.viewmodel == "models/v_gauss.mdl" ) ammoName1 = "uranium";
		if ( pPlayer.pev.viewmodel == "models/v_egon.mdl" ) ammoName1 = "uranium";
		if ( pPlayer.pev.viewmodel == "models/v_grenade.mdl" ) ammoName1 = "Hand Grenade";
		if ( pPlayer.pev.viewmodel == "models/v_satchel.mdl" ) ammoName1 = "Satchel Charge";
		if ( pPlayer.pev.viewmodel == "models/v_satchel_radio.mdl" ) ammoName1 = "Satchel Charge";
		if ( pPlayer.pev.viewmodel == "models/v_tripmine.mdl" ) ammoName1 = "Trip Mine";
		if ( pPlayer.pev.viewmodel == "models/v_squeak.mdl" ) ammoName1 = "Snarks";
		if ( pPlayer.pev.viewmodel == "models/v_m40a1.mdl" ) ammoName1 = "m40a1";
		if ( pPlayer.pev.viewmodel == "models/v_saw.mdl" ) ammoName1 = "556";
		if ( pPlayer.pev.viewmodel == "models/v_spore_launcher.mdl" ) ammoName1 = "sporeclip";
		if ( pPlayer.pev.viewmodel == "models/v_displacer.mdl" ) ammoName1 = "uranium";
		
		//ClassicMode
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_medkit.mdl" ) ammoName1 = "health";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_9mmhandgun.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_357.mdl" ) ammoName1 = "357";
		if ( pPlayer.pev.viewmodel == "models/hl/v_357.mdl" ) ammoName1 = "357";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_9mmAR.mdl" ) {ammoName1 = "9mm"; ammoName2 = "ARgrenades";}
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_shotgun.mdl" ) ammoName1 = "buckshot";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_crossbow.mdl" ) ammoName1 = "bolts";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_rpg.mdl" ) ammoName1 = "rockets";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_gauss.mdl" ) ammoName1 = "uranium";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_egon.mdl" ) ammoName1 = "uranium";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_grenade.mdl" ) ammoName1 = "Hand Grenade";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_satchel.mdl" ) ammoName1 = "Satchel Charge";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_satchel_radio.mdl" ) ammoName1 = "Satchel Charge";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_tripmine.mdl" ) ammoName1 = "Trip Mine";
		if ( pPlayer.pev.viewmodel == "models/hlclassic/v_squeak.mdl" ) ammoName1 = "Snarks";
		
		//Blue Shift
		if ( pPlayer.pev.viewmodel == "models/bshift/v_9mmhandgun.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_357.mdl" ) ammoName1 = "357";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_9mmar.mdl" ) {ammoName1 = "9mm"; ammoName2 = "ARgrenades";}
		if ( pPlayer.pev.viewmodel == "models/bshift/v_shotgun.mdl" ) ammoName1 = "buckshot";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_crossbow.mdl" ) ammoName1 = "bolts";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_m16a2.mdl" ) {ammoName1 = "556"; ammoName2 = "ARgrenades";}
		if ( pPlayer.pev.viewmodel == "models/bshift/v_rpg.mdl" ) ammoName1 = "rockets";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_gauss.mdl" ) ammoName1 = "uranium";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_egon.mdl" ) ammoName1 = "uranium";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_grenade.mdl" ) ammoName1 = "Hand Grenade";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_satchel.mdl" ) ammoName1 = "Satchel Charge";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_satchel_radio.mdl" ) ammoName1 = "Satchel Charge";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_tripmine.mdl" ) ammoName1 = "Trip Mine";
		if ( pPlayer.pev.viewmodel == "models/bshift/v_squeak.mdl" ) ammoName1 = "Snarks";
		
		//Opposing Force
		if ( pPlayer.pev.viewmodel == "models/opfor/v_medkit.mdl" ) ammoName1 = "health";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_9mmhandgun.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_357.mdl" ) ammoName1 = "357";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_desert_eagle.mdl" ) ammoName1 = "357";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_uzi.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_9mmar.mdl" ) {ammoName1 = "9mm"; ammoName2 = "ARgrenades";}
		if ( pPlayer.pev.viewmodel == "models/opfor/v_shotgun.mdl" ) ammoName1 = "buckshot";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_crossbow.mdl" ) ammoName1 = "bolts";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_m16a2.mdl" ) {ammoName1 = "556"; ammoName2 = "ARgrenades";}
		if ( pPlayer.pev.viewmodel == "models/opfor/v_rpg.mdl" ) ammoName1 = "rockets";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_gauss.mdl" ) ammoName1 = "uranium";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_egon.mdl" ) ammoName1 = "uranium";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_grenade.mdl" ) ammoName1 = "Hand Grenade";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_satchel.mdl" ) ammoName1 = "Satchel Charge";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_satchel_radio.mdl" ) ammoName1 = "Satchel Charge";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_tripmine.mdl" ) ammoName1 = "Trip Mine";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_squeak.mdl" ) ammoName1 = "Snarks";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_m40a1.mdl" ) ammoName1 = "m40a1";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_saw.mdl" ) ammoName1 = "556";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_spore_launcher.mdl" ) ammoName1 = "sporeclip";
		if ( pPlayer.pev.viewmodel == "models/opfor/v_displacer.mdl" ) ammoName1 = "uranium";
		
		//They Hunger
		if ( pPlayer.pev.viewmodel == "models/hunger/v_ap9.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_hkg36.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_hunger9mmar.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_hunger9mmhandgun.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_hunger357.mdl" ) ammoName1 = "357";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_hungercrossbow.mdl" ) ammoName1 = "bolts";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_hungergrenade.mdl" ) ammoName1 = "Hand Grenade";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_hungersatchel.mdl" ) ammoName1 = "Satchel Charge";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_hungersatchel_radio.mdl" ) ammoName1 = "Satchel Charge";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_hungershotgun.mdl" ) ammoName1 = "buckshot";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_syringe.mdl" ) ammoName1 = "health";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_taurus.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/hunger/v_tnt.mdl" ) ammoName1 = "Hand Grenade";
		if ( pPlayer.pev.viewmodel == "models/hunger/weapons/colt/v_1911.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/hunger/weapons/dbarrel/v_dbarrel.mdl" ) ammoName1 = "buckshot";
		if ( pPlayer.pev.viewmodel == "models/hunger/weapons/greasegun/v_greasegun.mdl" ) ammoName1 = "9mm";
		if ( pPlayer.pev.viewmodel == "models/hunger/weapons/m14/v_m14.mdl" ) ammoName1 = "m40a1";
		if ( pPlayer.pev.viewmodel == "models/hunger/weapons/m16a1/v_m16.mdl" ) ammoName1 = "556";
		if ( pPlayer.pev.viewmodel == "models/hunger/weapons/tesla/v_tesla.mdl" ) ammoName1 = "uranium";
		if ( pPlayer.pev.viewmodel == "models/hunger/weapons/tommygun/v_tommygun.mdl" ) ammoName1 = "9mm";
		
		int ammoInv = 0;
		int ammoInv2 = 0;
		int ammoInvHealth = 0;
		int ammoInvOld = -1;
		if(ammoName1 != "") ammoInvOld = pPlayer.AmmoInventory(g_PlayerFuncs.GetAmmoIndex(ammoName1));
		int ammoInvOld2 = -1;
		if(ammoName2 != "") ammoInvOld2 = pPlayer.AmmoInventory(g_PlayerFuncs.GetAmmoIndex(ammoName2));
		
		str = pArguments[1];
		str.ToUppercase();
		
		int customDrop = atoi(pArguments[1]);
		int customDrop2 = atoi(pArguments[2]);
		
		if (ammoName1 != "" && g_PlayerFuncs.GetAmmoIndex(ammoName1) == 16){
			if(customDrop<1){
				ammoInv = 1;
			}else{
				if (customDrop>ammoInvOld) customDrop=ammoInvOld;
				ammoInv = customDrop;
			}
			pPlayer.m_rgAmmo(g_PlayerFuncs.GetAmmoIndex(ammoName1), ammoInvOld-ammoInv);
		}else if(ammoName1 == "health"){
			if(ammoInvOld >= 10){
				ammoInvHealth = 1;
				pPlayer.m_rgAmmo(g_PlayerFuncs.GetAmmoIndex(ammoName1), ammoInvOld-10);
				
				string tarName = "dropper_weaponbox_"+dropper_weapon_box_counter;
				
				CBaseEntity@ pEntity = null;
				@pEntity = g_EntityFuncs.FindEntityByTargetname(pEntity, tarName);
				if( !(pEntity is null) )
					g_EntityFuncs.Remove(pEntity);
				
				CBaseEntity@ pWeaponBox = g_EntityFuncs.Create("ammo_medkit", pPlayer.pev.origin, pPlayer.pev.angles, false);
				
				pWeaponBox.pev.targetname = tarName;
				pWeaponBox.pev.spawnflags = 1024;
				pWeaponBox.pev.origin.z = pWeaponBox.pev.origin.z - 16.0f;
				pWeaponBox.pev.velocity.x = cos(pPlayer.pev.angles.y/180.0f*3.1415927f) * cos(pPlayer.pev.angles.x/60.0f*3.1415927f) * 240.0f;
				pWeaponBox.pev.velocity.y = sin(pPlayer.pev.angles.y/180.0f*3.1415927f) * cos(pPlayer.pev.angles.x/60.0f*3.1415927f) * 240.0f;
				pWeaponBox.pev.velocity.z = sin(pPlayer.pev.angles.x/60.0f*3.1415927f) * 240.0f + 240.0f ;
				pWeaponBox.pev.solid = SOLID_NOT;
				
				dropper_weapon_box_counter++;
				if ( dropper_weapon_box_counter >= dropper_weapon_box_counter_max ) dropper_weapon_box_counter = 0;
			}
			
		}else if(ammoName1 != "" && g_PlayerFuncs.GetAmmoIndex(ammoName1) > 0){
			if(customDrop<1){
				ammoInv = pPlayer.AmmoInventory(g_PlayerFuncs.GetAmmoIndex(ammoName1));
				ammoInv = ammoInv-ammoInv*9/10;
			}else{
				if (customDrop>ammoInvOld) customDrop=ammoInvOld;
				ammoInv = customDrop;
			}
			pPlayer.m_rgAmmo(g_PlayerFuncs.GetAmmoIndex(ammoName1), ammoInvOld-ammoInv);
		}
		
		if(ammoName2 != "" && g_PlayerFuncs.GetAmmoIndex(ammoName2) > 0){
			if(customDrop2<1){
				ammoInv2 = pPlayer.AmmoInventory(g_PlayerFuncs.GetAmmoIndex(ammoName2));
				ammoInv2 = ammoInv2-ammoInv2*9/10;
			}else{
				if (customDrop2>ammoInvOld2) customDrop2=ammoInvOld2;
				ammoInv2 = customDrop2;
			}
			pPlayer.m_rgAmmo(g_PlayerFuncs.GetAmmoIndex(ammoName2), ammoInvOld2-ammoInv2);
		}
		
		if(ammoInv > 0 || ammoInv2 > 0) {
			
			string tarName = "dropper_weaponbox_"+dropper_weapon_box_counter;
			
			CBaseEntity@ pEntity = null;
			@pEntity = g_EntityFuncs.FindEntityByTargetname(pEntity, tarName);
			if( !(pEntity is null) )
				g_EntityFuncs.Remove(pEntity);
			
			CBaseEntity@ pWeaponBox = g_EntityFuncs.Create("weaponbox", pPlayer.pev.origin, pPlayer.pev.angles, false);
			
			pWeaponBox.pev.targetname = tarName;
			pWeaponBox.pev.spawnflags = 1024;
			pWeaponBox.pev.origin.z = pWeaponBox.pev.origin.z - 16.0f;
			pWeaponBox.pev.velocity.x = cos(pPlayer.pev.angles.y/180.0f*3.1415927f) * cos(pPlayer.pev.angles.x/60.0f*3.1415927f) * 160.0f;
			pWeaponBox.pev.velocity.y = sin(pPlayer.pev.angles.y/180.0f*3.1415927f) * cos(pPlayer.pev.angles.x/60.0f*3.1415927f) * 160.0f;
			pWeaponBox.pev.velocity.z = sin(pPlayer.pev.angles.x/60.0f*3.1415927f) * 160.0f + 160.0f ;
			pWeaponBox.pev.solid = SOLID_NOT;
			
			array<string> strArr(3);
			strArr[0] = tarName;
			strArr[1] = ammoName1;
			strArr[2] = ammoName2;
			array<int> intArr(2);
			intArr[0] = ammoInv;
			intArr[1] = ammoInv2;
			
			g_Scheduler.SetTimeout( "AmmoHandling", 0.01, strArr, intArr );
			
			dropper_weapon_box_counter++;
			if ( dropper_weapon_box_counter >= dropper_weapon_box_counter_max ) dropper_weapon_box_counter = 0;
			
		}else if(ammoInvHealth == 0){
			string str1 = "AMMO-DROPPER: Couldn't drop Ammo!\n";
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, str1);
		}
		
		return HOOK_HANDLED;
	}
	
	return HOOK_CONTINUE;
}

void AmmoHandling(array<string>@ strArr, array<int>@ intArr){
	CBaseEntity@ pWeaponBox = null;
	@pWeaponBox = g_EntityFuncs.FindEntityByTargetname(pWeaponBox, strArr[0]);

	if( pWeaponBox !is null ) {
		//pWeaponBox.pev.solid = SOLID_TRIGGER;
		if(intArr[0]>0)
			g_EntityFuncs.DispatchKeyValue( pWeaponBox.edict(), strArr[1], intArr[0] );
		if(intArr[1]>0)
			g_EntityFuncs.DispatchKeyValue( pWeaponBox.edict(), strArr[2], intArr[1] );
	}
}
