


HW_Hangar_Active = true;

createDialog "HangarDialog";

disableSerialization;
_hangarDialog = findDisplay 9300;

waitUntil { !dialog };

HW_Hangar_Active = false;
