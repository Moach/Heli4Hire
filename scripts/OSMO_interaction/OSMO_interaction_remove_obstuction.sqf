private ["_heli", "_params", "_index"];
_heli = _this select 0;
_id = _this select 2;
_params = _this select 3;
_index = _params select 0;

// Remove the action
// _heli removeAction ((_heli getVariable "HSim_obstructionIDs") select (_index - 1));
_heli removeAction _id;

// Remove the visual
deleteVehicle (_params select 2);

Heli_Has_Obstruction = false;

// Remove the stored Code to execute
// (_heli getVariable "HSim_obstructionIDs") set [_index - 1, {}, true];

true