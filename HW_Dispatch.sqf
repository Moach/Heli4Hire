

GigLineup = [];
GigNumMax = 6; // maximum tasks presented to player at any one time...



//
// functions...

HW_Reset_RadioCalls = 
{
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
};

//
RadioCallDelay = 0;
HW_Disptach_Radio_Update = 
{
	if (time > RadioCallDelay) then
	{
		//
		central sideRadio (["HW_Radio_Update", "HW_Radio_CheckReport", "HW_Radio_MapCheck", "HW_Radio_UpdateReport", 
			"HW_Radio_CheckIn", "HW_Radio_Report", "HW_Radio_Dispatch", "HW_Radio_Update_Info"] call bis_fnc_selectRandom);
		
		RadioCallDelay = time+30; // no 'update' calls within 30 seconds from the last.... it can sound very robotic otherwise
	};
};

HW_Dispatch_Taxi = 
{
	//
	//
	
	_near = nearestLocations [getPos chopper, LocDefs_taxi, 5000];
	_p1 = locationPosition (_near call BIS_fnc_selectRandom);
	
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
	
	gig = createGroup CIVILIAN; // since we can't seem to use setVariable with tasks.... we use an empty group instead...
	
	gig setVariable ["p1", _p1];
	gig setVariable ["p2", _p2];
	gig setVariable ["exp", time + 45 + random(320)];
	gig setVariable ["mkr", _mkID];
	gig setVariable ["tsk", _tsk];
	gig setVariable ["fsm", "HeliWorks_Commute.fsm"];
	
	GigLineup set [ count GigLineup, gig ];
};



