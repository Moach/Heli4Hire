


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


HW_Fx_MEDEVAC_SpawnVictim = 
{

};