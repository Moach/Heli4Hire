
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
	} else {
		if (_this select 6 > 0.5 ) then
		{
			ctrlSetText [1009, "Condition: Used"]; // set condition
		} else {
			ctrlSetText [1009, "Condition: Junk"]; // set condition
		};
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
						
		HW_Office_StoreSelection call HW_Office_AddOrder;
		
	} else {
		hint "You don't have enough funds to order this";
	};
};






HW_Office_OrdersRefreshList = 
{
	lbClear 1501;

	// populate the orders list with items
	{	
		_i = lbAdd [1501, format ["%1 - ETA: %2m", (_x select 0),[(_x call HW_Office_GetOrderETA), "HH:MM"] call bis_fnc_timeToString]];
		lbSetValue [1501, _i, (_x select 1)];
		lbSetData [1501, _i, (_x select 2)];
		lbSetPicture[1501, _i, (_x select 3)];

	} foreach HW_Office_Orders;
	
	if (HW_Office_OrdersSelIdx != -1) then
	{
		_eta = HW_Office_OrdersSelection call HW_Office_GetOrderETA;
		ctrlSetText [1018,  format ["Time to Arrive: %1m", [_eta, "HH:MM"] call bis_fnc_timeToString]]; // set eta
	};
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
	} else {
		if ((_this select 0) select 6 > 0.5 ) then
		{
			ctrlSetText [1017, "Condition: Used"]; // set condition
		} else {
			ctrlSetText [1017, "Condition: Junk"]; // set condition
		};
	};
	_eta = (_this select 0) call HW_Office_OrderGetETA;	
	ctrlSetText [1018,   format ["Time to Arrive: %1m", [_eta, "HH:MM"] call bis_fnc_timeToString]]; // set eta
	
	HW_Office_OrdersSelection = (_this select 0);
	HW_Office_OrdersSelIdx = (_this select 1);
};


HW_Office_OrdersDeselect = 
{
	ctrlSetText [1012, ""]; // set name
			
	ctrlSetText [1014, ""]; // set price paid
	ctrlSetText [1015, ""]; // set refund price
	
	ctrlSetText [1013, "Select an item on the list to see its shipping status."];	// set description
	ctrlSetText [1201, "#(argb,8,8,3)color(1,1,1,0)"]; // set picture
	ctrlSetText [1016, ""]; // set weight
	ctrlSetText [1017, ""]; // set condition
	ctrlSetText [1018, ""]; // set eta
	
	ctrlShow [1605, false];
	
	HW_Office_OrdersSelIdx = -1;
	HW_Office_OrdersSelection = [];
};

HW_Office_CancelOrder = 
{
	_refund = (HW_Office_OrdersSelection select 1) * 0.8;

	HW_Office_Funds = HW_Office_Funds + _refund;
	ctrlSetText [1007, format["Funds: $%1", HW_Office_Funds]]; // set funds
		
	hint format ["You've cancelled your order for %1\n\nYou've been refunded $%2.", 
					HW_Office_OrdersSelection select 0, _refund];
					
	HW_Office_OrdersSelIdx call HW_Office_RemoveOrder;
	
	call HW_Office_OrdersDeselect;
};

// adds an item to the orders list
// syntax: item call HW_Office_AddOrder;
HW_Office_AddOrder = 
{
	_newOrder = [];
	_i = 0;
	{
		_newOrder set [_i, _x];
		_i = _i + 1;
	} foreach _this;
	
	_newOrder set [7, daytime + (_this select 5) / 60];
	HW_Office_Orders set [count HW_Office_Orders, _newOrder];
};

// removes an item from the orders list
// syntax: itemIndex call HW_Office_RemoveOrders;
HW_Office_RemoveOrder = 
{	
	HW_Office_Orders set [_this, -1];
	HW_Office_Orders = HW_Office_Orders - [-1];	
	
	if (HW_Office_Active && HW_Office_Mode == 2) then
	{
		call HW_Office_OrdersRefreshList;
	};
};

// returns the eta for the given order. 
// syntax: item call HW_Office_GetOrderETA;
HW_Office_GetOrderETA = 
{
	(_this select 7) - daytime
};

HW_Office_UpdateOrders = 
{
	_toRemove = [];
		
	scopeName "main";
	
	for [{_a = 0}, {_a < (count HW_Office_Orders)}, {_a = _a + 1}] do
	{	
		_o = HW_Office_Orders select _a;
	
		if (_o call HW_Office_GetOrderETA <= 0) then 
		{
			hint format ["The %1 you ordered has arrived!", _o select 0];
			
			// add item to inventory
			_o call HW_Office_AddInventory;								
			
			call HW_Office_OrdersDeselect;
			
			_a call HW_Office_RemoveOrder;						
			
			breakTo "main";
		};	
	};		
	
	if (HW_Office_Active && HW_Office_Mode == 2) then
	{
		call HW_Office_OrdersRefreshList;
	};	
};

