
if (Heli_Cabin_Condition < .9) then
{
	Cabin_needs_action = true;
	if (Heli_Cabin_Condition > .5) then
	{
		hint "Yeah, there are crumbs and dirt and whatnot... \nnot the best way to impress passengers, is it? ";
	} else
	{
		hint "Sweet Mother of Crap! It looks like someone exploded in here!/n That's outright unacceptable - grab a bucket and start scrubbin'!";
	};

} else
{
	hint "Cabin is looking good! Smells nice too!";
	Cabin_needs_action = false;
};