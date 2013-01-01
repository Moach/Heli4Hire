HW_Office_Active = true;

createDialog "OfficeDialog";

disableSerialization;
_officeDialog = findDisplay 4200;

_buttonOverview = _officeDialog displayCtrl 1600;
ctrlSetFocus _buttonOverview;

execFSM "Hangar\HW_Office.fsm";

waitUntil {
	!dialog
};

HW_Office_Active = false;
