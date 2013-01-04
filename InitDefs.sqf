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
	"GroundCrew_H",
	"Workman_H"
];

CargoDefs_Lite = 
[
	["FireSuppression_H",      320],
	["Ventilation_H",          250],
	["CargoCont_Net1_H",       350],
	["Misc_Cargo_Cont_Tiny",   400], // this thing is heavy as balls! the LB is barely able to lift it (+2 pax aboard)
	["PowerGenerator",         300]
];



MoveDefs_Men_Group = 
[
	"AmovPercMstpSnonWnonDnon_talking",
	"AidlPercSnonWnonDnon_talkBS",
	"AidlPercSnonWnonDnon_talk1",
	"AidlPercSnonWnonDnon_talk2",
	"AidlPercSnonWnonDnon_talk3",
	"AidlPercSnonWnonDnon_talk4",
	"AidlPercSnonWnonDnon_talk5",
	"c5calming_apc",
	"c5calming_fjodor",
	"c5calming_zevl1",
	"c5calming_zevl2",
	"c5calming_zevl3",
	"c5calming_zevl4",
	"c5calming_zevl5",
	"c5calming_zevl6",
	"c5calming_zevl7",
	"UnaErcVelitelProslov1",
	"UnaErcVelitelProslov3",
	"UnaErcVelitelProslov5",
	"LHD_hiDeck",
	"LHD_krajPaluby",
	"LHD_midDeck",
	"ActsPercMstpSnonWnonDnon_DancingStefan" // this one is an easter egg... a small reference to the simcopter gay sims prank that cost a developer his job
];

MoveDefs_Men_Idle = 
[
	"LHD_hiDeck",
	"LHD_krajPaluby",
	"LHD_midDeck"
];


MoveDefs_Women_Group = 
[
	"Cwmn_GalkinaErc_talkCry",
	"Cwmn_GalkinaErc_talkHappy1",
	"Cwmn_GalkinaErc_talkHappy2",
	"AidlPercMstpSnonWnonDnon_3greetR",
	"CwmnPerc_diskuse1",
	"CwmnPerc_ukazatDoleva",
	"CwmnPerc_diskuse2",
	"AidlPercMstpSnonWnonDnon_2",
	"AidlPercMstpSnonWnonDnon_1",
	"AidlPercMstpSnonWnonDnon_4"
];


MoveDefs_Women_Idle = 
[
	"AidlPercMstpSnonWnonDnon_2",
	"AidlPercMstpSnonWnonDnon_1",
	"AidlPercMstpSnonWnonDnon_4"
];


/*
	
["NavigationHeli"]

*/





//  the following points were marked by ACTUALLY flying a helicopter (ingame, not a real one, alas) onto them and logging the choppers position
//   using a special developer-tool script... many of those are not landing-friendly, which made cataloging them quite a pilot-intensive task


