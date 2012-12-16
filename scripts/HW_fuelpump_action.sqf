_pump = _this select 0;
_id = _this select 2;

_pump removeAction _id;

Fuel_hose = ropeCreate [_pump, [2,0,1], player, [0,0,1], 32, 20];


Chopper_refuel_action = chopper addAction
[
    "Pump Fuel", "Scripts\HW_fuelhose_connect.sqf", ["HitFuel", 1], 10, true, false, "", "(((_this distance (_target modeltoworld [-2,-1.7,-3])) < 1.5) || ((_this distance (_target modeltoworld [2,-1.7,-3])) < 1.5)) && !(_this in _target)", "",
    -1, -1, 1+8, 4,
    "hsim\ui_h\data\ui_action_refuel_ca",
    "Pump Fuel Into Tank"
];
	
player addAction ["Cancel Fuel", "Scripts\HW_fuelpump_cancel.sqf"];