HW_Dispatch_Survey = 
{
	//
	_p1 = getPos service_helipad;
	_num = 0;
	
	if (!RadioCall_J) then // not a debug run!
	{
		_near = nearestLocations [getPos chopper, LocDefs_taxi, 6000];
		_p1 = locationPosition (_near call BIS_fnc_selectRandom);
		_num = 1+random(5);
	};
	
	
	AreaCenter = [[[_p1, 25000], survey_safe_zone], ["water","out"], {(_this distance player) < 25000}] call BIS_fnc_randomPos;
	_surveyPoints = [];
	
	AreaLimit = (3+random(4)) * 1000;
	
	for "_i" from 0 to _num do
	{
		_sp = [[[AreaCenter, AreaLimit], survey_safe_zone], ["water","out"], {(_this distance AreaCenter) < AreaLimit}] call BIS_fnc_randomPos;
		_surveyPoints set [_i, _sp];
	};
	

	_tsk = player createSimpleTask ["Area Survey"];
	_tsk setSimpleTaskDestination _p1;
	_tsk setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept", "Area Survey", "Departing here"];
	
	
	_mkID = ("S-"+str(round time));
	_mkr = createMarker [_mkID, _p1];
	_mkr setMarkerType "hd_start";
	_mkr setMarkerDir ((AreaCenter select 0) - (_p1 select 0)) atan2 ((AreaCenter select 1) - (_p1 select 1));
	_mkr setMarkerText ("Survey | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString) + " | " + str(round((_p1 distance AreaCenter) * .01)* .1) + "km");
	
	gig = createGroup CIVILIAN; // since we can't seem to use setVariable with tasks.... we use an empty group instead...
	
	gig setVariable ["p1", _p1];
	gig setVariable ["p2", _surveyPoints];
	gig setVariable ["exp", time + 60 + random(400)];
	gig setVariable ["mkr", _mkID];
	gig setVariable ["tsk", _tsk];
	gig setVariable ["fsm", "HeliWorks_Survey.fsm"];
	
	GigLineup set [ count GigLineup, gig ];
};




HW_Dispatch_Cargo = 
{
	// locate tower (the high point requiring helicopter cargo)
	//
	_twrPos = PosDefs_roofTops call bis_fnc_selectRandom; // could be done better... but let's use this for now, there are only so many worthy rooftops out there
	
	_towerCargo = round((random 4)-2) max 0; // chance of random cargo atop tower needing a ride down
	_baseCargo  = round((random 4)-_towerCargo) max 0; // quasi-random amount of stuff going up (may be zero if cargo going down exists)
	
	// select base from our beloved list of possible locations
	_near = nearestLocations [_twrPos, LocDefs_taxi, 2500];
	_baseLoc = _near call BIS_fnc_selectRandom;
	_basePos = locationPosition (_baseLoc);
	
	
	if ((type _baseLoc) == "Heliport") then // heliports have a little caveat... they may be on top of something!
	{
		_atts = 0; // do some extra runs to try and use only ground locations, lest having the base atop some building (possibly higher up than the tower itself)
		while { _atts > -1 && _atts < 8 } do 
		{
			_castPos = _basePos; 
			_castPos set [2, 1000];	
			
			if ( lineIntersects [_castPos, _basePos, player, chopper] ) then
			{
				_basePos = locationPosition (_near call BIS_fnc_selectRandom); // try another...
				_atts = _atts+1;
			} else
			{
				_atts = -1;
			};
		};
	};
	
	
	// most times, the load crew is already at the base site - if not, then picking them up is the first order of the day...
	_crewPos = _basePos;
	if (random(5) > 2) then 
	{
		_near = nearestLocations [_basePos, LocDefs_taxi, 10000];
		_crewPos = locationPosition (_near call BIS_fnc_selectRandom);
	};

	_mkID = ("C-"+str(round time));
	_mkr = createMarker [_mkID, _crewPos];
	_mkr setMarkerType "hd_join";
	_mkr setMarkerText ("Cargo | " + ([daytime, "HH:MM"] call BIS_fnc_timeToString));
	
	_tsk = player createSimpleTask ["Cargo SlingLoad"];
	_tsk setSimpleTaskDestination _crewPos;
	_tsk setSimpleTaskDescription ["Set task as current and call dispatch by radio to accept", "Cargo SlingLoad", "Meet Logistics Crew here"];
	
	_order = [_basePos, _twrPos, _baseCargo, _towerCargo];
	
	gig = createGroup CIVILIAN; // since we can't seem to use setVariable with tasks.... we use an empty group instead...	
	gig setVariable ["p1", _crewPos];
	gig setVariable ["p2", _order]; // p2 holds our work order!
	gig setVariable ["exp", time + 60 + random(500)];
	gig setVariable ["mkr", _mkID];
	gig setVariable ["tsk", _tsk];
	gig setVariable ["fsm", "HeliWorks_Cargo.fsm"];
	
	GigLineup set [ count GigLineup, gig ];
};






HW_Pilot_Task_Commit = 
{
	_tsk = currentTask player; // well, as setVariable with tasks isn't working..... we loop to find ours
	{ 
		if ((_x getVariable "tsk") == _tsk) then 
		{ 
			// we should have it by now.... i hope
	
			_p1  = _x getVariable "p1";
			_p2  = _x getVariable "p2";
			_mkr = _x getVariable "mkr";
			_fsm = _x getVariable "fsm";
			
			deleteMarker _mkr;
			player RemoveSimpleTask _tsk;
			
			1 setRadioMsg "NULL";
			2 setRadioMsg "NULL";
			
			RadioCallDelay = time+30; // since dispatch man will call a report after acknowledging your commit, this counts for a non-repeat delay
			[_p1, _p2] execFSM _fsm;
			
			deleteGroup _x;
			exit;
		}; 
		
	} foreach GigLineup;
};





// //////////////////////////////////////////////////////////////  //////////////////////////////////////////////////////////////
// //////////////////////////////////////////////////////////////  //////////////////////////////////////////////////////////////
// //////////////////////////////////////////////////////////////  //////////////////////////////////////////////////////////////


//  generator loop...
//
//

player execFSM "HW_Dispatch_Gen.fsm";

if (HW_DEBUG) then // enable only for debug!
{	
	while { true } do
	{
	
		10 setRadioMsg "DEBUG!";
		
		waitUntil { sleep 1; RadioCall_J };
		
		player moveInDriver chopper;
		chopper setBatteryRTD true;
		
		10 setRadioMsg "NULL";
		
		sleep 1;
		call HW_Dispatch_Cargo;
		
		RadioCall_J = false;
	};
};







