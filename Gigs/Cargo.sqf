



// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // //////////////////////////////////////////// 
// //////////////////////////////////////////// // //////////////////////////////////////////// // Cargo SlingLoad

HW_Fx_Dispatch_Cargo = 
{
	// locate tower (the high point requiring helicopter cargo)
	//
	_twrPos = (PosDefs_roofTops call bis_fnc_selectRandom) select 1; 
	
	_towerCargo = round((random 2)-1) max 0; // chance of random cargo atop tower needing a ride down (two is the max to have coming down, not much room up there)
	_baseCargo  = ceil((random 2)-_towerCargo) max 0; // quasi-random amount of stuff going up (may be zero if cargo going down exists)
	
	if(_towerCargo+_baseCargo < 1) then // what da? no cargo = no job!
	{
		_towerCargo = 1; // fallback to 'one coming down' in the off chance this happens...
	};
	if(_towerCargo+_baseCargo > 3) then // what da? no cargo = no job!
	{
		_baseCargo = 1; // avoid too-long missions by removing base cargo if we ever exceed the maximum 3
	};
	
	if (RadioCall_J) then // override for debug run!
	{
		_towerCargo = 1;
		_baseCargo  = 1;
	};
	
	
	// select base from our beloved list of possible locations -- note that this is only the CARGO set, it does NOT allow above-ground pads, so unhandly those can be...
	_near = nearestLocations [_twrPos, ["ConstructionSupply"], 10000];
	// if (count _near > 2) then { _near resize 2; }; // allow only the few closest sites for supply - it's incoherent to have miles-long trips to sling loads over
	//
	_basePos = locationPosition (_near select 0);
	
	
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
	_mkr setMarkerText ("Cargo | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString) + " | " + (format ["%1/%2", _towerCargo, _baseCargo]));
	
	_tsk = player createSimpleTask ["Cargo SlingLoad"];
	_tsk setSimpleTaskDestination _crewPos;
	
	_order = [_basePos, _twrPos, _baseCargo, _towerCargo];
	
	_callCode =
	{
		deleteMarker (_this select GIG_MARKER);
		player RemoveSimpleTask (_this select GIG_TASKREF);
		
		(_this select GIG_DATA_ARRAY) execFSM "Gigs\Cargo.fsm";
		
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
			(_this select GIG_TASKREF) setSimpleTaskDescription ["You cannot request this task while engaged in another.", "Cargo SlingLoad", "Meet Logistics Crew here"];
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






