
	 chopper removeAction SlingRopeDiscn_Action_H;
SlingLoadCgo removeAction SlingRopeDiscn_Action_C;

SlingRopeDiscn_Action_H=-1;
SlingRopeDiscn_Action_C=-1;

chopper ropeDetach SlingRope;
ropeDestroy SlingRope;
SlingRope = nil;

playSound "FX_Rope_Unlatch";

sleep 3;

// hintSilent "Sling Rope released manually!";
RopeAttached = false;
SlingLoadCgo = objNull;