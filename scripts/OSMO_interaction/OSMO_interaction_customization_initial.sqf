_chopper = _this select 0;
_caller = _this select 1;
_id = _this select 2;

{_chopper removeAction _x} foreach OSMO_customize_actions;

OSMO_customize_actions = [];
OSMO_customize_opened = true;

hintSilent "Scroll your action menu to select the option.";

if(_chopper isKindOf "Heli_Heavy_Base_H") then
{
  // Add actions for adding and removing winch
  _act = _chopper addAction ["Add Winch", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddWinch",1]], 0, true, true, "", "((_target animationPhase ""AddWinch"") == 0) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Winch", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddWinch",0]], 0, true, true, "", "((_target animationPhase ""AddWinch"") == 1) && !((_target getVariable ""NEO_chopperProperties"") select 1) && ((_this distance _target) < 5) && !(_this in _target)"];  
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
/* // Add actions for adding and removing gun holder
  _chopper addAction ["Add Gun Holder", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddGunHolder",1]], 0, true, true, "", "((_target animationPhase ""AddGunHolder"") == 0) && ((_this distance _target) < 5) && !(_this in _target)"];
  _chopper addAction ["Remove Gun Holder", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddGunHolder",0]], 0, true, true, "", "((_target animationPhase ""AddGunHolder"") == 1) && !((_target getVariable ""NEO_chopperProperties"") select 1) && ((_this distance _target) < 5) && !(_this in _target)"];    */
};

if(_chopper isKindOf "Heli_Medium01_Base_H") then 
{
  // Add actions for adding and removing winch
  _act = _chopper addAction ["Add Winch", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddWinch",1]], 0, true, true, "", "((_target animationPhase ""AddWinch"") == 0) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Winch", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddWinch",0]], 0, true, true, "", "((_target animationPhase ""AddWinch"") == 1) && !((_target getVariable ""NEO_chopperProperties"") select 1) && ((_this distance _target) < 5) && !(_this in _target)"]; 
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Add Cargo Hook", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddCargoHook",1],["AddCargoHook_Cover",0]], 0, true, true, "", "((_target animationPhase ""AddCargoHook"") == 0) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Cargo Hook", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddCargoHook_Cover",1], ["AddCargoHook",0]], 0, true, true, "", "((_target animationPhase ""AddCargoHook"") == 1) && !(((_target getVariable ""NEO_chopperProperties"") select 0) select 0) && ((_this distance _target) < 5) && !(_this in _target)"];   
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Add Search Light", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddSearchLight",1]], 0, true, true, "", "((_target animationPhase ""AddSearchLight"") == 0) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Search Light", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddSearchLight",0]], 0, true, true, "", "((_target animationPhase ""AddSearchLight"") == 1) && !(((_target getVariable ""NEO_chopperProperties"") select 0) select 0) && ((_this distance _target) < 5) && !(_this in _target)"];   
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Add Camera", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddFLIR",1]], 0, true, true, "", "((_target animationPhase ""AddFLIR"") == 0) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Camera", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddFLIR",0]], 0, true, true, "", "((_target animationPhase ""AddFLIR"") == 1) && !(((_target getVariable ""NEO_chopperProperties"") select 0) select 0) && ((_this distance _target) < 5) && !(_this in _target)"];    
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
};

if(_chopper isKindOf "Heli_Light01_Base_H") then 
{   
   // Add actions for adding and removing components
  _act = _chopper addAction ["Add Mirror", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddMirror",1]], 0, true, true, "", "((_target animationPhase ""AddMirror"") == 0) && ((_this distance _target) < 5)  && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Mirror", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddMirror",0]], 0, true, true, "", "((_target animationPhase ""AddMirror"") == 1) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
