if(!isServer) exitwith {};

_serviceman = _this select 0;
_vehicle = _this select 1;
_fuel = _this select 2;
_servicegroup = group _serviceman;
_servicepad = _serviceman getVariable "OSMO_SV_servicepad";

waitUntil {((!isEngineOn _vehicle)&&(( sqrt((velocity _vehicle select 0)^2 + (velocity _vehicle select 1)^2) <= 0.2)))};

if((_vehicle distance _servicepad) > OSMO_SV_radius) exitWith {[[_serviceman, "Unable to service. Chopper has moved away from the service area."], "OSMO_SV_serviceChat"] call BIS_fnc_mp;};   

if(!isNil{_vehicle getVariable "OSMO_SV_serviced";}) exitWith {[[_serviceman, "Unable to service. Another group has been assigned to work on that chopper already."], "OSMO_SV_serviceChat"] call BIS_fnc_mp;};

{_x SetVariable ["OSMO_SV_service_busy",true,true];} foreach (units _serviceGroup);
_vehicle lock true;
_vehicle SetVariable ["OSMO_SV_serviced",true,true];

_serviceMan1 = (units _serviceGroup) select 0;
_serviceMan2 = (units _serviceGroup) select 1;
_serviceMan3 = (units _serviceGroup) select 2;
  
// If vehicle is beyond repair, delete it and spawn a new one
if (damage _vehicle > 0.8) then
{
  _type = typeOf _vehicle;
  _pos = getPosATL _vehicle;
  _dir = getDir _vehicle;
  deleteVehicle _vehicle;
  _vehicle = createVehicle [_type, _pos, [], _dir, "NONE"];
  _vehicle setPosATL _pos;
  _vehicle setDamage 0.7;
  _vehicle setFuel 0;
  [[_vehicle], "OSMO_initvehicle"] call BIS_fnc_mp;
};

//  Make sure simulation is enabled, so attaching works
[[_vehicle], "OSMO_SV_enablesimu"] call BIS_fnc_mp;

// Initialize service positions
_serviceMan1Pos = [0,0,0];
_serviceMan2Pos = [0,0,0];
_serviceMan3Pos = [0,0,0];
_serviceMan1Dir = 0;
_serviceMan2Dir = 0;
_serviceMan3Dir = 0;
_serviceMan1Anim = "ActsPercSnonWnonDnon_carFixing2";
_serviceMan2Anim = "ActsPercSnonWnonDnon_assembling";
_serviceMan3Anim = "ActsPercSnonWnonDnon_carFixing";
_openingAnimations = [];

switch (true) do 
{ 
		case (_vehicle isKindOf "Heli_Light01_Base_H"):
		{
      _serviceMan1Pos = [-2.15,2.65,-2.35]; 
      _serviceMan2Pos = [0.8,-0.8,-2.25]; 
      _serviceMan1Dir = 90; 
      _serviceMan2Dir = 320;   
      _serviceMan3Pos = [0.05, 3.75,-2.35];
      _serviceMan3Dir = 180;   
      _openingAnimations = ["Inspect_Panel2_1","Inspect_Panel2_2"];
		}; 
		case (_vehicle isKindOf "Heli_Medium01_Base_H"):
		{
      _serviceMan1Pos = [-2.25,2.85,-2.835]; 
      _serviceMan2Pos = [1.7,-0.3,-2.835]; 
      _serviceMan1Dir = 90; 
      _serviceMan2Dir = 290;   
      _serviceMan3Pos = [1.25, 5.10,-2.835];
      _serviceMan3Dir = 210;   
      _openingAnimations = ["Inspect_Panel1_1","Inspect_Panel2_1"];            
		}; 
		case (_vehicle isKindOf "Heli_Heavy_Base_H"):
		{
      _serviceMan1Pos = [3.15,-0.1,-3.56]; 
      _serviceMan2Pos = [0.3,8.6,-3.51]; 
      _serviceMan1Dir = 270; 
      _serviceMan2Dir = 200;   
      _serviceMan3Pos = [2.20, 6.00,-3.51];
      _serviceMan3Dir = 280;     
      _openingAnimations = ["Inspect_Panel3_1","Inspect_Panel1_1","Inspect_Panel2_1"];      
		}; 						            
  default 
  {
  };
};

