

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
	
	_near = nearestLocations [_p1, LocDefs_taxi, 30000];
	
	
	_size = count _near;
	_dmin = round(_size * .3); // remove the given nearest percentage of locations found - this culls out unreasonably close legs and the same-pad bug
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
		
		(_this select GIG_DATA_ARRAY) execFSM "Gigs\Commute.fsm";
		
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
			(_this select GIG_TASKREF) setSimpleTaskDescription ["You cannot request this task while engaged in another.",  "Passenger Shuttle", "Departing here"];
			(_this select GIG_MARKER) setMarkerColor "ColorRed";
			_this set [GIG_ABLE_FLAG, false];
		};
		
		if ((chopper getVariable "HW_PAXCOM") < 2 || (chopper getVariable "HW_PAXCAP") < 3) then
		{
			(_this select GIG_TASKREF) setTaskState "Canceled";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["UNABLE: Your helicopter is not equipped for passenger operations! Regulation requires that you have a minimum 3 seats, plus all cabin comfort and safety items such as doors, seats and boarding steps installed.", "Passenger Shuttle", "Departing here"];
			
			(_this select GIG_MARKER) setMarkerColor "ColorRed";
			_this set [GIG_ABLE_FLAG, false];
			
		} else
		{
			(_this select GIG_TASKREF) setTaskState "Created";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept.", "Passenger Shuttle", "Departing here"];
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


