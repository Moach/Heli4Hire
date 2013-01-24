

_spd = speed chopper;
_dst = (chopper distance (taskDestination currentTask player));

if (_spd < 1) exitWith 
{
	taskhint [format ["DME: %1km\nETE:  n/a | ETA:  n/a", (round(_dst * .01) * .1)], [1, 1, 1, 1], "taskCurrent"];
};


_est = ((_dst * .001) / _spd);

_txt = format ["DME: %1km,   %2km/h\nETE: %3min | ETA: %4hrs", 
	(round(_dst * .01) * .1), 
	(round(_spd * 10) * .1),
	([_est * 60, "HH:MM"] call bis_fnc_timeToString), 
	([daytime + _est, "HH:MM"] call bis_fnc_timeToString)];

taskhint [_txt, [1, 1, 1, 1], "taskCurrent"];