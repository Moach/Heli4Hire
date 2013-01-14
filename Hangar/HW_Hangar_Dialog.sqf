


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


sliderSetPosition [1900, 5];
sliderSetPosition [1901, 5];
sliderSetPosition [1902, 10];


HW_efx_SliderSet_HangarWorkStds = 
{
	_f = (sliderPosition 1900); // do it fast!
	_c = (sliderPosition 1901); // do it cheap!
	_r = (sliderPosition 1902); // do it right!
	
	_d = 20.0 - (_f + _c + _r);
	
	sliderSetPosition [1900, (_f + (_d * .5))];
	sliderSetPosition [1901, (_c + (_d * .5))];
	sliderSetPosition [1902, (_r + (_d * .5))];
	
	(_this select 0) sliderSetPosition (_this select 1);
};






waitUntil { !dialog };

_cam cameraEffect ["Terminate","BACK"];
_cam camCommit 0;
camDestroy _cam;


HW_Hangar_Active = false;
