_heli = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_inspectparams = _this select 3;
_hitpoint = _inspectparams select 0;
_hpid = _inspectparams select 1;

_partname = [_heli,_hitpoint] call OSMO_INS_HitpointDisplayName;

_anim = "Inspect_" + _hitpoint + "1";
[_heli,_anim] spawn 
{
  _heli = _this select 0;
  _anim = _this select 1;
  _heli animate [_anim, if ((_heli animationPhase _anim) == 0) then {1} else {0}]; 
};

private["_showCond","_frame","_file","_finished", "_max", "_iconstart"];

_frame = 0;
_max = 4;
_iconstart = "look";
_finished = false;
_showcond = {true}; // condition to continue inspection
_inspectColor = "#DD00FF00";
if(_hitpoint == "HitHydraulics") then
{
  _inputDetected = 0;
  hintSilent Format["Move your stick and rudder to inspect flight cotrols.\n\nProgress: %1%2",_inputdetected,"%"];
  
  private ["_inputDetected", "_inputs"];

  _previousInputActions = [0,0,0,0,0,0,0,0];
  _currentInputActions = [0,0,0,0,0,0,0,0];
  _inputs = ["heliLeft", "heliRight", "heliCyclicLeft", "heliCyclicRight", "heliCyclicForward", "heliCyclicBack", "HeliRudderLeft", "HeliRudderRight"];
  while {(_inputDetected < 100) && ((vehicle player) == _heli) && (alive _heli)} do
  {
    {_currentInputActions set [_forEachIndex, (inputAction _x)];}foreach _inputs;
    _inputsChanged = false;
    {if((_previousInputActions select _forEachIndex) != _x) exitwith {_inputsChanged = true;}}foreach _currentInputActions;
    if (_inputsChanged) then 
    {
      _inputDetected = _inputDetected + 1
    };
    _previousInputActions = + _currentInputActions;
    
    _frame = switch true do
    {
      case (_inputDetected < 25): {0};
      case (_inputDetected >= 25 && _inputDetected < 50) : {1};
      case (_inputDetected >= 50 && _inputDetected < 75) : {2};
      case (_inputDetected >= 75 && _inputDetected < 100) : {3};
      case (_inputDetected == 100) : {4};
      default {0};
    };
     
    _file = format["%1_%2",_iconstart,_frame];
    _actiontext = format["<t color='%1'>Inspecting %2 (%3%4)</t>",_inspectColor, _partname, _inputDetected, "%"];

    // highlight a new segment
    [_id,_file, ("Inspect " + _partname), _actiontext, _heli, _inspectColor] call OSMO_INS__UpdateInspectIcon;
    hintSilent Format["Move your stick and rudder to inspect flight controls.\n\nProgress: %1%2",_inputdetected,"%"];

		sleep 0.02;
	};
	sleep 0.15;
}
else
{
  while {(call _showCond) && (_frame < _max)} do
  {
     if(_hitpoint == "HitHRotor" || _hitpoint == "HitVRotor") then {_max = 3; _iconstart = "hand"};

    _file = format["%1_%2",_iconstart,_frame];
    _actiontext = format["<t color='%1'>Inspecting %2</t>",_inspectColor, _partname];

    // highlight a new segment
    [_id,_file, ("Inspect " + _partname), _actiontext, _heli, _inspectColor] call OSMO_INS__UpdateInspectIcon;
    
    sleep 0.15;
    _frame = _frame + 1;

    if !(call _showCond) exitWith {};
  };
};

if ((call _showCond) && _frame == _max) then
{  
  private ["_hitpointDamage","_actiontext","_actions","_retval", "_damageDesc", "_color", "_iconstart"];    
  _hitpointDamage = (_heli getHitPointDamage _hitpoint);
  _retval = _hitpointDamage call OSMO_INS_DamageToText;
  _damageDesc = _retval select 0;
  _retColor = _retval select 1;
  _color = "#DD" + _retColor;
  _fueltext = "";
  if(_hitpoint == "HitFuel") then 
  {
    _fueltext = " Fuel level about " + (str ((round((fuel _heli)*10))*10)) + "%.";
    _partname = "Fuel tank";
  };
  _actiontext = format["<t color='%2'>%1 %3%4</t>", _partname, _color, _damageDesc, _fueltext];  
  _iconstart = if (_hitpointDamage > 0) then {"damaged"} else {"ok"};
  sleep 0.15;
  if(_hitpoint == "HitHydraulics") then {hintsilent Format["%1 %2",_partname,_damagedesc];};
  for "_i" from 0 to 3 do
  {
  	    _file = format["%1_%2",_iconstart,_i];
  	    [_id,_file, ("Inspect " + _partname), _actiontext, _heli, _color] call OSMO_INS__UpdateInspectIcon;
    	sleep 0.2;
  };
	
	sleep 2;
	_file = format["%1_%2",_iconstart,3];
	_color = "#88" + _retColor;
    _actiontext = format["<t color='%2'>%1 %3%4</t>", _partname, _color, _damageDesc, _fueltext];  
	[_id,_file, ("Inspect " + _partname), _actiontext, _heli, _color] call OSMO_INS__UpdateInspectIcon;
	sleep 5;
};	
				
_file= if(_hitpoint == "HitHRotor" || _hitpoint == "HitVRotor") then {"hand"} else {"look_0"};
[_id,_file, ("Inspect " + _partname), ("Inspect " + _partname), _heli, ""] call OSMO_INS__UpdateInspectIcon;
