_chopper = _this;

OSMO_INT_obstructions = true; // (does not work yet) If you don't want random obstructions that need manual inspection / removal, set this to false 

if(isNil{_chopper getVariable "NEO_chopperProperties"}) then
{
 _chopper setVariable ["NEO_chopperProperties", [[false, []], false, [false, false]], true];
};

OSMO_initvehicle = {(_this select 0) execVM "scripts\OSMO_interaction\OSMO_interaction_init.sqf";};

_chopper execVM "scripts\OSMO_interaction\OSMO_interaction_features_init.sqf";
_chopper execVM "scripts\OSMO_interaction\OSMO_interaction_inspection_init.sqf";

