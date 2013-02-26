
_obj = _this select 0;
_id = _this select 2;
_heli = (_this select 3) select 0;
_mass = (_this select 3) select 1;


_xtraMass = (_heli getVariable "HW_ExtraWeight") - _mass;
_heli setCustomWeightRTD _xtraMass;
_heli setVariable ["HW_ExtraWeight", _xtraMass];


detach _obj;
_obj removeAction _id;


_p = (getPos player);
_obj setPos [(_p select 0), (_p select 1)+1, _p select 2];


_obj addAction["Load Into Helicopter", "Gear\LoadOnboardCargo.sqf", [_heli, _mass], 5, true, true, "", "true", "", 2, 1, 1+8];