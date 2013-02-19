

class OfficeDialog {
	idd = 4200;
	movingEnable = 0;
	class controlsBackground { 
	
	};
	class objects { 
		// define controls here
	};
	class controls { 
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Tom Larkin, v1.044)
////////////////////////////////////////////////////////

class IGUIBack_2200: IGUIBack
{
	idc = 2200;
	x = 0 * GUI_GRID_W + GUI_GRID_X;
	y = 0 * GUI_GRID_H + GUI_GRID_Y;
	w = 32 * GUI_GRID_W;
	h = 20 * GUI_GRID_H;
	colorBackground[] = {0.2,0.5,0.5,0.5};
};
class InnerFrame: IGUIBack
{
	idc = 2201;
	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
	y = 1.7 * GUI_GRID_H + GUI_GRID_Y;
	w = 31 * GUI_GRID_W;
	h = 16.5 * GUI_GRID_H;
	colorBackground[] = {0.2,0.2,0.2,0.2};
};
class OverviewGroup: RscControlsGroup
{
	idc = 2300;
	x = 1 * GUI_GRID_W + GUI_GRID_X;
	y = 2 * GUI_GRID_H + GUI_GRID_Y;
	w = 30 * GUI_GRID_W;
	h = 16 * GUI_GRID_H;
	class controls
	{
		class OverviewText: RscText
		{
			idc = 1000;
			text = "Overview"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W;
			y = 0 * GUI_GRID_H;
			w = 3 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class IGUIBack_2206: IGUIBack
		{
			idc = 2206;
			x = 10 * GUI_GRID_W;
			y = 1 * GUI_GRID_H;
			w = 8.5 * GUI_GRID_W;
			h = 15 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.2};
		};
		class InventoryText: RscText
		{
			idc = 1019;
			text = "Inventory"; //--- ToDo: Localize;
			x = 10 * GUI_GRID_W;
			y = 0 * GUI_GRID_H;
			w = 3 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class IGUIBack_2207: IGUIBack
		{
			idc = 2207;
			x = 18.5 * GUI_GRID_W;
			y = 1 * GUI_GRID_H;
			w = 11.5 * GUI_GRID_W;
			h = 15 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.2};
		};
		class InventorySelDescription: RscText
		{
			style = ST_MULTI;

			idc = 1020;
			text = "Select an item on the list for details."; //--- ToDo: Localize;
			x = 19 * GUI_GRID_W;
			y = 6.5 * GUI_GRID_H;
			w = 10.5 * GUI_GRID_W;
			h = 5 * GUI_GRID_H;
		};
		class InventorySelName: RscText
		{
			idc = 1021;
			x = 19 * GUI_GRID_W;
			y = 1.5 * GUI_GRID_H;
			w = 10.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class InventorySelPicture: RscPicture
		{
			idc = 1202;
			text = "#(argb,8,8,3)color(1,1,1,0)";
			x = 22.5 * GUI_GRID_W;
			y = 3 * GUI_GRID_H;
			w = 3.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class InventoryList: RscListbox
		{
			onLBSelChanged = "[HW_Office_Inventory select (_this select 1), _this select 1] call HW_Office_InventorySetSelection;";

			idc = 1502;
			x = 10.5 * GUI_GRID_W;
			y = 1.5 * GUI_GRID_H;
			w = 7.5 * GUI_GRID_W;
			h = 14 * GUI_GRID_H;
		};
		class IGUIBack_2208: IGUIBack
		{
			idc = 2208;
			x = 0 * GUI_GRID_W;
			y = 1 * GUI_GRID_H;
			w = 10 * GUI_GRID_W;
			h = 15 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.2};
		};
		class InventorySelWeight: RscText
		{
			style = ST_MULTI;

