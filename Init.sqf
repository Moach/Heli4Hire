
HW_DEBUG = false;

_HeliPort = nearestObject [(getPos player), "Land_Heliport_Small_H"];
[(getPos _HeliPort), (getDir _HeliPort), "heliport_hangarDefault"] spawn BIS_fnc_ObjectsMapper;

_HeliPort = nearestObject [(getPos player), "Land_Heliport_Small_H"];
[(getPos _HeliPort), ((getDir _HeliPort) + 110), "heliport_hangarExterior"] spawn BIS_fnc_ObjectsMapper;



setCamShakeDefParams [1.25, 2, 2, 4, 5, .5, .65]; 

titleText["", "BLACK FADED"];

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




LocDefs_taxi = ["FlatAreaCity", "FlatAreaCitySmall", "FlatArea", "Heliport", "Airport", "ConstructionSupply", "ConstructionSite", "SummerCamp"];

PaxDefs_taxi = [
	"Woman01_Random_H",
	"Woman02_Random_H",
	"Woman03_Random_H",
	"Hooker1",
	"Hooker4",
	"Hooker2",
	"Citizen_Random_H",
	"Citizen_Random_H",
	"Citizen_Random_H",
	"Journalist_H",
	"Manager_H",
	"Rocker_H",
	"SeattleMan_Random_H"
];


enableEndDialog;


sleep 1;




deleteVehicle nearestObject [(getPos start_here), "air"]; // remove helicopter in the hangar that comes with the object composition...


player setPos (getPos start_here);
player setDir 60;



if (!HW_DEBUG) then // this will enable a REAL need to inspect before flight
{

	_reliability_factor = 80; //
	_reliability_cutoff = .55; // 
	_hps = chopper call BIS_fnc_helicopterGetHitpoints;
	{
		chopper setHitPointDamage [_x, ( (1 / (.0001 + (random(1) * _reliability_factor))) - _reliability_cutoff ) max 0];
	} foreach _hps;
};


Heli_Has_Obstruction = false; // or is it?

chopper execVM "scripts\OSMO_interaction\OSMO_interaction_init.sqf";
[service_helipad, "pad_service_marker"] execVM "scripts\OSMO_service\OSMO_service_init.sqf";


chopper enableCoPilot true;
chopper setFuel .2 + random .65;
chopper enableAutoStartUpRTD false;
chopper enableAutoTrimRTD false;


Heli_Cabin_Condition = .7 + random .3;  // cabin interior condition -- 1: fine and dandy,  .5: crumbs and dirt,  0: may require an exorcist

Cabin_needs_action = false;
chopper addAction ["Inspect Cabin", "HW_Cabin_Check.sqf", nil, 0, false, true, "", 
	"!Cabin_needs_action && isTouchingGround chopper;", "", -1,-1, 0, 2];

chopper addAction ["Tidy Up Cabin", "HW_Cabin_Cleanup.sqf", nil, 0, false, true, "", 
	"Cabin_needs_action && !((chopper turretUnit [0]) == player || driver chopper == player) && Heli_Cabin_Condition < .9 && chopper distance service_helipad < 10 && isTouchingGround chopper && !isEngineOn chopper;", 
	"", -1,-1, 0, 2];


sleep 1;	
	
// chopper setBatteryChargeRTD (.6 + random .4);
	
//
sleep 1;


//
//
player execVM "HW_Dispatch.sqf";



chopper execVM "HW_AdvFailureModel.sqf";





