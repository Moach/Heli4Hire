////////////////////////////////////////////////////////

class HangarDialog
{
	idd = 9300;
	movingEnable = 0;
	enableSimulation = 1;
	class controlsBackground { 
	
	};
	class objects { 
		// define controls here
	};
	class controls
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = -0.00130207 * safezoneW + safezoneX;
			y = 0.00519294 * safezoneH + safezoneY;
			w = 0.200521 * safezoneW;
			h = 0.989614 * safezoneH;
			
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class IGUIBack_2201: IGUIBack
		{
			idc = 2201;
			x = 0.79362 * safezoneW + safezoneX;
			y = 0.00519294 * safezoneH + safezoneY;
			w = 0.207682 * safezoneW;
			h = 0.989614 * safezoneH;
			
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class IGUIBack_2202: IGUIBack
		{
			idc = 2202;
			x = 0.213542 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.565755 * safezoneW;
			h = 0.274893 * safezoneH;
			
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class IGUIBack_2203: IGUIBack
		{
			idc = 2203;
			x = 0.213542 * safezoneW + safezoneX;
			y = 0.00519294 * safezoneH + safezoneY;
			w = 0.565755 * safezoneW;
			h = 0.0412339 * safezoneH;
			
			colorBackground[] = {0.5,0.2,0.2,0.8};
		};
		class IGUIBack_2204: IGUIBack
		{
			idc = 2204;
			x = 0.213542 * safezoneW + safezoneX;
			y = 0.0464268 * safezoneH + safezoneY;
			w = 0.565755 * safezoneW;
			h = 0.0687232 * safezoneH;
			
			colorBackground[] = {0.2,0.2,0.2,0.6};
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "FLEET MAINTENANCE"; //--- ToDo: Localize;
			x = 0.457031 * safezoneW + safezoneX;
			y = -0.0085517 * safezoneH + safezoneY;
			w = 0.107422 * safezoneW;
			h = 0.0687232 * safezoneH;
		};
		class SB_Office: RscShortcutButton
		{
			idc = 1700;
			text = "Access Office"; //--- ToDo: Localize;
			x = 0.217132 * safezoneW + safezoneX;
			y = 0.0113215 * safezoneH + safezoneY;
			w = 0.0716146 * safezoneW;
			h = 0.0274893 * safezoneH;
		};
		class SB_Close: RscShortcutButton
		{
			idc = 1701;
			text = "Close"; //--- ToDo: Localize;
			x = 0.704111 * safezoneW + safezoneX;
			y = 0.0113215 * safezoneH + safezoneY;
			w = 0.0716146 * safezoneW;
			h = 0.0274893 * safezoneH;
			
			action = "closeDialog 9300;";
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Hangar Inventory"; //--- ToDo: Localize;
			x = 0.00288323 * safezoneW + safezoneX;
			y = 0.0132255 * safezoneH + safezoneY;
			w = 0.0716146 * safezoneW;
			h = 0.0137446 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Helicopter Components"; //--- ToDo: Localize;
			x = 0.805543 * safezoneW + safezoneX;
			y = 0.00941753 * safezoneH + safezoneY;
			w = 0.0859375 * safezoneW;
			h = 0.0137446 * safezoneH;
		};
		class LB_HangarInventory: RscListbox
		{
			idc = 1500;
			sizeEx = 0.024;
			rowHeight = .03;
			x = 0.00585939 * safezoneW + safezoneX;
			y = 0.0326822 * safezoneH + safezoneY;
			w = 0.186198 * safezoneW;
			h = 0.94838 * safezoneH;
			
			onLBDblClick="_this call HW_efx_AttachComponent;";
		};
		class LB_HeliComponents: RscListbox
		{
			idc = 1501;
			sizeEx = 0.024;
			rowHeight = .03;
			x = 0.800781 * safezoneW + safezoneX;
			y = 0.0326822 * safezoneH + safezoneY;
			w = 0.193359 * safezoneW;
			h = 0.94838 * safezoneH;
			
			onLBDblClick="_this call HW_efx_DetachComponent;";
		};
		class TT_Selected: RscText
		{
			idc = 1003;
			text = "Helicopter At Pad [A] :  Wright LD-500   [ N047DF ]"; //--- ToDo: Localize;
			x = 0.292318 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.479818 * safezoneW;
			h = 0.0274893 * safezoneH;
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			text = "Overview"; //--- ToDo: Localize;
			x = 0.292318 * safezoneW + safezoneX;
			y = 0.747404 * safezoneH + safezoneY;
			w = 0.300781 * safezoneW;
			h = 0.164936 * safezoneH;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			text = "Maintenance Report"; //--- ToDo: Localize;
			x = 0.593099 * safezoneW + safezoneX;
			y = 0.747404 * safezoneH + safezoneY;
			w = 0.179036 * safezoneW;
			h = 0.164936 * safezoneH;
		};
		class RscFrame_1802: RscFrame
		{
			idc = 1802;
			text = "Heliport Slots"; //--- ToDo: Localize;
			x = 0.220703 * safezoneW + safezoneX;
			y = 0.73366 * safezoneH + safezoneY;
			w = 0.0644531 * safezoneW;
			h = 0.17868 * safezoneH;
		};
		class SB_PadA: RscShortcutButton
		{
			idc = 1702;
			text = "Pad A"; //--- ToDo: Localize;
			x = 0.227865 * safezoneW + safezoneX;
			y = 0.774893 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0274893 * safezoneH;
			
			action="[0] spawn HW_efx_SelectActiveSpot;";
		};
		class SB_PadB: RscShortcutButton
		{
			idc = 1703;
			text = "Pad B"; //--- ToDo: Localize;
			x = 0.227865 * safezoneW + safezoneX;
			y = 0.829871 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0274893 * safezoneH;
			
			action="[1] spawn HW_efx_SelectActiveSpot;";
		};
		class SB_PadC: RscShortcutButton
		{
			idc = 1704;
			text = "Pad C"; //--- ToDo: Localize;
			x = 0.227865 * safezoneW + safezoneX;
			y = 0.88485 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0274893 * safezoneH;
			
			action="[2] spawn HW_efx_SelectActiveSpot;";
		};
		class TT_PadState_A: RscText
		{
			idc = 1006;
			text = "Landed"; //--- ToDo: Localize;
			x = 0.227865 * safezoneW + safezoneX;
			y = 0.747404 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0274893 * safezoneH;
		};
		class TT_PadState_B: RscText
		{
			idc = 1007;
			text = "In Hangar"; //--- ToDo: Localize;
			x = 0.227865 * safezoneW + safezoneX;
			y = 0.802382 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0274893 * safezoneH;
		};
		class RscFrame_1804: RscFrame
		{
			idc = 1804;
			text = "Pilot"; //--- ToDo: Localize;
			x = 0.700521 * safezoneW + safezoneX;
			y = 0.912339 * safezoneH + safezoneY;
			w = 0.0716146 * safezoneW;
			h = 0.0687232 * safezoneH;
		};
		class RscFrame_1803: RscFrame
		{
			idc = 1803;
			text = "Ground"; //--- ToDo: Localize;
			x = 0.220703 * safezoneW + safezoneX;
			y = 0.912339 * safezoneH + safezoneY;
			w = 0.136068 * safezoneW;
			h = 0.0687232 * safezoneH;
		};
		class TT_PadState_C: RscText
		{
			idc = 1008;
			text = "Empty"; //--- ToDo: Localize;
			x = 0.227865 * safezoneW + safezoneX;
			y = 0.857361 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0274893 * safezoneH;
		};
		class ST_Overview: RscStructuredText
		{
			idc = 1100;
			text = "insert crap here"; //--- ToDo: Localize;
			x = 0.299479 * safezoneW + safezoneX;
			y = 0.761148 * safezoneH + safezoneY;
			w = 0.286458 * safezoneW;
			h = 0.137446 * safezoneH;
		};
		class ST_Maintenance: RscStructuredText
		{
			idc = 1101;
			text = "last maintenance was a shitload of hours ago"; //--- ToDo: Localize;
			x = 0.60026 * safezoneW + safezoneX;
			y = 0.761148 * safezoneH + safezoneY;
			w = 0.164714 * safezoneW;
			h = 0.137446 * safezoneH;
		};
		class SB_Push2Pilot: RscShortcutButton
		{
			idc = 1705;
			text = " Take On Helicopter!"; //--- ToDo: Localize;
			x = 0.707682 * safezoneW + safezoneX;
			y = 0.926084 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class SB_Move2Hangar: RscShortcutButton
		{
			idc = 1706;
			text = "Move To Hangar"; //--- ToDo: Localize;
			x = 0.227865 * safezoneW + safezoneX;
			y = 0.926083 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.05 * safezoneH;
			
			action="[_this] spawn HW_efx_Move2Hangar;";
		};
		class SB_MoveToHelipad: RscShortcutButton
		{
			idc = 1707;
			text = "Move To Helipad"; //--- ToDo: Localize;
			x = 0.292318 * safezoneW + safezoneX;
			y = 0.926083 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.05 * safezoneH;
			
			action="[_this] spawn HW_efx_Move2Helipad;";
		};
		class RscFrame_1805: RscFrame
		{
			idc = 1805;
			text = "Maintenance Work Standards - pick two:"; //--- ToDo: Localize;
			x = 0.363932 * safezoneW + safezoneX;
			y = 0.91234 * safezoneH + safezoneY;
			w = 0.329427 * safezoneW;
			h = 0.0687232 * safezoneH;
		};
		class RscFrame_1806: RscFrame
		{
			idc = 1806;
			text = "Currently Assigned Helicopter"; //--- ToDo: Localize;
			x = 0.220703 * safezoneW + safezoneX;
			y = 0.0530909 * safezoneH + safezoneY;
			w = 0.365234 * safezoneW;
			h = 0.0549786 * safezoneH;
		};
		class RscFrame_1807: RscFrame
		{
			idc = 1807;
			text = "Funds"; //--- ToDo: Localize;
			x = 0.591909 * safezoneW + safezoneX;
			y = 0.0525554 * safezoneH + safezoneY;
			w = 0.179036 * safezoneW;
			h = 0.0549786 * safezoneH;
		};
		class TT_Current: RscText
		{
			idc = 1004;
			text = "Model: Wright LD-500  |  Tail Number: N047DF  |  Landed At Pad [A]"; //--- ToDo: Localize;
			x = 0.227865 * safezoneW + safezoneX;
			y = 0.0601715 * safezoneH + safezoneY;
			w = 0.350911 * safezoneW;
			h = 0.0412339 * safezoneH;
		};
		class TT_Funds: RscText
		{
			idc = 1005;
			text = "$:  42.00"; //--- ToDo: Localize;
			x = 0.60026 * safezoneW + safezoneX;
			y = 0.0601715 * safezoneH + safezoneY;
			w = 0.157552 * safezoneW;
			h = 0.0412339 * safezoneH;
		};
		class SL_Deadline: RscSlider
		{
			idc = 1900;
			x = 0.385417 * safezoneW + safezoneX;
			y = 0.926084 * safezoneH + safezoneY;
			w = 0.078776 * safezoneW;
			h = 0.0274893 * safezoneH;
			
			onSliderPosChanged="_this call HW_efx_SliderSet_HangarWorkStds;";
		};
		class SL_Budget: RscSlider
		{
			idc = 1901;
			x = 0.485677 * safezoneW + safezoneX;
			y = 0.926084 * safezoneH + safezoneY;
			w = 0.078776 * safezoneW;
			h = 0.0274893 * safezoneH;
			
			onSliderPosChanged="_this call HW_efx_SliderSet_HangarWorkStds;";
		};
		class SL_Quality: RscSlider
		{
			idc = 1902;
			x = 0.585938 * safezoneW + safezoneX;
			y = 0.926084 * safezoneH + safezoneY;
			w = 0.078776 * safezoneW;
			h = 0.0274893 * safezoneH;
			
			onSliderPosChanged="_this call HW_efx_SliderSet_HangarWorkStds;";
		};
		
		class RscText_1009: RscText
		{
			idc = 1009;
			text = "Slow   x   Fast"; //--- ToDo: Localize;
			x = 0.392578 * safezoneW + safezoneX;
			y = 0.953573 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.0274893 * safezoneH;
		};
		class RscText_1010: RscText
		{
			idc = 1010;
			text = "Costly x Cheap"; //--- ToDo: Localize;
			x = 0.492839 * safezoneW + safezoneX;
			y = 0.939828 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.0549786 * safezoneH;
		};
		class RscText_1011: RscText
		{
			idc = 1011;
			text = "Shoddy x Proper"; //--- ToDo: Localize;
			x = 0.593099 * safezoneW + safezoneX;
			y = 0.939828 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.0549786 * safezoneH;
		};

	};
};
