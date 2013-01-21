
SlingLoadCgo = _this select 0;
SlingLoadLen = (_this select 3) select 0;
_mass = ((_this select 3) select 1) select 1;

playSound "FX_Rope_Connect";



sleep 2;

SlingRope = ropeCreate [chopper, "slingload0", SlingLoadCgo, [0, .35, 0], round(SlingLoadLen * 3), SlingLoadLen, true];
ropeSetCargoMass [SlingRope, SlingLoadCgo, _mass];

RopeAttached = true;

sleep 2;

// hintSilent " - Sling Rope Connected! -\n push 'HeliRopeAction' to release from the helicopter"; 

SlingRopeDiscn_Action_H = chopper      addAction ["Disconnect Sling Rope", "SlingLoad\HW_Detach_Sling_Cargo_Action.sqf", nil, 0, true, true, "", "RopeAttached && (player distance _target) < 4 && (vehicle player != chopper)"];
SlingRopeDiscn_Action_C = SlingLoadCgo addAction ["Disconnect Sling Rope", "SlingLoad\HW_Detach_Sling_Cargo_Action.sqf", nil, 0, true, true, "", "RopeAttached && (player distance _target) < 2 && (vehicle player != chopper)"];


SlingLogic = [] spawn 
{ 
	
	while { RopeAttached } do
	{
		sleep .025;
		if ( (inputAction "HeliRopeAction") != 0 ) then
		{
			// hintSilent " - Sling Rope Released! - ";
			
			chopper      removeAction SlingRopeDiscn_Action_H;
			SlingLoadCgo removeAction SlingRopeDiscn_Action_C;
			
			chopper ropeDetach SlingRope;
			ropeDestroy SlingRope;
			SlingRope = nil;
			
			playSound "FX_Rope_Release";
			
			
			sleep 2;
			
			SlingLoadCgo = objNull;
			RopeAttached = false;
			
			
			exit;
		};
	};
};


