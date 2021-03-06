

#include <arrayDefs.h>

#define CAM_R_POS [8,4,4]
#define CAM_H_POS [7,-2,3]

#define ITEM_CLR_RED [.8, .1, .1, 1]
#define ITEM_CLR_BLUE [.2, .2, .7, 1]
#define ITEM_CLR_WHITE [1, 1, 1, 1]


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


// fill up the list with inventory items!
{
	
	_idx = lbAdd [1500, _x select ITEM_uniqueIdTag];
	_x set [ITEM_hangarIndex, _idx];
	if (_x select ITEM_isInstalled) then { lbSetColor [1500, _idx, ITEM_CLR_BLUE]; }; // mark installed items in blue
	//
	
} foreach HW_Hgr_Inventory;




HW_efx_SelectActiveSpot= 
{
	HW_Hgr_Select = (_this select 0);
	if ((HW_Hgr_Pads select HW_Hgr_Select) == (HW_Hgr_HangarSpot select 1)) then // selected slot chopper is in hangar
	{
		HW_hgr_cam camSetTarget hangar_area;
		HW_hgr_cam camSetFocus [7, 2];
		HW_hgr_cam camSetRelPos CAM_H_POS;
		HW_hgr_cam camCommit 0;
		
	} else 
	{ 
		HW_hgr_cam camSetTarget (HW_Hgr_Pads select HW_Hgr_Select);
		HW_hgr_cam camSetFocus [10, 2];
		HW_hgr_cam camSetRelPos CAM_R_POS;
		HW_hgr_cam camCommit 0;
	};
	
	lbClear 1501;
	
	if (!isNull(HW_Hgr_Spots select HW_Hgr_Select)) then
	{
		_heli = (HW_Hgr_Spots select HW_Hgr_Select);
		_cfg = missionConfigFile >> "cfgSimCopterFleet" >> (typeOf _heli);
		
		//
		ctrlSetText [1003, format ["Helicopter at Pad [%1]:  %2", (["A", "B", "C"] select HW_Hgr_Select), getText ( _cfg >> "airframeIdent" )]];		
		{
			if (_x select SLOT_isInstalled) then
			{
				_item = _x select SLOT_ITEM_struct;
				_idx = lbAdd [1501, getText((_item select ITEM_HardwareCfg) >> "ident")];
				
			} else
			{
				_hdwr = _x select SLOT_hardwareCfg;
				
				_idx = lbAdd [1501, getText(_hdwr >> "ident")];
				lbSetColor [1501, _idx, ITEM_CLR_RED]; // not installed...
			};
			
		} foreach (_heli getVariable "HW_ComponentSlots");
		
	} else
	{
		// no helicopter!
		
	};
	
	
};

[0] call HW_efx_SelectActiveSpot;






HW_efx_AttachComponent =
{	
	_itemIdx = _this select 1;
	
	_heli = (HW_Hgr_Spots select HW_Hgr_Select);
	if ( isNull(_heli) ) exitWith { titleText ["There's no helicopter in this pad!", "PLAIN"]; };
	
	_curItem = (HW_Hgr_Inventory select _itemIdx); 
	
	
	_checkFail=true; // just for feedback
	_heliCfg = missionConfigFile >> "cfgSimCopterFleet" >> (typeOf _heli);
	_checkFailMsg = format ["This item is not certified for use on the %1", getText(_heliCfg >> "airframeIdent")]; // default message for no-components-match-hardware scenario
			
	
	// check helicopter components...
	{

		if ((_x select SLOT_hardwareCfg) == (_curItem select ITEM_HardwareCfg)) then // compatible! -- config entries match
		{
			// if a match exists, the contingency message is changed...
			_checkFailMsg = "Helicopter already has this installed!";
			
			// part matches a component for this helicopter, check if the slot is open			
			if (!(_x select SLOT_isInstalled)) then
			{
				
				_res = [_heli, _curItem, _x] call HW_Fs_AttachComponent;
				if (_res != "ok") exitWith
				{
					_checkFailMsg = _res;
				};
				
				_checkFail = false; // we got this far!
				
				lbSetColor [1500, _itemIdx, ITEM_CLR_BLUE];
				lbSetColor [1501, (_x select SLOT_installIndex), ITEM_CLR_WHITE];
				
				titleText [format ["Helicopter has %1kg extra weight from components.", (_heli getVariable "HW_ExtraWeight")], "PLAIN"];
				
				exit;
			};
		};
	} foreach (_heli getVariable "HW_ComponentSlots");
	
	
	// if we get this far, this component could be attached for whatever reason...
	if (_checkFail) then
	{
		//
		titleText [_checkFailMsg, "PLAIN"];
	};
};





HW_efx_DetachComponent =
{
	_compIdx = _this select 1;
	
	_heli = (HW_Hgr_Spots select HW_Hgr_Select);
	if ( isNull(_heli) ) exitWith { titleText ["There's no helicopter in this pad!", "PLAIN"]; };

	// 
	_slot = (_heli getVariable "HW_ComponentSlots") select (_compIdx);
	if ( _slot select SLOT_isInstalled ) then
	{
		_hngrIdx=((_slot select SLOT_ITEM_struct) select ITEM_hangarIndex);
		_res = [_heli, _slot] call HW_Fs_DetachComponent;
		
		if (_res != "ok") exitWith
		{
			titleText [_res, "PLAIN"];
		};
		
		lbSetColor [1501, _compIdx, ITEM_CLR_RED];
		lbSetColor [1500, _hngrIdx, ITEM_CLR_WHITE];
		
		titleText [format ["Helicopter has %1kg extra weight from components.", (_heli getVariable "HW_ExtraWeight")], "PLAIN"];
 		
	} else
	{
		//
		titleText ["That item is not installed on this helicopter!", "PLAIN"];
	};
	
};














HW_efx_Move2Hangar = 
{
	if ( isNull(HW_Hgr_Spots select HW_Hgr_Select) ) exitWith
	{
		titleText ["There's no helicopter in this pad!", "PLAIN"];
	};
	
	if ( !isNull(HW_Hgr_HangarSpot select 0) ) exitWith
	{
		titleText ["The hangar is occupied!", "PLAIN"];
	};
	
	
	titleText ["Moving Into Hangar...", "BLACK OUT", 1];
	
	_heli = (HW_Hgr_Spots select HW_Hgr_Select);
	HW_Hgr_HangarSpot = [_heli, HW_Hgr_Pads select HW_Hgr_Select];
	
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
	if ( isNull(HW_Hgr_Spots select HW_Hgr_Select) ) exitWith
	{
		titleText ["There's no helicopter in this pad!", "PLAIN"];
	};
	
	if ( isNull(HW_Hgr_HangarSpot select 0) || (HW_Hgr_HangarSpot select 0 != (HW_Hgr_Spots select HW_Hgr_Select)) ) exitWith
	{
		titleText ["This helicopter already out on the pad!", "PLAIN"];
	};
	

	titleText ["Moving Out To Helipad...", "BLACK OUT", 1];
	ctrlSetText [([1006, 1007, 1008] select HW_Hgr_Select), "..."];
	
	sleep 1;
	
	_heli = (HW_Hgr_HangarSpot select 0);
	_heli setPosATL (getPosATL (HW_Hgr_HangarSpot select 1));
	_heli setDir 70;
	
	HW_hgr_cam camSetTarget (HW_Hgr_HangarSpot select 1);
	HW_hgr_cam camSetRelPos CAM_R_POS;
	HW_hgr_cam camCommit 0;
	
	HW_Hgr_HangarSpot = [objNull, objNull];
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
