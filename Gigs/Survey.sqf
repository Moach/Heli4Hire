
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
		_num = floor((random 2) + (random 2));
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
	_tsk = player createSimpleTask ["Location Scouting"];
	_tsk setSimpleTaskDestination _p1;
	
	_mkID = ("S-"+str(round time));
	_mkr = createMarker [_mkID, _p1];
	_mkr setMarkerType "hd_start";
	_mkr setMarkerDir ((AreaCenter select 0) - (_p1 select 0)) atan2 ((AreaCenter select 1) - (_p1 select 1));
	_mkr setMarkerText ("Scout | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString) + " | " + str(round((_p1 distance AreaCenter) * .01)* .1) + "km");
	
	
	_callCode =
	{
		deleteMarker (_this select GIG_MARKER);
		player RemoveSimpleTask (_this select GIG_TASKREF);
		
		(_this select GIG_DATA_ARRAY) execFSM "Gigs\Survey.fsm";
		
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
			(_this select GIG_TASKREF) setSimpleTaskDescription ["You cannot request this task while engaged in another.",  "Location Scouting", "Departing here"];
			(_this select GIG_MARKER) setMarkerColor "ColorRed";
			_this set [GIG_ABLE_FLAG, false];
		};
		
		if ((chopper getVariable "HW_PAXCOM") < 1 || (chopper getVariable "HW_PAXCAP") < 3) then
		{
			(_this select GIG_TASKREF) setTaskState "Canceled";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["UNABLE: Your helicopter is not equipped for observation flights! Regulation requires that you have a minimum of 3 seats and all basic safety items installed.", 
			 "Location Scouting", "Departing here"];
			
			(_this select GIG_MARKER) setMarkerColor "ColorRed";
			_this set [GIG_ABLE_FLAG, false];
			
		} else
		{
			(_this select GIG_TASKREF) setTaskState "Created";
			(_this select GIG_TASKREF) setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept", "Location Scouting", "Departing here"];
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



