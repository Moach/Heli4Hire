// config.bin - 14:09:40 07/07/07, generated in 1.07 seconds
// Generated by unRap v1.05 by Kegetys
// Separate rootclasses: Disabled, Automatic comments: Enabled
#define true 1
#define false 0

#define private 0
#define protected 1
#define public 2

#define TEast 0
#define TWest 1
#define TGuerrila 2
#define TCivilian 3
#define TSideUnknown 4
#define TEnemy 5
#define TFriendly 6
#define TLogic 7

#define VSoft 0
#define VArmor 1
#define VAir 2

#define LockNo 0
#define LockCadet 1
#define LockYes 2

#define ReadAndWrite 0
#define ReadAndCreate 1
#define ReadOnly 2
#define ReadOnlyVerified 3


#define _ARMA_

enum {
	destructengine = 2,
	destructdefault = 6,
	destructwreck = 7,
	destructtree = 3,
	destructtent = 4,
	stabilizedinaxisx = 1,
	stabilizedinaxisy = 2,
	destructno = 0,
	stabilizedinaxesboth = 3,
	stabilizedinaxesnone = 0,
	_scale = 2,
	destructman = 5,
	destructbuilding = 1
};



/* Declaration as Addon-Content.*/
class CfgPatches 		
{
	class moach_hw_basics 
	{
		units[] = {"Heli_Light01_HeliWorks"};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"HSim_Air_US_H"};
		fileName = "moach_hw_basics.pbo";
		author = "Moach";
		mail = "vanquish.moach@gmail.com";
	};
};

class RotorLibHelicopterProperties;

class CfgVehicles 
{
	class Heli_Light01_H;
	class Heli_Light01_HeliWorks: Heli_Light01_H
	{
		enableGPS = 0;
		displayName = "HW Wright LD500";
		faction = "HSim_Civ_US";
		hiddenSelectionsTextures[] = {"HSim\Air_US_H\Helicopters_Light\Data\skins\Heli_light01_ext_blueline_co.paa"};
		class RotorLibHelicopterProperties: RotorLibHelicopterProperties
		{
		//	RTDconfig = "moach_hw_basics\WrightLD500Sim.xml";
			starterTime = 10;
		};
	};
};