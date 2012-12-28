_p = getPos vehicle player;
_logThis = format ["Position Log @t: %1   [%2, %3, %4]", time, _p select 0, _p select 1, _p select 2];

diag_log _logThis;
hint _logThis;

copyToClipboard format ["[%1, %2, %3]", _p select 0, _p select 1, _p select 2];