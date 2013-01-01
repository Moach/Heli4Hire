
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