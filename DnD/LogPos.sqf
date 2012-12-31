_p = getPos vehicle player;


// _logThis = format ["Position Log @: %1   [%2, %3, %4]", time, _p select 0, _p select 1, _p select 2];
// diag_log _logThis;

lzLogCount = lzLogCount +1;

_id = "lz." + str(lzLogCount);
_mk = createMarker [_id, _p];
_mk setMarkerText _id;
_mk setMarkerType "Flag";
_mk setMarkerColor "ColorRed";

_logThis = format ["['ConstructionSupply', '%1' ,[%2, %3, %4]],", _id, _p select 0, _p select 1, _p select 2];
hint _logThis;

copyToClipboard _logThis;
