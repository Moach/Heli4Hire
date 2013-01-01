Office_Active = true;

execFSM "Hangar\HW_Office.fsm";

waitUntil {
	!dialog
};

Office_Active = false;
