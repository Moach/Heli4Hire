

_grp = _this select 0; // passengers group!
_heli = _this select 1;

if (!PD_Armed) then 
{
	call HW_Fx_PD_Clear;
};

sleep 1;

PilotDecision=0;
[["PD: Safe for boarding!"]] call HW_Fx_PD_Prompt;

waitUntil { PilotDecision == 1 };

call HW_Fx_PD_Clear;


[player, "greet"] call BIS_fnc_helicopterSeatMove;
hintSilent "Now boarding...";

_t = time + 45; // if pax ain't aboard after this long, we oughta do something about it...


sleep 2; // small delay so it doesn't feel like passengers are unnaturally aware of your signal, real people take some time to react

(units _grp) call HW_Fx_Util_Animate_Off;
 

sleep 1; // failsafe


// we decide if boarding is ok to do without forcing by checking for a vertical distance between the chopper and the group leader...
// anything more than a few meters is already too much for this - then we use a shorter timeout and don't even bother telling AI to get in...

if ( abs((getPosASL (leader _grp) select 2) - (getPosASL _heli select 2)) > 2 ) then 
{
	_t = (time + 3) + (random 7); // wait a little while...
	
	sleep _t;
	
	// then force averyone aboard...
	{
		_x moveInCargo _heli;
	} foreach units _grp;

	(leader _grp) moveInTurret [_heli,[0]]; // override leader to seat in the front
	units _grp orderGetIn true;


} else
{
	// put everyone aboard by telling them to like normal people...
	
	{
		_x assignAsCargo _heli;
	} foreach units _grp;

 	(leader _grp) assignAsTurret [_heli,[0]]; // override leader to seat in the front
	units _grp orderGetIn true;

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
};

sleep 3 + random 5;
	

