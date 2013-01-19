
/*

	these is a place for custom class definitions - it will be used to ensure forward-compatibility with addons to come (which hopefully will, someday)
	so in case a 3rd party helicopter is created, it may define it's own means of integration for use with our little mission here...
	
	this removes the necessity to manually adapt the mission itself to incorporate new aircraft and hardware, at least to some extent....
	
*/

// this file turn into mayhem if not split - we're sorry for the inconvenience
#include <cfgBaseClassDefs.h> 


class CfgSimCopterHardware
{
	class HW_Gen_Battery: HW_Hardware_Base
	{
		ident= "12V Battery";
		fullName="Aeonics BD-6G 12V Battery";
	};
	class HW_Enroy520_Engine: HW_Hardware_Base
	{
		ident= "M520 Engine";
		fullName="Enroy M520 Turboshaft Engine";
	};
	class HW_LD500_Transmission: HW_Hardware_Base
	{
		ident= "TX-V500 Transmission";
		fullName="Coyle TX-V5002E Transmission";
	};
	class HW_LD500_MainRotor: HW_Hardware_Base
	{
		ident= "CR-5 Main Rotor";
		fullName="Aesis-Wright CR-5 Main Rotor";
	};
	class HW_LD500_TailRotor: HW_Hardware_Base
	{
		ident= "STR-50 Tail Rotor";
		fullName="Aesis-Wright STR-50 Tail Rotor";
	};
	class HW_Fasko392_Hydraulics: HW_Hardware_Base
	{
		ident= "MHD-392A Hydraulics";
		fullName="Fasko MHD-392A Hydraulics System";
	};
	class HW_LD500_Starter: HW_Hardware_Base
	{
		ident= "SL-P1 Starter";
		fullName="Enroy SL-P1 Starter Motor";
	};
	class HW_LD500_FuelTank: HW_Hardware_Base
	{
		ident= "Int. Fuel Tank";
		fullName="Airframe Integrated Fuel Tank";
	};
	class HW_LD500_Gear: HW_Hardware_Base
	{
		ident= "Land. Skids";
		fullName="LD500 Landing Skids";
	};
	class HW_LD500_Avionics: HW_Hardware_Base
	{
		ident= "VT.1260H Avionics";
		fullName="Raycon VT.1260H Radio Pack";
	};
	class HW_LD500_SearchLight: HW_Hardware_Base
	{
		ident= "PL-AV3 Light";
		fullName="Lunostat PL-AV3 SuperBeam Light";
	};
	
	
	class HW_LD500_Doors: HW_Hardware_Base
	{
		ident= "LD500 Doors";
		fullName="Wright LD500 Cabin Doors";
	};
	class HW_Rearview_Mirror: HW_Hardware_Base
	{
		ident= "AS Mirror G2";
		fullName="Miraline G2 AeroSport Mirror";
	};
	class HW_Raycon_LCD: HW_Hardware_Base
	{
		ident= "E1026 LCD Panel";
		fullName="Raycon Evest 1026 LCD Panel";
	};
	class HW_LD500_LongStep: HW_Hardware_Base
	{
		ident= "LD500 Long Step";
		fullName="Wright LD500 Gear Boarding Step (Long)";
	};
	class HW_LD500_ShortStep: HW_Hardware_Base
	{
		ident= "LD500 Short Step";
		fullName="Wright LD500 Gear Boarding Step (Short)";
	};
	class HW_2Seat_BackSeats: HW_Hardware_Base
	{
		ident= "Back Seats";
		fullName="Marano Pro-SC 2 Seat Bench";
	};
	class HW_LD500_Bracket: HW_Hardware_Base
	{
		ident= "LD Side Rig";
		fullName="Wright LD-Series R-Side Rig";
	};
	
	class HW_Air300_RotoCamera: HW_Hardware_Base
	{
		ident= "Air300 Camera";
		fullName="EZ-Vue RotoCaster Air300 Camera";
	};
	class HW_Raycon7500_Flir: HW_Hardware_Base
	{
		ident= "FLIR 7500";
		fullName="Raycon MIRNA Series FLIR 7500";
	};
};

class CfgSimCopterFleet
{
	// class name here must match the respective helicopters class name in cfgVehicles
	class Heli_Light01_HeliWorks: HW_Airframe_Base
	{
		airframeIdent="Wright LD-500C";
		desc="A single engine, general-purpuse light helicopter, seats 4 including pilot.<br />Powered by the time-honed Enroy M520 turboshaft engine, this little one is a lot of bird for your buck!";
		
		fuelMaxKg=183;
		fuelTankCount=1;
		engineCount=1;
		payloadMaxKg=428;
		
		pilotClearanceLvl=1; // means you at least gotta be a pilot...
		
		purchaseNew=2000000; // two million gold!! -- estimated from averaged costs of some 2011 MD-500E found for sale online (presumably used, at 1.8M$)
		purchaseUsed=1800000; // as long as there's no damage, few hours and all.... then it's downhill
	
		insuranceMin=200; // starts low, but just you wait 'til they learn what you're putting the bird through!
		
