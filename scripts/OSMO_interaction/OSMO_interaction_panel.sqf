private ["_heli", "_params", "_mode", "_index", "_cfgPanel", "_compartment", "_componentCount", "_animTiming", "_mp"];
_heli = _this select 0;
_params = _this select 3;
_mode = _params select 0;
_index = _params select 1;
_cfgPanel = _params select 2;
_compartment = getNumber (_cfgPanel >> "accessToCompartment");
_componentCount = getNumber (_cfgPanel >> "componentCount");
_mp = "Inspect_Panel" + (str _index);

//Animate using timings and store correct open status (i.e. 2 panels may provide access to same compartment)
private ["_start", "_end", "_step"];
if (_mode) then 
{
	_start = 1;
	_end = _componentCount;
	_step = 1;
	_animTiming = getArray (_cfgPanel >> "animTimingOpen");
} 
else 
{
	_start = _componentCount;
	_end = 1;
	_step = -1;
	_animTiming = getArray (_cfgPanel >> "animTimingClose");
};

for "_i" from _start to _end step _step do 
{
	sleep (_animTiming select (_i - 1));
	_heli animate [_mp + "_" + (str _i), if (_mode) then {1} else {0}];
};

//Update compartment status
_heliCompartments = (_heli getVariable "HSim_compartments");
_heliCompartments set [_compartment, _mode];
_heli setVariable ["HSim_compartments", _heliCompartments, true];

true