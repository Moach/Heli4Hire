
//
//
Fuel_Pump_Active = false;


_this addAction ["Draw Fuel Line and Pump to 100%", "Hangar\HW_Refuel_Helicopter.sqf", 1, 0, true, true, "fire", 
	"chopper distance service_helipad < 10 && isTouchingGround chopper && !isEngineOn chopper && !Fuel_Pump_Active;",
	"", .5, .5, 1+8];
	
_this addAction ["Draw Fuel Line and Pump to 80%", "Hangar\HW_Refuel_Helicopter.sqf", .8, 0, true, true, "fire", 
	"chopper distance service_helipad < 10 && isTouchingGround chopper && !isEngineOn chopper && !Fuel_Pump_Active && (fuel chopper) < .8;",
	"", .5, .5, 1+8];

_this addAction ["Draw Fuel Line and Pump to 60%", "Hangar\HW_Refuel_Helicopter.sqf", .6, 0, true, true, "fire", 
	"chopper distance service_helipad < 10 && isTouchingGround chopper && !isEngineOn chopper && !Fuel_Pump_Active && (fuel chopper) < .6;",
	"", .5, .5, 1+8];

_this addAction ["Draw Fuel Line and Pump to 50%", "Hangar\HW_Refuel_Helicopter.sqf", .5, 0, true, true, "fire", 
	"chopper distance service_helipad < 10 && isTouchingGround chopper && !isEngineOn chopper && !Fuel_Pump_Active && (fuel chopper) < .5;",
	"", .5, .5, 1+8];
	
_this addAction ["Draw Fuel Line and Pump to 40%", "Hangar\HW_Refuel_Helicopter.sqf", .4, 0, true, true, "fire", 
	"chopper distance service_helipad < 10 && isTouchingGround chopper && !isEngineOn chopper && !Fuel_Pump_Active && (fuel chopper) < .4;",
	"", .5, .5, 1+8];