// rooftops for cargo sling ops -- use debug mode to locate each defs respective ID on the map
//
PosDefs_roofTops = 
[
	['rt.1',  [31734.6, 30996.2, 294.387]],      	
	['rt.2',  [31429.3, 31134.3, 153.391]],      	
	['rt.3',  [31384.1, 30999.6, 147.203]],      	
	['rt.4',  [31362.7, 31078.7, 133.485]],      	
	['rt.5',  [31307.5, 31274.3, 224.278]],      	
	['rt.6',  [31447.6, 31481.7, 151.177]],      	
	['rt.7',  [31424, 31668, 168.276]],          	
	['rt.8',  [31641.4, 31649.9, 239.237]],      	
	['rt.9',  [31895.8, 31539.5, 136.932]],      	
	['rt.10', [31777.5, 31165.2, 219.065]],      	
	['rt.11', [31085.8, 31542.5, 131.341]],      	
	['rt.12', [31125.9, 31929.2, 97.3887]],      	
	['rt.13', [31315.8, 32010.4, 140.424]],      	
	['rt.14', [31390.6, 32087.9, 153.862]],      	
	['rt.15', [31205.8, 31314.3, 183.823]],      	
	['rt.16', [31597.8, 31776.5, 105.473]],      	
	['rt.17', [31519.6, 32024.5, 132.545]],      	
	['rt.18', [31286.9, 32479.6, 100.232]],      	
	['rt.19', [31760.6, 33231.7, 116.799]],      	
	['rt.20', [31961.9, 33182.2, 83.7743]],      	
	['rt.21', [31853.7, 33704.3, 59.3321]],      	
	['rt.22', [30908.3, 34194.4, 65.497]],       	
	['rt.23', [32892.9, 37266.7, 108.089]],      	
	['rt.24', [33159.6, 37115.5, 37.5076]],      	
	['rt.25', [33724.6, 36960.8, 33.5384]],      	
	['rt.26', [34353, 39670.2, 47.5857]],        	
	['rt.27', [30392.2, 48539.8, 47.3917]],      	
	['rt.28', [30549, 48385.3, 47.6479]],        	
	['rt.29', [30521.5, 47401, 38.6539]],        	
	['rt.30', [28117.6, 52742.6, 52.0535]],      	
	['rt.31', [27289.2, 53826.4, 55.8806]],      	
	['rt.32', [27676.4, 53855.2, 52.1402]],      	
	['rt.33', [27846.2, 53865.6, 43.9174]],      	
	['rt.34', [31739.8, 54383, 37.7603]],        	
	['rt.35', [33963.8, 55227.2, 55.5936]],      	
	['rt.36', [34569.2, 55028.6, 80.581]],       	
	['rt.37', [42567.9, 42715.5, 47.3036]],      	
	['rt.38', [42561.8, 42342.8, 44.9826]],      	
	['rt.39', [42349.8, 42532.9, 32.7184]],      	
	['rt.40', [43342.5, 42538, 38.6445]],        	
	['rt.41', [44037, 39961.7, 43.6749]],        	
	['rt.42', [43691.3, 39473.6, 38.6268]],      	
	['rt.43', [44084.2, 37997.7, 41.1618]],      	
	['rt.44', [46321.1, 36440.7, 20.4312]],      	
	['rt.45', [46108.9, 36427.3, 47.0719]],      	
	['rt.46', [45954.6, 35803.6, 43.7524]],      	
	['rt.47', [46535.3, 35590.1, 34.5511]],      	
	['rt.48', [49433, 37932.2, 79.7873]],        	
	['rt.49', [49520.6, 38127.3, 70.0125]],      	
	['rt.50', [49522.6, 38890.6, 38.6827]],      	
	['rt.51', [47151.7, 30701.8, 57.6638]],      	
    ['rt.52', [47036, 28717.4, 101.785]],          	
	['rt.53', [45359.6, 29091.8, 37.4311]],
    ['rt.54', [41702.3, 31899.5, 99.4418]],
    ['rt.55', [41695.9, 32162.9, 154.138]],
    ['rt.56', [41513.2, 32343.2, 123.943]],
    ['rt.57', [41798.6, 32391.6, 97.3056]],
    ['rt.58', [41895.5, 32267, 127.476]],
    ['rt.59', [41993.8, 32245.6, 128.569]],
    ['rt.60', [41809.5, 32147.8, 95.9119]],
    ['rt.61', [41326, 31687.8, 79.4575]],
    ['rt.62', [41759.5, 31194.1, 38.0787]],
    ['rt.63', [43087.3, 31944.1, 38.2856]],
    ['rt.64', [42210.1, 32727.5, 101.531]],
    ['rt.65', [42932.9, 33366.1, 34.6708]],
    ['rt.66', [39186.9, 28686.5, 37.745]],
    ['rt.67', [38820.9, 28963.4, 38.8455]],
    ['rt.68', [41862.1, 23482.3, 100.073]],
    ['rt.69', [41766.4, 23427.7, 65.1128]],
    ['rt.70', [43222.9, 20385.4, 46.377]],
    ['rt.71', [43253.7, 20466.7, 46.5074]],
    ['rt.72', [27634, 26195.3, 44.0908]],
    ['rt.73', [28254.3, 25845.3, 12.1274]],
    ['rt.74', [28445, 24393.1, 33.9783]],
    ['rt.75', [28279.1, 24359.6, 11.0458]],
    ['rt.76', [32425.2, 21377.9, 67.1232]],
    ['rt.77', [33071.2, 21753.2, 80.6652]],
    ['rt.78', [33156.7, 21715.4, 133.016]],
    ['rt.79', [33177.7, 21549.7, 124.387]],
    ['rt.80', [32919.7, 21243.4, 92.4687]],
    ['rt.81', [34048.1, 21454, 68.3238]],
    ['rt.82', [36124.1, 22091, 80.2219]],
    ['rt.83', [36351.4, 21809.4, 82.885]],
    ['rt.84', [35993.7, 18188.9, 41.2417]],
    ['rt.85', [35884.1, 18253.7, 40.6061]],
    ['rt.86', [35792.1, 18420.6, 55.8926]],
    ['rt.87', [35873, 16605.9, 38.6885]],
    ['rt.88', [36550.2, 15504.5, 45.155]],
    ['rt.89', [37084, 14460.4, 93.4037]],
    ['rt.90', [37155.3, 14351.2, 100.846]],
    ['rt.91', [43449.9, 18847.8, 29.0365]],
    ['rt.92', [42835.4, 19608.4, 39.2025]],
    ['rt.93', [42945.7, 20121.9, 31.554]],
    ['rt.94', [42831.4, 20265.1, 38.687]],
    ['rt.95', [45283.6, 19671.9, 44.4369]],
    ['rt.96', [46306.7, 34095.6, 49.8693]],
    ['rt.97', [46256.9, 33690.3, 25.6266]],
    ['rt.98', [44363.2, 23833.3, 20.4898]],
    ['rt.99', [45011.6, 26003.8, 40.9852]],
    ['rt.100', [44121.7, 28150.4, 19.6911]],
    ['rt.101', [33542.9, 26495.1, 64.1711]],
    ['rt.102', [32900.4, 29192.9, 47.27]],
    ['rt.103', [32709, 29524.3, 26.337]],
    ['rt.104', [35377.3, 37402.9, 38.7076]],
    ['rt.105', [35991.8, 37601, 19.6457]],
	['rt.106', [29663.8, 15646.6, 37.2568]],
	['rt.107', [30619.3, 16121.6, 38.6541]],
	['rt.108', [30614.7, 17554.1, 43.8012]],
	['rt.109', [36226.2, 22084.4, 55.8641]],
	['rt.110', [30930.9, 26882.2, 47.77]],
	['rt.111', [29802.3, 27723.8, 47.7192]],
	['rt.112', [29446.2, 27268.3, 44.755]],
	['rt.113', [26311.6, 28435.4, 16.6907]]
];

