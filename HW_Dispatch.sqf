

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
	
	GigLineup set [ count GigLineup, gig ];
};




HW_Pilot_Task_Commit = 
{
	_tsk = currentTask player; // well, as setVariable with tasks isn't working.....
	{ 
		if ((_x getVariable "tsk") == _tsk) then 
		{ 
			// we should have it by now.... i hope
	
			_p1  = _x getVariable "p1";
			_p2  = _x getVariable "p2";
			_mkr = _x getVariable "mkr";
			
			deleteMarker _mkr;
			player RemoveSimpleTask _tsk;
			
			1 setRadioMsg "NULL";
			2 setRadioMsg "NULL";
			
			RadioCallDelay = time+30; // since dispatch man will call a report after acknowledging your commit, this counts for a non-repeat delay
			OnCall = [_p1, _p2] execFSM "HeliWorks_Commute.fsm";
			
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












