


#define GIG_TASKREF 0        // task through which gig gets selected for request
#define GIG_MARKER 1         // associated marker shown on map

#define GIG_CALL_CODE 2      // code executed on request
#define GIG_DATA_ARRAY 3     // custom parameters used for request code as well as expiration and able'ness checks

#define GIG_EXP_CODE 4       // code to execute upon expiration check - receives gig struct as parameter - must return true or false, deciding if gig shall remain available afterwards
#define GIG_EXP_TIME 5       // time upon which expiration code shall execute

#define GIG_ABLE_CODE 6      // code to determine the capacity of the player's helicopter to comply with gig - receives gig struct     
#define GIG_ABLE_FLAG 7      // flag indicating as to if the gig was considered able at last check

#define GIG_STRUCT_SIZE 8;   // size of a gig struct array












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
	_dmin = round(_size * .2); // remove the nearest 20% locations found - this culls out unreasonably close legs and the same-pad bug
	for "_i" from 0 to _size-_dmin do 
	{ 
		_near set [_i, _near select _i+_dmin]; 
	};
	_near resize (_size - _dmin);
	
	//
	_p2 = locationPosition (_near call BIS_fnc_selectRandom);
	
	
	
	_tsk = player createSimpleTask ["Pax Shuttle"];
	_tsk setSimpleTaskDestination _p1;
	
	_mkID = ("P-"+str(round time));
	_mkr = createMarker [_mkID, _p1];
	_mkr setMarkerType "hd_start";
	_mkr setMarkerDir ((_p2 select 0) - (_p1 select 0)) atan2 ((_p2 select 1) - (_p1 select 1));
	_mkr setMarkerText ("Pax | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString) + " | " + str(round((_p1 distance _p2) * .01)* .1) + "km");
	
	_callCode =
	{
		deleteMarker (_this select GIG_MARKER);
		player RemoveSimpleTask (_this select GIG_TASKREF);
		
		(_this select GIG_DATA_ARRAY) execFSM "HeliWorks_Commute.fsm";
		
		[] spawn 
		{ 
			//
			sleep (8+random(4));
			playSound "FX_Dispatch_Beep";
		};
	};
	
	_ableCode =
	{
		if (HW_PilotCommited) exitWith
		{
			(_this select GIG_TASKREF) setTaskState "Canceled";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["You cannot request this task while engaged in another.",  "Shuttle Passengers", "Departing here"];
			(_this select GIG_MARKER) setMarkerColor "ColorRed";
			_this set [GIG_ABLE_FLAG, false];
		};
		
		if ((chopper getVariable "HW_PAXCOM") < 2 || (chopper getVariable "HW_PAXCAP") < 3) then
		{
			(_this select GIG_TASKREF) setTaskState "Canceled";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["UNABLE: Your helicopter is not equipped for passenger operations! Regulation requires that you have a minimum 3 seats, plus all cabin comfort and safety items such as doors, seats and boarding steps installed.", "Shuttle Passengers", "Departing here"];
			
			(_this select GIG_MARKER) setMarkerColor "ColorRed";
			_this set [GIG_ABLE_FLAG, false];
			
		} else
		{
			(_this select GIG_TASKREF) setTaskState "Created";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept.", "Shuttle Passengers", "Departing here"];
			(_this select GIG_MARKER) setMarkerColor "ColorBlue";
			_this set [GIG_ABLE_FLAG, true];
		};
	};
	
	_expCode = 
	{		
		deleteMarker (_this select GIG_MARKER);
		player RemoveSimpleTask (_this select GIG_TASKREF);
		
		// simple expiration by timeout...
		(false)
	};
	
	
	_gig = []; _gig resize GIG_STRUCT_SIZE;
	
	_gig set [GIG_TASKREF,    _tsk];
	_gig set [GIG_MARKER,     _mkID];
	_gig set [GIG_EXP_TIME,   time + 45 + random(320)];
	_gig set [GIG_DATA_ARRAY, [_p1, _p2, RadioCall_J]];
	_gig set [GIG_CALL_CODE,  _callCode];
	_gig set [GIG_ABLE_CODE,  _ableCode];
	_gig set [GIG_EXP_CODE,   _expCode];
	
	_gig call _ableCode;
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
	
	_mkID = ("S-"+str(round time));
	_mkr = createMarker [_mkID, _p1];
	_mkr setMarkerType "hd_start";
	_mkr setMarkerDir ((AreaCenter select 0) - (_p1 select 0)) atan2 ((AreaCenter select 1) - (_p1 select 1));
	_mkr setMarkerText ("Survey | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString) + " | " + str(round((_p1 distance AreaCenter) * .01)* .1) + "km");
	
	
	_callCode =
	{
		deleteMarker (_this select GIG_MARKER);
		player RemoveSimpleTask (_this select GIG_TASKREF);
		
		(_this select GIG_DATA_ARRAY) execFSM "HeliWorks_Survey.fsm";
		
		[] spawn 
		{ 
			//
			sleep (8+random(4));
			playSound "FX_Dispatch_Beep";
		};
	};
	
	_ableCode =
	{
		if (HW_PilotCommited) exitWith
		{
			(_this select GIG_TASKREF) setTaskState "Canceled";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["You cannot request this task while engaged in another.",  "Field Survey", "Departing here"];
			(_this select GIG_MARKER) setMarkerColor "ColorRed";
			_this set [GIG_ABLE_FLAG, false];
		};
		
		if ((chopper getVariable "HW_PAXCOM") < 1 || (chopper getVariable "HW_PAXCAP") < 3) then
		{
			(_this select GIG_TASKREF) setTaskState "Canceled";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["UNABLE: Your helicopter is not equipped for observation flights! Regulation requires that you have a minimum of 3 seats and all basic safety items installed.", 
			 "Field Survey", "Departing here"];
			
			(_this select GIG_MARKER) setMarkerColor "ColorRed";
			_this set [GIG_ABLE_FLAG, false];
			
		} else
		{
			(_this select GIG_TASKREF) setTaskState "Created";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept", "Field Survey", "Departing here"];
			(_this select GIG_MARKER) setMarkerColor "ColorBlue";
			_this set [GIG_ABLE_FLAG, true];
		};
	};
	
	_expCode = 
	{		
		deleteMarker (_this select GIG_MARKER);
		player RemoveSimpleTask (_this select GIG_TASKREF);
		
		// simple expiration by timeout...
		(false)
	};
	
	
	_gig = []; _gig resize GIG_STRUCT_SIZE;
	
	_gig set [GIG_TASKREF,    _tsk];
	_gig set [GIG_MARKER,     _mkID];
	_gig set [GIG_EXP_TIME,   time + 60 + random(400)];
	_gig set [GIG_DATA_ARRAY, [_p1, _surveyPoints]];
	_gig set [GIG_CALL_CODE,  _callCode];
	_gig set [GIG_ABLE_CODE,  _ableCode];
	_gig set [GIG_EXP_CODE,   _expCode];
	
	_gig call _ableCode;
	GigLineup set [count GigLineup, _gig];
	
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
	if (count _near > 2) then { _near resize 2; }; // allow only the few closest sites for supply - it's incoherent to have miles-long trips to sling loads over
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
	
	_tsk = player createSimpleTask ["Cargo SlingLoad"];
	_tsk setSimpleTaskDestination _crewPos;
	
	_order = [_basePos, _twrPos, _baseCargo, _towerCargo];
	
	_callCode =
	{
		deleteMarker (_this select GIG_MARKER);
		player RemoveSimpleTask (_this select GIG_TASKREF);
		
		(_this select GIG_DATA_ARRAY) execFSM "HeliWorks_Cargo.fsm";
		
		[] spawn 
		{ 
			//
			sleep (8+random(4));
			playSound "FX_Dispatch_Beep";
		};
	};
	
	_ableCode =
	{
		
		if (HW_PilotCommited) exitWith
		{
			(_this select GIG_TASKREF) setTaskState "Canceled";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["You cannot request this task while engaged in another.",  "Cargo SlingLoad", "Departing here"];
			(_this select GIG_MARKER) setMarkerColor "ColorRed";
			_this set [GIG_ABLE_FLAG, false];
		};
		
		(_this select GIG_TASKREF) setTaskState "Created";
		(_this select GIG_TASKREF) setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept", "Cargo SlingLoad", "Meet Logistics Crew here"];
		(_this select GIG_MARKER) setMarkerColor "ColorBlue";
		_this set [GIG_ABLE_FLAG, true];
	};
	
	_expCode = 
	{		
		deleteMarker (_this select GIG_MARKER);
		player RemoveSimpleTask (_this select GIG_TASKREF);
		
		// simple expiration by timeout...
		(false)
	};
	
	
	_gig = []; _gig resize GIG_STRUCT_SIZE;
	
	_gig set [GIG_TASKREF,    _tsk];
	_gig set [GIG_MARKER,     _mkID];
	_gig set [GIG_EXP_TIME,   time + 90 + random(500)];
	_gig set [GIG_DATA_ARRAY,  [_crewPos, _order]];
	_gig set [GIG_CALL_CODE,  _callCode];
	_gig set [GIG_ABLE_CODE,  _ableCode];
	_gig set [GIG_EXP_CODE,   _expCode];
	
	_gig call _ableCode;
	GigLineup set [count GigLineup, _gig];
};







// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // MEDEVAC

HW_Fx_Dispatch_MEDEVAC = 
{
	//
	_pos = [[[(getPos chopper), 25000], survey_safe_zone], ["water","out"], {(_this distance player) < 30000}] call BIS_fnc_randomPos;
	_rpp = [(_pos select 0) + (random 500) -250, (_pos select 1) + (random 500) -250]; // report position - often differs from actual location....
	
	
	_mkID = ("MV-"+str(round time));
	_mkr = createMarker [_mkID, _rpp];
	_mkr setMarkerType "hd_destroy";
	_mkr setMarkerText ("MEDEVAC | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString));
	_mkr setMarkerColor "ColorRed";
	
	_tsk = player createSimpleTask ["MEDEVAC"];
	_tsk setSimpleTaskDestination _rpp;
	
	_callCode =
	{
		
		
	};
	
	_ableCode =
	{
		(_this select GIG_TASKREF) setSimpleTaskDescription ["Set task as current and call dispatch by radio to request paramedics assistance from the hospital nearest to your position.", "MEDEVAC", "Reported Accident Site"];
		(_this select GIG_MARKER) setMarkerColor "ColorBlue";
		_this set [GIG_ABLE_FLAG, true];
	};
	
	_expCode = 
	{		
		deleteMarker (_this select GIG_MARKER);
		player RemoveSimpleTask (_this select GIG_TASKREF);
		
		// simple expiration by timeout...
		(false)
	};
	
	
	_gig = []; _gig resize GIG_STRUCT_SIZE;
	
	_gig set [GIG_TASKREF,    _tsk];
	_gig set [GIG_MARKER,     _mkID];
	_gig set [GIG_EXP_TIME,   time + 250 + random(300)];
	_gig set [GIG_DATA_ARRAY, [_pos, _rpp]];
	_gig set [GIG_CALL_CODE,  _callCode];
	_gig set [GIG_ABLE_CODE,  _ableCode];
	_gig set [GIG_EXP_CODE,   _expCode];
	
	_gig call _ableCode;
	_gig execFSM "Emergency\MEDEVAC.fsm";
	
	
	GigLineup set [count GigLineup, _gig];
	
	
};




