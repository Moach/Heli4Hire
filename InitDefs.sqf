
LocDefs_taxi = ["FlatAreaCity", "FlatAreaCitySmall", "FlatArea", "Heliport", "Airport", "ConstructionSupply", "ConstructionSite", "SummerCamp"];

PaxDefs_taxi = [
	"Woman01_Random_H",
	"Woman02_Random_H",
	"Woman03_Random_H",
	"Hooker1",
	"Hooker4",
	"Hooker2",
	"Citizen_Random_H",
	"Citizen_Random_H",
	"Citizen_Random_H",
	"Journalist_H",
	"Manager_H",
	"Rocker_H",
	"SeattleMan_Random_H"
];


//  the following points were marked by ACTUALLY flying a helicopter (ingame, not a real one, alas) onto them and logging the choppers position
//   using a special developer-tool script... many of those are not landing-capable, which made cataloging them quite a pilot-intensive task
PosDefs_roofTops = [
	//
	//                                                SEATTLE DOWNTOWN AND IMMEDIATE AREA
	[31735.6, 30994.8, -0.115967],  // columbia tower
	[31773.7, 31161.4, -0.116119],  // identical to police mission building, taller, near columbia tower
	[31639.3, 31653.1, -0.115143],  // robocop-like building (northmost downtown skyscraper)
	[31208.7, 31311.7, -0.116104],  // flat glass panelled tower by the waterfront
	[31087.9, 31539.4, -0.083206],  // ellipsoid double panel top building
	[31106.6, 31938.7, -0.248611],  // the one that looks like this from above --> (=||=)
	[31316.8, 32008.8, -0.115936],  // northern glass box fenced top building
	[31448.5, 31682.9, -0.115814],  // pizza-hut top building (eastern spur)
	[31897.2, 31531.8, -0.115692],  // southern glass box fenced top building
	[30337.8, 32761.8, 2.75691],    // spire atop the friggin' space needle (boy, it's hard to land there!)
	[29770.5, 32457.9, -0.3153],    // swirly glass building WSW of the above... (no landing there either, really! it killed me!)
	[32267.1, 31416.5, -0.164993],  // pale yellow box tower east of downtown
	[32341, 31739.9, -0.115662],    // vintage-looking building east of downtown
	[31779.2, 33225.3, -0.115417],  // vrana-like tower by union lake
	[32897.5, 37266.5, -0.115616],  // lone high-rise north of the water
	[32900.9, 29198.6, -0.14769],   // single rectangular tower atop south hill
	//
	//                                                          BELLEVUE AREA
	[41471, 32460.5, -0.114471],    // robocop-type building, south "tray" on top
	[41695.5, 32166.8, -0.115295],  // columbia tower's baby brother
	[41881.1, 32249.7, -0.114868],  // convoluted side vrana-topped building
	[41996.1, 32162.9, -0.114838],  // assymetric one SE of the above
	[38822.1, 29029.5, -0.11599],   // one of 3-building compound at island near eastbound motorway
	//
	//                                                      NEWPORT HILLS / RENTON IMMEDIACY
	[41858.9, 23498, -0.115891],    // multi-tier compound east of the aforementioned island
	[42950.6, 20122.2, -0.115768],  // hotel-like structure near cluster of glass towers facing softball fields
	[43184.7, 20436, -0.115875],    // one of the swirly glass towers of the aforementioned cluster
	[41524.5, 19755.5, -0.115448],  // awkward-L building east of renton mun. airfield
	[43453.8, 18809.8, -0.115799],  // chamfered corners castle flanged top stumpy building
	[45275.1, 19630.1, -0.115479],  // boeing-wannabe compound near the above
	[47039.5, 28723.1, 0.884644],   // north tower of the 2-building compund near the eastern lakeside
	[55866.3, 26236.3, -0.115189],  // flat-top way east of issaquah
	[53851.7, 30880, -0.115005],    // robocop type building up the road north of the above
	//
	//                                            SHOREWOOD / RENTON VALLEY NEAR BOEING FIELD
	[32748.8, 22062.2, -0.115356],  // awkward dual angled building (looks residential)
	[32918.6, 21267.8, -0.115273],  // cube-top building west across motorway
	[33149.3, 21553.4, -0.114777],  // tallest one in the middle
	[33318, 21562.8, -0.115356],    // cube-topped flip-off shaped towers center
	[34057.2, 21441.5, -0.162743],  // yellow box building across the water by the airfield
	[36115.2, 22092.7, -0.115326],  // lil' blue flat-top past the hill east of boeing field
	[36332.9, 21803.6, -0.115372],  // brown one SE of the above
	[33520.5, 26486.9, -0.115112],  // 3-tier cube-top NE of boeing field	
	//
	//                                                 SHOREWOOD NORTH AREA
	[27632.1, 26194.4, -0.1185],    // thin L-shaped tower east of golf course
	[28337.6, 24419.1, -0.114929],  // boxy building some ways south of the above
	//
	//                                                 RICHMOND HIGHLANDS / REDMOND
	[30050.9, 46412.3, -0.120193],  // X-shaped building by large parking lots
	[30391.3, 48548.4, -0.147919],  // lone rectangular building by motorway
	[27253.7, 53806.7, -0.116287],  // awkward-L by the waterfront
	[27465.4, 53742, -0.116741],    // triangle-top W of the above
	[27677.8, 53672.2, -0.116482],  // stumpy star-shaped near the two above (hardly warrants a chopper, but anyways...)
	[28072.6, 52742.3, -0.14225],   // rectangular compound south of the above
	[49440.4, 37929.8, -0.115265],  // one of the redmond cluster towers
	[49520, 38079.6, -0.115242],    // another of the redmond towers, not the same type though
	[44721.2, 41755.2, -0.114822],  // a discreet little building north of redmond unlikely to be serviced by land cranes...
	[42551, 42691.2, -0.113976],    // awkward-L by the motorway intersection
	[42403.3, 42299.1, -0.114304],  // multi-box building near the above
	[44025.1, 40000.3, -0.114838],  // fortress-looking castle thing atop hill
	[42824.8, 39957.1, -0.140884]   // Y-shaped building between motorway and little lake
];


