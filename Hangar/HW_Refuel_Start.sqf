
_fillAmount = _this select 3;

chopper removeAction Fuel_Connect_Action;
player removeAction Fuel_Cancel_Action;

hintSilent "Pumping Fuel....";
playSound ["FX_Pump_Fuel", true];

Fuel_Pumping = true;

while {Fuel_Pump_Active} do 
{
	sleep 2;
	
	if ((fuel chopper) < _fillAmount) then
	{
		// keep it flowing!
		chopper setFuel ( ((fuel chopper) + .05) min 1 );
	
	} else
	{
		// all done!
		hint "Fueling Complete!!";
		chopper lock false;
		
		Fuel_Pump_Active = false;
		Fuel_Pumping = false;
	};

};