			idc = 1022;
			x = 19 * GUI_GRID_W;
			y = 12 * GUI_GRID_H;
			w = 5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class InventorySelCondition: RscText
		{
			style = ST_MULTI;

			idc = 1023;
			x = 19 * GUI_GRID_W;
			y = 13 * GUI_GRID_H;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ButtonSell: RscButton
		{
			action = "call HW_Office_SellItem;";

			idc = 1606;
			text = "Sell"; //--- ToDo: Localize;
			x = 23.5 * GUI_GRID_W;
			y = 14.5 * GUI_GRID_H;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ButtonUnpack: RscButton
		{
			action = "call HW_Office_UnpackItem;";

			idc = 1607;
			text = "Unpack"; //--- ToDo: Localize;
			x = 19 * GUI_GRID_W;
			y = 14.5 * GUI_GRID_H;
			w = 3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ButtonRepack: RscButton
		{
			action = "call HW_Office_RepackItem;";

			idc = 1608;
			text = "Re-pack"; //--- ToDo: Localize;
			x = 19 * GUI_GRID_W;
			y = 14.5 * GUI_GRID_H;
			w = 3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ButtonScrap: RscButton
		{
			action = "call HW_Office_ScrapItem;";

			idc = 1609;
			text = "Scrap"; //--- ToDo: Localize;
			x = 27.5 * GUI_GRID_W;
			y = 14.5 * GUI_GRID_H;
			w = 2 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};
class StoreGroup: RscControlsGroup
{
	idc = 2301;
	x = 1 * GUI_GRID_W + GUI_GRID_X;
	y = 2 * GUI_GRID_H + GUI_GRID_Y;
	w = 30 * GUI_GRID_W;
	h = 16 * GUI_GRID_H;
	class controls
	{
		class StoreText: RscText
		{
			idc = 1001;
			text = "Store"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W;
			y = 0 * GUI_GRID_H;
			w = 3 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "Welcome to Heli-bay! Your one-stop shop for all things hovering!"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W;
			y = 1 * GUI_GRID_H;
			w = 18.5 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class IGUIBack_2202: IGUIBack
		{
			idc = 2202;
			x = 0 * GUI_GRID_W;
			y = 2 * GUI_GRID_H;
			w = 13 * GUI_GRID_W;
			h = 14 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.2};
		};
		class IGUIBack_2203: IGUIBack
		{
			idc = 2203;
			x = 13 * GUI_GRID_W;
			y = 2 * GUI_GRID_H;
			w = 17 * GUI_GRID_W;
			h = 14 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.2};
		};
		class StoreItemList: RscListbox
		{
			onLBSelChanged = "(HW_Office_StoreItems select (_this select 1)) call HW_Office_StoreSetSelection;";

			idc = 1500;
			x = 0.5 * GUI_GRID_W;
			y = 2.5 * GUI_GRID_H;
			w = 12 * GUI_GRID_W;
			h = 13 * GUI_GRID_H;
		};
		class StoreSelText: RscText
		{
			idc = 1004;
			x = 13.5 * GUI_GRID_W;
			y = 2.5 * GUI_GRID_H;
			w = 16 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class StoreSelDescription: RscText
		{
			style = ST_MULTI;

			idc = 1005;
			text = "Select an item on the list to purchase it."; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W;
			y = 4 * GUI_GRID_H;
			w = 15.5 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};
		class StoreSelPicture: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(1,1,1,0)";
			x = 13.5 * GUI_GRID_W;
			y = 8 * GUI_GRID_H;
			w = 8 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;
		};
		class StoreSelPrice: RscText
		{
			idc = 1006;
			x = 20.5 * GUI_GRID_W;
			y = 14.5 * GUI_GRID_H;
			w = 5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class BuyButton: RscButton
		{
			action = "call HW_Office_StorePlaceOrder;";

			idc = 1604;
			text = "Order"; //--- ToDo: Localize;
			x = 26.5 * GUI_GRID_W;
			y = 14.5 * GUI_GRID_H;
			w = 3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class StoreItemWeight: RscText
		{
			idc = 1008;
			x = 22.5 * GUI_GRID_W;
			y = 8 * GUI_GRID_H;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class StoreItemCondition: RscText
		{
			idc = 1009;
			x = 22.5 * GUI_GRID_W;
			y = 9.5 * GUI_GRID_H;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class StoreEstimatedDeliveryTime: RscText
		{
			idc = 1010;
			x = 22.5 * GUI_GRID_W;
			y = 11 * GUI_GRID_H;
			w = 7 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
	};
};
class OrdersGroup: RscControlsGroup
{
	idc = 2302;
	x = 1 * GUI_GRID_W + GUI_GRID_X;
	y = 2 * GUI_GRID_H + GUI_GRID_Y;
	w = 30 * GUI_GRID_W;
	h = 16 * GUI_GRID_H;
	class controls
	{
		class OrdersText: RscText
		{
			idc = 1002;
			text = "Orders"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W;
			y = 0 * GUI_GRID_H;
			w = 3 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class IGUIBack_2204: IGUIBack
		{
			idc = 2204;
			x = 0 * GUI_GRID_W;
			y = 2 * GUI_GRID_H;
			w = 13 * GUI_GRID_W;
			h = 14 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.2};
		};
		class IGUIBack_2205: IGUIBack
		{
			idc = 2205;
			x = 13 * GUI_GRID_W;
			y = 2 * GUI_GRID_H;
			w = 17 * GUI_GRID_W;
			h = 14 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.2};
		};
		class OrdersCaption: RscText
		{
			idc = 1011;
			text = "Incoming Orders"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W;
			y = 1 * GUI_GRID_H;
			w = 18.5 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class OrdersItemsList: RscListbox
		{
			onLBSelChanged = "[HW_Office_Orders select (_this select 1), _this select 1] call HW_Office_OrdersSetSelection;";

			idc = 1501;
			x = 0.5 * GUI_GRID_W;
			y = 2.5 * GUI_GRID_H;
			w = 12 * GUI_GRID_W;
			h = 13 * GUI_GRID_H;
		};
		class OrdersSelName: RscText
		{
			idc = 1012;
			x = 13.5 * GUI_GRID_W;
			y = 2.5 * GUI_GRID_H;
			w = 16 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class OrdersSelDescription: RscText
		{
			style = ST_MULTI;

			idc = 1013;
			text = "Select an item on the list to see its shipping status."; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W;
			y = 4 * GUI_GRID_H;
			w = 15.5 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};
		class OrdersSelPicture: RscPicture
		{
			idc = 1201;
			text = "#(argb,8,8,3)color(1,1,1,0)";
			x = 13.5 * GUI_GRID_W;
			y = 8 * GUI_GRID_H;
			w = 8 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;
		};
		class CancelOrderButton: RscButton
		{
			action = "call HW_Office_CancelOrder;";

			idc = 1605;
			text = "Cancel Order"; //--- ToDo: Localize;
			x = 25 * GUI_GRID_W;
			y = 14.5 * GUI_GRID_H;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class OrdersPricePaid: RscText
		{
			idc = 1014;
			x = 13.5 * GUI_GRID_W;
			y = 14.5 * GUI_GRID_H;
			w = 5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class OrdersRefund: RscText
		{
			idc = 1015;
			x = 19.5 * GUI_GRID_W;
			y = 14.5 * GUI_GRID_H;
			w = 5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class OrdersItemWeight: RscText
		{
			idc = 1016;
			x = 22.5 * GUI_GRID_W;
			y = 8 * GUI_GRID_H;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class OrdersItemCondition: RscText
		{
			idc = 1017;
			x = 22.5 * GUI_GRID_W;
			y = 9.5 * GUI_GRID_H;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class OrdersEstimatedTime: RscText
		{
			idc = 1018;
			x = 22.5 * GUI_GRID_W;
			y = 11 * GUI_GRID_H;
			w = 7 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
	};
};
class FundsText: RscText
{
	idc = 1007;
	text = "Funds: "; //--- ToDo: Localize;
	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class OverviewButton: RscButton
{
	action = "HW_Office_Mode = 0";

	idc = 1600;
	text = "Overview"; //--- ToDo: Localize;
	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
	y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class StoreButton: RscButton
{
	action = "HW_Office_Mode = 1";

	idc = 1601;
	text = "Online Store"; //--- ToDo: Localize;
	x = 5.5 * GUI_GRID_W + GUI_GRID_X;
	y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class OrdersButton: RscButton
{
	action = "HW_Office_Mode = 2";

	idc = 1603;
	text = "Orders"; //--- ToDo: Localize;
	x = 10.5 * GUI_GRID_W + GUI_GRID_X;
	y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class CloseButton: RscButton
{
	action = "closeDialog 4200";

	idc = 1602;
	text = "Close"; //--- ToDo: Localize;
	x = 27 * GUI_GRID_W + GUI_GRID_X;
	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

	};	
};

