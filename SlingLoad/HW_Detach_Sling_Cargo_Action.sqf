
	 chopper removeAction SlingRopeDiscn_Action_H;
SlingLoadCgo removeAction SlingRopeDiscn_Action_C;
SlingLoadCgo = objNull;

chopper ropeDetach SlingRope;
ropeDestroy SlingRope;
SlingRope = nil;

playSound "FX_Rope_Unlatch";

sleep 3;

hintSilent "Sling Rope released manually!";
RopeAttached = false;