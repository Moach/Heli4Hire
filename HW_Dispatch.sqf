

GigLineup = [];
GigNumMax = 8; // maximum tasks presented to player at any one time...


HW_CannotComply=false;


// this is used for missions where a decision is prompted to the pilot, zero sets the "expecting answer" state, higher values correspond to specific options
// should be reset to zero after use....
PilotDecision = 0;
PD_Armed = false; // indicates if pilot decisions are available
PD_Actions = [];  // tracks menu action ids for pilot decisions



/* GIG array format:
	[0] task     task being requested
	[1] string   filename for mission fsm
	[2] string   ID of marker pointing task on map
	[3] float    expiration time
	[4] array    mission parameters (given to fsm)
*/



//
// functions...

HW_Fx_Reset_RadioCalls = 
{
	RadioCall_A = false;	RadioCall_F = false;
	RadioCall_B = false;	RadioCall_G = false;
	RadioCall_C = false;	RadioCall_H = false;
	RadioCall_D = false;	RadioCall_I = false;
	RadioCall_E = false;	RadioCall_J = false;
};

//
RadioCallDelay = 0;
HW_Fx_Disptach_Radio_Update = 
{
	if (time > RadioCallDelay) then
	{
		//
		central sideRadio (["HW_Radio_Update", "HW_Radio_CheckReport", "HW_Radio_MapCheck", "HW_Radio_UpdateReport", 
			"HW_Radio_CheckIn", "HW_Radio_Report", "HW_Radio_Dispatch", "HW_Radio_Update_Info"] call bis_fnc_selectRandom);
		
		RadioCallDelay = time+60; // no 'update' calls within so many seconds from the last.... it can sound very robotic otherwise
	};
};





// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // Passenger Flight

