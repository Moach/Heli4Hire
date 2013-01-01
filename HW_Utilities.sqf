


HW_Util_Clear_Cranes = 
{
	//--- Get rid of cranes
	_spawns = [];
	{
		_site = _x;
		_cranes = (_x nearObjects ["Land_A_CraneCon_H",150]);
		{
			_siteDirTo = [_x, _site] call bis_fnc_dirto;
			_x setdir (_siteDirTo - 5 + random 10) + 90;

			
		} foreach _cranes;
		
		//
	} foreach _this;
};