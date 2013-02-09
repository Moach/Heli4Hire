/* dumpConfig.sqf, v0.95
 *
 * Copyright (c) 2009, shreds-of-sanity@gmx.net
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

private ["_fn_writeToReport","_fn_dumpConfig","_fn_dumpArray","_fn_dumpText","_fn_dumpNumber","_fn_writeClassProlog","_fn_writeClassEpilog","_fn_writeArrayProlog","_fn_writeArrayEpilog","_fn_increaseIndent","_fn_decreaseIndent","_fn_duplicateSpecialChars","_tab","_indentLevel","_indent"];

#define USE_TABS
#define TAB_WIDTH	2

#define OUTPUT_FUNCTION _fn_writeToReport

#define ASCII_TAB	9
#define ASCII_DBLQUOTE	34
#define ASCII_PERCENT	37

#define SPECIAL_CHARS	[ASCII_DBLQUOTE]
//,ASCII_PERCENT]

//////////////////////////////////////////////////////////////////////////////

_fn_writeToReport =
{
	private["_i","_array","_stringArray"];
	_i = 0;
	_stringArray = toArray _this;
	if ((count _stringArray) > 1000) then
	{
		_array = [];
		{
			_array set [count _array,_x];
			_i = _i + 1;
			if (_i > 1000) then
			{
				diag_log (text (toString _array));
				diag_log "XXX TO REMOVE XXX";
				_i = 0;
				_array = [];
			};
		} forEach _stringArray;
		if ((count _array) > 0) then
		{
			diag_log (text (toString _array));
		};
	}
	else
	{
		diag_log (text _this);
	};
};
_fn_dumpConfig =
{
	switch (true) do
	{
		case isClass _this:
		{
			//to found buggy model
			//if ( getText (_this >> "model") == "bmp" ) then
			//if (getText(configFile >> "CfgVehicles" >> (configName _this) >> "model") == "bmp") then
			//{
			//	"found" call OUTPUT_FUNCTION;
			//};
			if ((str _this) == "bin\config.bin") then
			{
				for "_i" from 0 to (count _this - 1) do
				{
					(_this select _i) call _fn_dumpConfig;// recursion
				};
			}
			else
			{
				_this call _fn_writeClassProlog;
				for "_i" from 0 to (count _this - 1) do
				{
					(_this select _i) call _fn_dumpConfig;// recursion
				};
				call _fn_writeClassEpilog;
			};
		};
		case isArray _this:
		{
			private "_s";
			_s = _this call _fn_writeArrayProlog;
			_s = _s + ([getArray _this] call _fn_dumpArray);
			_s = _s + "};";
			_s call OUTPUT_FUNCTION;
			
		};
		case isNumber _this:
		{
			_this call _fn_dumpNumber;
		};
		case isText _this:
		{
			_this call _fn_dumpText;
		};
		default
		{
			hintC "ERROR: Unknown type:\n" + str _this; sleep 1;
			halt;
		};
	};
};
_fn_dumpArray =
{
	private ["_delimiter","_count","_element","_s","_array"];
	_delimiter = ",";
	_array = _this select 0;
	_count = count _array - 1;
	_s = "";

	for "_i" from 0 to _count do
	{
		_element = _array select _i;
		if (_i == _count) then {_delimiter = "";};// no delimiter after last element

		switch (typeName _element) do
		{
			case "ARRAY":
			{
				_s = _s + "{";
				_newString = [_element] call _fn_dumpArray;// recursion
				_s = _s + _newString + "}" + _delimiter;
			};
			case "SCALAR":
			{
				_s = _s + str(_element) + _delimiter;//_indent + 
			};
			case "STRING":
			{
				_newString = _element call _fn_duplicateSpecialChars;
				_s = _s + """" + _newString + """" + _delimiter;//_indent + 
			};
		};
	};
	_s;
};
_fn_dumpText =
{
	private "_s";
	_s = getText _this call _fn_duplicateSpecialChars;
	_s = _indent + configName _this + " = """ + _s + """;";
	_s call OUTPUT_FUNCTION;
};
_fn_dumpNumber =
{
	private "_s";
	_s = str getNumber _this;
	_s = _indent + configName _this + " = " + _s + ";";
	_s call OUTPUT_FUNCTION;
};

//////////////////////////////////////////////////////////////////////////////

_fn_writeClassProlog =
{
	private "_s";
	_s = configName inheritsFrom _this;
	if (_s != "") then {_s = ": " + _s;};

	_s = _indent + "class " + configName _this + _s;
	_s call OUTPUT_FUNCTION;

	_s = _indent + "{";
	_s call OUTPUT_FUNCTION;

	call _fn_increaseIndent;
};
_fn_writeClassEpilog =
{
	private "_s";
	call _fn_decreaseIndent;

	_s = _indent + "};";
	_s call OUTPUT_FUNCTION;
};
_fn_writeArrayProlog =
{
	private "_s";
	_s = _indent + configName _this + "[] = {";
	_s;
};
_fn_writeArrayEpilog =
{
	call _fn_writeClassEpilog;
};
_fn_increaseIndent =
{
	_indentLevel = _indentLevel + 1;
	_indent = "";
	for "_i" from 1 to _indentLevel do {_indent = _indent + _tab;};
};
_fn_decreaseIndent =
{
	_indentLevel = _indentLevel - 1;
	_indent = "";
	for "_i" from 1 to _indentLevel do {_indent = _indent + _tab;};
};
_fn_duplicateSpecialChars =
{
	private "_t";
	_t = [];
	{
		_t set [count _t,_x];
		if (_x in SPECIAL_CHARS) then
		{
			_t set [count _t,_x];
		};
	} forEach toArray _this;
	toString _t;// return value
};

//////////////////////////////////////////////////////////////////////////////

#ifdef USE_TABS
_tab = toString [ASCII_TAB];
#else
_tab = " ";
for "_i" from 2 to TAB_WIDTH do {_tab = _tab + " ";};
#endif

_indentLevel = 0;
_indent = "";

startLoadingScreen [""];
_this call _fn_dumpConfig;
endLoadingScreen;

endMission "END1";