/*  
  _act = _chopper addAction ["Add Doors", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddDoors",1]], 0, true, true, "", "((_target animationPhase ""AddDoors"") == 0) && ((_this distance _target) < 5)  && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Doors", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddDoors",0]], 0, true, true, "", "((_target animationPhase ""AddDoors"") == 1) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
    _act = _chopper addAction ["Add Back Seats", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddBackseats",1]], 0, true, true, "", "((_target animationPhase ""AddBackseats"") == 0) && ((_this distance _target) < 5)  && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
 */ 
  _act = _chopper addAction ["Remove Back Seats", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddBackseats",0]], 0, true, true, "", "((_target animationPhase ""AddBackseats"") == 1) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Add Long Step", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddTread",1]], 0, true, true, "", "((_target animationPhase ""AddTread_Short"") == 0) && ((_target animationPhase ""AddFLIR"") == 0) && ((_target animationPhase ""AddTread"") == 0) && ((_this distance _target) < 5)  && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Long Step", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddTread",0]], 0, true, true, "", "((_target animationPhase ""AddTread"") == 1) && ((_this distance _target) < 5)  && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Add LCD", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddScreen1",1]], 0, true, true, "", "((_target animationPhase ""AddScreen1"") == 0) && ((_this distance _target) < 5)  && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove LCD", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddScreen1",0]], 0, true, true, "", "((_target animationPhase ""AddScreen1"") == 1) && ((_this distance _target) < 5)  && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Add Short Step", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddTread_Short",1]], 0, true, true, "", "((_target animationPhase ""AddTread"") == 0) && ((_target animationPhase ""AddTread_Short"") == 0) && ((_this distance _target) < 5)  && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Short Step", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddTread_Short",0]], 0, true, true, "", "((_target animationPhase ""AddTread_Short"") == 1) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Add Camera Below", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddFLIR2",1]], 0, true, true, "", "((_target animationPhase ""AddFLIR2"") == 0) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Camera Below", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddFLIR2",0]], 0, true, true, "", "((_target animationPhase ""AddFLIR2"") == 1) && ((_this distance _target) < 5) && !(_this in _target)"];    
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
 /*  _act = _chopper addAction ["Add Cargo Hook", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddCargoHook",1]], 0, true, true, "", "((_target animationPhase ""AddCargoHook"") == 0) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Cargo Hook", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddCargoHook",0]], 0, true, true, "", "((_target animationPhase ""AddCargoHook"") == 1) && ((_this distance _target) < 5) && !(_this in _target)"];    
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
    _act = _chopper addAction ["Add Hook Cover", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddCargoHook_cover",1]], 0, true, true, "", "((_target animationPhase ""AddCargoHook_cover"") == 0) && ((_this distance _target) < 5) && !(_this in _target)"];
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
  _act = _chopper addAction ["Remove Hook Cover", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddCargoHook_cover",0]], 0, true, true, "", "((_target animationPhase ""AddCargoHook_cover"") == 1) && ((_this distance _target) < 5) && !(_this in _target)"];    
  OSMO_customize_actions set [count OSMO_customize_actions, _act];
*/
  
  if((_chopper isKindOf "CIV_Heli_Light01_ION_H") || (_chopper isKindOf "Heli_Light01_ION_H")) then
  {
     // Add actions for adding and removing side benches
    _act = _chopper addAction ["Add Side Benches", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddBenches",1]], 0, true, true, "", "((_target animationPhase ""AddBenches"") == 0) && ((_this distance _target) < 5) && !(_this in _target)"];
    OSMO_customize_actions set [count OSMO_customize_actions, _act];
    
    _act = _chopper addAction ["Remove Side Benches", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddBenches",0]], 0, true, true, "", "((_target animationPhase ""AddFLIR"") == 0) && ((_target animationPhase ""AddBenches"") == 1) && ((_this distance _target) < 5) && !(_this in _target) && ((count crew _target) == 0)"]; 
    OSMO_customize_actions set [count OSMO_customize_actions, _act];
    

  }
  else
  {
    if(!(_chopper isKindOf "IND_Heli_Light01_Military_H")) then
    {       
      _act = _chopper addAction ["Add Holding Frame", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddHoldingFrame",1]], 0, true, true, "", "((_target animationPhase ""AddHoldingFrame"") == 0) && ((_this distance _target) < 5)  && !(_this in _target)"];
      OSMO_customize_actions set [count OSMO_customize_actions, _act];
      
      _act = _chopper addAction ["Remove Holding Frame", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddHoldingFrame",0]], 0, true, true, "", "((_target animationPhase ""AddFLIR"") == 0) && ((_target animationPhase ""AddHoldingFrame"") == 1) && ((_this distance _target) < 5) && !(_this in _target)"];  
      OSMO_customize_actions set [count OSMO_customize_actions, _act];      
    };
  };
  
  if(!(_chopper isKindOf "IND_Heli_Light01_Military_H")) then
  {
      _act = _chopper addAction ["Add Right Side Camera", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddFLIR",1]], 0, true, true, "", "((_target animationPhase ""AddTread"") == 0) && (((_target animationPhase ""AddHoldingFrame"") == 1) || (((_target animationPhase ""AddBenches"") == 1) && ((_target animationPhase ""BenchR_Up"") == 0))) && ((_target animationPhase ""AddFLIR"") == 0) && ((_this distance _target) < 5)  && !(_this in _target)"];
      OSMO_customize_actions set [count OSMO_customize_actions, _act];      
      
      _act = _chopper addAction ["Remove Right Side Camera", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["AddFLIR",0]], 0, true, true, "", "((_target animationPhase ""AddFLIR"") == 1) && ((_this distance _target) < 5) && !(_this in _target)"]; 
      OSMO_customize_actions set [count OSMO_customize_actions, _act];      
  };
};

_act = _chopper addAction ["Cancel", "scripts\OSMO_interaction\OSMO_interaction_customization_cancel.sqf", nil, 0, true, true, "", "((_this distance _target) < 5) && !(_this in _target)"];
OSMO_customize_actions set [count OSMO_customize_actions, _act];
  
_timer = time + 20;
waituntil{((_caller distance _chopper) > 6) || (time > _timer) || !OSMO_customize_opened};
if(OSMO_customize_opened) then
{
  [_chopper] execVM "scripts\OSMO_interaction\OSMO_interaction_customization_cancel.sqf";
};