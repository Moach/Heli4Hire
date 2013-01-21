
/*
	you are about to enter the ultimate vortex of enthropy! 
	there where random things are!
	
	proceed at own risk of general confustication!
	
	

	mind the required argument notation comments on some of this project's functions,
	hopefully we can make this a standard, since self-documenting code is a no-go...
	
	
	
	henceforth, we define the basic laws of proper modular programming:
	
		1: functions that AWNSWER QUESTIONS by returning values shall not execute any logic that 
		   results in change to the answer given by itself or another function.
		
		2: functions that EXECUTE LOGIC shall not proceed beyond that which is immediately obvious given their purpose,
		   specially if this would cause an indirectly related question to produce a different answer.
		   
		3: functions that EXECUTE LOGIC AND RETURN THE RESULT must not cause change to answers other than that which it 
		   provides whenever said result indicates failure to obtain full success in execution.
		   
	   
	...and hope it sticks
	
	
	thus-wise, a secondary prefix (post the HW_ project identifier) will read:
	
	Fn_   for functions that answer questions
	Fx_   for functions that execute logic
	Fs_   for functions that return their own success upon execution

	the absense of such prefix usually denotes the definition of a variable, rather than a function...
	other variants may appear at times, such as:
	
	efx_ for event initiated functions, i.e. handlers for UI dialog controls
	fsp_ for functions that spawn internal execution logic and promptly return in an asynchronous fashion
	
	and whatnot...
	
	do note however - it's really a tough gig to enforce stuff of this sort on this type of project, so things may not comply (even at all) at some various scripts...
	
	
*/





HW_DEBUG = true; // master debug flag -- DO NOT commit to master when enabled



enableEndDialog;

// removeAllItems player;

_initRun = player execVM "InitDefs.sqf";
waitUntil { scriptDone _initRun };


_initRun = office_area execVM "Hangar\HW_Office_init.sqf";
waitUntil { scriptDone _initRun };

_initRun = [] execVM "Hangar\HW_Hangar_Init.sqf";
waitUntil { scriptDone _initRun };

chopper call HW_Fx_InitChopper;



_HeliPort = nearestObject [(getPos player), "Land_Heliport_Small_H"];
[(getPos _HeliPort), (getDir _HeliPort), "heliport_hangarDefault"] spawn BIS_fnc_ObjectsMapper;

_HeliPort = nearestObject [(getPos player), "Land_Heliport_Small_H"];
[(getPos _HeliPort), ((getDir _HeliPort) + 110), "heliport_hangarExterior"] spawn BIS_fnc_ObjectsMapper;


setCamShakeDefParams [1.25, 2, 2, 4, 5, .5, .65]; 

if (!HW_DEBUG) then
{
	cutText ["Welcome!\nYour Helicopter is out on the pad, make sure to inspect it before flight!", "PLAIN DOWN"];
	titleText ["", "BLACK FADED"];
};

// reset upon expecting radio call
//
RadioCall_A = false;    1 setRadioMsg "Call in Available";
RadioCall_B = false;    2 setRadioMsg "NULL";
RadioCall_C = false;    3 setRadioMsg "NULL";
RadioCall_D = false;    4 setRadioMsg "NULL";
RadioCall_E = false;    5 setRadioMsg "NULL";
RadioCall_F = false;    6 setRadioMsg "NULL";
RadioCall_G = false;    7 setRadioMsg "NULL";
RadioCall_H = false;    8 setRadioMsg "NULL";
RadioCall_I = false;    9 setRadioMsg "NULL";
RadioCall_J = false;   10 setRadioMsg "NULL";




sleep 1;

deleteVehicle nearestObject [(getPos start_here), "air"]; // remove medium helicopter in the hangar that comes with the object composition...

HW_defTsk_rtb = player createSimpleTask [" -- Return To Heliport"];
HW_defTsk_rtb setSimpleTaskDescription ["Set your heading back to base.", " -- Return To Heliport", "Your Heliport"];
HW_defTsk_rtb setSimpleTaskDestination (getPos pad_A);


HW_defTsk_clr = player createSimpleTask [" -- Clear Nav Data"];
HW_defTsk_clr setSimpleTaskDescription ["Reset to clear heading.", " -- Clear Nav Data", ""]; 

if (!HW_DEBUG) then // this will enable a REAL need to inspect before flight
{
	player setPos (getPos start_here);
	player setDir 20;
	
	
	titleFadeOut 2;
	//
	
	_reliability_factor =  80; //
	_reliability_cutoff = .55; // 
	_hps = chopper call BIS_fnc_helicopterGetHitpoints;
	{
		chopper setHitPointDamage [_x, ( (1 / (.0001 + (random(1) * _reliability_factor))) - _reliability_cutoff ) max 0];
	} foreach _hps;
} else
{
	player setPos [getPos player select 0,  getPos player select 1, 0]; // make sure he's on ground level - if not we may start on a roof or something...
	//

};




player addAction ["Access Hangar", "Hangar\HW_Hangar_Dialog.sqf", nil, 0, false, true, "", 
	"(HW_DEBUG || (player distance hangar_area) < 20 && !isEngineOn chopper) && chopper distance hangar_area < 100"];



RopeAttached = false;
SlingLoadCgo = ObjNull;
SlingLoadLen = 0;
SlingRopeDiscn_Action_H=-1;
SlingRopeDiscn_Action_C=-1;

Heli_Has_Obstruction = false; // or is it?
Heli_Hint_On_Fail = false;

chopper execVM "scripts\OSMO_interaction\OSMO_interaction_init.sqf";
/*[service_helipad, "pad_service_marker"] execVM "scripts\OSMO_service\OSMO_service_init.sqf";
*/


