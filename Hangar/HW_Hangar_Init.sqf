


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
	
	_num = count (_cfg >> "Components");
	_cmps=[];
	_cmps resize _num;
	_n=0;
	for "_i" from 0 to (_num-1) do
	{
		_cp = ((_cfg >> "Components") select _i);
		if (isClass (_cp) && getNumber (_cp >> "minimalSpec") > 0) then
		{
			_cmps set [_n, [_i, 0, 0]]; // components Nth index, damage, logged time
			_n = _n+1;
			//
		};
		
	};
	
	_this setVariable ["HW_Components", _cmps];
	_this setVariable ["HW_PaxCap", 1];
	_this lockCargo true;
	
	hint format ["Chopper Init: %1 Basic Components", count _cmps];
};




HW_Fn_GetHardware = 
{
	
	
};