// adds an item to the inventory
// syntax: item call HW_Office_AddInventory;
HW_Office_AddInventory = 
{
	_newItem = [];
	_i = 0;
	{
		_newItem set [_i, _x];
		_i = _i + 1;
	} foreach _this;
	
	_newItem set [7, time];
	HW_Office_Inventory set [count HW_Office_Inventory, _newItem];
	
	if (HW_Office_Active && HW_Office_Mode == 0) then
	{
		call HW_InventoryRefreshList;
	};
};

// removes an item from the inventory (and updates the list if necessary)
// syntax: [itemIndices] call HW_Office_RemoveInventory;
HW_Office_RemoveInventory = 
{
	HW_Office_Inventory set [_this, -1];
	HW_Office_Inventory = HW_Office_Inventory - [-1];	
	
	if (HW_Office_Active && HW_Office_Mode == 0) then
	{
		call HW_InventoryRefreshList;
	};
};

HW_InventoryRefreshList = 
{
	lbClear 1502;

	// populate the store list with items
	{	
		_i = lbAdd [1502, (_x select 0)];
		lbSetValue [1502, _i, (_x select 1)];
		lbSetData [1502, _i, (_x select 2)];
		lbSetPicture[1502, _i, (_x select 3)];

	} foreach HW_Office_Inventory;
};

HW_Office_InventorySelection = [];
HW_Office_InventoryIndex = -1;

HW_Office_InventorySetSelection = 
{		
	HW_Office_InventorySelection = (_this select 0);
	HW_Office_InventoryIndex = (_this select 1);
	
	call HW_Office_InventoryUpdateItemDetails;
};

HW_Office_InventoryUpdateItemDetails = 
{
	ctrlSetText [1021, HW_Office_InventorySelection select 0]; // set name		
	ctrlSetText [1020, HW_Office_InventorySelection select 2];	// set description
	ctrlSetText [1202, HW_Office_InventorySelection select 3]; // set picture
	ctrlSetText [1022, format ["Weight: %1", HW_Office_InventorySelection select 4]]; // set weight
	
	if (HW_Office_InventorySelection select 6 > 0.99) then
	{
		ctrlSetText [1023, "Condition: New"]; // set condition
	} else {
		if (HW_Office_InventorySelection select 6 > 0.5 ) then
		{
			ctrlSetText [1023, "Condition: Used"]; // set condition
		} else {
			ctrlSetText [1023, "Condition: Junk"]; // set condition
		};
	};

	{
		ctrlShow[_x, false];
	} foreach [1606, 1607, 1608, 1609]; 
	
	_canSell = HW_Office_InventorySelection select 10;
	_packed = HW_Office_InventorySelection select 11;
	
		
	if (_canSell) then
	{	
		_resellValue = HW_Office_InventorySelection call HW_Office_GetItemValue;
	
		if (_packed) then
		{
			if (_resellValue > 0) then
			{
				ctrlShow [1606, true]; // show sell button
				ctrlSetText [1606, format ["Sell for $%1", _resellValue]];
			};
						
		} else {
			ctrlShow [1608, true]; // show repack button
		}
	};
	
	if (_packed) then
	{
		ctrlShow[1607, true]; // show unpack button
	};
};

// returns the value of the item, based on its purchase price and condition
// syntax: item call HW_Office_GetItemValue;
HW_Office_GetItemValue = 
{
	//  value proportional to condition
	(_this select 1) * (_this select 6) * 0.8
};

HW_Office_InventoryDeselect = 
{
	ctrlSetText [1021, ""]; // set name		
	ctrlSetText [1020, "Select an item on the list for details."];	// set description
	ctrlSetText [1202, "#(argb,8,8,3)color(1,1,1,0)"]; // set picture
	ctrlSetText [1022, ""]; // set weight
	ctrlSetText [1023, ""]; // set condition
	
	HW_Office_InventorySelection = [];
	HW_Office_InventoryIndex = -1;
	
	{
		ctrlShow[_x, false];
	} foreach [1606, 1607, 1608, 1609]; 
};

HW_Office_SellItem = 
{
	_sellValue = HW_Office_InventorySelection call HW_Office_GetItemValue;

	hint format ["Sold %1 for $%2", HW_Office_InventorySelection select 0, _sellValue];
	
	HW_Office_Funds = HW_Office_Funds + _sellValue;
	ctrlSetText [1007, format["Funds: $%1", HW_Office_Funds]]; // set funds
	
	HW_Office_InventoryIndex call HW_Office_RemoveInventory;	
	call HW_Office_InventoryDeselect;	
};

HW_Office_ScrapItem = 
{
	hint format ["Scrapped %1.", HW_Office_InventorySelection select 0];
	
	HW_Office_InventoryIndex call HW_Office_RemoveInventory;	
	call HW_Office_InventoryDeselect;	
};

HW_Office_UnpackItem = 
{	
	_onUnpack = compile (HW_Office_InventorySelection select 8);
	
	HW_Office_InventorySelection call _onUnpack;
	
	call HW_Office_InventoryUpdateItemDetails;
};

HW_Office_RepackItem = 
{
	_onRepack = compile (HW_Office_InventorySelection select 9);
	
	HW_Office_InventorySelection call _onRepack;
	
	call HW_Office_InventoryUpdateItemDetails;
};

