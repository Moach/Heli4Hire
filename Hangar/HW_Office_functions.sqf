
HW_Office_StoreRefreshList = 
{
	lbClear 1500;

	// populate the store list with items
	{	
		_i = lbAdd [1500, (_x select 0)];
		lbSetValue [1500, _i, (_x select 1)];
		lbSetData [1500, _i, (_x select 2)];
		lbSetPicture[1500, _i, (_x select 3)];

	} foreach HW_Office_StoreItems;
};

HW_Office_StoreSelection = [];


HW_Office_StoreSetSelection = 
{
	//hint format ["selected %1", _this];
	ctrlShow [1604, true];
	
	ctrlSetText [1004, _this select 0]; // set name
	ctrlSetText [1006, format["$%1", _this select 1]]; // set price
	ctrlSetText [1005, _this select 2];	// set description
	ctrlSetText [1200, _this select 3]; // set picture
	ctrlSetText [1008, format ["Weight: %1", _this select 4]]; // set weight
	
	if (_this select 6 > 0.99) then
	{
		ctrlSetText [1009, "Condition: New"]; // set condition
	};
	if (_this select 6 > 0.5 ) then
	{
		ctrlSetText [1009, "Condition: Used"]; // set condition
	} else {
		ctrlSetText [1009, "Condition: Junk"]; // set condition
	};
	
	ctrlSetText [1010,   format ["Shipping Time: %1 mins.", _this select 5]]; // set eta
	
	HW_Office_StoreSelection = _this;
};

HW_Office_StorePlaceOrder = 
{
	if (HW_Office_Funds >= HW_Office_StoreSelection select 1) then
	{		
		HW_Office_Funds = HW_Office_Funds - (HW_Office_StoreSelection select 1);
		ctrlSetText [1007, format["Funds: $%1", HW_Office_Funds]]; // set funds
		
		hint format ["You've ordered %1\n\nYour order will arrive in %2 minutes\n\nThank you for shopping at Heli-bay!", 
						HW_Office_StoreSelection select 0, HW_Office_StoreSelection select 5];
		
		HW_Office_StoreSelection set [7, daytime];
		
		HW_Office_Orders set [count HW_Office_Orders, HW_Office_StoreSelection];
		
		
	} else {
		hint "You don't have enough funds to order this";
	};
};






HW_Office_OrdersRefreshList = 
{
	lbClear 1501;

	// populate the orders list with items
	{	
		_i = lbAdd [1501, (_x select 0)];
		lbSetValue [1501, _i, (_x select 1)];
		lbSetData [1501, _i, (_x select 2)];
		lbSetPicture[1501, _i, (_x select 3)];

	} foreach HW_Office_Orders;
};

HW_Office_OrdersSelection = [];
HW_Office_OrdersSelIdx = -1;

HW_Office_OrdersSetSelection = 
{
	//hint format ["selected %1", _this];
	ctrlShow [1605, true];
	
	ctrlSetText [1012, (_this select 0) select 0]; // set name
	
	ctrlSetText [1014, format["Paid: $%1", (_this select 0) select 1]]; // set price paid
	ctrlSetText [1015, format["Refund: $%1", ((_this select 0) select 1) * 0.8]]; // set refund price
	
	ctrlSetText [1013, (_this select 0) select 2];	// set description
	ctrlSetText [1201, (_this select 0) select 3]; // set picture
	ctrlSetText [1016, format ["Weight: %1", (_this select 0) select 4]]; // set weight
	
	if ((_this select 0) select 6 > 0.99) then
	{
		ctrlSetText [1017, "Condition: New"]; // set condition
	};
	if ((_this select 0) select 6 > 0.5 ) then
	{
		ctrlSetText [1017, "Condition: Used"]; // set condition
	} else {
		ctrlSetText [1017, "Condition: Junk"]; // set condition
	};
	
	ctrlSetText [1018,   format ["Shipping Time: %1 mins.", (_this select 0) select 5]]; // set eta
	
	HW_Office_OrdersSelection = (_this select 0);
	HW_Office_OrdersSelIdx = (_this select 1);
};

HW_Office_CancelOrder = 
{
	_refund = (HW_Office_OrdersSelection select 1) * 0.8;

	HW_Office_Funds = HW_Office_Funds + _refund;
	ctrlSetText [1007, format["Funds: $%1", HW_Office_Funds]]; // set funds
		
	hint format ["You've cancelled your order for %1\n\nYou've been refunded $%2.", 
					HW_Office_OrdersSelection select 0, _refund];
					
	ctrlSetText [1012, ""]; // set name
	
	ctrlSetText [1014, ""]; // set price paid
	ctrlSetText [1015, ""]; // set refund price
	
	ctrlSetText [1013, "Select an item on the list to see its shipping status."];	// set description
	ctrlSetText [1201, "#(argb,8,8,3)color(1,1,1,0)"]; // set picture
	ctrlSetText [1016, ""]; // set weight
	ctrlSetText [1017, ""]; // set condition
	ctrlSetText [1018, ""]; // set eta
	
	ctrlShow [1605, false];
	
	HW_Office_Orders set [HW_Office_OrdersSelIdx, -1];
	HW_Office_Orders = HW_Office_Orders - [-1];
	
	call HW_Office_OrdersRefreshList;
};