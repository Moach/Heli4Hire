
#define CAM_R_POS [8,4,4]
#define CAM_H_POS [7,-2,3]


HW_Hangar_Active = true;

createDialog "HangarDialog";

disableSerialization;
_hangarDialog = findDisplay 9300;

ctrlSetFocus (_hangarDialog displayCtrl 1701);


ctrlSetText [1005, format ["$: %1", HW_Office_Funds]];



ctrlSetText [1006, "READY"];
ctrlSetText [1007, "empty"];
ctrlSetText [1008, "empty"];


HW_hgr_cam = "camera" camCreate [(getPos pad_A) select 0, ((getPos pad_A) select 1) + 8, 3];
HW_hgr_cam cameraEffect ["External", "BACK"]; // will commit on selecting the active pad for the first time, shortly below

showCinemaBorder false;


for "_i" from 0 to (count (missionConfigFile >> "cfgSimCopterHardware"))-1 do
{
	if (isClass ((missionConfigFile >> "cfgSimCopterHardware") select _i)) then
	{
		_idx = lbAdd [1500, getText( ((missionConfigFile >> "cfgSimCopterHardware") select _i) >> "ident" )];
		//
		
	};
};






HW_efx_SelectActiveSlot= 
{
	HW_Hgr_Select = (_this select 0);
	if ((HW_Hgr_Pads select HW_Hgr_Select) == (HW_Hgr_HangarSlot select 1)) then // selected slot chopper is in hangar
	{
		HW_hgr_cam camSetTarget hangar_area;
		HW_hgr_cam camSetRelPos CAM_H_POS;
		HW_hgr_cam camCommit 0;
		
	} else 
	{ 
		HW_hgr_cam camSetTarget (HW_Hgr_Pads select HW_Hgr_Select);
		HW_hgr_cam camSetRelPos CAM_R_POS;
		HW_hgr_cam camCommit 0;
	};
	
	lbClear 1501;
	
	if (!isNull(HW_Hgr_Slots select HW_Hgr_Select)) then
	{
		_heli = (HW_Hgr_Slots select HW_Hgr_Select);
		_cfg = missionConfigFile >> "cfgSimCopterFleet" >> (typeOf _heli);
		
		//
		ctrlSetText [1003, format ["Helicopter at Pad [%1]:  %2", (["A", "B", "C"] select HW_Hgr_Select), getText ( _cfg >> "airframeIdent" )]];		
		{
			_idx = lbAdd [1501, getText(missionConfigFile >> "cfgSimCopterHardware" >> (_x select 0) >> "ident")];
			
		} foreach (_heli getVariable "HW_Hardware");
		
	} else
	{
		
		(_hangarDialog displayCtrl 1100) ctrlSetStructuredText parseText "<br />";
		
	};
	
	
};

[0] call HW_efx_SelectActiveSlot;














HW_efx_Move2Hangar = 
{
	if ( isNull(HW_Hgr_Slots select HW_Hgr_Select) ) exitWith
	{
		titleText ["There's no helicopter in this pad!", "PLAIN"];
	};
	
	if ( !isNull(HW_Hgr_HangarSlot select 0) ) exitWith
	{
		titleText ["The hangar is occupied!", "PLAIN"];
	};
	
	
	titleText ["Moving Into Hangar...", "BLACK OUT", 1];
	
	_heli = (HW_Hgr_Slots select HW_Hgr_Select);
	HW_Hgr_HangarSlot = [_heli, HW_Hgr_Pads select HW_Hgr_Select];
	
	ctrlSetText [([1006, 1007, 1008] select HW_Hgr_Select), "..."];
	sleep 1;
	
	
	_heli setPosATL (getPosATL hangar_area);
	_heli setDir 70;
	
	HW_hgr_cam camSetTarget hangar_area;
	HW_hgr_cam camSetRelPos CAM_H_POS;
	HW_hgr_cam camCommit 0;
	
	
	ctrlSetText [([1006, 1007, 1008] select HW_Hgr_Select), "IN HANGAR"];
	sleep 1;
	
	titleFadeOut 1;

};


HW_efx_Move2Helipad = 
{
	if ( isNull(HW_Hgr_Slots select HW_Hgr_Select) ) exitWith
	{
		titleText ["There's no helicopter in this pad!", "PLAIN"];
	};
	
	if ( isNull(HW_Hgr_HangarSlot select 0) || (HW_Hgr_HangarSlot select 0 != (HW_Hgr_Slots select HW_Hgr_Select)) ) exitWith
	{
		titleText ["This helicopter already out on the pad!", "PLAIN"];
	};
	

	titleText ["Moving Out To Helipad...", "BLACK OUT", 1];
	ctrlSetText [([1006, 1007, 1008] select HW_Hgr_Select), "..."];
	
	sleep 1;
	
	_heli = (HW_Hgr_HangarSlot select 0);
	_heli setPosATL (getPosATL (HW_Hgr_HangarSlot select 1));
	_heli setDir 70;
	
	HW_hgr_cam camSetTarget (HW_Hgr_HangarSlot select 1);
	HW_hgr_cam camSetRelPos CAM_R_POS;
	HW_hgr_cam camCommit 0;
	
	HW_Hgr_HangarSlot = [objNull, objNull];
	ctrlSetText [([1006, 1007, 1008] select HW_Hgr_Select), "READY"];
	sleep 1;
	
	titleFadeOut 1;

};




sliderSetPosition [1900, (HW_Hgr_WorkStandards select 0)];
sliderSetPosition [1901, (HW_Hgr_WorkStandards select 1)];
sliderSetPosition [1902, (HW_Hgr_WorkStandards select 2)];

HW_efx_SliderSet_HangarWorkStds = 
{
	_f = (sliderPosition 1900); // do it fast!
	_c = (sliderPosition 1901); // do it cheap!
	_r = (sliderPosition 1902); // do it right!
	_d = 20.0 - (_f + _c + _r);
	
	sliderSetPosition [ 1900, (_f + (_d * .5)) ];
	sliderSetPosition [ 1901, (_c + (_d * .5)) ];
	sliderSetPosition [ 1902, (_r + (_d * .5)) ];
	
	(_this select 0) sliderSetPosition (_this select 1);
	
	HW_Hgr_WorkStandards set [0, (sliderPosition 1900)];
	HW_Hgr_WorkStandards set [1, (sliderPosition 1901)];
	HW_Hgr_WorkStandards set [2, (sliderPosition 1902)];
};









waitUntil { !dialog };

HW_hgr_cam cameraEffect ["Terminate", "BACK"];
HW_hgr_cam camCommit 0;
camDestroy HW_hgr_cam;


HW_Hangar_Active = false;
