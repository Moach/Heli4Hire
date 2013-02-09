_mode = _this select 3;


switch _mode do
{
	case 0: 
	{
		_p = getPosATL player;


		rtLogCount = rtLogCount +1;

		_id = "rt." + str(rtLogCount);
		_mk = createMarker [_id, _p];
		_mk setMarkerText _id;
		_mk setMarkerType "Flag";
		_mk setMarkerColor "ColorRed";

		// _logThis = format ["['ConstructionSupply', '%1' ,[%2, %3, %4]],", _id, _p select 0, _p select 1, _p select 2];

		_logThis = format ["['%1', [%2, %3, %4]],", _id, _p select 0, _p select 1, _p select 2];
		hint _logThis;

		copyToClipboard _logThis;
	};
	case 1: 
	{
		_p = getPos player;


		lzLogCount = lzLogCount +1;

		_id = "lz." + str(lzLogCount);
		_mk = createMarker [_id, _p];
		_mk setMarkerText _id;
		_mk setMarkerType "Flag";
		_mk setMarkerColor "ColorBlue";

		// _logThis = format ["['ConstructionSupply', '%1' ,[%2, %3, %4]],", _id, _p select 0, _p select 1, _p select 2];

		_logThis = format ["['ConstructionSupply', '%1', [%2, %3, %4]],", _id, _p select 0, _p select 1, _p select 2];
		hint _logThis;

		copyToClipboard _logThis;
	};
}
