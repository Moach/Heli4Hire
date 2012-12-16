Name: Helicopter Service
Developer: Osmo
Version: Beta 7
Credits: _neo_ and all Tour members for suggestions, feedback, scripting help and testing.
Description: This script will create a helicopter service for your mission. On request, servicemen will inspect, repair, refuel and rearm your helicopter.
Usage: To use the helicopter service, park your helicopter on (or near) the service helipad, and then walk to the servicemen. Use your action menu and select the helicopter and fuel level to initiate the service.


Features

[*]Servicemen will walk to the chopper and play animations while servicing.
[*]You will get a full detailed damage report of each damaged part, as well as fuel level.
[*]Default service time will be 0-5 minutes, depending on how much damage there is (and how much fuel needed).
[*]Service time can be adjusted by the mission maker.
[*]Designed to work in multiplayer, but should also work fine in single player.
[*]Supports all default light, medium and heavy helicopters of Take On Helicopters.
[*]Supports multiple instances (you can add as many service points as you want)

Note

[*]Hinds are not supported in this version.


Installation

- Unzip the file into your mission folder (e.g. it should be in scripts\OSMO_service\)
- Add one helipad object
- Add one empty marker somewhere near the helipad (this is where the servicemen spawn and hang out)
- Add following line to your init.sqf

init.sqf 

[Helipad_name, "Marker_Name"] execVM "scripts\OSMO_service\OSMO_service_init.sqf";

Change Log:

Beta 7
- Maintenance report overhauled and improved
- Fixed: Service did not work on dedicated server
- New parameter OSMO_SV_radius added to the OSMO_service_init.sqf (defines the size of service area)
- Icons added to actions
- Code optimized + other minor fixes

Beta 6
- Fixed a bug in the adding of actions

Beta 5
- Now supports multiple instances of service
- Initialization changed to [Helipad_name, "Marker_Name"] execVM "scripts\OSMO_service\OSMO_service_init.sqf";
- Helicopter type is now shown in the list of serviceable helicopters instead of just "light helicopter" etc.

Beta 4
- Serviceman's chat, as well as the damage report are now visible to everyone within 20 meters of him.
- Fixed a bug where servicemen were created on all clients instead of just on the server

Beta 3
- Mission maker can now define the service times by editing parameters in OSMO_service_init.sqf
- Default service times increased to:
  - Inspection time: 30s
  - Refuel time: 60s (from empty to full tank, half tank would be 30s)
  - Hitpoint fix time: 20s (for each fully damaged hitpoint. 50% damaged will take half the time)
  - Maximum time: 5 minutes (the service will never exceed this time. Does not include inspection)

Beta 2
- Added option to select fuel level during the initial service request
- Optimized code
- Improved the inspection report

Beta 1 
- Initial version