chopper enableCoPilot false;
chopper setFuel .2 + random .65;
chopper enableAutoStartUpRTD false; // doesn't work... dunno why - these do nothing...
chopper enableAutoTrimRTD false;



Heli_Cabin_Condition = .7 + random .3;  // cabin interior condition -- 1: fine and dandy,  .5: crumbs and dirt,  0: may require an exorcist

Cabin_needs_action = false;
chopper addAction ["Inspect Cabin", "HW_Cabin_Check.sqf", nil, 0, false, true, "", 
	"!Cabin_needs_action && isTouchingGround chopper", "", 3,2, 0, 2];

chopper addAction ["Tidy Up Cabin", "HW_Cabin_Cleanup.sqf", nil, 0, false, true, "", 
	"Cabin_needs_action && !((chopper turretUnit [0]) == player || driver chopper == player) && Heli_Cabin_Condition < .9 && chopper distance service_helipad < 10 && isTouchingGround chopper && !isEngineOn chopper;", 
	"", -1,-1, 0, 2];

DisasterEvent = ""; // for now...






sleep 1;



	
rtLogCount = count PosDefs_roofTops;	
lzLogCount = count PosDefs_landings;	
//


chopper addAction ["D+D: Log Position (RT)", "DnD\LogPos.sqf", 0, 0, false,   true, "", "HW_DEBUG"];
chopper addAction ["D+D: Log Position (LZ)", "DnD\LogPos.sqf", 1, 0, false,   true, "", "HW_DEBUG"];
chopper addAction ["D+D: Magic Teleport", "DnD\WarpDrive.sqf", nil, 0, false, true, "", "HW_DEBUG"];
chopper addAction ["D+D: Force Fail", "DnD\ForceFailure.sqf",  nil, 0, false, true, "", "HW_DEBUG"];
//
//




if (HW_DEBUG) then
{
	
	[] execVM "AnimationViewer\init.sqf";
	hintSilent " - DEBUG MODE ACTIVE -\nwarning, you may have been given superpowers - do not use for evil!";
};	


HW_Fx_DD_IdentLZs = 
{
	// create markers showing ALL indexed landing areas!
	_locLZs = nearestLocations [getMarkerPos "map_center", LocDefs_taxi, 100000];
	_counter = 0;
	{
		_counter = _counter + 1;
		_lzMkr = createMarker [("LZ#"+str(_counter)), (locationPosition _x)];
		_lzMkr setMarkerType "mil_dot";
		_lzMkr setMarkerColor "ColorRedAlpha";
		_lzMkr setMarkerAlpha 0.4; 
		
	} foreach _locLZs;
	hintSilent format ["LZ count = %1", count _locLZs];
};


HW_Fx_DD_IdentCargoTowers = 
{
	{
		_lzMkr = createMarker [_x select 0, _x select 1];
		_lzMkr setMarkerType "mil_triangle";
		_lzMkr setMarkerText ((_x select 0) + ": Tower");
		_lzMkr setMarkerColor "ColorBlack";
		_lzMkr setMarkerAlpha 0.6; 
		
	} foreach PosDefs_roofTops;	
};

HW_Fx_DD_IdentCargoBases = 
{
	{
		_lzMkr = createMarker [_x select 1, _x select 2];
		_lzMkr setMarkerType "mil_box";
		_lzMkr setMarkerText (_x select 0) + ": " + (_x select 1);
		_lzMkr setMarkerColor "ColorBlue";
		_lzMkr setMarkerAlpha 0.5; 
		
	} foreach PosDefs_landings;
};
	
	
	



//
//
_initUtils = player execVM "HW_Utilities.sqf";
waitUntil { scriptDone _initUtils };


player execVM "HW_Dispatch.sqf";
chopper execVM "HW_AdvFailureModel.sqf";

chopper addAction ["Attach 16m Sling Rope (free)", "SlingLoad\HW_Attach_Sling_Loose_Action.sqf", 16, 0, false, true, "", "!RopeAttached && (player distance chopper) < 2.8 && !(player in chopper)", "", 3, 2];
chopper addAction ["Attach 24m Sling Rope (free)", "SlingLoad\HW_Attach_Sling_Loose_Action.sqf", 24, 0, false, true, "", "!RopeAttached && (player distance chopper) < 2.8 && !(player in chopper)", "", 3, 2];
chopper addAction ["Attach 32m Sling Rope (free)", "SlingLoad\HW_Attach_Sling_Loose_Action.sqf", 32, 0, false, true, "", "!RopeAttached && (player distance chopper) < 2.8 && !(player in chopper)", "", 3, 2];



_testCDef = [typeOf test_cargo, 300];
test_cargo addAction ["Connect 16m Sling Rope", "SlingLoad\HW_Attach_Sling_Cargo_Action.sqf", [16, _testCDef], 6, true, true, "Fire", "!RopeAttached && (player distance _target) < 2 && (chopper distance _target) < 14", "", 3, 2];
test_cargo addAction ["Connect 24m Sling Rope", "SlingLoad\HW_Attach_Sling_Cargo_Action.sqf", [24, _testCDef], 6, true, true, "Fire", "!RopeAttached && (player distance _target) < 2 && (chopper distance _target) < 22", "", 3, 2];
test_cargo addAction ["Connect 32m Sling Rope", "SlingLoad\HW_Attach_Sling_Cargo_Action.sqf", [32, _testCDef], 6, true, true, "Fire", "!RopeAttached && (player distance _target) < 2 && (chopper distance _target) < 30", "", 3, 2];



sleep 1;



// OSMO_SV_serviceMenArray call HW_Util_Animate_Idle;



