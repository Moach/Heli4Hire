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
class SoundsExt;
class AnimationSources;
class AddBackseats;
class AddScreen1;
class AddTread_Short;
class AddTread;
class AddDoors;

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
		
		class AnimationSources: AnimationSources
		{
			class AddBackseats: AddBackseats
			{
				initPhase = 0;
			};
			class AddScreen1: AddScreen1
			{
				initPhase = 0;
			};
			class AddTread_Short: AddTread_Short
			{
				initPhase = 0;
			};
			class AddTread: AddTread
			{
				initPhase = 0;
			};
			class AddDoors: AddDoors
			{
				initPhase = 0;
			};
		};
		
		
		
		class SoundsExt: SoundsExt
		{
			class Starter
			{
				startInt[] = {"HSim\Sounds_H\Air\heli_light\new-heli-light_int_starter-start-noclick",0.031622775,1.0};
				startExt[] = {"HSim\Sounds_H\Air\heli_light\new-heli-light_ext_starter-start-noclick",1.0,1.0,300};
				stopInt[] = {"HSim\Sounds_H\Air\heli_light\new-heli-light_int_starter-stop",0.002,1.0};
				stopExt[] = {"HSim\Sounds_H\Air\heli_light\new-heli-light_ext_starter-stop",0.1,1.0,300};
				damageInt[] = {"HSim\Sounds_H\Air\Noises\damage_starter_int_light",1.0,1.0};
				damageOut[] = {"HSim\Sounds_H\Air\Noises\damage_starter_ext_light",1.0,1.0,300};
			};
		};
	};
};




