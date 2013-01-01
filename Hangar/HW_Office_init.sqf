
Office_Active = false;

player addAction ["Access Office", "Hangar\HW_Office_Dialog.sqf", 1, 0, true, true, "fire", 
	"player distance office_area < 8 && !Office_Active;",
	"", -1, -1, 1+8];