if((str _serviceMan1Pos) == "[0,0,0]") exitwith{[[_serviceman, "Unable to service. This helicopter is not supported."], "OSMO_SV_serviceChat"] call BIS_fnc_mp;};

[[_serviceman, "Starting service."], "OSMO_SV_serviceChat"] call BIS_fnc_mp;

_original_serviceMan1_pos = getposATL _serviceMan1;
_original_serviceMan2_pos = getposATL _serviceMan2;
_original_serviceMan3_pos = getposATL _serviceMan3;

_original_serviceMan1_dir = getdir _serviceMan1;
_original_serviceMan2_dir = getdir _serviceMan2;
_original_serviceMan3_dir = getdir _serviceMan3;

_serviceArray = [
[_serviceMan1, _serviceMan1Pos, _serviceMan1Dir, _serviceMan1Anim, _vehicle, _openingAnimations, _original_serviceMan1_pos, _original_serviceMan1_dir, false],
[_serviceMan2, _serviceMan2Pos, _serviceMan2Dir, _serviceMan2Anim, _vehicle, _openingAnimations, _original_serviceMan2_pos, _original_serviceMan2_dir, true],
[_serviceMan3, _serviceMan3Pos, _serviceMan3Dir, _serviceMan3Anim, _vehicle, _openingAnimations, _original_serviceMan3_pos, _original_serviceMan3_dir, false]
];

// Walk to vehicle and start service anims
{
  sleep 1;
  _x spawn
  {
    _unit = _this select 0;
    _pos = _this select 1;
    _dir = _this select 2;
    _anim = _this select 3;
    _vehicle = _this select 4;
    _openingAnimations = _this select 5;
    _playSpecialAnims = _this select 8;
    _service_maintimeout = time + 45;
    
    // Make sure unit can't move by itself
    _unit disableAI "ANIM";
    _unit disableAI "MOVE";    
    sleep 1; 

     // Check vehicle size
    _bb = boundingBox _vehicle;
    _bbMax = _bb select 1;
    _bbY = _bbMax select 1;   

     // Calculate pathway
    _finalpos = _vehicle modelToWorld _pos;
    _dir_vehicle_finalpos = [_vehicle, _finalpos] call BIS_fnc_dirTo;
    _dir_vehicle_unit = [_vehicle, _unit] call BIS_fnc_dirTo;
    _interpos = [_vehicle, _bbY, _dir_vehicle_finalpos] call BIS_fnc_relPos;
    _dirchange = 0;
 
    // If unit's service position is on the other side of the vehicle, go around it first
    if((_unit distance _finalpos) > (_unit distance _vehicle)) then
    {
       // Check  which way is shorter way to go around
      _angle_diff = _dir_vehicle_finalpos - _dir_vehicle_unit;
      if(_angle_diff < 0) then
      {
        _angle_diff = 360 - (abs _angle_diff);
      };
   
      if(_angle_diff < 180) then
      {
        // Go around left
        _dirchange = 20;
      }
      else
      {
        // Go around right
        _dirchange = -20;
      };
      
      // Walk around the vehicle in steps
      while{_angle_diff > 40 && (time < _service_maintimeout)} do
      {
        // Calculate next position
        _next_pos = [_vehicle, _bbY, (_dir_vehicle_unit + _dirchange)] call BIS_fnc_relPos;

        // Walk to next position
        _timeout = time + 30;    
        while { _unit distance _next_pos > 0.5 && time < _timeOut && (time < _service_maintimeout)} do
        {
          private ["_d"];
          _d = time + 3;
          _unit setDir ([_unit, _next_pos] call BIS_fnc_dirTo);
          _unit setFormDir ([_unit, _next_pos] call BIS_fnc_dirTo);
          _unit setPosATL (getPosATL _unit);   
          _unit playAction "WalkF";
          waitUntil { _unit distance _next_pos <= 0.5 || time > _d};
        };  

        _dir_vehicle_unit = [_vehicle, _unit] call BIS_fnc_dirTo;
        
        // Check Angle between destination and unit pos from vehicle
        _angle_diff = _dir_vehicle_finalpos - _dir_vehicle_unit;
        _angle_diff = if(_angle_diff < 0) then {360 - (abs _angle_diff)} else {_angle_diff};
        _angle_diff = if(_angle_diff > 180) then {360 - _angle_diff} else {_angle_diff}; 
      };     
    };
    
    // Walk to the last step
    _timeout = time + 30;    
    while { _unit distance _interpos > 0.5 && time < _timeOut && (time < _service_maintimeout)} do
    {
      private ["_d"];
      _d = time + 3;
      _unit setDir ([_unit, _interpos] call BIS_fnc_dirTo);
      _unit setFormDir ([_unit, _interpos] call BIS_fnc_dirTo);
      _unit setPosATL (getPosATL _unit);   
      _unit playAction "WalkF";
      waitUntil { _unit distance _interpos <= 0.5 || time > _d };
    };   
    
    // Walk to the service position
    _timeout = time + 30;    
    _distance = 0.5;
    while { _unit distance _finalpos > _distance && time < _timeOut && (time < _service_maintimeout)} do
    {
      private ["_d"];
      _d = time + 3;
      _unit setDir ([_unit, _finalpos] call BIS_fnc_dirTo);
      _unit setFormDir ([_unit, _finalpos] call BIS_fnc_dirTo);
      _unit setPosATL (getPosATL _unit);   
      _unit playAction "WalkF";
      waitUntil { _unit distance _finalpos <= _distance || time > _d };
    };       

		if(_playSpecialAnims) then
		{
      _unit playActionNow "stand"; 
      sleep 0.5;
      [[_unit, "AmovPercMstpSnonWnonDnon_opendoor02_forgoten"], "OSMO_SV_switchMove"] call BIS_fnc_mp;
      sleep 1.5;      
      {_vehicle animate [_x,1]; sleep 1;} foreach _openingAnimations;
      sleep 0.3;
      [[_unit, "stand"], "OSMO_SV_switchMove"] call BIS_fnc_mp;    
		};
	
    _unit playActionNow "stand"; 
    sleep 1;
		_unit attachTo [_vehicle,_pos]; 
		_unit setDir _dir; 
    _unit setFormDir _dir;		
		_unit playMoveNow _anim;
  };
} foreach _serviceArray;

