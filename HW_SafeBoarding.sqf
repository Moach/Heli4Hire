

_grp = _this select 0; // passengers group!
_heli = _this select 1;

if (!PD_Armed) then 
{
	call HW_Fx_PD_Clear;
};

sleep 1;

PilotDecision=0;
[["PD: Safe for boarding!"]] call HW_Fx_PD_Prompt;

_t = time + 45; // if after this long you haven't cleared boarding - ppl will decide for themselves
waitUntil { PilotDecision == 1 || time > _t; };

call HW_Fx_PD_Clear;


[player, "greet"] call BIS_fnc_helicopterSeatMove;
hintSilent "Now boarding...";

sleep 2; // small delay so it doesn't feel like passengers are unnaturally aware of your signal, real people take some time to react

(units _grp) call HW_Fx_Util_Animate_Off;
 
{
	_x assignAsCargo _heli;
} foreach units _grp;

(leader _grp) assignAsTurret [_heli,[0]]; // override leader to seat in the front
units _grp orderGetIn true;

sleep 1;
_tMax=60; // time before forced boarding takes on...

// landing on rooftops may cause problems with pathfinding....
if ( ((getPosATL _heli) select 2) > 2 ) then 
{	
	sleep 2;
	
	// so we bring ppl to a position near the helicopter - provided there's a pad around...
	_tMax = 30; // less time for such cases - they have a very annoying tendency to become stuck...
	
	_pad = nearestObject [_heli, "RooftopLanding_Base_H"];
	if (!isNull(_pad)) then
	{
		_bdp = _pad buildingPos 1;
		{
			//
			_x setPos _bdp;
			sleep 3;

		} foreach units _grp;
	};
};


_failsafe = [_heli, _grp, _tMax] spawn
{
	sleep (_this select 2);
	
	_heli = _this select 0;
	_grp = _this select 1;
	{
		if (_x == leader _grp) then
		{
			_x moveInTurret [_heli,[0]];
		} else
		{
			_x moveInCargo _heli;
		};
	} foreach (units _grp);
};

waitUntil 
{
	sleep 1; // check once per second...
	_allIn=true;
	
	{
		if (!(_x in _heli)) then
		{
			_allIn=false;
		};
	} foreach (units _grp);
	
	(_allIn)
};

terminate _failsafe;
playSound "FX_Seatbelts";

// lead-out delay, it feels more natural when takeoff isn't directed right away after boarding...
sleep 5 + random 3;
	

