
HW_DEBUG = false;

_initDefs = player execVM "InitDefs.sqf";
waitUntil { scriptDone _initDefs };

enableEndDialog;


_HeliPort = nearestObject [(getPos player), "Land_Heliport_Small_H"];
[(getPos _HeliPort), (getDir _HeliPort), "heliport_hangarDefault"] spawn BIS_fnc_ObjectsMapper;

_HeliPort = nearestObject [(getPos player), "Land_Heliport_Small_H"];
[(getPos _HeliPort), ((getDir _HeliPort) + 110), "heliport_hangarExterior"] spawn BIS_fnc_ObjectsMapper;


setCamShakeDefParams [1.25, 2, 2, 4, 5, .5, .65]; 

if (!HW_DEBUG) then {
	titleText["", "BLACK FADED"];
};

 1 setRadioMsg "Call in Available";
 2 setRadioMsg "NULL";
 3 setRadioMsg "NULL";
 4 setRadioMsg "NULL";
 5 setRadioMsg "NULL";
 6 setRadioMsg "NULL";
 7 setRadioMsg "NULL";
 8 setRadioMsg "NULL";
 9 setRadioMsg "NULL";
10 setRadioMsg "NULL";

// reset upon expecting radio call
//
RadioCall_A = false; 
RadioCall_B = false; 
RadioCall_C = false; 
RadioCall_D = false; 
RadioCall_E = false; 
RadioCall_F = false; 
RadioCall_G = false; 
RadioCall_H = false; 
RadioCall_I = false; 
RadioCall_J = false; 


// this is used for missions where a decision is prompted to the pilot, zero sets the "expecting answer" state, higher values correspond to specific options
// should be reset to zero after use....
PilotDecision = 0;
PD_Armed = false; // indicates if pilot decisions are available
PD_Actions = [];  // tracks menu action ids for pilot decisions



//
// PD setup utility functions...
//

HW_PD_Prompt = 
{
	if (PD_Armed) exitWith { player sidechat "WARNING!!\n - PD armed - \ncannot prompt further options before clear!"; };
	
	PD_Armed = true;
	_opts = _this select 0; // array expected as argument, should contain strings of titles for each option

	_p = 1; 
	PD_Actions resize (count _opts);
	
	{
		//
		_id = chopper addAction [_x, "HW_Pilot_Decision.sqf", _p, 6];
		PD_Actions set [_p-1, _id];
		_p = _p+1;
		
	} foreach _opts;
};


HW_PD_Clear = 
{
	PilotDecision = 0;
	PD_Armed = false;
	
	{
		chopper removeAction _x;
		//
	} foreach PD_Actions;
	
	PD_Actions = [];
};






sleep 1;

deleteVehicle nearestObject [(getPos start_here), "air"]; // remove helicopter in the hangar that comes with the object composition...


player setPos (getPos start_here);
player setDir 60;



if (!HW_DEBUG) then // this will enable a REAL need to inspect before flight
{

	_reliability_factor =  80; //
	_reliability_cutoff = .55; // 
	_hps = chopper call BIS_fnc_helicopterGetHitpoints;
	{
		chopper setHitPointDamage [_x, ( (1 / (.0001 + (random(1) * _reliability_factor))) - _reliability_cutoff ) max 0];
	} foreach _hps;
};


Heli_Has_Obstruction = false; // or is it?

chopper execVM "scripts\OSMO_interaction\OSMO_interaction_init.sqf";
[service_helipad, "pad_service_marker"] execVM "scripts\OSMO_service\OSMO_service_init.sqf";



chopper enableCoPilot false;
chopper setFuel .2 + random .65;
chopper enableAutoStartUpRTD false; // doesn't work... dunno why - these do nothing...
chopper enableAutoTrimRTD false;


Heli_Cabin_Condition = .7 + random .3;  // cabin interior condition -- 1: fine and dandy,  .5: crumbs and dirt,  0: may require an exorcist

Cabin_needs_action = false;
chopper addAction ["Inspect Cabin", "HW_Cabin_Check.sqf", nil, 0, false, true, "", 
	"!Cabin_needs_action && isTouchingGround chopper;", "", -1,-1, 0, 2];

chopper addAction ["Tidy Up Cabin", "HW_Cabin_Cleanup.sqf", nil, 0, false, true, "", 
	"Cabin_needs_action && !((chopper turretUnit [0]) == player || driver chopper == player) && Heli_Cabin_Condition < .9 && chopper distance service_helipad < 10 && isTouchingGround chopper && !isEngineOn chopper;", 
	"", -1,-1, 0, 2];


sleep 1;	
	


// since this feature is so damn useful, its availability bypasses the debug flag -- comment out to remove!
chopper addAction ["D+D: Log Position", "DnD\LogPos.sqf", nil, 0, false];

if (HW_DEBUG) then
{
	chopper addAction ["D+D: Magic Teleport", "DnD\WarpDrive.sqf", nil, 0, false];
	//
	
	// create markers showing ALL indexed landing areas!
	_locLZs = nearestLocations [getMarkerPos "map_center", LocDefs_taxi, 100000];
	_counter = 0;
	{
		_counter = _counter + 1;
		_lzMkr = createMarker [("LZ#"+str(_counter)), (locationPosition _x)];
		_lzMkr setMarkerType "mil_dot";
		_lzMkr setMarkerColor "ColorRedAlpha";
		_lzMkr setMarkerAlpha 0.2; 
		
	} foreach _locLZs;
	
	_counter = 0;
	{
		_counter = _counter + 1;
		_lzMkr = createMarker [("RT#"+str(_counter)), _x];
		_lzMkr setMarkerType "mil_triangle";
		_lzMkr setMarkerColor "ColorRedAlpha";
		_lzMkr setMarkerAlpha 0.2; 
		
	} foreach PosDefs_roofTops;
	
	
	
	
	hintSilent format [" - DEBUG MODE ON - \nLZ count = %1\nRooftops = %2", count _locLZs, count PosDefs_roofTops];
};


//
//
player execVM "HW_Dispatch.sqf";
chopper execVM "HW_AdvFailureModel.sqf";



