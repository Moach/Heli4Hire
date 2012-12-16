_serviceman = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_servicepad = _serviceman getVariable "OSMO_SV_servicepad";

_near_helis = nearestObjects [_servicepad, ["Helicopter"], OSMO_SV_radius];
_near_vehicles = _near_helis;
{_serviceman removeAction _x} foreach OSMO_service_actions;

_serviceman setDir ([_serviceman, _caller] call BIS_fnc_dirTo);

OSMO_service_actions = [];
OSMO_service_fuellist_opened = false;
if(count _near_vehicles > 0) then
{ 
  OSMO_service_servicelist_opened = true;
  hint "Scroll your action menu to select the vehicle.";
  {
    _vehi = _x call OSMO_SV_ChopperDisplayName;  
    _distance = (str (round (_x distance _serviceman)));
    if((str (velocity _x) == "[0,0,0]") && ((getposatl _x select 2) < 0.2)) then
    {
      _act = _serviceman addAction [format ["Service %1 at %2m away",_vehi,_distance], "scripts\OSMO_service\OSMO_service_action_fuel.sqf", _x, 6, true, false, "", "isNil {_target getVariable ""OSMO_SV_service_busy""}","",-1, -1, 1, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_repair_ca' size='1.5' shadow='true' /></t>",format ["Service %1 at %2m away",_vehi,_distance]];
      OSMO_service_actions set [count OSMO_service_actions, _act];
    };
  }foreach _near_vehicles;
  
  _act = _serviceman addAction ["Cancel", "scripts\OSMO_service\OSMO_service_action_cancel.sqf", nil, 6, true, true, "", "isNil {_target getVariable ""OSMO_SV_service_busy""}"];
  OSMO_service_actions set [count OSMO_service_actions, _act];
  
  _timer = time + 20;
  waituntil{((_caller distance _serviceman) > 6) || (time > _timer) || OSMO_service_fuellist_opened || !OSMO_service_servicelist_opened};
  if(!OSMO_service_fuellist_opened) then
  {
    [_serviceman] execVM "scripts\OSMO_service\OSMO_service_action_cancel.sqf";
  };
}
else
{
  hint "There are no nearby vehicles to service.";
}; 