// Wait until servicemen are in position
waituntil{(_serviceMan2 distance (_vehicle modelToWorld _serviceMan2Pos)) < 0.6};
sleep 2;

if((!isEngineOn _vehicle) && ((_vehicle distance _servicepad) < OSMO_SV_radius)) then
{
  [[_serviceman, "Inspecting helicopter."], "OSMO_SV_serviceChat"] call BIS_fnc_mp;

  // Sleep for the Inspection time
  _timer = time + OSMO_SV_insptime;
  waituntil {(!isEngineOn _vehicle)&&(_timer < time)};
    
 private["_hitpoints", "_heliName", "_servicetime", "_serviceReport"];
  _hitpoints = _vehicle call BIS_fnc_helicopterGetHitpoints;
  _heliName = _vehicle call OSMO_SV_ChopperDisplayName;
  _servicetime = 0.01;
  
  //--- Report header
	_serviceReport = "<t align='left'><t size='1.5'>" + _heliName + "</t><br />";
	_serviceReport = _serviceReport + "<t color='#99ffffff'>" + "Maintenance Report" + "</t><br />";
	_serviceReport = _serviceReport + "<img image='hsim\UI_H\data\tutorial\lines\thin.paa' size='0.38' align='left' /><br /><br />";	 
	
	_icon = "<img image='hsim\UI_H\data\icons\checkbox\ok.paa' /> ";
	_iconInfo = "<img image='hsim\UI_H\data\icons\checkbox\info.paa' /> ";
	_iconFunc = "<img image='hsim\UI_H\data\icons\checkbox\func.paa' /> ";
	_iconFail = "<img image='hsim\UI_H\data\icons\checkbox\fail.paa' /> ";
	
	//--- Damage
	_serviceReport = _serviceReport + "Damage" + "<br /><br />";
	
	// Check each hitpoint
	{
    if((_vehicle getHitPointDamage _x)>0) then
    {
      _damage = _vehicle getHitPointDamage _x;
      _retv = _damage call OSMO_SV_DamageToText;
      _damageDesc = _retv select 0;
      _color = _retv select 1;      
			
			_serviceReport = _serviceReport + _iconInfo + "<t color='#99ffffff'>" + (_x call OSMO_SV_HitpointDisplayName) + "</t>" + ": <t color='" + _color + "'>" + _damageDesc + "</t>" + "<br />";
			
      _servicetime = _servicetime + (_damage * OSMO_SV_hpfixtime);
    };
  }foreach _hitpoints;	
	
	// No damage?
	if(_servicetime == 0.01) then
	{
    _serviceReport = _serviceReport + _iconInfo +  "<t color='#99ffffff'>" + "Helicopter condition: " + "</t><t color='#00ff00'>good</t><br />";	
	};
	
	//--- Fuel
	_serviceReport = _serviceReport + "<br />" + "Fuel" + "<br /><br />";
  _serviceReport = _serviceReport + _iconInfo + "<t color='#99ffffff'>Current Level: </t>" + (str (round((fuel _vehicle)*100))) + "%" + "<br />";
  _serviceReport = _serviceReport + _iconInfo + "<t color='#99ffffff'>Required Level: </t>" + (str (_fuel*100)) + "%" + "<br /><br />";
  _servicetime = _servicetime + ((abs (_fuel-(fuel _vehicle)))*OSMO_SV_fueltime);
    
  //--- Time  
  
  // Converting service time from seconds to minutes
  _servicetime = (round(_servicetime /6))/10;
  
  // Set maximum service time
  if(_servicetime > OSMO_SV_maxtime) then {_servicetime == OSMO_SV_maxtime};
     
  _serviceReport = _serviceReport + "<img image='hsim\UI_H\data\tutorial\lines\thin.paa' size='0.38' align='left' /><br />";	 
     
  if(_servicetime == 0) then
	{
    _serviceReport = _serviceReport + "<t color='#99ffffff'>No maintenance needed!</t>";
	}
	else
	{
    _serviceReport = _serviceReport + "<t color='#99ffffff'>" + "Maintenance Time: " + "</t>"+ (str _servicetime) + " minutes"; 
	};
	
  _serviceReport = _serviceReport + "</t>";
	
	// Inspection complete
	_inspectText = "Inspection complete. ";
	if(_servicetime == 0) then 
	{
    _inspectText = _inspectText + "No maintenance is needed. Here is the report."}
  else 
  {
    _inspectText = _inspectText + "Here is the report. We will start maintenance immediately."
  };
	[[_serviceman, _inspectText], "OSMO_SV_serviceChat"] call BIS_fnc_mp;
 
  // Show report
  [[_serviceman, _serviceReport], "OSMO_SV_serviceHint"] call BIS_fnc_mp;
  
  // Sleep for the service time
  _timer = time + (_servicetime * 60);
  waituntil {(!isEngineOn _vehicle)&&(_timer < time)};

  // Repair
  { _vehicle setHitPointDamage [_x, 0];} foreach _hitpoints;
  _vehicle setDamage 0;
  
  // Refuel
  [[_vehicle, _fuel], "OSMO_SV_refuel"] call BIS_fnc_mp;
  
  // Rearm
  [[_vehicle], "OSMO_SV_rearm"] call BIS_fnc_mp;
  
  if(_servicetime != 0) then
  {
    [[_serviceman, "Service finished. It's as good as new!"], "OSMO_SV_serviceChat"] call BIS_fnc_mp;
  };
};



