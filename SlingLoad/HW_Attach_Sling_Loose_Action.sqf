
SlingLoadCgo = objNull;
SlingLoadLen = _this select 3;

playSound "FX_Rope_Connect";
RopeAttached = true;

sleep 2;

SlingRope = ropeCreate [chopper, "slingload0", round(SlingLoadLen * 3), SlingLoadLen, true];



sleep 2;

// hintSilent " - Sling Rope Connected! -\n push 'HeliRopeAction' to release from the helicopter"; 
SlingRopeDiscn_Action_H = chopper addAction ["Disconnect Sling Rope", "SlingLoad\HW_Detach_Sling_Loose_Action.sqf", nil, 0, true, true, "", "RopeAttached && (player distance _target) < 4 && (vehicle player != chopper)"];
//

SlingLogic = [] spawn 
{ 
	
	while { RopeAttached } do
	{
		sleep .1;
		if ( (inputAction "HeliRopeAction") != 0 ) then
		{
			// hintSilent " - Sling Rope Released! - ";
			
			chopper removeAction SlingRopeDiscn_Action_H;
			
			chopper ropeDetach SlingRope;
			ropeDestroy SlingRope;
			SlingRope = nil;
			
			playSound "FX_Rope_Release";
			
			sleep 2;
			RopeAttached = false;
		};
	};
};


