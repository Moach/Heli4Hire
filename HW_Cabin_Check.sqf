
if (Heli_Cabin_Condition < .9) then
{
	Cabin_needs_action = true;
	if (Heli_Cabin_Condition > .5) then
	{
		if (Heli_Cabin_Condition > .75) then
		{
			
			hint "I've seen it cleaner...\n but hey, a neat chopper is one that isn't getting flown enough, right?....  right??";
		} else
		{
		
			hint "Yeah, there are crumbs and dirt and whatnot... \nnot exactly a luxury ride, one might say...";
		};
		
	} else
	{
		if (Heli_Cabin_Condition > .3) then
		{
			
			hint "That lovely new helicopter smell is dead and gone, that's for sure....\n all that filth could perhaps use a cleaning hand (yours)";
		} else
		{
		
			hint "Sweet Mother of Crud! It looks like somebody exploded in here!\n That's outright unacceptable - roll up your sleeves and start scrubbin'!";
		};
	};

} else
{
	hint "Cabin is looking good! Smells nice too!";
	Cabin_needs_action = false;
};