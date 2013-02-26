
_obj = _this select 0;
_id = _this select 2;
_heli = (_this select 3) select 0;
_mass = (_this select 3) select 1;


_xtraMass = (_heli getVariable "HW_ExtraWeight") + _mass;
_heli setCustomWeightRTD _xtraMass;
_heli setVariable ["HW_ExtraWeight", _xtraMass];


_obj attachTo [_heli, [0,1.15,-.97]];

_obj removeAction _id;
_obj addAction ["Unload From Helicopter", "Gear\UnloadOnboardCargo.sqf", [_heli, _mass], 5, true, true, "", "true", "", 2, 1, 1+8];
