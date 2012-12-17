
while {true} do
{
	sleep 5;
	
	if (isEngineOn chopper)
	{
		// chance of damage from flying with a less-than-perfect bird
		//  this adds a cascading effect where minor damage may lead to further complications snowballing up to a severely destructive outcome
		//
		
		// flying with a sub-optimal rotor is mighty dangerous!
		//
		if (random 250 < ((10 * chopper getHitPointDamage "HitHRotor") + (10 * getHitPointDamage "HitVRotor"))) then
		{
			_rtrDmg = (chopper getHitPointDamage "HitHRotor" * .25) + (chopper getHitPointDamage "HitVRotor" * .75);
			
			// it just may cause damage to the transmission!
			_dmg = chopper getHitPointDamage "HitTransmission"; chopper setHitPointDamage ["HitTransmission", _dmg + random (1-_dmg)* .6 * _rtrDmg];
		};
		
		
		
		
		// flying with a busted transmission increases risk of engine/hydraulics damage!
		if (random 200 < (10 * chopper getHitPointDamage "HitTransmission")) then
		{
			_dmg = chopper getHitPointDamage "HitTransmission"; // potential for damage is proportional to severity of the cause!
			chopper setHitPointDamage ["HitEngine", _dmg + random (1-_dmg) * chopper getHitPointDamage "HitTransmission"];
			
			_dmg = (chopper getHitPointDamage "HitEngine" * .5) + (chopper getHitPointDamage "HitTransmission" * .5);
			chopper setHitPointDamage ["HitHydraulics", _dmg + random (1-_dmg) * chopper getHitPointDamage "HitHydraulics"];
		};
		
		
		// flying with a busted fuel tank may also damage the engine!
		if (random 200 < (10 * chopper getHitPointDamage "HitTransmission")) then
		{
			_dmg = chopper getHitPointDamage "HitEngine"; // potential for damage is proportional to severity of the cause!
			chopper setHitPointDamage ["HitEngine", _dmg + random (1-_dmg) * chopper getHitPointDamage "HitFuel"];	
		};
		
		
		if (random 200 < (20 * chopper getHitPointDamage "HitEngine")) then
		{
			// minor damage to other components brought on by engine fault 
			// this includes the engine itself... damage is exponential!
			
			_dmg = chopper getHitPointDamage "HitEngine";       chopper setHitPointDamage ["HitEngine",       _dmg + random (1-_dmg) * .1 * _dmg];
			_engDmg = chopper getHitPointDamage "HitEngine"; // engine damage drives further problems proportionally
			
			_dmg = chopper getHitPointDamage "HitTransmission"; chopper setHitPointDamage ["HitTransmission", _dmg + random (1-_dmg)* .2 * _engDmg];		
			_dmg = chopper getHitPointDamage "HitHydraulics";   chopper setHitPointDamage ["HitHydraulics",   _dmg + random (1-_dmg)* .5 * _engDmg];
		};
		
		//
		if (random 500 < (20 * chopper getHitPointDamage "HitEngine")) then
		{
			// these are things that can be taken down in the mayhem in case of MAJOR engine failure.... (i.e. it blows up!)
			
			_dmg = chopper getHitPointDamage "HitEngine";       chopper setHitPointDamage ["HitEngine",       _dmg + random (1-_dmg) * _dmg];
			_engDmg = chopper getHitPointDamage "HitEngine"; // engine damage drives further problems proportionally
			
			_dmg = chopper getHitPointDamage "HitTransmission"; chopper setHitPointDamage ["HitTransmission", _dmg + random (1-_dmg)* .6 * _engDmg];		
			_dmg = chopper getHitPointDamage "HitHydraulics";   chopper setHitPointDamage ["HitHydraulics",   _dmg + random (1-_dmg)* .5 * _engDmg];			
			_dmg = chopper getHitPointDamage "HitFuel";         chopper setHitPointDamage ["HitFuel",         _dmg + random (1-_dmg)* .8 * _engDmg];			
			_dmg = chopper getHitPointDamage "HitBattery";      chopper setHitPointDamage ["HitBattery",      _dmg + random (1-_dmg)* _engDmg];		
			_dmg = chopper getHitPointDamage "HitAvionics";     chopper setHitPointDamage ["HitAvionics",     _dmg + random (1-_dmg)* _engDmg];
			
			sleep 3;
			hint "Something's seriously wrong with the helicopter!!";
		};
		
		
		// obstruction caused damage! - this is mighty serious!
		//
		if (Heli_Has_Obstruction && random 42 < 1) then // fuck!
		{
			// damage here is not proportional to anything!! -- and by the way, insurance will probably not cover this!
			
			_dmg = chopper getHitPointDamage "HitEngine";       chopper setHitPointDamage ["HitEngine",       _dmg + random (1-_dmg)];		
			_dmg = chopper getHitPointDamage "HitTransmission"; chopper setHitPointDamage ["HitTransmission", _dmg + random (1-_dmg)];		
			_dmg = chopper getHitPointDamage "HitHydraulics";   chopper setHitPointDamage ["HitHydraulics",   _dmg + random (1-_dmg)];			
			_dmg = chopper getHitPointDamage "HitFuel";         chopper setHitPointDamage ["HitFuel",         _dmg + random (1-_dmg)];			
			_dmg = chopper getHitPointDamage "HitBattery";      chopper setHitPointDamage ["HitBattery",      _dmg + random (1-_dmg)];		
			_dmg = chopper getHitPointDamage "HitAvionics";     chopper setHitPointDamage ["HitAvionics",     _dmg + random (1-_dmg)];
			
			sleep 3;
			hint "Something's wrong with the engine!!!\n Did you remember to inspect it??!";
		};
	};
};