// Service finished, walk back to starting position
{
  sleep 1;
  _x spawn
  {
    _unit = _this select 0;
    _pos = _this select 1;
    _dir = _this select 2;
    _anim = _this select 3;
    _vehicle = _this select 4;
    _openingAnimations = _this select 5;
    _finalpos = _this select 6;  
    _finaldir = _this select 7;
    _playSpecialAnims = _this select 8;
    _service_maintimeout = time + 40;    
    
    _unit playActionNow "stand";        
    sleep 1;
    detach _unit;  
    sleep 1;
    _unit enableAI "ANIM";
    [[_unit, "stand"], "OSMO_SV_switchMove"] call BIS_fnc_mp;
    sleep 1;
    _unit playMoveNow "stand";       
    sleep 1;
    _unit disableAI "ANIM";
    _unit playActionNow "stand"; 
    sleep 1;
    
    if(_playSpecialAnims) then
		{
      _unit playActionNow "stand"; 
      sleep 0.5;
      [[_unit, "AmovPercMstpSnonWnonDnon_opendoor02_forgoten"], "OSMO_SV_switchMove"] call BIS_fnc_mp;   

      // Reverse the animations
      _openingAnimationsCopy = + _openingAnimations;
      {_openingAnimations set [(((count _openingAnimations) - 1) - _forEachIndex), _x]; sleep 1;} foreach _openingAnimationsCopy;
      
      // Play the animations
      {_vehicle animate [_x,0]; sleep 1;} foreach _openingAnimations;
      [[_unit, "stand"], "OSMO_SV_switchMove"] call BIS_fnc_mp;    		
		};
    
    // check vehicle size
    _bb = boundingBox _vehicle;
    _bbMax = _bb select 1;
    _bbY = _bbMax select 1;   
    
    // First check if you need to go around again 
   _dir_vehicle_finalpos = [_vehicle, _finalpos] call BIS_fnc_dirTo;
   sleep 1;
   _dir_vehicle_unit = [_vehicle, _unit] call BIS_fnc_dirTo;  
   _interpos = [_vehicle, _bbY, _dir_vehicle_unit] call BIS_fnc_relPos;
   _dirchange = 0;
 
    // If unit's service position is on the other side of the vehicle, go around it first
    if((_interpos distance _finalpos) > (_vehicle distance _finalpos)) then
    {
       // Check  which way is shorter way to go around
      _angle_diff = _dir_vehicle_finalpos - _dir_vehicle_unit;
      if(_angle_diff < 0) then
      {
        _angle_diff = 360 - (abs _angle_diff);
      };
   
      if(_angle_diff < 180) then
      {
        // Go around left
        _dirchange = 20;
      }
      else
      {
        // Go around right
        _dirchange = -20;
      };
      
      // Walk around the vehicle in steps
      while{_angle_diff > 40 && (time < _service_maintimeout)} do
      {
        // Calculate next position
        _next_pos = [_vehicle, _bbY, (_dir_vehicle_unit + _dirchange)] call BIS_fnc_relPos;

        // Walk to next position
        _timeout = time + 30;    
        while { _unit distance _next_pos > 0.5 && time < _timeOut  && (time < _service_maintimeout)} do
        {
          private ["_d"];
          _d = time + 3;
          _unit setDir ([_unit, _next_pos] call BIS_fnc_dirTo);
          _unit setFormDir ([_unit, _next_pos] call BIS_fnc_dirTo);
          _unit setPosATL (getPosATL _unit);   
          _unit playAction "WalkF";
          waitUntil { _unit distance _next_pos <= 0.5 || time > _d };
        };  

        _dir_vehicle_unit = [_vehicle, _unit] call BIS_fnc_dirTo;
        
        // Check Angle between destination and unit pos from vehicle
        _angle_diff = _dir_vehicle_finalpos - _dir_vehicle_unit;
        _angle_diff = if(_angle_diff < 0) then {360 - (abs _angle_diff)} else {_angle_diff};
        _angle_diff = if(_angle_diff > 180) then {360 - _angle_diff} else {_angle_diff};
      };     
    };    
    
    _timeout = time + 40;
    while { _unit distance _finalpos > 0.2 && time < _timeOut  && (time < _service_maintimeout)} do
    {
      private ["_d"];
      _d = time + 3;
      _unit setDir ([_unit, _finalpos] call BIS_fnc_dirTo);
      _unit setFormDir ([_unit, _finalpos] call BIS_fnc_dirTo);
      _unit setPosATL (getPosATL _unit);   
       _unit playAction "WalkF";
      waitUntil { _unit distance _finalpos <= 0.2 || time > _d };
    };     
        
    _unit playActionNow "stand";     
    _unit setPos _finalpos;
    _unit enableAI "ANIM";
    _unit setDir _finaldir;
    _unit setFormDir _finaldir;       
  };
}foreach _serviceArray;

sleep 5;
_vehicle lock false;
_vehicle SetVariable ["OSMO_SV_serviced",nil,true];

// Wait until men are back in their original positions before enabling service action again
waituntil{((_serviceMan1 distance _original_serviceMan1_pos) < 0.6) && 
          ((_serviceMan2 distance _original_serviceMan2_pos) < 0.6) && 
          ((_serviceMan3 distance _original_serviceMan3_pos) < 0.6)};
          
{_x SetVariable ["OSMO_SV_service_busy",nil,true];} foreach (units _serviceGroup);