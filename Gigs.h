
#define GIG_TASKREF 0        // task through which gig gets selected for request
#define GIG_MARKER 1         // associated marker shown on map

#define GIG_CALL_CODE 2      // code executed on request
#define GIG_DATA_ARRAY 3     // custom parameters used for request code as well as expiration and able'ness checks

#define GIG_EXP_CODE 4       // code to execute upon expiration check - receives gig struct as parameter - must return true or false, deciding if gig shall remain available afterwards
#define GIG_EXP_TIME 5       // time upon which expiration code shall execute

#define GIG_ABLE_CODE 6      // code to determine the capacity of the player's helicopter to comply with gig - receives gig struct     
#define GIG_ABLE_FLAG 7      // flag indicating as to if the gig was considered able at last check

#define GIG_STRUCT_SIZE 8;   // size of a gig struct array




