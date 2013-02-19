// Service parameters
OSMO_SV_insptime = 5; // (seconds) The time it takes for service men to inspect vehicle
OSMO_SV_fueltime = 60; // (seconds) The time it takes for for completely empty fueltank to be refueled into full
OSMO_SV_hpfixtime = 30; // (seconds) The time it takes for service men to fix each fully damaged hitpoint
OSMO_SV_maxtime = 5; //  (minutes) Maximum time the service (not including inspection) can take
OSMO_SV_radius = 20; // (meters) Maximum distance of the helicopter from the helipad for service to be available

_servicepad = _this select 0;
_hangout = _this select 1;

if(isNil{_servicepad}) exitWith {hint "Error in OSMO_service: Cannot find service pad";};
if("[0,0,0]" == (str getMarkerPos _hangout)) exitWith {hint "Error in OSMO_service: Can not find hangout marker";};

OSMO_SV_switchMove = {(_this select 0) switchMove (_this select 1)};
OSMO_SV_setGroupID = {(_this select 0) setGroupID (_this select 1)};
OSMO_SV_serviceChat = {if((player distance (_this select 0) < 20)) then {(_this select 0) globalChat (_this select 1);};};
OSMO_SV_serviceHint = {if((player distance (_this select 0) < 20)) then {hintSilent (parseText (_this select 1));};};
OSMO_SV_startService = {if(isServer) then {_this execVM "scripts\OSMO_service\OSMO_service.sqf"};};
OSMO_SV_enablesimu = {(_this select 0) enableSimulation true;};
OSMO_SV_refuel = {(_this select 0) setFuel (_this select 1);};
OSMO_SV_rearm = {(_this select 0) setVehicleAmmo 1;};
OSMO_SV_addServiceAction = 
{
  if(isNil{_this getVariable "OSMO_SV_service_action_added"}) then
  {
    _this addAction ["Service", "scripts\OSMO_service\OSMO_service_action_initial.sqf", nil, 10, true, false, "", "(_this distance _target < 6) && isNil {_target getVariable ""OSMO_SV_service_busy""} && !OSMO_service_servicelist_opened","",-1, -1, 1, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_repair_ca' size='1.5' shadow='true' /></t>","Service"];
    _this setVariable ["OSMO_SV_service_action_added",true,false];
  };
};
OSMO_service_fuellist_opened = false;
OSMO_service_servicelist_opened = false;

if(isNil{OSMO_initvehicle}) then
{
  OSMO_initvehicle = {};
};

if(isServer) then
{
  if(isNil{OSMO_SV_serviceMenArray}) then
  {
    OSMO_SV_serviceMenArray = [];
  };
   
  _serviceGroup = createGroup CIVILIAN;
  _serviceMan1 = _serviceGroup createUnit ["Workman_Random_H", getMarkerPos _hangout, [], 3, "FORM"];
  _serviceMan2 = _serviceGroup createUnit ["Workman_Random_H", getMarkerPos _hangout, [], 3, "FORM"];
  _serviceMan3 = _serviceGroup createUnit ["Workman_Random_H", getMarkerPos _hangout, [], 3, "FORM"];
  
  [_serviceMan1,_serviceMan2,_serviceMan3] joinsilent _serviceGroup;
  
  [[_serviceGroup, ["Helicopter Service"]],  "OSMO_SV_setGroupID", nil, false, true] call BIS_fnc_MP;

  _serviceMan1 setDir ([_serviceMan1, _serviceMan2] call BIS_fnc_dirTo);
  _serviceMan2 setDir ([_serviceMan2, _serviceMan1] call BIS_fnc_dirTo);
  _serviceMan3 setDir ([_serviceMan3, _servicepad] call BIS_fnc_dirTo);
  
  _serviceMan1 setPosATL [getPos _serviceMan1 select 0, getPos _serviceMan1 select 1, 0];
  _serviceMan2 setPosATL [getPos _serviceMan2 select 0, getPos _serviceMan2 select 1, 0];
  _serviceMan3 setPosATL [getPos _serviceMan3 select 0, getPos _serviceMan3 select 1, 0];
  
  {
    _x allowDamage false; 
    _x disableAI "move";
    _x SetVariable ["OSMO_SV_servicepad",_servicepad,true];        
    OSMO_SV_serviceMenArray set [count OSMO_SV_serviceMenArray, _x];
  } foreach (units _serviceGroup);
  publicvariable "OSMO_SV_serviceMenArray";
  "OSMO_SV_beginServiceArray" addPublicVariableEventHandler {OSMO_SV_beginServiceArray call OSMO_SV_startService;};
};

if(!isDedicated) then
{
  if(!isNil{OSMO_SV_serviceMenArray}) then
  {
    {_x call OSMO_SV_addServiceAction;} foreach OSMO_SV_serviceMenArray;
  };
  "OSMO_SV_serviceMenArray" addPublicVariableEventHandler {{_x call OSMO_SV_addServiceAction;} foreach OSMO_SV_serviceMenArray;};
};


// Functions

OSMO_SV_ChopperDisplayName = 
{
  private ["_chtext"];
  _chtext = getText(configFile >> "CfgVehicles" >> (typeOf _this) >> "DisplayName");
  _chtext;
};   

OSMO_SV_HitpointDisplayName = 
{
  _hptext = switch(_this) do
  {
    case("HitEngine"): {"Engine"};
    case("HitEngine2"): {"Engine 2"};
    case("HitEngine3"): {"Engine 3"};
    case("HitHull"): {"Hull"};
    case("HitHRotor"): {"Main rotor"};
    case("HitVRotor"): {"Tail rotor"};
    case("HitBatteries"): {"Electrical system"};
    case("HitLight"): {"Landing Light"};
    case("HitMissiles"): {"Missiles"};
    case("HitHydraulics"): {"Hydraulics system"};
    case("HitTransmission"): {"Transmission"};
    case("HitAvionics"): {"Avionics"};
    case("HitGear"): {"Landing gear"};
    case("HitFuel"): {"Fuel tank"};
    case("HitHStabilizerL1"): {"Left horizonal stabilizer"};
    case("HitHStabilizerR1"): {"Right horizontal stabilizer"};
    case("HitVStabilizer1"): {"Vertical stabilizer"};
    case("HitTail"): {"Tail boom"};
    case("HitPitotTube"): {"Pitot tube"};
    case("HitStaticPort"): {"Static port"};
    case("HitStarter1"): {"Starter"};
    case("HitStarter2"): {"Starter 2"};
    case("HitStarter3"): {"Starter 3"};
    case("HitRGlass"): {"Right side glass"};
    case("HitLGlass"): {"Left side glass"};
    case("HitGlass1"): {"Glass #1"};
    case("HitGlass2"): {"Glass #2"};
    case("HitGlass3"): {"Glass #3"};
    case("HitGlass4"): {"Glass #4"};
    case("HitGlass5"): {"Glass #5"};
    case("HitGlass6"): {"Glass #6"};
  };
  _hptext;
};

OSMO_SV_DamageToText = 
{
  private ["_damageDesc", "_color", "_returnval"];
  switch true do
  {
    case(_this == 0): {_damageDesc = "ok"; _color = "#00FF00";};
    case(_this > 0 && _this <= 0.33): {_damageDesc = "minor"; _color = "#FFFF00";};
    case((_this > 0.33 && _this < 0.66)): {_damageDesc = "problematic"; _color = "#FF8800";};
    case(_this > 0.66): {_damageDesc = "severe"; _color = "#FF0000";};
  };
  _returnval = [_damageDesc, _color];
  _returnval;
};