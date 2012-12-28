#include "\HSim\Modules_H\functions\wlib\_shared\formatting.hpp"

_heli = _this;

private ["_hps", "_ids", "_idHPs","_compartments"];
_hps = _heli call BIS_fnc_helicopterGetHitpoints;
_ids = [];
_idHPs = [];
_compartments = [];
		
private ["_cfgInspection"];
_cfgInspection = configFile >> "CfgVehicles" >> (typeOf _heli) >> "Inspection";

//Retrieve and initialize compartment accessable states
for "_i" from 0 to (getNumber (_cfgInspection >> "compartments")) do
{
  _compartments set [_i, if (_i == 0) then {true} else {false}];
};
_heli setVariable ["HSim_compartments", _compartments];

TEST_inspectable = [];
TEST_hydraulics = "";
TEST_batteries = "";
for "_i" from 0 to ((count _hps) - 1) do
{
  private ["_hp", "_hpCfg", "_displayName"];
  _hp = _hps select _i;
  _hpCfg = _cfgInspection >> "Hitpoints" >> _hp;
  _displayName = getText (_hpCfg >> "displayName");

  if ((getNumber (_hpCfg >> "inspectable")) == 1) then
  {
    private ["_visuals", "_compartment", "_radius", "_radiusView"];
    _visuals = getArray (_hpCfg >> "visuals");
    _compartment = getNumber (_hpCfg >> "compartment");
    _radius = getNumber (_hpCfg >> "radius");
    if (_radius == 0) then {_radius = 2.5;};
    _radiusView = getNumber (_hpCfg >> "radiusView");
    if (_radiusView == 0) then {_radiusView = 0.1;};
    
    // DEBUG
    if(_heli == testplane) then
    {
      TEST_inspectable set [count TEST_inspectable, _displayName];    
    };

    // Add inspection actions for all components
    // Some components have more than 1 inspection point
    private ["_j"];
    _j = 1;
    while {true} do
    {
      private ["_mp", "_pos"];
      _mp = "Inspect_" + _hp + (str _j);
      _pos = _heli selectionPosition _mp;
      if ((_pos distance [0, 0, 0]) < 0.001) exitWith {};

      private ["_text", "_cond", "_id"];
      _text = "Inspect " + _displayName;

      // Test compartment conditions if necessary
      _cond = "";
      if (_compartment != 0) then
      {
        _cond = format ["(_target getVariable 'HSim_compartments') select %1", _compartment];
      };

      private ["_icon"];
      _icon = if(_hp == "HitHRotor" || _hp == "HitVRotor") then {INSPECTION_ICON("hand")} else {INSPECTION_ICON("look_0")};
      _id = _heli addAction
      [
        _text, "scripts\OSMO_interaction\OSMO_intearction_inspect.sqf", [_hp, _i], 10, true, false, "", _cond, _mp,
        _radius, _radiusView, 1+8, 4,
        _icon,
        _text
      ];

      // We need to store the IDs for detection later on
      _ids set [count _ids, _id];
      _idHPs set [count _idHPs, _hp];

      _j = _j + 1;
    };
  };
};

// Adding fuel inspection to heavy chopper manually
if(_heli isKindOf "Heli_Heavy_Base_H") then
{
  _id = _heli addAction
  [
    "Inspect Fuel Tank", "scripts\OSMO_interaction\OSMO_intearction_inspect.sqf", ["HitFuel", 1], 10, true, false, "", "(((_this distance (_target modeltoworld [-2,-1.7,-3])) < 1.5) || ((_this distance (_target modeltoworld [2,-1.7,-3])) < 1.5)) && !(_this in _target)", "",
    -1, -1, 1+8, 4,
    INSPECTION_ICON("look_0"),
    "Inspect Fuel Tank"
  ];
};

// Adding hydraulics inspection
_heli addAction
[
  "Inspect Hydraulics", "scripts\OSMO_interaction\OSMO_intearction_inspect.sqf", ["HitHydraulics", 1], 10, false, false, "", "", "",
  -1, -1, 1+2, 1,
  INSPECTION_ICON("look_0"),
  "Inspect Hydraulics"
];


