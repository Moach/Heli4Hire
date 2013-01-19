_heli = _this;

if(!isDedicated) then
{
  // Add panel open / close actions
  private ["_cfgInspection","_cfgPanels"];

  _cfgInspection = configFile >> "CfgVehicles" >> (typeOf _heli) >> "Inspection";
  _cfgPanels = _cfgInspection >> "Panels";

  for "_i" from 1 to (count _cfgPanels) do
  {
    private ["_mp", "_anim", "_panel", "_id"];
    _mp = "Inspect_Panel" + (str _i);
    _anim = _mp + "_1";
    _panel = _cfgPanels select (_i - 1);

    private ["_radius", "_radiusView"];
    _radius = getNumber (_panel >> "radius");
    if (_radius == 0) then {_radius = 2.5;};
    _radiusView = getNumber (_panel >> "radiusView");
    if (_radiusView == 0) then {_radiusView = 0.1;};

    _id = _heli addAction
    [
      "Open panel", "scripts\OSMO_interaction\OSMO_interaction_panel.sqf", [true, _i, _panel], 15, true, true, "", "((_target animationPhase '" + _anim + "') == 0)", _mp,
      _radius, _radiusView, 1+8, 0,
      "<t align='center'><img image='hsim\ui_h\data\ui_action_open_ca' size='1.5' shadow='true' /></t>",
      "Open"
    ];
    
    if(_heli isKindOf "Heli_Heavy_Base_H") then {_radius = _radius + 0.5;};

    _id = _heli addAction
    [
      "Close Panel", "scripts\OSMO_interaction\OSMO_interaction_panel.sqf", [false, _i, _panel], 13, true, true, "", "((_target animationPhase '" + _anim + "') > 0)", _mp,
      _radius, _radiusView, 1+8, 0,
      "<t align='center'><img image='hsim\ui_h\data\ui_action_close_ca' size='1.5' shadow='true' /></t>",
      "Close"
    ];
  };


  // Customization
  OSMO_customize_opened = false;
 //  _heli addAction ["Customize Helicopter", "scripts\OSMO_interaction\OSMO_interaction_customization_initial.sqf", nil, 0, false, true, "", "!(_this in _target) && !OSMO_customize_opened && ((_this distance _target) < 5)", "",-1, -1, 1+8, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_repair_ca' size='1.5' shadow='true' /></t>","Customize"];

  // Add actions for opening and closing the rear ramp  for heavy choppers
  if(_heli isKindOf "Heli_Heavy_Base_H") then
  {
    _id = _heli addAction["Open ramp", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["CargoRamp_Open",1]], 1.5, true, true, "", "((_target animationPhase ""CargoRamp_Open"") == 0) && ((_this distance (_target modeltoworld [0,-5,-3])) < 2) && !(_this in _target)", "",-1, -1, 1+8, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_open_ca' size='1.5' shadow='true' /></t>","Open"];
    
      _id = _heli addAction["Close ramp", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["CargoRamp_Open",0]], 1.5, true, true, "", "((_target animationPhase ""CargoRamp_Open"") == 1) && ((_this distance (_target modeltoworld [0,-5,-3])) < 2) && !(_this in _target)", "",-1, -1, 1+8, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_close_ca' size='1.5' shadow='true' /></t>","Close"];
  };

  // Add event handler for Light ION models. Allow sitting in cargo only if side benches are added.
  if((_heli isKindOf "CIV_Heli_Light01_ION_H") || (_heli isKindOf "Heli_Light01_ION_H")) then 
  { 
    _heli addEventHandler ["getin", "
      if(((_this select 1) == ""cargo"") && (((_this select 0) animationPhase ""AddBenches"") == 0)) then
      {
         (_this select 2) action [""getout"", (_this select 0)];
        if((_this select 2) == player) then 
        { 
          hint ""You have to add side benches to sit in cargo of this chopper!"";
        };
      }
      else
      {
        {(_this select 0) animate [_x,0]} foreach [""BenchR_Up"", ""BenchL_Up""];; 
      };
    "];

    // Add actions for folding side benches
    
    _heli addAction ["Fold Side Bench", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["BenchL_Up",1]], 0, false, true, "", "((_target animationPhase ""BenchL_Up"") == 0) && ((_target animationPhase ""AddBenches"") == 1) && ((count crew _target) == 0) &&  ((_this distance (_target modeltoworld [-1.5,1,-1.5])) < 1.5)","z_benchl",-1, -1, 1+8, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_arrow_up_gs' size='1.5' shadow='true' /></t>","Fold Side Bench"];
  
    _heli addAction ["Unfold Side Bench", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["BenchL_Up",0]], 0, false, true, "", "((_target animationPhase ""BenchL_Up"") == 1) && ((_target animationPhase ""AddBenches"") == 1) && ((count crew _target) == 0) &&  ((_this distance (_target modeltoworld [-1.5,1,-1.5])) < 1.5)","z_benchl",-1, -1, 1+8, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_arrow_down_gs' size='1.5' shadow='true' /></t>","Unfold Side Bench"];  
  
    _heli addAction ["Fold Side Bench", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["BenchR_Up",1]], 0, false, true, "", "((_target animationPhase ""BenchR_Up"") == 0) && ((_target animationPhase ""AddBenches"") == 1) && ((count crew _target) == 0) &&  ((_this distance (_target modeltoworld [1.5,1,-1.5])) < 1.5)","z_benchr",-1, -1, 1+8, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_arrow_up_gs' size='1.5' shadow='true' /></t>","Fold Side Bench"];
  
    _heli addAction ["Unfold Side Bench", "scripts\OSMO_interaction\OSMO_interaction_animate.sqf", [["BenchR_Up",0]], 0, false, true, "", "((_target animationPhase ""BenchR_Up"") == 1) && ((_target animationPhase ""AddBenches"") == 1) && ((count crew _target) == 0) &&  ((_this distance (_target modeltoworld [1.5,1,-1.5])) < 1.5)","z_benchr", -1, -1, 1+8, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_arrow_down_gs' size='1.5' shadow='true' /></t>","Unfold Side Bench"];     
  };
};

// Add Default Components
if(isServer) then
{
  if(_heli isKindOf "Heli_Heavy_Base_H") then
  {
    _components  = ["AddWinch"];
    {_heli animate [_x,1]} foreach _components;
  };

  if(_heli isKindOf "Heli_Medium01_Base_H") then 
  {  
    _components  =  ["AddSearchLight", "AddWinch"];
    {_heli animate [_x,1]} foreach _components;  
  };
  
  if(_heli isKindOf "Heli_Light01_Base_H") then 
  { 
    // Add
 //   _components  = ["AddMirror", "AddTread"];
 //   {_heli animate [_x,1]} foreach _components;  
      
    // Remove
    _components = ["AddBackseats", "AddMirror", "AddDoors", "AddScreen1", "AddHoldingFrame", "AddTread_Short", "AddTread"];
    {_heli animate [_x,0]} foreach _components;
  };
};
    