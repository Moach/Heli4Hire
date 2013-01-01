_chopper = _this select 0;
_arguments = _this select 3;
[_chopper] execVM "scripts\OSMO_interaction\OSMO_interaction_customization_cancel.sqf";

{
  _animation = _x select 0;
  _action = _x select 1;
  _chopper animate [_animation, _action];
  
 
  
  waitUntil {_chopper animationPhase _animation == _action};
} foreach _arguments;