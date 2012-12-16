Name: Helicopter Interaction
Developer: Osmo
Version: Beta 2
Credits: _neo_ for feedback and testing
Description: This script adds inspection and customization options to a helicopter. Inspection allows you to check the condition of different parts of the chopper and fuel level. Customization allows you to add and remove items such as mirrors, cameras, winch, etc. This script also adds actions for opening and closing the inspection panels and heavy helicopter's rear ramp.

Usage: To use the new features, simply walk to the chopper and use the new actions. Some inspection actions are behind panels which you have to open first. To check hydraulics you must sit in pilot position.

Light Helicopter Features

[*]Add / Remove Mirror
[*]Add / Remove Bottom Camera
[*]Add / Remove Side Camera (only possible to add it after holding frame is added)
[*]Add / Remove Holding Frame (only non-ION models)
[*]Add / Remove Long Steps (only possible if side camera is not attached, and shot steps are not attached)
[*]Add / Remove Shot Steps (only possible if long steps are not attached)
[*]Add / Remove Side Benches (only ION models)
[*]Open / Close Left Side Mainentance Panel
[*]Open / Close Right Side Mainentance Panel
[*]Inspect condition of: Engine, Main Rotor, Tail Rotor, Landing Light, Transmission, Landing Gear, Fuel Tank (+ Fuel Level), Left and Right Horizontal Stabilizers, Vertical Stabilizer, Pitot Tube, Static Port, Hydraulics

Medium Helicopter Features

[*]Add / Remove Cargo Hook (only if it's not in use by _neo_'s Multiplayer Slingload)
[*]Add / Remove Camera
[*]Add / Remove Search Light
[*]Add / Remove Winch (only if it's not in use by _neo_'s Multiplayer Slingload)
[*]Open / Close Left Side Engine Panel
[*]Open / Close Right Side Engine Panel
[*]Inspect condition of: Engine #1, Engine #2, Main Rotor, Tail Rotor, Landing Light, Transmission, Landing Gear, Fuel Tank (+ Fuel Level), Left and Right Horizontal Stabilizers, Vertical Stabilizer, Pitot Tube, Static Port, Hydraulics

Heavy Helicopter Features

[*]Add / Remove Winch (only if it's not in use by _neo_'s Multiplayer Slingload)
[*]Open / Close Left Side Engine Panel
[*]Open / Close Right Side Engine Panel
[*]Open / Close Front Maintenance Panel
[*]Open / Close Rear Ramp
[*]Inspect condition of: Engine #1, Engine #2, Main Rotor, Tail Rotor, Transmission, Avionics, Landing Gear, Fuel Tank (+ Fuel Level), Left and Right Horizontal Stabilizers, Vertical Stabilizer, Pitot Tube, Hydraulics

Note

[*]If the mission uses Multiplayer Slingload by _neo_, this script will work with it. E.g. you can't remove winch when rope is in use, and you can't remove cargo hook if rope is attached to it.

Installation

Unzip the file into [B]scripts[/B] folder under your mission folder (e.g. it should be in scripts\OSMO_interaction\)

init.sqf (Note this is just an example, adding all AIR objects to run the script)

_choppers = allMissionObjects "Air";
{ _x execVM "scripts\OSMO_interaction\OSMO_interaction_init.sqf" } forEach _choppers;

Change Log:

Beta 2:
- All inspection actions are overhauled and visually improved.
- Helicopter customization (adding and removing parts) is now done through one action.
- Renamed the init file into OSMO_interaction_init.sqf

Beta 1:
- Added option to add and remove side benches for ION Tactical and Light (ION) models
- Added option to fold / unfold benches for ION Tactical and Light (ION) models
- Added a restriction for ION Tactical and Light (ION) models: Sitting as cargo not possible if side benches are removed.
- Added option to inspect damage on different helicopter parts

Alpha
- Initial release