////////////////////////////////////////////////////////

class HangarDialog: RscControlsGroup
{
	idc = 2300;
	idd = 9300;
	x = 0.20638 * safezoneW + safezoneX;
	y = 0.128895 * safezoneH + safezoneY;
	w = 0.601563 * safezoneW;
	h = 0.755955 * safezoneH;
	class controls
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.263672 * safezoneW + safezoneX;
			y = 0.197618 * safezoneH + safezoneY;
			w = 0.472656 * safezoneW;
			h = 0.59102 * safezoneH;
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.211363 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.0274893 * safezoneH;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.238852 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.536041 * safezoneH;
		};
		class TXT_Title: RscText
		{
			idc = 1000;
			text = "- HANGAR -"; //--- ToDo: Localize;
			x = 0.471354 * safezoneW + safezoneX;
			y = 0.197618 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0549786 * safezoneH;
		};
		class SB_Close: RscShortcutButton
		{
			idc = 1700;
			text = "Close"; //--- ToDo: Localize;
			x = 0.671875 * safezoneW + safezoneX;
			y = 0.211363 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0274893 * safezoneH;
			tooltip = "just does what it says..."; //--- ToDo: Localize;
			
			action = "closeDialog 9300";
		};
		class SB_Office: RscShortcutButton
		{
			idc = 1701;
			text = "Office"; //--- ToDo: Localize;
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.211363 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0274893 * safezoneH;
			tooltip = "Access Office"; //--- ToDo: Localize;
		};
	};
};
