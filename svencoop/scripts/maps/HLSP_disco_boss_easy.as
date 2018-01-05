#include "point_checkpoint"
#include "HLSPClassicMode"
#include "cubemath/disco_floor_system_easy"
#include "cubemath/disco_drone_easy"
#include "cubemath/disco_disconator_easy"

void MapInit()
{
	RegisterPointCheckPointEntity();
	RegisterDiscoFloorSystemEasyCustomEntity();
	RegisterDiscoDroneEasyCustomEntity();
	RegisterDiscoDisconatorEasyCustomEntity();
	
	g_EngineFuncs.CVarSetFloat( "mp_hevsuit_voice", 1 );
	
	ClassicModeMapInit();
}
