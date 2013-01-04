

HW_Comp_Sling_Base = 
[
	["Paleta2",[-11.3301,-5.02539,0],234.171],
	["PoliceCar_H",[-12.3594,-9.06445,0],153.163], 
	["RoadCone",[-11.9922,11.043,0],234.171], 
	["RoadCone",[-12.5488,1.1543,0],234.171], 
	["RoadCone",[-4.64063,-12.877,0],234.171],
	["RoadCone",[12.4297,-11.9883,0],234.171], 
	["GroundCrew_H",[5.01172,10.2539,0],175.683], 
	["Workman_Random_H",[-5.44531,8.66211,0],132.178], 
	["Workman_Random_H",[3.65234,10.0977,0],205.06], 
	["PoliceOfficer_H",[-8.52344,-5.53516,0],82.3151], 
	["Van_Flatbed_H",[-4.96484,12.8809,0],268.858], 
	["Van_H",[-10.627,-1.54102,0],234.426], 
	["RoadCone",[-8.32031,-9.91602,0],234.171], 
	["RoadCone",[9.95508,11.3594,0],234.171], 
	["RoadCone",[16.1836,-1.14453,0],234.171], 
	["FireExtinguisher_H",[1.92773,10.4766,0],234.171], 
	["FireExtinguisher_H",[1.69141,10.0781,0],234.171], 
	["Paleta2",[9.25586,4.93359,0],234.171], 
	["Paleta2",[11.6152,6.00977,0],167.153], 
	["Paleta1",[-9.33398,-3.44531,0],234.171], 
	["Paleta1",[8.85938,7.3125,0],234.171],
	["RoadCone",[13.5391,6.81836,0],234.171]
];








HW_Fx_Composition_Assemble = 
{
	_center = (_this select 0);
	
	_compGrp = createGroup CIVILIAN; // will be used for all humans spawning here...
	_vehs = []; _vehs resize count (_this select 1);
	_counter = 0;
	//
	
	
	{
		_p = _x select 1;
		_p = [(_p select 0) + (_center select 0), (_p select 1) + (_center select 1), 0];
		
		if ((_x select 0) isKindOf "Man") then
		{
			(_x select 0) createUnit [_p, _compGrp, "cmpNewUnit = this"];
			processInitCommands;
			
			cmpNewUnit disableAI "MOVE";
			cmpNewUnit setPosATL _p;
			cmpNewUnit setDir (_x select 2);
			
		} else
		{
			_veh = (_x select 0) createVehicle _p;
			_veh setPosATL _p;
			_veh setDir (_x select 2);
			
			_vehs set [_counter, _veh];
			_counter = _counter+1;
		};
	} foreach (_this select 1);
	
	
[_compGrp, _vehs] };



HW_Fx_Composition_Delete = 
{	
	{ deleteVehicle _x; } foreach units (_this select 0);
	{ if (!isNil "_x") then { deleteVehicle _x; }; } foreach (_this select 1);
	
	//
	deleteGroup (_this select 0);
};













