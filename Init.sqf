
_HeliPort = nearestObject [(getPos player), "Land_Heliport_Small_H"];
[(getPos _HeliPort), (getDir _HeliPort), "heliport_hangarDefault"] spawn BIS_fnc_ObjectsMapper;

_HeliPort = nearestObject [(getPos player), "Land_Heliport_Small_H"];
[(getPos _HeliPort), ((getDir _HeliPort) + 110), "heliport_hangarExterior"] spawn BIS_fnc_ObjectsMapper;



chopper execVM "scripts\OSMO_interaction\OSMO_interaction_init.sqf";
[service_helipad, "pad_service_marker"] execVM "scripts\OSMO_service\OSMO_service_init.sqf";

chopper enableCoPilot true;
chopper setFuel .2 + random .65;
chopper enableAutoStartUpRTD false;
chopper enableAutoTrimRTD false;

Heli_Cabin_Condition = .7 + random .3;  // cabin interior condition -- 1: fine and dandy,  .5: crumbs and dirt,  0: may require an exorcist

chopper addAction ["Tidy Up Cabin", "HW_Cabin_Cleanup.sqf", nil, 0, false, true, "", 
	"Heli_Cabin_Condition < .9 && chopper distance service_helipad < 10 && isTouchingGround chopper;", "", -1,-1, 0, 1+2];



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




LocDefs_taxi = ["FlatAreaCity", "FlatAreaCitySmall", "FlatArea", "Heliport", "Airport", "ConstructionSupply", "SummerCamp"];

PaxDefs_taxi = [
	"Woman01_Random_H",
	"Woman02_Random_H",
	"Woman03_Random_H",
	"Citizen_Random_H",
	"Citizen_Random_H",
	"Citizen_Random_H",
	"Journalist_H",
	"Manager_H",
	"Rocker_H",
	"SeattleMan_Random_H"
];

PaxDefs_tour = [
	"Woman01_Random_H",
	"Woman02_Random_H",
	"Woman03_Random_H",
	"Citizen_Random_H",
	"Citizen_Random_H",
	"Rocker_H",
	"SeattleMan_Random_H"
];

enableEndDialog;


sleep 1;

deleteVehicle nearestObject [(getPos start_here), "air"];

player setPos (getPos start_here);
player setDir 60;



sleep 1;
/*
hsim_copilot assignAsTurret [chopper, [0]];
[hsim_copilot] orderGetIn true;
*/

player execVM "HW_Dispatch.sqf";


/*
while {true} do
{
	waitUntil { sleep 2; RadioCall_A };
	
	RadioCall_A = false;
	1 setRadioMsg "NULL";
	
	_near = nearestLocations [getPos chopper, LocDefs_taxi, 5000];
	_p1 = locationPosition (_near call BIS_fnc_selectRandom);
	
	_near = nearestLocations [_p1, LocDefs_taxi, 25000];
	
	_size = count _near;
	_dmin = round(_size * .1); // remove the nearest 10% locations found - this culls out unreasonably close legs and the same-pad bug
	for "_i" from 0 to _size do { _near set [_i, _near select _i+_dmin]; };
	_near resize (_size - _dmin);
	
	_p2 = locationPosition (_near call BIS_fnc_selectRandom);
	
	OnDuty = [_p1, _p2] execFSM "HeliWorks_Commute.fsm"; // when this ends, it should re-enable the alpha call option
};
*/

