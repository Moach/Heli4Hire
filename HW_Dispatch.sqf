

GigLineup = [];
GigNumMax = 8; // maximum tasks presented to player at any one time...


HW_CannotComply=false;
Pilot_Commited=false;

// this is used for missions where a decision is prompted to the pilot, zero sets the "expecting answer" state, higher values correspond to specific options
// should be reset to zero after use....
PilotDecision = 0;
PD_Armed = false; // indicates if pilot decisions are available
PD_Actions = [];  // tracks menu action ids for pilot decisions




#include <Gigs.h>
//


#include <Gigs\Commute.sqf>
#include <Gigs\Survey.sqf>
#include <Gigs\Cargo.sqf>






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

HW_Fx_Clear_All_Radio = 
{
	call HW_Fx_Reset_RadioCalls;
	
	1 setRadioMsg "NULL";      6 setRadioMsg "NULL";
	2 setRadioMsg "NULL";      7 setRadioMsg "NULL";
	3 setRadioMsg "NULL";      8 setRadioMsg "NULL";
	4 setRadioMsg "NULL";      9 setRadioMsg "NULL";
	5 setRadioMsg "NULL";     10 setRadioMsg "NULL";
};




//
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





HW_Fx_Gig_Generator = 
{
	// 
	//  entries below appear multiple times as needed to adjust the relative likelyhood of each type of gig...
	//   these are the initiator functions defined in the script included earlier
	
	_random_fnc_dispatchGig =
	 [
		HW_Fx_Dispatch_Taxi, HW_Fx_Dispatch_Taxi, HW_Fx_Dispatch_Taxi, HW_Fx_Dispatch_Taxi, HW_Fx_Dispatch_Taxi,
		HW_Fx_Dispatch_Survey, HW_Fx_Dispatch_Survey, HW_Fx_Dispatch_Survey,
		HW_Fx_Dispatch_Cargo, HW_Fx_Dispatch_Cargo
	//	HW_Fx_Dispatch_MEDEVAC, HW_Fx_Dispatch_MEDEVAC, HW_Fx_Dispatch_MEDEVAC

	] call BIS_fnc_selectRandom;
	

	call _random_fnc_dispatchGig;

	playSound "FX_Dispatch_Chime";
	// if (random (10) <  2.5) then {  call HW_Fx_Disptach_Radio_Update;  }; // dispatch won't always call out a new gig by radio, most times, it's just a chime
};




HW_Fx_Gig_Tasks_Update = 
{
	_GigCycleCheck = GigLineup;
	GigLineup = [];

	_down = false;
	{
		if (time > (_x select GIG_EXP_TIME)) then
		{
			// run expiration code now!
			_exp = _x call (_x select GIG_EXP_CODE);
			if (!_exp) then
			{
				// if not good... well, then we kill them				
				
				_x = nil;
				_down = true;
			};
		} else
		{
			// still good - keep it!
			GigLineup set [count GigLineup, _x];
			
			// update pilot information...
			
			
			
		};
	} foreach _GigCycleCheck;
	
	if (_down) then
	{
		playSound "FX_Dispatch_Beep";
	};
};



HW_Fx_All_Gigs_AbleCheck =
{
	{
		_x call (_x select GIG_ABLE_CODE);
		//
	} foreach GigLineup;
};



HW_Fx_Pilot_Task_Commit = 
{
	
	_tsk = currentTask player; // find gig array with this task
	{ 
		if ((_x select GIG_TASKREF) == _tsk) then 
		{ 
			// we should have it by now.... i hope
			HW_PilotCommited = true;
			
			1 setRadioMsg "NULL";
			2 setRadioMsg "NULL";	
			RadioCallDelay = time+30; // since dispatch man will call a report after acknowledging your commit, this counts for a non-repeat delay
			
			_x call (_x select GIG_CALL_CODE); // run the call code!
			
			
		} else // as well as searching for our requested gig, this loop will reset all others so they are disabled until second notice
		{
			_x call (_x select GIG_ABLE_CODE); // since this function is called by the fsm right after setting the commit flag on, gigs should update themselves accordingly...
			
		};
		
	} foreach GigLineup;
};




HW_Fx_Clear_All_Tasks =
{
	{
		player RemoveSimpleTask (_x select GIG_TASKREF);
		deleteMarker (_x select GIG_MARKER);
		_x = nil;
		
	} foreach GigLineup;

	GigLineup = [];	
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
		
		RadioCall_A = true; // auto call in as available
		
	//	sleep 1;
		call HW_Fx_Dispatch_Cargo;
		
		RadioCall_J = false;
	};
};







