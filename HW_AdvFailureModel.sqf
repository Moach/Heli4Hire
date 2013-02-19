
// chopper setHitPointDamage ["HitHRotor", .3]; // for testing purposes! 

_uberFail_set = false;


while {true} do
{
	sleep 1;
	
	if (isEngineOn chopper) then
	{
		// chance of damage from flying with a less-than-perfect bird
		//  this adds a cascading effect where minor damage may lead to further complications snowballing up to a severely destructive outcome
		//
		
		// flying with a sub-optimal rotor is mighty dangerous!
		//
		if ( random 50 < ((10 * (chopper getHitPointDamage "HitHRotor")) + (10 * (chopper getHitPointDamage "HitVRotor"))) ) then
		{
			
			
			
			// hintSilent "damaged rotors affect transmission!";
			
			_rtrDmg = ((chopper getHitPointDamage "HitHRotor") * .75) + ((chopper getHitPointDamage "HitVRotor") * .25);
			
			// it just may cause damage to the transmission!
			_dmg = chopper getHitPointDamage "HitTransmission"; chopper setHitPointDamage ["HitTransmission", _dmg + random (1-_dmg) * .6 * _rtrDmg];
			
			
			
		};
		
		sleep 1;
		
		
		// flying with a busted transmission increases risk of engine/hydraulics damage!
		if (random 40 < (10 * (chopper getHitPointDamage "HitTransmission"))) then
		{
			
			_dmg = chopper getHitPointDamage "HitEngine"; // potential for damage is proportional to severity of the cause!
			chopper setHitPointDamage ["HitEngine", _dmg + random (1-_dmg) * (chopper getHitPointDamage "HitTransmission") * .6];
			
			_dmg = ((chopper getHitPointDamage "HitEngine") * .5) + ((chopper getHitPointDamage "HitTransmission") * .5);
			chopper setHitPointDamage ["HitHydraulics", _dmg + random (1-_dmg) * (chopper getHitPointDamage "HitHydraulics") * .2];
			
			// it also may further damage the rotors!
			_dmg = (chopper getHitPointDamage "HitHRotor");
			chopper setHitPointDamage ["HitHRotor", _dmg + random (1-_dmg) * (chopper getHitPointDamage "HitTransmission") * .2];
			_dmg = (chopper getHitPointDamage "HitVRotor");
			chopper setHitPointDamage ["HitVRotor", _dmg + random (1-_dmg) * (chopper getHitPointDamage "HitTransmission") * .4];
			
			playSound "FX_Fail_Rough";
			
			sleep 5;
			if Heli_Hint_On_Fail then { hintSilent "The helicopter feels like it's getting increasingly rough..."; };
			
		};
		
		sleep 1;
		
		// flying with a busted fuel tank may also damage the engine!
		if (random 50 < (10 * (chopper getHitPointDamage "HitFuel"))) then
		{
			// hintSilent "damaged fuel tank affects engine";
			
			_dmg = chopper getHitPointDamage "HitFuel"; // potential for damage is proportional to severity of the cause!
			chopper setHitPointDamage ["HitEngine", _dmg + random (1-_dmg) * (chopper getHitPointDamage "HitFuel") * .15];	
			
			playSound "FX_Fail_Crackling";
		};
		
		
		sleep 1;
		
		if (random 80 < (20 * (chopper getHitPointDamage "HitEngine"))) then
		{
			// minor damage to other components brought on by engine fault 
			// this includes the engine itself... damage is exponential!
			
			if Heli_Hint_On_Fail then { hintSilent "The helicopter feels like it's getting worse as it goes....\ndid you properly inspect it?!"; };
			
			_dmg = chopper getHitPointDamage "HitEngine";       chopper setHitPointDamage ["HitEngine",       _dmg + random (1-_dmg) * .1 * _dmg];
			_engDmg = chopper getHitPointDamage "HitEngine"; // engine damage drives further problems proportionally
			
			_dmg = chopper getHitPointDamage "HitTransmission"; chopper setHitPointDamage ["HitTransmission", _dmg + random (1-_dmg)* .2 * _engDmg];		
			_dmg = chopper getHitPointDamage "HitHydraulics";   chopper setHitPointDamage ["HitHydraulics",   _dmg + random (1-_dmg)* .5 * _engDmg];
			_dmg = chopper getHitPointDamage "HitBattery";      chopper setHitPointDamage ["HitBattery",      _dmg + random (1-_dmg)* .5 * _engDmg];
			
			if (_engDmg < .3) then
			{			
				playSound "FX_Fail_Clunk";
			} else
			{
				if (_engDmg > .6 && !_uberFail_set) then { playSound "FX_Fail_Engine_Bad"; _uberFail_set = true; } else { playSound "FX_Fail_Surge"; };
			};
		};
		
		sleep 1;
		//
		if (random 200 < (20 * (chopper getHitPointDamage "HitEngine"))) then
		{
			// these are things that can be taken down in the mayhem in case of MAJOR engine failure.... (i.e. it blows up!)
			
			_dmg = chopper getHitPointDamage "HitEngine";       chopper setHitPointDamage ["HitEngine",       _dmg + random (1-_dmg) * _dmg];
			_engDmg = chopper getHitPointDamage "HitEngine"; // engine damage drives further problems proportionally
			
			_dmg = chopper getHitPointDamage "HitTransmission"; chopper setHitPointDamage ["HitTransmission", _dmg + random (1-_dmg)* .6 * _engDmg];		
			_dmg = chopper getHitPointDamage "HitHydraulics";   chopper setHitPointDamage ["HitHydraulics",   _dmg + random (1-_dmg)* .5 * _engDmg];			
			_dmg = chopper getHitPointDamage "HitFuel";         chopper setHitPointDamage ["HitFuel",         _dmg + random (1-_dmg)* .8 * _engDmg];			
			_dmg = chopper getHitPointDamage "HitBattery";      chopper setHitPointDamage ["HitBattery",      _dmg + random (1-_dmg)* _engDmg];		
			_dmg = chopper getHitPointDamage "HitAvionics";     chopper setHitPointDamage ["HitAvionics",     _dmg + random (1-_dmg)* _engDmg];
			
			if (_engDmg > .6 && !_uberFail_set) then 
			{ 
				playSound "FX_Fail_Engine_Bad";
				chopper setHitPointDamage ["HitEngine", 1]; // that's that... engine is OUT
				chopper setThrottleRTD [0, -1];
			//	chopper setWantedRPMRTD [0, 100, -1];
				_uberFail_set = true;
				
			} else 
			{ 
				playSound "FX_Fail_Surge"; 
			};
			
			
			sleep 3;
			if Heli_Hint_On_Fail then { hintSilent "OMG! Something's really, really wrong with this helicopter!!!"; };
		};
		
		sleep 1;
		
		// obstruction caused damage! - this is mighty serious!
		//
		if (Heli_Has_Obstruction && random 35 < 1) then // fuck!
		{
			// damage here is not proportional to anything!! -- and by the way, insurance will probably not cover this!
			
			_dmg = chopper getHitPointDamage "HitEngine";   chopper setHitPointDamage ["HitEngine", _dmg + random (1-_dmg)];
			if (_dmg > .35 && !_uberFail_set) then 
			{ 
				playSound "FX_Fail_Engine_Bad"; 
				chopper setHitPointDamage ["HitEngine", 1]; // that's that... engine is OUT
				chopper setThrottleRTD [0, -1];
			//	chopper setWantedRPMRTD [0, 100, -1];
				
				_uberFail_set = true;
				
			} else 
			{ 
				//
				playSound "FX_Fail_Surge"; 
			};
			
			_dmg = chopper getHitPointDamage "HitTransmission"; chopper setHitPointDamage ["HitTransmission", _dmg + random (1-_dmg)];		
			_dmg = chopper getHitPointDamage "HitHydraulics";   chopper setHitPointDamage ["HitHydraulics",   _dmg + random (1-_dmg)];			
			_dmg = chopper getHitPointDamage "HitFuel";         chopper setHitPointDamage ["HitFuel",         _dmg + random (1-_dmg)];			
			_dmg = chopper getHitPointDamage "HitBattery";      chopper setHitPointDamage ["HitBattery",      _dmg + random (1-_dmg)];		
			_dmg = chopper getHitPointDamage "HitAvionics";     chopper setHitPointDamage ["HitAvionics",     _dmg + random (1-_dmg)];
			
			sleep 3;
			if Heli_Hint_On_Fail then { hintSilent "WHat Da?!!! Something's wrong with the engine!!!\n Did you remember to check it before takeoff??!"; };
		};
	};
};

