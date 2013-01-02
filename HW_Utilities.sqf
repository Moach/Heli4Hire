


HW_Util_Clear_Cranes = 
{
	//--- Get rid of cranes by spinning them away from landing site (one hopes)
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


// "AnimDone"

HW_Util_Animate_Idle = 
{
	{
		// first, figure out if we're dealing with boys or girls... their animations are completely distinct....
		if (_x isKindOf "Man_Base_H") then
		{
			_x switchMove (MoveDefs_Men_Idle call BIS_fnc_selectRandom);
			_x addEventHandler ["AnimDone",
			{
				//
				(_this select 0) switchMove (MoveDefs_Men_Idle call BIS_fnc_selectRandom);
			}];
		
		} else
		{
		
			_x switchMove (MoveDefs_Women_Idle call BIS_fnc_selectRandom);
			_x addEventHandler ["AnimDone",
			{
				//
				(_this select 0) switchMove (MoveDefs_Women_Idle call BIS_fnc_selectRandom);
			}];
		};
		
	} foreach _this;
};


HW_Util_Animate_Off = 
{
	{
		_x removeAllEventHandlers "AnimDone";
		_x switchmove "";
	} foreach _this;
};