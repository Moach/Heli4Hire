
HW_Office_Active = false;

execVM "Hangar\HW_Office_functions.sqf";

// item syntax is [0 "Item Name", 	1 int cost,			  	2 "Description",		3 "picture filename",
//				   4 int weight,  	5 int deliveryTimeMins,	6 01float condition, 	7 int timeOfPurchase]
				   
HW_Office_StoreItems = [
	["Test Item 1", 100, "A test item to test items", "#(argb,8,8,3)color(1,1,1,1)", 10, 5, 1, 0],
	["Test Item 2", 130, "Another test item to test items", "#(argb,8,8,3)color(0,1,1,1)", 55, 12, 1, 0]
];

HW_Office_Inventory = [];

HW_Office_Orders = [];

HW_Office_Funds = 500 + random 500;


player addAction ["Save Career Progress", "HW_Savegame.sqf", nil, 0, false, true, "", "!(player in chopper) && player distance office_area < 8 && !HW_Office_Active;"];


player addAction ["Access Office", "Hangar\HW_Office_Dialog.sqf", 1, 0, true, true, "fire", 
	"player distance office_area < 8 && !HW_Office_Active;",
	"", -1, -1, 1+8];
	
if (HW_DEBUG) then
{
	player addAction ["Buddamus", "Hangar\HW_OfficeBuddamus.sqf", nil, 0, false, true, "", "!(player in chopper) && player distance office_area < 8 && !HW_Office_Active;"];
}