

hint "Magic powers granted!\n Click on the map to go there!\n\ncaution: magic may not accout for terrain, so watch your altitude!\n\nfor safety reasons, SHIFT must be down upon map click to confirm location";

HW_Magic_Warp_Click = false;
HW_Magic_Warp_Pos = getPos player;


onMapSingleClick "HW_Magic_Warp_Click=true; HW_Magic_Warp_Pos=_pos; _shift;";

openMap true;

waitUntil { HW_Magic_Warp_Click };

openMap false; 

onMapSingleClick "";

chopper setPosATL [HW_Magic_Warp_Pos select 0, HW_Magic_Warp_Pos select 1, (getPosATL chopper) select 2];

hint "MAGIC!!";

HW_Magic_Warp_Click = nil;
HW_Magic_Warp_Pos   = nil;