HW_Fx_Dispatch_Taxi = 
{
	//
	//
	_p1 = getPos pad_A;
	_near=[];
	if (!RadioCall_J) then // not a debug run!
	{
		_near = nearestLocations [getPos chopper, LocDefs_taxi, 6000];
		_p1 = locationPosition (_near call BIS_fnc_selectRandom);
	};
	
	_near = nearestLocations [_p1, LocDefs_taxi, 25000];
	
	
	_size = count _near;
	_dmin = round(_size * .1); // remove the nearest 10% locations found - this culls out unreasonably close legs and the same-pad bug
	for "_i" from 0 to _size-_dmin do 
	{ 
		_near set [_i, _near select _i+_dmin]; 
	};
	_near resize (_size - _dmin);
	
	//
	_p2 = locationPosition (_near call BIS_fnc_selectRandom);

	_tsk = player createSimpleTask ["Pax Shuttle"];
	_tsk setSimpleTaskDestination _p1;
	_tsk setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept", "Shuttle Passengers", "Departing here"];
	
	_mkID = ("P-"+str(round time));
	_mkr = createMarker [_mkID, _p1];
	_mkr setMarkerType "hd_start";
	_mkr setMarkerDir ((_p2 select 0) - (_p1 select 0)) atan2 ((_p2 select 1) - (_p1 select 1));
	_mkr setMarkerText ("Pax | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString) + " | " + str(round((_p1 distance _p2) * .01)* .1) + "km");
	_mkr setMarkerColor "ColorRed";
	
	_gig = [_tsk, "HeliWorks_Commute.fsm", _mkID, time + 45 + random(320), [_p1, _p2, RadioCall_J]];
	GigLineup set [count GigLineup, _gig];
};







// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // General-Purpose Point Survey


HW_Fx_Dispatch_Survey = 
{
	//
	_p1 = getPos pad_A;
	_num = 2;
	
	if (!RadioCall_J) then // not a debug run!
	{
		_near = nearestLocations [getPos chopper, LocDefs_taxi, 6000];
		_p1 = locationPosition (_near call BIS_fnc_selectRandom);
		_num = floor((random 3) + (random 3));
	};
	
	//
	AreaCenter = [[[_p1, 25000], survey_safe_zone], ["water","out"], {(_this distance player) < 25000}] call BIS_fnc_randomPos;
	_surveyPoints = [];
	
	AreaLimit = (3+random(4)) * 1000;
	
	for "_i" from 0 to _num do // due to the nature of 'for' loops in this scripting language, if _num is zero, we'll still get one area to fly
	{
		_sp = [[[AreaCenter, AreaLimit], survey_safe_zone], ["water","out"], {(_this distance AreaCenter) < AreaLimit}] call BIS_fnc_randomPos;
		_surveyPoints set [_i, _sp];
	};
	
	//
	_tsk = player createSimpleTask ["Field Survey"];
	_tsk setSimpleTaskDestination _p1;
	_tsk setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept", "Field Survey", "Departing here"];
	
	_mkID = ("S-"+str(round time));
	_mkr = createMarker [_mkID, _p1];
	_mkr setMarkerType "hd_start";
	_mkr setMarkerDir ((AreaCenter select 0) - (_p1 select 0)) atan2 ((AreaCenter select 1) - (_p1 select 1));
	_mkr setMarkerText ("Survey | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString) + " | " + str(round((_p1 distance AreaCenter) * .01)* .1) + "km");
	_mkr setMarkerColor "ColorRed";
	
	_gig = [_tsk, "HeliWorks_Survey.fsm", _mkID, time + 60 + random(400), [_p1, _surveyPoints]];
	GigLineup set [ count GigLineup, _gig ];
};










// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // Cargo SlingLoad

HW_Fx_Dispatch_Cargo = 
{
	// locate tower (the high point requiring helicopter cargo)
	//
	_twrPos = (PosDefs_roofTops call bis_fnc_selectRandom) select 1; 
	
	_towerCargo = round((random 4)-2) max 0; // chance of random cargo atop tower needing a ride down (two is the max to have coming down, not much room up there)
	_baseCargo  = ceil((random 4)-_towerCargo) max 0; // quasi-random amount of stuff going up (may be zero if cargo going down exists)
	
	if(_towerCargo+_baseCargo < 1) then // what da? no cargo = no job!
	{
		_towerCargo = 1; // fallback to 'one coming down' in the off chance this happens...
	};
	
	
	if (RadioCall_J) then // override for debug run!
	{
		_towerCargo = 2;
		_baseCargo  = 2;
	};
	
	
	// select base from our beloved list of possible locations -- note that this is only the CARGO set, it does NOT allow above-ground pads, so unhandly those can be...
	_near = nearestLocations [_twrPos, ["ConstructionSupply"], 10000];
	if (count _near > 3) then { _near resize 3; }; // allow only the few closest sites for supply - it's incoherent to have miles-long trips to sling loads over
	//
	_basePos = locationPosition (_near call BIS_fnc_selectRandom);
	
	
	// most times, the load crew is already at the base site - if not, then picking them up is the first order of the day...
	_crewPos = _basePos;
	if (random(10) < 2) then 
	{
		_near = nearestLocations [_basePos, LocDefs_taxi, 15000];
		_crewPos = locationPosition (_near call BIS_fnc_selectRandom);
	};

	_mkID = ("C-"+str(round time));
	_mkr = createMarker [_mkID, _crewPos];
	_mkr setMarkerType "hd_join";
	_mkr setMarkerText ("Cargo | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString));
	_mkr setMarkerColor "ColorRed";
	
	_tsk = player createSimpleTask ["Cargo SlingLoad"];
	_tsk setSimpleTaskDestination _crewPos;
	_tsk setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept", "Cargo SlingLoad", "Meet Logistics Crew here"];
	
	_order = [_basePos, _twrPos, _baseCargo, _towerCargo];
	
	_gig = [_tsk, "HeliWorks_Cargo.fsm", _mkID, time + 90 + random(500), [_crewPos, _order] ];
	GigLineup set [ count GigLineup, _gig ];
};







// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // Marine Search-N-Rescue 

HW_Fx_Dispatch_MSAR = 
{
	_zoneTrg = ((synchronizedObjects marine_area_logic) call bis_fnc_selectRandom); // select area at random...
	hint (vehicleVarName _zoneTrg);
	
	_area = triggerArea _zoneTrg;
	_rpos = getPos _zoneTrg; // reference 'last known' position for search efforts
	
	_rpos set [0, (_pos select 0) + (random ((_area select 0)* 2) ) - (_area select 0)];
	_rpos set [1, (_pos select 1) + (random ((_area select 1)* 2) ) - (_area select 1)];
	
	_mkID = ("MS-"+str(round time));
	_mkr = createMarker [_mkID, _rpos];
	_mkr setMarkerType "mil_unknown";
	_mkr setMarkerText ("SAR | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString));
	_mkr setMarkerColor "ColorRed";
	
	_tsk = player createSimpleTask ["Marine SAR"];
	_tsk setSimpleTaskDestination _rpos;
	_tsk setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept", "Marine SAR", "Last known vessel location"];
	
	_pos = getPos _zoneTrg; // actual vessel location...
	_pos set [0, (_pos select 0) + (random ((_area select 0)* 2) ) - (_area select 0)];
	_pos set [1, (_pos select 1) + (random ((_area select 1)* 2) ) - (_area select 1)];
	
	_gig = [_tsk, "HeliWorks_MarineSAR.fsm", _mkr, time + 100 + random(300), [_rpos, _pos]];
	GigLineup set [ count GigLineup, _gig ];
};






// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // MEDEVAC

HW_Fx_Dispatch_MEDEVAC = 
{
	//
	_pos = [[[_p1, 25000], survey_safe_zone], ["water","out"], {(_this distance player) < 30000}] call BIS_fnc_randomPos;
	_rpp = [(_pos select 0) + (random 500) -250, (_pos select 1) + (random 500) -250]; // report position - often differs from actual location....
	_hospital = locationPosition ((nearestLocations [_pos, ["heliportHospital", "heliportTrauma"], 25000]) select 0);
	
	
	_mkID = ("MV-"+str(round time));
	_mkr = createMarker [_mkID, _rpp];
	_mkr setMarkerType "hd_destroy";
	_mkr setMarkerText ("MEDEVAC | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString));
	_mkr setMarkerColor "ColorRed";
	
	_tsk = player createSimpleTask ["MEDEVAC"];
	_tsk setSimpleTaskDestination _rpp;
	_tsk setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept", "MEDEVAC", "Pickup Paramedics"];

	_gig = [_tsk, "HeliWorks_MEDEVAC.fsm", _mkr, time + 100 + random(300), [_hospital, _pos, _rpp]];
	GigLineup set [ count GigLineup, _gig ];
};









// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // ...and the rest of it...


HW_Fx_Pilot_Task_Commit = 
{
	_tsk = currentTask player; // find gig array with this task
	{ 
		if ((_x select 0) == _tsk) then 
		{ 
			// we should have it by now.... i hope
			_fsm  = _x select 1;
			_mkr  = _x select 2;
			_pars = _x select 4;
			
			deleteMarker _mkr;
			player RemoveSimpleTask _tsk;
			
			1 setRadioMsg "NULL";
			2 setRadioMsg "NULL";
			
			HW_CannotComply=false;
			
			RadioCallDelay = time+30; // since dispatch man will call a report after acknowledging your commit, this counts for a non-repeat delay
			_pars execFSM _fsm;
			
			[] spawn 
			{ 
				//
				sleep (8+random(4));
				playSound "FX_Dispatch_Beep";
			};
			exit;
		}; 
		
	} foreach GigLineup;
};






//
// PD setup utility functions...
//

HW_Fx_PD_Prompt = 
{
	if (PD_Armed) exitWith { player sidechat "WARNING!!\n - PD armed - \ncannot prompt further options before clear!"; };
	
	PD_Armed = true;
	_opts = _this select 0; // array expected as argument, should contain strings of titles for each option

	_p = 1; 
	PD_Actions resize (count _opts);
	
	{
		//
		_id = chopper addAction [_x, "HW_Pilot_Decision.sqf", _p, 6, false, true];
		PD_Actions set [_p-1, _id];
		_p = _p+1;
		
	} foreach _opts;
};


HW_Fx_PD_Clear = 
{
	PilotDecision = 0;
	PD_Armed = false;
	
	{
		chopper removeAction _x;
		//
	} foreach PD_Actions;
	
	PD_Actions = [];
};











// //////////////////////////////////////////////////////////////  //////////////////////////////////////////////////////////////
// //////////////////////////////////////////////////////////////  //////////////////////////////////////////////////////////////
// //////////////////////////////////////////////////////////////  //////////////////////////////////////////////////////////////


//  generator loop...
//
//

player execFSM "HW_Dispatch_Gen.fsm";


//
//

if (HW_DEBUG) then // enabled only for debug!
{
	while { true } do
	{
		10 setRadioMsg "DEBUG!";
	
		waitUntil { sleep 1; RadioCall_J };
		
		player moveInDriver chopper;
		chopper setBatteryRTD true;
		
		10 setRadioMsg "NULL";
		
		[1, chopper, true] call BIS_fnc_enginesOnDebug;
		chopper setFuel 1;
		chopper setDamage 0;
		
		RadioCall_A = true; // auto call in available
		
		sleep 1;
		call HW_Fx_Dispatch_MEDEVAC;
		
		RadioCall_J = false;
	};
};