_heli setVariable ["HSim_actionIDs", _ids];
_heli setVariable ["HSim_actionIDHitpoints", _idHPs];
_heli setVariable ["HSim_hitpoints", _hps];


// TODO: Add obstructions

if(OSMO_INT_obstructions && isServer && !HW_DEBUG) then
{
  // Randomly trigger obstructions defined in config
  private ["_cfgObstructions", "_obstructIDs"];
  _cfgObstructions = _cfgInspection >> "Obstructions";
  _obstructIDs = [];

  for "_i" from 1 to (count _cfgObstructions) do
  {
    private ["_mp", "_obstruction"];
    _mp = "Inspect_Obstruction" + (str _i);
    _obstruction = _cfgObstructions select (_i - 1);

    // if (true) then
    if ((random 30) < 2) then
	{
      Heli_Has_Obstruction = true;
	  
	  private ["_visual", "_cond", "_id"];
	 
	  // added many different things that can end up in an engine compartment... BAD things to have near a running engine!
	  _visual = (["Nest_H", "Hammer_H", "Wrench_H", "Pliers_H", "Gloves_H", "DustMask_H", "LightStick_H"] call BIS_fnc_selectRandom) createVehicle [100, 100, 100];
      _visual setDir (random 360);
      _visual attachTo [_heli, _heli selectionPosition _mp];

      private ["_radius", "_radiusView"];
      _radius = getNumber (_obstruction >> "radius");
      if (_radius == 0) then {_radius = 2.5;};
      _radiusView = getNumber (_obstruction >> "radiusView");
      if (_radiusView == 0) then {_radiusView = 0.1;};

      // Condition
      _compartment = getNumber (_obstruction >> "compartment");
      _cond = "";
      if (_compartment != 0) then
      {
        _cond = format ["(_target getVariable 'HSim_compartments') select %1", _compartment];
      };
      
      // Add inspection action
      _id = _heli addAction
      [
        "Remove obstruction", "scripts\OSMO_interaction\OSMO_interaction_remove_obstuction.sqf", [_i, _obstruction, _visual], 15, true, false, "", _cond, "",
        _radius, _radiusView, 1+8, 4,
        INSPECTION_ICON("hand"),
        "Remove"
      ];
      _obstructIDs set [_i - 1, _id];
    }
    else
    {
      _obstructIDs set [_i - 1, -1];
    };
  };
  _heli setVariable ["HSim_obstructionIDs", _obstructIDs, true];
};

// Set event handler to check if there are obstructions, cause damage to engine if yes
// _this setHitPointDamage ["HitEngine", (_this getHitPointDamage "HitEngine") + 0.2];


// Functions

OSMO_INS_HitpointDisplayName = 
{
  private ["_heli","_hp","_displayName"];
  _heli = _this select 0;
  _hp = _this select 1;
  _displayName = getText (configFile >> "CfgVehicles" >> (typeOf _heli) >> "Inspection" >> "Hitpoints" >> _hp >> "displayName");	
  _displayName;
};


OSMO_INS_DamageToText = 
{
  private ["_damageDesc", "_color", "_returnval"];
  switch true do
  {
    case(_this == 0): {_damageDesc = "looks good!"; _color = "00FF00";};
    case(_this > 0 && _this <= 0.33): {_damageDesc = "ain't quite perfect!"; _color = "88FF00";};
    case((_this > 0.33 && _this < 0.66)): {_damageDesc = "could use some attention!"; _color = "FF8800";};
    case(_this > 0.66): {_damageDesc = "has seen better days!"; _color = "FF0000";};
  };
  _returnval = [_damageDesc, _color];
  _returnval;
};

OSMO_INS__UpdateInspectIcon = 
{
	private["_filename","_id","_text", "_actiontext", "_heli", "_color"];

	_id     = _this select 0;
	_filename = _this select 1;
	_text     = _this select 2;
	_actiontext  = _this select 3;
	_heli     = _this select 4;
	_color = _this select 5;
	
  if (_color == "") then
	{
		_heli setUserActionText[_id,_text,INSPECTION_ICON(_filename),_actiontext];
	}
	else
	{
		_heli setUserActionText[_id,_text,INSPECTION_ICON_COLOR(_filename,_color),_actiontext];
	};
};