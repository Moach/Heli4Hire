


HW_Fx_Util_Clear_Cranes = 
{
	//--- Get rid of cranes by spinning them away from landing site (with some luck...)
	_spawns = [];
	{
		_site = _x;
		_cranes = (_x nearObjects ["Land_A_CraneCon_H",200]);
		{
			_siteDirTo = [_x, _site] call bis_fnc_dirto;
			_x setdir (_siteDirTo - 5 + random 10) + 180;

			
		} foreach _cranes;
		
		//
	} foreach _this;
};











HW_Fx_Util_Animate_Idle = 
{
/*	if (count _this > 1) then // when in a group, people turn around a common mean center position so they appear to talk to eachother (not facing away)
	{
		_ctr = [0,0];
		{ _ctr = [((getPos _x) select 0) + (_ctr select 0), ((getPos _x) select 1) + (_ctr select 1)]; } foreach _this;
		
		_k = 1 / (count _this);
		_ctr = [(_ctr select 0) * _k, (_ctr select 1) * _k];
		
		{ _x setDir [getPos _x, _ctr] call bis_fnc_dirto; } foreach _this;
	};
*/	
	{
		// now, figure out if we're dealing with boys or girls... their animations are completely distinct....
		//
		
		_animDefs = [];
		if (_x isKindOf "Man_Base_H") then
		{
			_animDefs = MoveDefs_Men_Idle;
			if (count _this > 1) then // sanity check so ppl don't appear to talk to themselves (like a crazy person, programmers maybe...) when animated alone 
			{
				_animDefs = MoveDefs_Men_Group;
			};
			
		} else
		{
			_animDefs = MoveDefs_Women_Idle;
			if (count _this > 1) then // same check for women... it's even less likely those are game programmers who converse enthusiastically to not a peer
			{
				_animDefs = MoveDefs_Women_Group;
			};
		};
		
		_x switchMove (_animDefs call BIS_fnc_selectRandom);
		_x addEventHandler ["AnimDone", 
		{ 
			(_this select 0) switchMove (_this select 1); 
		}];
		// and once a character is given an animation, it loops on it until told otherwise... you usually don't stay around long enough for this to matter, anyways...
		
	} foreach _this;
};





HW_Fx_Util_Animate_Set =
{
	_moveSet = _this select 1;
	{
		if (count _moveSet > 1) then 
		{ _x switchMove (_moveSet call BIS_fnc_selectRandom); } else { _x switchMove (_moveSet select 0); };
		
		_x addEventHandler ["AnimDone", 
		{ 
			(_this select 0) switchMove (_this select 1); 
		}];
	} foreach (_this select 0);
};




HW_Fx_Util_Animate_Off = 
{
	{
		_x removeAllEventHandlers "AnimDone";
		_x switchmove "";
	} foreach _this;
};






//
// ////////////////////////////////////// // ////////////////////////////////////// // //////////////////////////////////////
//
//  VECTORS!
//



HW_Fn_VectorLerp2D = 
{
	_v1   = _this select 0;
	_v2   = _this select 1;
	_lerp = _this select 2;
	
	_d = (_v1 distance _v2);
	_r = (1.0 / _d) * _lerp;
	
	[((_v2 select 0) - (_v1 select 0)) * _r, ((_v2 select 1) - (_v1 select 1)) * _r]
};


HW_Fn_VectorLerp3D = 
{
	_v1   = _this select 0;
	_v2   = _this select 1;
	_lerp = _this select 2;
	
	_d = (_v1 distance _v2);
	_r = (1.0 / _d) * _lerp;
	
	[((_v2 select 0) - (_v1 select 0)) * _r, ((_v2 select 1) - (_v1 select 1)) * _r, ((_v2 select 2) - (_v1 select 2)) * _r]
};







