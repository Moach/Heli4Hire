
/*

	these is a place for custom class definitions - it will be used to ensure forward-compatibility with addons to come (which hopefully will, someday)
	so in case a 3rd party helicopter is created, it may define it's own means of integration for use with our little mission here...
	
	this removes the necessity to manually adapt the mission itself to incorporate new aircraft and hardware, at least to some extent....
	
*/


class HW_Airframe_Base
{
	airframeIdent="Whatdacopter";
	desc="";
		
	fuelMaxKg=1;
	fuelTankCount=1;
	engineCount=1;
	payloadMaxKg=100;
	
	pilotClearanceLvl=1;
	
	purchaseNew=1000000;
	purchaseUsed=800000;
	
	insuranceMin=100;
	maintananceBaseCost=100;
	maintananceTimeFactor=1;
	
	hardware[]={};
	basicHardware[]={};
};


class HW_Hardware_Base
{
	ident="generic thingumabob";                     // abbridged item name shown on inventory listings
	fullName="general generics thingummabob pro";    // full item name with all the bells and whistles
	desc="a thing that probably does something";	 // description of the thing (ideally make it kinda funny)
	
	icon="";                // icon shown on listings
	picture="";             // larger image shown with expanded information
	
	featureLinkage="";      // connection to physical part on helicopter, namely a hitpoint e.g. 'hitEngine' - this assigns a particular source for component damage where applicable
	//
	onItemUnpack="";        // code executed on item being unpacked
	onItemRepack="";        // code executed on it being packed back up (for refund, or sale)
	onItemInstall="";       // code executed when item is installed onto helicopter
	onItemRemove="";        // code executed when it is removed from said helicopter
	onItemDamage="";        // code executed when item receves damage
	
	itemMass=1;             // physical mass in Kg. (affects flight dynamics* and shipping costs)  *FDs are only altered for non-basic components (those that do NOT come with the airframe)
	itemVolume=1;           // approximate volume in Litres (affects shipping costs)
	
	itemAvailabity=0;       // factor of how frequently this item comes across the store - zero makes it fully unavailable
	itemCostNew=1;          // these are kinda self-explaining, no?
	itemCostUsed=1;         // ....we've all been there
	
	repairLevel=1;          // feasibility of maintenace work being peformed to such level of success - 1= fully repairable, .5= can be fix to half as good, 0= must replace
	repairCost=2;           // cost of maintenance at full damage -- may exceed cost of new part, making it a total loss... then seen as a negative-valued item
	repairFail=0;           // a point on damage scale where the feasibility of repair becomes zero (does NOT factor into cost)
	
	vulnerability=0;        // scalar determining how much damage from the hitpoint translates into more permanent component damage
	wearFactor=0;           // scalar for wear-induced damage from flying hours (should be low) 
};


class CfgSimCopterHardware
{
	access = 1;
	class HW_Gen_Battery: HW_Hardware_Base
	{
		ident="12V Battery";
		featureLinkage="hitBattery";
	};
	class HW_LD500_Engine: HW_Hardware_Base
	{
		ident="Enroy M520 Engine";
		featureLinkage="hitEngine";
	};
	class HW_LD500_Tranmission: HW_Hardware_Base
	{
		ident="LD500 Transmission";
		featureLinkage="hitTransmission";
	};
	class HW_LD500_MainRotor: HW_Hardware_Base
	{
		ident="LD500 Main Rotor";
		featureLinkage="hitHRotor";
	};
	class HW_LD500_TailRotor: HW_Hardware_Base
	{
		ident="LD500 Tail Rotor";
		featureLinkage="hitVRotor";
	};
};

class CfgSimCopterFleet
{
	access = 1;
	
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
		
		
		//
		hardware[]={"HW_Gen_Battery", "HW_LD500_Engine", "HW_LD500_Tranmission", "HW_LD500_MainRotor", "HW_LD500_TailRotor"};
		basicHardware[]={"HW_Gen_Battery", "HW_LD500_Engine", "HW_LD500_Tranmission", "HW_LD500_MainRotor", "HW_LD500_TailRotor"};
		
		// more shall follow....
	};
};




