_pars = _this select 3;

_center = getPosATL comp_setup_area;
_objs = _center nearObjects ["All", 30];

_output = "";

{
	if (_x != player) then // everything minus the player (who's gotta be in the zone to call it in)
	{
		
		_p = [((getPosATL _x) select 0) - (_center select 0), ((getPosATL _x) select 1) - (_center select 1), 0];
		_d = getDir _x;
		_writeObj = format ["%1, ", [typeOf _x, _p, _d]];
		_output = (_output + _writeObj);
	};
} foreach _objs;

copyToClipboard _output;

hint format ["compiled %1 objects", (count _objs)];  

