
_fillAmount = _this select 3;
Fuel_Pump_Active = true;
Fuel_Pumping = false;

hintSilent "Now, connect the fuel line to the chopper to start refueling...";
playSound ["FX_Draw_Fuel_Line", true];
//



Fuel_Connect_Action = chopper addAction ["Start Refueling", "Hangar\HW_Refuel_Start.sqf", _fillAmount, 6, true, true, "fire", 
	"player distance _target < 30 && isTouchingGround chopper && player distance chopper < 3", 
	"HitFuel", 1, .15, 1+8, 4, "Refuel Helicopter", "Connect line and start pump"];


Fuel_Cancel_Action = player addAction ["Cancel Refuelling", "Hangar\HW_Refuel_Cancel.sqf", nil, 5, false, true];

chopper lock true; // no getting in chopper carrying the fuel nozzle!

while {Fuel_Pump_Active && !Fuel_Pumping} do 
{
	sleep 1;
	
	// turning on the chopper will cancel the fueling process... same as for going too far from the pad (hose won't reach that far)
	//
	if (player distance service_helipad > 30 || isEngineOn chopper) then
	{
		Fuel_Pump_Active = false;
		hint "Refuelling Cancelled";
		
		chopper removeAction Fuel_Connect_Action;
		player  removeAction Fuel_Cancel_Action;
		chopper lock false;
	};
};