// additional field landing points (allows an easier/more fun alternative method for indexing LZ's) 
//
PosDefs_landings = [
	['ConstructionSupply', 'lz.1',  [30685.5, 31455.1, -0.19357]],
	['ConstructionSupply', 'lz.2',  [30787.1, 32514.5, -0.118195]],
	['ConstructionSupply', 'lz.3',  [31655.6, 31903.9, -0.115631]],
	['ConstructionSupply', 'lz.4',  [31751.8, 30259.2, -0.115619]],
	['ConstructionSupply', 'lz.5',  [32168.4, 29381.6, -0.115246]],
	['ConstructionSupply', 'lz.6',  [32813.5, 31369.7, -0.103508]],
	['ConstructionSupply', 'lz.7',  [32645.1, 31809.9, -0.10112]],
	['ConstructionSupply', 'lz.8',  [33568.4, 37159.4, -0.114929]],
	['ConstructionSupply', 'lz.9',  [32945.5, 37474, -0.115128]],
	['ConstructionSupply', 'lz.10', [33215.6, 27270, -0.115395]],
	['ConstructionSupply', 'lz.11', [33550.2, 26311.9, -0.103859]],
	['ConstructionSupply', 'lz.12', [27447.4, 26089.8, -0.112984]],
	['ConstructionSupply', 'lz.13', [27988.6, 25383.5, -0.115364]],
	['ConstructionSupply', 'lz.14', [27928, 26111.2, -0.0989914]],
	['ConstructionSupply', 'lz.15', [28309.8, 23878.7, -0.110077]],
	['ConstructionSupply', 'lz.16', [28674.9, 24422.1, -0.115448]],
	['ConstructionSupply', 'lz.17', [27350.3, 23805.1, -0.118538]],
	['ConstructionSupply', 'lz.18', [31623.8, 21287.4, -0.108788]],
	['ConstructionSupply', 'lz.19', [32982.6, 21359.6, -0.110984]],
	['ConstructionSupply', 'lz.20', [33619.7, 22344.9, -0.114958]],
	['ConstructionSupply', 'lz.21', [27978, 34057.9, -0.112494]],
	['ConstructionSupply', 'lz.22', [33634.2, 32856.4, -0.115746]],
	['ConstructionSupply', 'lz.23', [33978.7, 35602.9, -0.0968237]],
	['ConstructionSupply', 'lz.24', [39948.6, 27302, -0.107979]],
	['ConstructionSupply', 'lz.25', [39261.4, 29329.7, -0.115719]],
	['ConstructionSupply', 'lz.26', [39246.4, 28916.2, -0.107254]],
	['ConstructionSupply', 'lz.27', [44339.7, 30082.9, -0.0858727]],
	['ConstructionSupply', 'lz.28', [42823.6, 31282, -0.102856]],
	['ConstructionSupply', 'lz.29', [42718.5, 32042.3, -0.0912285]],
	['ConstructionSupply', 'lz.30', [40576.4, 33243.2, -0.11869]],
	['ConstructionSupply', 'lz.31', [41395.2, 31669.9, -0.107603]],
	['ConstructionSupply', 'lz.32', [41083.4, 32268.5, -0.0974388]],
	['ConstructionSupply', 'lz.33', [42466, 33409, -0.072403]],
	['ConstructionSupply', 'lz.34', [42683.9, 30973.9, -0.10804]],
	['ConstructionSupply', 'lz.35', [46426.2, 28587.6, -0.106148]],
	['ConstructionSupply', 'lz.36', [48045.7, 28131.8, -0.113417]],
	['ConstructionSupply', 'lz.37', [41418.3, 22890.8, -0.114307]],
	['ConstructionSupply', 'lz.38', [39954.8, 23992.2, -0.119675]],
	['ConstructionSupply', 'lz.39', [43096.4, 20485.5, -0.115524]],
	['ConstructionSupply', 'lz.40', [43052.9, 19579, -0.115135]],
	['ConstructionSupply', 'lz.41', [40294.4, 19380.3, -0.111359]],
	['ConstructionSupply', 'lz.42', [45509.4, 18835.6, -0.115616]],
	['ConstructionSupply', 'lz.43', [43468.6, 17789.4, -0.115921]],
	['ConstructionSupply', 'lz.44', [42815.7, 19100.5, -0.114685]],
	['ConstructionSupply', 'lz.45', [44032.9, 20929.8, -0.115128]],
	['ConstructionSupply', 'lz.46', [46509.8, 19713.3, -0.114456]],
	['ConstructionSupply', 'lz.47', [46079.5, 31325.1, -0.115791]],
	['ConstructionSupply', 'lz.48', [46571.2, 33966.9, -0.115822]],
	['ConstructionSupply', 'lz.49', [45053.9, 34201.8, -0.114296]],
	['ConstructionSupply', 'lz.50', [45916.9, 36993.5, -0.11335]],
	['ConstructionSupply', 'lz.51', [48314.2, 36307, -0.115555]],
	['ConstructionSupply', 'lz.52', [46401, 36059.8, -0.0960007]],
	['ConstructionSupply', 'lz.53', [47885.1, 37344.1, -0.116003]],
	['ConstructionSupply', 'lz.54', [44649.3, 39866.7, -0.112572]],
	['ConstructionSupply', 'lz.55', [43162.6, 40127.1, -0.10199]],
	['ConstructionSupply', 'lz.56', [42485.9, 43014.8, -0.114883]],
	['ConstructionSupply', 'lz.57', [45802, 42227, -0.116129]],
	['ConstructionSupply', 'lz.58', [30644, 47350.4, -0.11528]],
	['ConstructionSupply', 'lz.59', [28608.9, 48283.4, -0.102356]],
	['ConstructionSupply', 'lz.60', [26831.9, 53287, -0.11483]],
	['ConstructionSupply', 'lz.61', [28456.2, 54437.9, -0.0846996]],
	['ConstructionSupply', 'lz.62', [29005.8, 54978.6, -0.118587]],
	['ConstructionSupply', 'lz.63', [36854.7, 21981.3, -0.114371]],
	['ConstructionSupply', 'lz.64', [35716.9, 20655.8, -0.116359]],
	['ConstructionSupply', 'lz.65', [34502.9, 20435.1, -0.114703]],
	['ConstructionSupply', 'lz.66', [31199, 16026.9, 0]],
	['ConstructionSupply', 'lz.67', [30184.1, 16277.4, 0]],
	['ConstructionSupply', 'lz.68', [30794.6, 16032.8, 0]],
	['ConstructionSupply', 'lz.69', [36036.6, 22301.6, 0]],
	['ConstructionSupply', 'lz.70', [29308.5, 27461.9, 1.19246]],
	['ConstructionSupply', 'lz.71', [30109, 27635.7, 1.19256]],
	['ConstructionSupply', 'lz.72', [31029.5, 26349.1, 1.19249]],
	['ConstructionSupply', 'lz.73', [27907.1, 29743.5, 1.1922]]
];



{ 
	_lz = createLocation [(_x select 0), (_x select 2), 100, 100]; 
	//
} foreach PosDefs_landings;





_compsInit = [] execVM "Comps\CompDefs.sqf";
waituntil { scriptdone _compsInit };












