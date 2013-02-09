case "SLINGLOAD_INTRO": {
	_kb = ["Oneliners_Intro","MissionSlingload",[true,true]] call bis_fnc_kbTell;
	bis_fnc_genericsentence_1 = hsim_worker;
};
case "SLINGLOAD_FIRST": {
	_kb = ["Oneliners_Sling","MissionSlingload",[true,true]] call bis_fnc_kbTell;
};
case "SLINGLOAD_LAST": {
	_kb = ["01_Oneliners_Building","MissionSlingloadCamp",[["WOR",2],true]] spawn bis_fnc_kbTell;
	["SLINGLOAD_FIRST",true] call bis_fnc_counter;
};
case "SLINGLOAD_OUTRO": {
	_kb = ["Oneliners_Done","MissionSlingload",[true,true]] call bis_fnc_kbTell;
};