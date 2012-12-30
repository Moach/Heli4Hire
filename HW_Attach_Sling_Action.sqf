
SlingLoadCgo = _this select 0;
_len = _this select 3;

playSound "FX_Rope_Connect";
RopeAttached = true;

sleep 2;



// _top = ((boundingBox SlingLoadCgo) select 1) select 2;


SlingRope = ropeCreate [chopper, "slingload0", SlingLoadCgo, [0, .32, 0], round(_len * 2)];

hintSilent " - Sling Rope Connected! -\n push 'HeliRopeAction' to release from the helicopter"; 

SlingRopeDiscn_Action_H = chopper      addAction ["Disconnect Sling Rope", "HW_Detach_Sling_Action.sqf", nil, 0, true, true, "", "RopeAttached && (player distance _target) < 4 && (vehicle player != chopper)"];
SlingRopeDiscn_Action_C = SlingLoadCgo addAction ["Disconnect Sling Rope", "HW_Detach_Sling_Action.sqf", nil, 0, true, true, "", "RopeAttached && (player distance _target) < 2 && (vehicle player != chopper)"];


SlingLogic = [] spawn 
{ 
	
	while { RopeAttached } do
	{
		sleep .1;
		if ( (inputAction "HeliRopeAction") != 0 ) then
		{
			hintSilent " - Sling Rope Released! - ";
			
			chopper      removeAction SlingRopeDiscn_Action_H;
			SlingLoadCgo removeAction SlingRopeDiscn_Action_C;
			SlingLoadCgo = nil;
			
			chopper ropeDetach SlingRope;
			ropeDestroy SlingRope;
			SlingRope = nil;
			
			playSound "FX_Rope_Release";
			
			
			sleep 2;
			RopeAttached = false;
			
		};
	};
};


