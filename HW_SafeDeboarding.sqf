
_grp = _this select 0;
_heli = _this select 1;


if (!PD_Armed) then 
{
	call HW_Fx_PD_Clear;
};

sleep 1;

PilotDecision=0;
[["PD: Safe for deboarding!"]] call HW_Fx_PD_Prompt;

_t = time + 30; // if after this long you haven't cleared deboarding - ppl will decide for themselves
waitUntil { PilotDecision == 1 || time > _t; };

call HW_Fx_PD_Clear;


playSound "FX_Seatbelts";




_grp leaveVehicle _heli;             // everyone out
doGetOut units _grp;                 // i mean it!
units _grp allowGetIn false;         // OUT! NOW!! - beat it!

// now, go somewhere, don't just stand around being idiots...
(units _grp) doMove ((nearestBuilding _heli) buildingExit 0);