		maintananceBaseCost=500;
		maintananceTimeFactor=10;
		
		
		// hardware get assigned IN from chopper definition, rather than having the components identify suitable airframes -- meaning that common parts can be reused even across models
		//	  this adds major flexibility for future addons, e.g. a bell jetranger uses the very same powerplant as the md500
		//
		
		// this is a list of all hardware bindings for this helicopter -- mind that a repeat entry may appear as some parts may exist in numbers greater than one (redundancy rule)
		class Components
		{	
			class Battery : HW_Hdwr_2_Heli_Base
			{
				hardwareClass="HW_Gen_Battery";
				damageSource="hitBattery";
				minimalSpec=1;
			};
			class Engine : HW_Hdwr_2_Heli_Base
			{
				hardwareClass="HW_Enroy520_Engine";
				damageSource="hitEngine";
				minimalSpec=1;
			};
			class Transmission : HW_Hdwr_2_Heli_Base
			{
				hardwareClass="HW_LD500_Transmission";
				damageSource="hitTransmission";
				minimalSpec=1;
			};
			class MainRotor : HW_Hdwr_2_Heli_Base
			{
				hardwareClass="HW_LD500_MainRotor";
				damageSource="hitHRotor";
				minimalSpec=1;
			};
			class TailRotor : HW_Hdwr_2_Heli_Base
			{
				hardwareClass="HW_LD500_TailRotor";
				damageSource="hitVRotor";
				minimalSpec=1;
			};
			class Hydraulics : HW_Hdwr_2_Heli_Base
			{
				hardwareClass="HW_Fasko392_Hydraulics";
				damageSource="hitHydraulics";
				minimalSpec=1;
			};
			class Starter : HW_Hdwr_2_Heli_Base
			{
				hardwareClass="HW_LD500_Starter";
				damageSource="hitStarter";
				minimalSpec=1;
			};
			class FuelTank : HW_Hdwr_2_Heli_Base
			{
				hardwareClass="HW_LD500_FuelTank";
				damageSource="hitFuel";
				minimalSpec=1;
			};
			class Gear: HW_Hardware_Base
			{
				hardwareClass="HW_LD500_Gear";
				damageSource="hitGear";
				minimalSpec=1;
			};
			class Avionics: HW_Hardware_Base
			{
				hardwareClass="HW_LD500_Avionics";
				damageSource="hitAvionics";
				minimalSpec=1;
				minimalSafe=1; // fly without radio? - sure, why not? - it's your funeral...
			};
			class Light: HW_Hardware_Base
			{
				hardwareClass="HW_LD500_SearchLight";
				damageSource="hitLight";
				minimalSpec=1;
				minimalSafe=1; // as long as you don't go out after dark....
			};
			
			class Doors: HW_Hardware_Base
			{
				hardwareClass="HW_LD500_Doors";
				//
				onItemInstall="_this animate ['addDoors', 1];";
				onItemRemove="_this animate ['addDoors', 0];";	
			};
			class Mirror: HW_Hardware_Base
			{
				hardwareClass="HW_Rearview_Mirror";
				//
				onItemInstall="_this animate ['addMirror', 1];";
				onItemRemove="_this animate ['addMirror', 0];";
			};
			class LCD: HW_Hardware_Base
			{
				hardwareClass="HW_Raycon_LCD";
				//
				onItemInstall="_this animate ['addScreen1', 1];";
				onItemRemove="_this animate ['addScreen1', 0];";
				
				
			};
			class LongStep: HW_Hardware_Base
			{
				hardwareClass="HW_LD500_LongStep";
				//
				onItemInstall="_this animate ['addTread', 1];";
				onItemRemove="_this animate ['addTread', 0];";
							
			};
			class ShortStep: HW_Hardware_Base
			{
				hardwareClass="HW_LD500_ShortStep";
				//
				onItemInstall="_this animate ['addTread_Short', 1];";
				onItemRemove="_this animate ['addTread_Short', 0];";

			};
			class BackSeats: HW_Hardware_Base
			{
				hardwareClass="HW_2Seat_BackSeats";
				//
				onItemInstall="_this animate ['addBackseats', 1];";
				onItemRemove="_this animate ['addBackseats', 0];";
				
			};
			class Bracket: HW_Hardware_Base
			{
				hardwareClass="HW_LD500_Bracket";
				//
				onItemInstall="_this animate ['AddHoldingFrame', 1];";
				onItemRemove="_this animate ['AddHoldingFrame', 0];";

			};
			
			class Camera: HW_Hardware_Base
			{
				hardwareClass="HW_Air300_RotoCamera";
				//
				onItemInstall="_this animate ['AddFlir2', 1];";
				onItemRemove="_this animate ['AddFlir2', 0];";		

			};
			class Flir: HW_Hardware_Base
			{
				hardwareClass="HW_Raycon7500_Flir";
				//
				onItemInstall="_this animate ['AddFLIR', 1];";
				onItemRemove="_this animate ['AddFLIR', 0];";
				
			};
		};
		

		// more shall follow....
	};
};




