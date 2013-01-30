
#include <arrayDefs.h>

HW_Hgr_WorkStandards = [5, 5, 10];
//



HW_Hgr_Select = 0; // currently selected spot (focused on the center screen)

HW_Hgr_Pads = [pad_A, pad_B, pad_C];
HW_Hgr_Spots = [chopper, objNull, objNull]; // for pads a,b and c rspectively


HW_Hgr_HangarSpot = [objNull, objNull]; // chopper in hangar, reference to pad (as seen above) to which it belongs


/*  
	load up hangar inventory with startup crap...
	actually... let's just add stuff that isn't basic equipment for now... buying replacemens will be added soon later on...
	
	...here we define how hangar invetory items are laid out through their parameters:
	
	[0] config     hardware class entry 
	[1] bool       installed to helicopter (otherwise it's back at hangar) -- at this time, this might be a redundant redundancy maybe now --
	[2] object     reference for the aformentioned possible helicopter - objNUll if in hangar
	[3] int        index for installed component where attached- as found in _heli getVariable "HW_Components"; - irrelevant if part is in hangar...
	[4] float      hours logged with this item
	[5] float      damage sustained by item
	[6] string     unique part identification tag
	[7] int 	   index of self in hangar list (updated dynamically with list)
	
	
	...later on we add cost and time for repairs to complete, making the notion of having spare parts around a very good idea for the chronologically-impaired

*/

HW_Fn_getComponentItem = 
{
	_hdwr = (_this select 0);
	_sNum = (_this select 1);
	
	// returns what follows:
	[
		_hdwr, 
		false,
		objNull, 
		-1, 
		0.0, 
		0.0,
		format ["#%1%2  :  %3", getText (_hdwr >> "serialTag"), _sNum, getText( _hdwr >> "ident") ],
		-1
	]
};




HW_Hgr_Inventory = [];  // this is ALL your owned unpacked stuff... regardless of being in the hangar or on some bird out there - you'll find it here!
HW_Hgr_SerialTag = 0;

/*
for "_i" from 0 to (count (missionConfigFile >> "cfgSimCopterHardware"))-1 do
{
	if (isClass ((missionConfigFile >> "cfgSimCopterHardware") select _i)) then
	{
		_hdwr = ((missionConfigFile >> "cfgSimCopterHardware") select _i);
		if (getNumber (_hdwr >> "minimalSpec")) > 0 then 
		{
			//
			HW_Hgr_SerialTag = HW_Hgr_SerialTag+1;
			HW_Hgr_Inventory set [(count HW_Hgr_Inventory), [_hdwr, HW_Hgr_SerialTag] call HW_Fn_getComponentItem]; 
		};
	};
};
*/




HW_Fx_InitChopper = 
{
	// gets helicopter as only parameter - uses type name to locate matching fleet class!
	
	_helicfg = missionConfigFile >> "cfgSimCopterFleet" >> (typeOf _this);
	
	_num = count (_helicfg >> "Components");
	_slots=[];
	_slots resize _num;
	for "_n" from 0 to (_num-1) do
	{
		_cp = ((_helicfg >> "Components") select _n);
		
		_hdwr = missionConfigFile >> "cfgSimCopterHardware" >> getText( _cp >> "hardwareClass");
		
		HW_Hgr_SerialTag = HW_Hgr_SerialTag+1;
		_item = [_hdwr, HW_Hgr_SerialTag] call HW_Fn_getComponentItem;
		HW_Hgr_Inventory set [(count HW_Hgr_Inventory), _item]; 
		
		if (getNumber(_cp >> "minimalSpec") > 0) then
		{
			
			//
			_item set [ITEM_isInstalled, true];
			_item set [ITEM_installHeli, _this];
			_item set [ITEM_instSlotIdx, _n];
			
			/*
				component slots list has:     
				
				[0] config   ref to component binding cfg,
				[1] config   bound hardware class
				[2] bool     installed flag
				[3] array    installed item data
				[4] int 	 index of self in components list
				[5] string   damage source
				[6] bool     minimal spec (comes with helicopter)
				[7] bool     safe to fly without or damaged
			*/
			_slots set [_n, [ _cp, _hdwr, true, _item, _n, getText( _cp >> "damageSource"), true, getNumber(_cp >> "minimalSafe") > 0]];
		} else
		{
			_slots set [_n, [ _cp, _hdwr, false, [], _n, getText( _cp >> "damageSource"),  false, getNumber(_cp >> "minimalSafe") > 0]];
		};
	};
	
	_this setVariable ["HW_airframeCfg", _helicfg];
	_this setVariable ["HW_ComponentSlots", _slots];
	_this setVariable ["HW_ExtraWeight", 0];
	
	_caps = (_heliCfg >> "Capabilities");
	_num = count _caps;
	
	for "_n" from 0 to (_num-1) do
	{
		_this setvariable [configName(_caps select _n), getNumber(_caps select _n)];
		//
	};
	
	
	_this call (compile getText( _heliCfg >> "onAirframeCapsInit" ));
  //  hint format ["Chopper Init: %1", _caps];
};



