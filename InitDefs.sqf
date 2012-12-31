LocDefs_taxi = ["FlatAreaCity", "FlatAreaCitySmall", "FlatArea", "Heliport", "Airport", "ConstructionSupply", "ConstructionSite", "SummerCamp"];

PaxDefs_taxi = [
	"Woman01_Random_H",
	"Woman02_Random_H",
	"Woman03_Random_H",
	"Hooker1",
	"Hooker4",
	"Hooker2",
	"Hooker3",
	"Citizen_Random_H",
	"Citizen_Random_H",
	"Citizen_Random_H",
	"Journalist_H",
	"Manager_H",
	"Rocker_H",
	"SeattleMan_Random_H"
];

PaxDefs_cargo = [
	"Citizen_Random_H",
	"Citizen_Random_H",
	"Citizen_Random_H"
];

CargoDefs_Lite = 
[
	["FireSuppression_H",      320],
	["Ventilation_H",          250],
	["CargoCont_Net1_H",       350],
	["Misc_Cargo_Cont_Tiny",   400],
	["PowerGenerator",         300],
	["Land_Antenna",           210]
];


//  the following points were marked by ACTUALLY flying a helicopter (ingame, not a real one, alas) onto them and logging the choppers position
//   using a special developer-tool script... many of those are not landing-friendly, which made cataloging them quite a pilot-intensive task


// rooftops for cargo sling ops
//
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
	[41785.7, 32149.8, -0.152466],  // fancy glass-thing building between two of the above
	[41931.5, 32642.6, -0.133713],  // round panelled top north of highrise cluster
	[41702.4, 31900.5, -0.248566],  // center of building that looks like this --> (=||=)
	[41333.1, 31700.5, -0.115913],  // two-tier flat top near the water
	[42004.5, 32244, -0.270859],    // SIDE of taller round panelled top close the the columbia-like tower mentioned above
	[45949.9, 33854.8, -0.11557],   // large flat-top over to the northeast cluster
	[46533.6, 35593.4, -0.129532],  // westernmost one of two twin buildings adjacent to northbound motorway
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
	[47150.1, 30700.3, -0.115616],  // lone awkward-L somewhere among the hills  
	[45885.7, 35095.5, -0.115067],  // generic office building north of the above
	//
	//                                            SHOREWOOD / RENTON VALLEY NEAR BOEING FIELD
	[32748.8, 22062.2, -0.115356],  // awkward dual angled building (looks residential)
	[32918.6, 21267.8, -0.115273],  // cube-top building west across motorway
	[33149.3, 21553.4, -0.114777],  // tallest one in the middle
	[33318, 21562.8, -0.115356],    // cube-topped flip-off shaped towers center
	[34057.2, 21441.5, -0.162743],  // dull yellow box building across the water by the airfield
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



