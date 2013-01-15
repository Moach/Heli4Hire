


HW_Hangar_Active = true;

createDialog "HangarDialog";

disableSerialization;
_hangarDialog = findDisplay 9300;


ctrlSetFocus (_hangarDialog displayCtrl 1701);

_cam = "camera" camCreate [(getPos pad_A) select 0, ((getPos pad_A) select 1) + 8, 3];
_cam cameraEffect ["External", "BACK"];
_cam camSetTarget pad_A;
_cam camCommit 0; 
showCinemaBorder false;

waitUntil { !dialog };

_cam cameraEffect ["Terminate","BACK"];
_cam camCommit 0;
camDestroy _cam;


HW_Hangar_Active = false;
