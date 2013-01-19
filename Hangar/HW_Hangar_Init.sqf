


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
	[6] bool       is minimal spec item
	[7] bool       is it safe to fly without
	[8] string     unique part identification tag
	[9] int 	   index of self in hangar array (mayc hange as parts get sold away, but for now that ain't gonna happen)
	
	
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
		false,
		false,
		format ["#%1%2  :  %3", getText (_hdwr >> "serialTag"), _sNum, getText( _hdwr >> "ident") ],
		(count HW_Hgr_Inventory)
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
			_item set [6, true];
			//
			_item set [1, true];
			_item set [2, _this];
			_item set [3, _n];
			
			/*
				component slots list has:     
				
				[0] config   ref to component binding cfg,
				[1] config   bound hardware class
				[2] bool     installed flag, 
				[3] array    installed item data, 
				[4] int 	 index of self in list
			*/
			_slots set [_n, [ _cp, _hdwr, true, _item, _n]]; 
		} else
		{
			_slots set [_n, [ _cp, _hdwr,false, [], _n]];
		};
	};
	
	_this setVariable ["HW_airframeCfg", _helicfg];
	_this setVariable ["HW_ComponentSlots", _slots];
	_this setVariable ["HW_PaxCap", 1];
	_this lockCargo true;
	
	hint format ["Chopper Init: %1 Components", count _slots];
};



HW_Fx_AttachComponent = 
{
	_heli = _this select 0;
	_item = _this select 1;
	_slot = _this select 2;
	
	_item set [1, true];
	_item set [2, _heli];
	_item set [3, (_slot select 3)];
	
	_slot set [2, true]; // installed now!
	_slot set [3, _item];
	
	// ok, here we go...
	_installCode = compile getText ((_slot select 0) >> "onItemInstall");
	_heli call _installCode;
};





















