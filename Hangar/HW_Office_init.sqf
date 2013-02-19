
HW_Office_Active = false;

execVM "Hangar\HW_Office_functions.sqf";

// item syntax is  [0 "Item Name", 		 1 int cost,			  	2 "Description",		3 "picture filename",
//				   	4 int weight,  		 5 int deliveryTimeMins,	6 01float condition, 	7 int deliveryTimestamp,
//				   	8 "onItemUnpack",   9 "onItemRepack", 			10 bool sellable, 		11 bool packed]
				   
// item parameters:
// 0 - default
// 1 - sellable
// 2 - unpackable
// 4 - repackable


HW_Office_StoreItems = 
[	
	
	["GPS", 499.90, "The Armin BX300 Personal Satellite Signal Trilateration Processor and Chart Overlay Rendering Device may have a name that is longer than its list of features, but it is certainly much less deadly to use while flying than a foldout paper map.",	"#(argb,8,8,3)color(0.3,0.4,0.2,1)", 0.5, 0.1, 1, 0, 
	 " 	if (player hasWeapon 'ItemGPS') then
		{
			hint 'It seems you already have one of those. No point in unpacking this one.';
		} else {
			player addWeapon 'ItemGPS';
			hint 'Unpacked GPS and added to Gear.';
			_this set [11, false];
			_this set [6, 0.8];			
		}; ",  
	 "  if (player hasWeapon 'ItemGPS') then
		{
			player removeWeapon 'ItemGPS';
			hint 'Packed GPS back neatly into its box.'; 
			_this set [11, true];
		} else {
			hint 'You dont have the GPS with you. Did you drop it somewhere?';
		}; ", true, true],
		
		
	["Watch", 44.90, "A rugged, reliable time-telling device, with a manly brushed steel surface. Very useful if you have deadlines to keep. ",	"#(argb,8,8,3)color(0.4,0.4,0.4,1)", 0.1, 0.1, 1, 0, 
	 " 	if (player hasWeapon 'ItemWatch') then
		{
			hint 'It seems you already have one of those. No point in unpacking this one.';
		} else {
			player addWeapon 'ItemWatch';
			hint 'Unpacked the watch and added to Gear.';
			_this set [11, false];
			_this set [6, 0.8];			
		}; ",  
	 "  if (player hasWeapon 'ItemWatch') then
		{
			player removeWeapon 'ItemWatch';
			hint 'Packed watch back neatly into its box.'; 
			_this set [11, true];
		} else {
			hint 'You dont have the watch with you. Did you drop it somewhere?';
		}; ", true, true],
		
	["Binoculars", 149.90, "Not very useful for flying, admittedly, but these high-performance binoculars are great for plane (or heli) spotting.",	"#(argb,8,8,3)color(0.1,0.4,0.4,1)", 0.1, 0.1, 1, 0, 
	 " 	if (player hasWeapon 'Binocular') then
		{
			hint 'It seems you already have one of those. No point in unpacking this one.';
		} else {
			player addWeapon 'Binocular';
			hint 'Unpacked the binoculars and added to Gear.';
			_this set [11, false];
			_this set [6, 0.8];			
		}; ",  
	 "  if (player hasWeapon 'Binocular') then
		{
			player removeWeapon 'Binocular';
			hint 'Packed binoculars back neatly into its box.'; 
			_this set [11, true];
		} else {
			hint 'You dont have the binoculars with you. Did you drop it somewhere?';
		}; ", true, true],
		
	["Compass", 129.90, "A butch and brawny army grade compass, it features a directional targeting string for precisely resolving 'where am i looking at?' moments. According to Wikipedia, the needle points to where Santa lives!",	"#(argb,8,8,3)color(0.1,0.4,0.4,1)", 0.1, 0.1, 1, 0, 
	 " 	if (player hasWeapon 'ItemCompass') then
		{
			hint 'It seems you already have one of those. No point in unpacking this one.';
		} else {
			player addWeapon 'ItemCompass';
			hint 'Unpacked the binoculars and added to Gear.';
			_this set [11, false];
			_this set [6, 0.8];			
		}; ",  
	 "  if (player hasWeapon 'ItemCompass') then
		{
			player removeWeapon 'ItemCompass';
			hint 'Packed binoculars back neatly into its box.'; 
			_this set [11, true];
		} else {
			hint 'You dont have the compass with you. Did you drop it somewhere?';
		}; ", true, true]
];

HW_Office_Inventory = 
[
	
];

HW_Office_Orders = [];

HW_Office_Funds = 500 + random 500;


player addAction ["Save Career Progress", "HW_Savegame.sqf", nil, 0, false, true, "", "!(player in chopper) && player distance office_area < 8 && !HW_Office_Active;"];


player addAction ["Access Office", "Hangar\HW_Office_Dialog.sqf", 1, 0, true, true, "fire", 
	"player distance office_area < 8 && !HW_Office_Active;",
	"", -1, -1, 1+8];
	
if (HW_DEBUG) then 
{
	player addAction ["Buddamus", "Hangar\HW_OfficeBuddamus.sqf", nil, 0, false, true, "", "!(player in chopper) && player distance office_area < 8 && !HW_Office_Active;"];
};
	
HW_Office_OrdersUpdateDaemon = [] spawn 
{
	while { true } do 
	{
		sleep 1;	
		call HW_Office_UpdateOrders;
	};	
};
