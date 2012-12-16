_unit = _this select 0;
{_unit removeAction _x} foreach OSMO_service_actions;
OSMO_service_fuellist_opened = false;
OSMO_service_servicelist_opened = false;