// additional field landing points (allows an easier/more fun alternative method for indexing LZ's) 
//
PosDefs_landings = [
	['ConstructionSupply', 'lz.1' ,[30685.5, 31455.1, -0.19357]],
	['ConstructionSupply', 'lz.2' ,[30787.1, 32514.5, -0.118195]],
	['ConstructionSupply', 'lz.3' ,[31655.6, 31903.9, -0.115631]],
	['ConstructionSupply', 'lz.4' ,[31751.8, 30259.2, -0.115619]],
	['ConstructionSupply', 'lz.5' ,[32168.4, 29381.6, -0.115246]],
	['ConstructionSupply', 'lz.6' ,[32813.5, 31369.7, -0.103508]],
	['ConstructionSupply', 'lz.7' ,[32645.1, 31809.9, -0.10112]],
	['ConstructionSupply', 'lz.8' ,[33568.4, 37159.4, -0.114929]],
	['ConstructionSupply', 'lz.9' ,[32945.5, 37474, -0.115128]],
	['ConstructionSupply', 'lz.10' ,[33215.6, 27270, -0.115395]],
	['ConstructionSupply', 'lz.11' ,[33550.2, 26311.9, -0.103859]],
	['ConstructionSupply', 'lz.12' ,[27447.4, 26089.8, -0.112984]],
	['ConstructionSupply', 'lz.13' ,[27988.6, 25383.5, -0.115364]],
	['ConstructionSupply', 'lz.14' ,[27928, 26111.2, -0.0989914]],
	['ConstructionSupply', 'lz.15' ,[28309.8, 23878.7, -0.110077]],
	['ConstructionSupply', 'lz.16' ,[28674.9, 24422.1, -0.115448]],
	['ConstructionSupply', 'lz.17' ,[27350.3, 23805.1, -0.118538]],
	['ConstructionSupply', 'lz.18' ,[31623.8, 21287.4, -0.108788]],
	['ConstructionSupply', 'lz.19' ,[32982.6, 21359.6, -0.110984]],
	['ConstructionSupply', 'lz.20' ,[33619.7, 22344.9, -0.114958]],
	['ConstructionSupply', 'lz.21' ,[27978, 34057.9, -0.112494]],
	['ConstructionSupply', 'lz.22' ,[33634.2, 32856.4, -0.115746]],
	['ConstructionSupply', 'lz.23' ,[33978.7, 35602.9, -0.0968237]],
	['ConstructionSupply', 'lz.24' ,[39948.6, 27302, -0.107979]],
	['ConstructionSupply', 'lz.25' ,[39261.4, 29329.7, -0.115719]],
	['ConstructionSupply', 'lz.26' ,[39246.4, 28916.2, -0.107254]],
	['ConstructionSupply', 'lz.27' ,[44339.7, 30082.9, -0.0858727]],
	['ConstructionSupply', 'lz.28' ,[42823.6, 31282, -0.102856]],
	['ConstructionSupply', 'lz.29' ,[42718.5, 32042.3, -0.0912285]],
	['ConstructionSupply', 'lz.30' ,[40576.4, 33243.2, -0.11869]],
	['ConstructionSupply', 'lz.31' ,[41395.2, 31669.9, -0.107603]],
	['ConstructionSupply', 'lz.32' ,[41083.4, 32268.5, -0.0974388]],
	['ConstructionSupply', 'lz.33' ,[42466, 33409, -0.072403]],
	['ConstructionSupply', 'lz.34' ,[42683.9, 30973.9, -0.10804]],
	['ConstructionSupply', 'lz.35' ,[46426.2, 28587.6, -0.106148]],
	['ConstructionSupply', 'lz.36' ,[48045.7, 28131.8, -0.113417]],
	['ConstructionSupply', 'lz.37' ,[41418.3, 22890.8, -0.114307]],
	['ConstructionSupply', 'lz.38' ,[39954.8, 23992.2, -0.119675]],
	['ConstructionSupply', 'lz.39' ,[43096.4, 20485.5, -0.115524]],
	['ConstructionSupply', 'lz.40' ,[43052.9, 19579, -0.115135]],
	['ConstructionSupply', 'lz.41' ,[40294.4, 19380.3, -0.111359]],
	['ConstructionSupply', 'lz.42' ,[45509.4, 18835.6, -0.115616]],
	['ConstructionSupply', 'lz.43' ,[43468.6, 17789.4, -0.115921]],
	['ConstructionSupply', 'lz.44' ,[42815.7, 19100.5, -0.114685]],
	['ConstructionSupply', 'lz.45' ,[44032.9, 20929.8, -0.115128]],
	['ConstructionSupply', 'lz.46' ,[46509.8, 19713.3, -0.114456]],
	['ConstructionSupply', 'lz.47' ,[46079.5, 31325.1, -0.115791]],
	['ConstructionSupply', 'lz.48' ,[46571.2, 33966.9, -0.115822]],
	['ConstructionSupply', 'lz.49' ,[45053.9, 34201.8, -0.114296]],
	['ConstructionSupply', 'lz.50' ,[45916.9, 36993.5, -0.11335]],
	['ConstructionSupply', 'lz.51' ,[48314.2, 36307, -0.115555]],
	['ConstructionSupply', 'lz.52' ,[46401, 36059.8, -0.0960007]],
	['ConstructionSupply', 'lz.53' ,[47885.1, 37344.1, -0.116003]],
	['ConstructionSupply', 'lz.54' ,[44649.3, 39866.7, -0.112572]],
	['ConstructionSupply', 'lz.55' ,[43162.6, 40127.1, -0.10199]],
	['ConstructionSupply', 'lz.56' ,[42485.9, 43014.8, -0.114883]],
	['ConstructionSupply', 'lz.57' ,[45802, 42227, -0.116129]],
	['ConstructionSupply', 'lz.58' ,[30644, 47350.4, -0.11528]],
	['ConstructionSupply', 'lz.59' ,[28608.9, 48283.4, -0.102356]],
	['ConstructionSupply', 'lz.60' ,[26831.9, 53287, -0.11483]],
	['ConstructionSupply', 'lz.61' ,[28456.2, 54437.9, -0.0846996]],
	['ConstructionSupply', 'lz.62' ,[29005.8, 54978.6, -0.118587]],
	['ConstructionSupply', 'lz.63' ,[36854.7, 21981.3, -0.114371]],
	['ConstructionSupply', 'lz.64' ,[35716.9, 20655.8, -0.116359]],
	['ConstructionSupply', 'lz.65' ,[34502.9, 20435.1, -0.114703]]
];



{ 
	_lz = createLocation [(_x select 0), (_x select 2), 100, 100]; 
	//
} foreach PosDefs_landings;


















