


HW_Hgr_WorkStandards = [5, 5, 10];
//



HW_Hgr_Select = 0; // currently selected slot (focused on the center screen)

HW_Hgr_Pads = [pad_A, pad_B, pad_C];
HW_Hgr_Slots = [chopper, objNull, objNull]; // for pads a,b and c rspectively


HW_Hgr_HangarSlot = [objNull, objNull]; // chopper in hangar, reference to pad (as seen above) to which it belongs



/*
	take a regular chopper, throw it in, get it rigged out and ready for the hangar!
*/
HW_Fx_InitChopper = 
{
	// gets helicopter as only parameter - uses type name to locate matching fleet class!
	
	_cfg = missionConfigFile >> "cfgSimCopterFleet" >> (typeOf _this);
	
	_hdwr=[];
	_i=0;
	_hdwr resize count (_cfg >> "basicHardware");
	{
		_hdwr set [_i, [_x, 0]]; 
		_i = _i+1;
		//
		
	} foreach getArray(_cfg >> "basicHardware");
	
	_this setVariable ["HW_Hardware", _hdwr];
	_this setVariable ["HW_PaxCap", 1];
	_this lockCargo true;
	
	hint format ["%1", _hdwr];
};




HW_Fn_GetHardware = 
{
	
	
};