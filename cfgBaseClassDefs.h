

class HW_Airframe_Base
{
	airframeIdent="Whatdacopter";
	desc="";
	
	icon="";                // icon shown on listings
	picture="";             // larger image shown with expanded information
		
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
	
	class Components {};
	
	
	onAirframeCapsInit=""; // code to run at initialization time to setup the basic features needed to determine what this bird can do (runs before hardware init, defines basic-only capabilities)
	class Capabilities  // capabilities for any airframe to comply with missions - these are default settings (and very unproductive, really) - apply to individual aircraft via setVariable by config names as follows:
	{
		HW_PAXCAP = 1; // number of passengers it may carry
		HW_PAXCOM = 1; // degree to which passengers get to ride comfortably   0: emergency / cargo only | 1: ok for 'heavy work' | 2: passenger-friendly | 3: VIP
		HW_CGOCAP = 1; // level of cargo capacity  0: none | 1: lite | 2: medium | 3: heavy
		HW_MEDCAP = 1; // level of medical/emergency readyness  0: none | 1: limited/makeshift | 2: air ambulance
		HW_TACCAP = 1; // level of tactical operations capability 0: none | 1: fast landing | 2: fast rope
		
		HW_SLING_OPS = 0; // flag defining a toggle for slingload capabilities
		HW_WINCH_OPS = 0; // flag defining a toggle for winch capabilities
		HW_FRIES_OPS = 0; // flag defining a toggle for fast-rope-insertion-extraction system capabilities
		
		HW_INTCGO = 0;    // cargo capacity inside airframe  0: none, e.g. schweizer 300, R22 | 1: lite/med, e.g. JetRanger, MD500, AS350, Bell 407 | 2: big, e.g. EH101, AS532 | 3: huge, e.g. MI26, CH-47
		HW_CABVIS = 1;    // passenger visibility from inside cabin  0: unfit for observation flight | 1: clear, best to side opposite of pilot | 2: clear, either side but not front
		HW_PILOTSIDE = 0; // side where pilot sits - affects side visibility for front seat passengers
		
		HW_AIRDROP = 0;   // ability to drop objects from the air  0: cannot | 1: small stuff | 2: larger stuff
		
		HW_WATERBOMB = 0; // ability to operate as a water bomber 0: none | 1: using bucket | 2: internal tank (water cannon??)
		HW_SPOTLIGHT = 1; // type of spotlight installed  0:  none |  1: fixed  |  2: spotting searchlight
		HW_CAMERA = 0;    // equipped with a camera  0: not | 1: fixed camera | 2: full rotating unit
		HW_FLIR = 0;      // defines if a FLIR unit is available or not
		
		HW_COPILOT = 0;   // level to which copilot is required  0: not  |  1:  for advanced ops only  |  2:  always		
		HW_GUNSHIP = 0;   // having too much fun, are you?
	};
};


class HW_Hardware_Base
{
	ident="generic thingumabob";                     // abbridged item name shown on inventory listings
	fullName="general generics thingummabob pro";    // full item name with all the bells and whistles
	desc="a thing that probably does something";	 // description of the thing (ideally make it kinda funny)
	serialTag="SN-0";                                // tag prefixing unique part designation strings
	
	icon="";                // icon shown on listings
	picture="";             // larger image shown with expanded information
	
	//
	onItemUnpack="";        // code executed on item being unpacked
	onItemRepack="";        // code executed on it being packed back up (for refund, or sale)
	
	itemMass=0;             // physical mass in Kg. (affects flight dynamics and shipping costs) 
	itemVolume=1;           // approximate volume in Litres (affects shipping costs)
	
	itemAvailabity=0;       // factor of how frequently this item comes across the store - zero makes it fully unavailable
	itemCostNew=1;          // these are kinda self-explaining, no?
	itemCostUsed=1;         // ....we've all been there
	
	repairLevel=1;      // feasibility of maintenace work being peformed to such level of success - 1= fully repairable, .5= can be fix to half as good, 0= must replace
	repairCost=2;       // cost of maintenance at full damage -- may exceed cost of new part, making it a total loss... then seen as a negative-valued item
	repairFail=0;       // a point on damage scale where the feasibility of repair becomes zero (does NOT factor into cost)
};




class HW_Hdwr_2_Heli_Base
{
	/*
		wait whaaat? 
		 -- right, the point of this is to isolate the logic of how items attach to individual helicopters from the items themselves... i.e. the flir and camera units fit on multiple aiframes, but
			their animation names may differ for each case - this method allows a same part to adapt to differently configured helicopters through specialized logic...
			
			it also allows more than one of the same part being fitted without discretion of the itemized part (namely, twin engines)
			
			or in other words, it makes an item of hardware a helicopter component!
			
		it is a little more writing to do... but trust me - it'll be worth it!
	*/
	
	hardwareClass="";   // hardware item class this connects to
	slotIdent="";       // slot name shown on components lisy
	
	requiredItems[]={}; // list of further parts that need to be installed for this to be physically assembled into the airframe (CANNOT EVER be reciprocal!)
	conflictItems[]={}; // conversely, parts that must NOT be installed for this being assembled (MUST be reciprocal!)
	
	minimalSpec=0;      // determines if this item comes included in the barebones configuration of the given airframe
	minimalSafe=0;      // in case of the above being true - is it safe and/or physically possible to take it out and still fly the thing??
	
	onItemInstall="";   // code executed when item is installed onto helicopter (receives _this as helicopter reference)
	onItemRemove="";    // code executed when it is removed from said helicopter
	onItemDamage="";    // code executed when item receveis damage (see how below) -- not required for basic damage to apply, but allows manipulating throughput
	onItemRepair="";    // same as above, but backwards...
	
	damageSource="";    // namely a hitpoint e.g. 'hitEngine' - this assigns a link for component damage where applicable
	
	assemblyCost=1;     // cost of mounting this part to the airframe (blend of proverbially equally-valued time and money)
	servicePenalty=.2;  // factor for cost of servicing this part while it is attached (whithout removing, which inflicts 1/2 of the assembly cost) - 0= easy; 1= must remove for any repair!
	
	vulnerability=0;    // scalar determining how much damage from the hitpoint translates into more permanent component damage (with unmanipulated value)
	wearFactor=0;       // scalar for wear-induced damage from flying hours (should be low) 
	criticalWear=.5;    // level of damage where the component becomes critically impaired for use on this airframe (or maybe even at all...)
};


