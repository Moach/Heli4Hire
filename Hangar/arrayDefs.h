

/* 
		defining indexing helpers for data-driven code dealing with very long arrays
		
		think of it like a C header file defininf structs... the principle is really the same! 
		
		
		in hindsight, this seems like an obvious solution... one wonders why this isn't standard practice by now
		
		
		
		just mind that operations may fall out of order when used without proper parenthesis placement
*/



// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////// INVENTORY ITEMS

#define ITEM_HardwareCfg 0     //    hardware class entry 
#define ITEM_isInstalled 1     //    installed to helicopter (otherwise it's back at hangar) -- at this time, this might be a redundant redundancy maybe now --
#define ITEM_installHeli 2     //    reference for the aformentioned possible helicopter - objNUll if in hangar
#define ITEM_instSlotIdx 3     //    index for installed component slot where attached- as found in _heli getVariable "HW_ComponentSlots"; - irrelevant if part is in hangar...
#define ITEM_hoursLogged 4     //    hours logged with this item
#define ITEM_damageLevel 5     //    damage sustained by item
#define ITEM_uniqueIdTag 6     //    unique part identification tag
#define ITEM_hangarIndex 7     //    index of self in hangar list (updated dynamically with list)

#define ITEM_STRUCT_SIZE 8


// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////// HELICOPTER COMPONENT SLOT



                          
#define SLOT_ComponentCfg 0    //   ref to component binding cfg,
#define SLOT_hardwareCfg 1     //   bound hardware class
#define SLOT_isInstalled 2     //   installed flag
#define SLOT_ITEM_struct 3     //   installed item data
#define SLOT_installIndex 4    //   index of self in compoents list
#define SLOT_damageSource 5    //   damage source
#define SLOT_minimalSpec 6     //   is minimal spec component?
#define SLOT_minimalSafe 7     //   is it safe to fly without or with it damaged?

#define SLOT_STRUCT_SIZE 8