HW_Fs_AttachComponent = 
{
	_heli = _this select 0;
	_item = _this select 1;
	_slot = _this select 2;
	
	// check for dependencies...
	_fail=false;
	_problems=[];
	{
		_dep = _x;
		{
			if ( !(_x select SLOT_isInstalled) && configName (_x select SLOT_ComponentCfg) == _dep ) then
			{
				// not clear! -- we have a missing dependency for this!
				_fail=true;
				_problems set [count _problems, getText((_x select SLOT_ComponentCfg) >> "slotIdent")];
			};
		} foreach (_heli getVariable "HW_ComponentSlots");
		
	} foreach getArray((_slot select 0) >> "requiredItems");
	if (_fail) exitWith 
	{
		//
		(format ["Item Installation Requires:\n%1", _problems])
	};
	
	// we must be clear, then -- check for conflicts!
	{
		_con = _x;
		{
			if ( (_x select SLOT_isInstalled) && configName (_x select SLOT_ComponentCfg) == _con ) then
			{
				_fail=true;
				_problems set [count _problems, getText((_x select SLOT_ComponentCfg) >> "slotIdent")];
			};
		} foreach (_heli getVariable "HW_ComponentSlots");
	} foreach getArray((_slot select SLOT_ComponentCfg) >> "conflictItems");
	if (_fail) exitWith 
	{
		//
		(format ["Item Installation Conflicts with:\n%1", _problems])
	};
	
	
	
	_item set [ITEM_isInstalled, true];
	_item set [ITEM_installHeli, _heli];
	_item set [ITEM_instSlotIdx, (_slot select SLOT_installIndex)];
	
	_slot set [SLOT_isInstalled, true]; // installed now!
	_slot set [SLOT_ITEM_struct, _item];
	
	_itemMass = getNumber((_item select ITEM_HardwareCfg) >> "itemMass");
	_xtraMass = (_heli getVariable "HW_ExtraWeight") + _itemMass;
	_heli setCustomWeightRTD _xtraMass;
	_heli setVariable ["HW_ExtraWeight", _xtraMass];
	
	// ok, here we go...
	_installCode = compile getText ((_slot select SLOT_ComponentCfg) >> "onItemInstall");
	_heli call _installCode;
	
	
	
	_item set [ITEM_damageLevel, 0]; // damage to zero on install... since we don't really have any better way to fix things yet...
	if ((_slot select SLOT_damageSource) != "") then
	{
		_heli setHitpointDamage [(_slot select SLOT_damageSource), 0];
	};
	
	
	_repairCode = compile getText ((_slot select SLOT_ComponentCfg) >> "onItemRepair"); 
	_heli call _repairCode;
	
	("ok")
	
};





HW_Fs_DetachComponent = 
{
	_heli = _this select 0;
	_slot = _this select 1;
	_item = _slot select SLOT_ITEM_struct;
	
	// look for components that may have this as a requirement
	_fail=false;
	_rqrdBy=[];
	{
		_cpSlot = _x;
		if (_cpSlot select SLOT_isInstalled) then
		{
			{
				if ( configName(_slot select SLOT_ComponentCfg) == _x ) then // something else needs this installed...
				{
					_fail=true;
					_rqrdBy set [(count _rqrdBy), getText((_cpSlot select SLOT_ComponentCfg) >> "slotIdent")];
				};
			} foreach getArray((_cpSlot select SLOT_ComponentCfg) >> "requiredItems");
		};
	} foreach (_heli getVariable "HW_ComponentSlots");
	if (_fail) exitWith 
	{ 
		(format ["This item is required by:\n%1", _rqrdBy])
	};
	
	
	_item set [ITEM_isInstalled, false];
	_item set [ITEM_installHeli, objNull];
	_item set [ITEM_instSlotIdx, -1];
	
	_slot set [SLOT_isInstalled, false]; // ...and now it's out!
	_slot set [SLOT_ITEM_struct, []];
	
	_itemMass = getNumber((_item select ITEM_HardwareCfg) >> "itemMass");
	_xtraMass = (_heli getVariable "HW_ExtraWeight") - _itemMass;
	_heli setCustomWeightRTD _xtraMass;
	_heli setVariable ["HW_ExtraWeight", _xtraMass];
	
	_removeCode = compile getText ((_slot select SLOT_ComponentCfg) >> "onItemRemove");
	_heli call _removeCode;
	
	("ok")
};




HW_Fn_checkClear4Flight = 
{
	_fail=false;
	_holdOn=[];
	{
		_item=(_x select SLOT_ITEM_struct);
		if (_x select SLOT_isInstalled) then // item is installed...
		{
			_critical = getNumber((_x select SLOT_ComponentCfg) >> "criticalWear");
			
			if ((_item select ITEM_damageLevel) > _critical) then
			{
				if ((_x select SLOT_minimalSpec) || !(_x select SLOT_minimalSafe)) then // badly damaged critical and/or minimal-spec component
				{
					_fail=true;
					_holdOn set [count _holdOn, format getText((_x select SLOT_ComponentCfg) >> "slotIdent")];
				};
			};
			
		} else 
		{
			// not installed
			
			if ((_x select SLOT_minimalSpec) || !(_x select SLOT_minimalSafe)) then // missing critical and/or minimal-spec component
			{
				_fail=true;
				_holdOn set [count _holdOn, getText((_x select SLOT_ComponentCfg) >> "slotIdent")];
			};
		}
		
		
	} foreach (_heli getVariable "HW_ComponentSlots");
	
	if (_fail) exitWith
	{
		(format ["Cannot fly with damaged/missing components:\n%1", _holdOn])
	};
	
	("ok")
};









