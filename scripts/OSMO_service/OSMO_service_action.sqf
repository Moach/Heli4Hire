_serviceman = _this select 0;
_myParams = _this select 3;
_vehicle = _myParams select 0;
_fuel = _myParams select 1;
OSMO_service_fuellist_opened = false;
OSMO_service_servicelist_opened = false;

//[[_serviceman, _vehicle, _fuel], "OSMO_SV_startService", _serviceman, true, false] spawn BIS_fnc_mp;

// BIS_fnc_MP seems broken and not executing on dedi. Using publicvariable instead

OSMO_SV_beginServiceArray = [_serviceman, _vehicle, _fuel];

if(isServer) then
{
  OSMO_SV_beginServiceArray call OSMO_SV_startService;
}
else
{
  publicvariable "OSMO_SV_beginServiceArray";  
};
