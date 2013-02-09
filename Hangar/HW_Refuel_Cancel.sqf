
Fuel_Pump_Active = false;
hint "Refuelling Cancelled";

chopper removeAction Fuel_Connect_Action;
player removeAction Fuel_Cancel_Action;

chopper lock false;