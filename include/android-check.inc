#if defined _ACK_include
	#endinput
#endif
#define _ACK_include

#if !defined SendClientCheck
    native SendClientCheck(playerid, type, arg, offset, size);
#endif 

forward OnClientCheckResponse(playerid, actionid, memaddr, retndata);
forward OnCheckOperatingSystem(playerid, OSType);

#define GetBit(%0,%1) ((%0 >> %1) & 1)

/**
    Default method definition
 */
#if !defined USE_METHOD
    #define USE_METHOD 3 // 1 - 4
#endif

//Just to sure user not inserting the wrong configuration
#if USE_METHOD > 4 || USE_METHOD < 1
    #error USE_METHOD must contain 1 - 4
#endif

/*
    Constant definition
*/
#define OS_TYPE_ANDROID 0
#define OS_TYPE_PC 1

#if USE_METHOD == 1
enum Flags
{
    b0x01,
    bApplyGravity,
    bDisableFriction,
    bCollidable,
    b0x10,
    bDisableMovement,
    b0x40,
    b0x80,

    bSubmergedInWater,
    bOnSolidSurface,
    bBroken,
    b0x800,
    b0x1000,
    b0x2000,
    b0x4000,
    b0x8000,

    b0x10000,
    b0x20000,
    bBulletProof,
    bFireProof,
    bCollisionProof,
    bMeeleProof,
    bInvulnerable,
    bExplosionProof,

    b0x1000000,
    bAttachedToEntity,
    b0x4000000,
    bTouchingWater,
    bEnableCollision,
    bDestroyed,
    b0x40000000,
    b0x80000000
};

new PhysFlags[MAX_PLAYERS][Flags];
#endif

new 
    bool:isPC[MAX_PLAYERS];

/**
    Hook callbacks
 */
public OnFilterScriptInit(){
    print("-----------------------------------------");
    print("    Android Check Include Loaded         ");
    print("-----------------------------------------");
	#if defined ACK_OnFilterScriptInit
		return ACK_OnFilterScriptInit();
    #else
        return 1;
	#endif
}

#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit ACK_OnFilterScriptInit
#if defined ACK_OnFilterScriptInit
	forward ACK_OnFilterScriptInit();
#endif

public OnFilterScriptExit()
{
    print("-----------------------------------------");
    print("   Android Check Include unloaded        ");
    print("-----------------------------------------");
	#if defined ACK_OnFilterScriptExit
		return ACK_OnFilterScriptExit();
	#else
        return 1;
    #endif
}

#if defined _ALS_OnFilterScriptExit
	#undef OnFilterScriptExit
#else
	#define _ALS_OnFilterScriptExit
#endif
#define OnFilterScriptExit ACK_OnFilterScriptExit
#if defined ACK_OnFilterScriptExit
	forward ACK_OnFilterScriptExit();
#endif

public OnGameModeInit()
{
    print("-----------------------------------------");
    print("   Android Check Include loaded          ");
    print("-----------------------------------------");
	#if defined ACK_OnGameModeInit
		return ACK_OnGameModeInit();
	#else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit ACK_OnGameModeInit
#if defined ACK_OnGameModeInit
	forward ACK_OnGameModeInit();
#endif

public OnGameModeExit()
{
    print("-----------------------------------------");
    print("   Android Check Include unloaded        ");
    print("-----------------------------------------");
	#if defined ACK_OnGameModeExit
		return ACK_OnGameModeExit();
	#else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif
#define OnGameModeExit ACK_OnGameModeExit
#if defined ACK_OnGameModeExit
	forward ACK_OnGameModeExit();
#endif


public OnPlayerConnect(playerid)
{
    #if USE_METHOD == 1
    for(new i = 0; i < 32; i++)
    {
        PhysFlags[playerid][Flags:i] = 0;
    }
    #elseif USE_METHOD == 2
    SendClientCheck(playerid, 0x48, 0, 0, 2);
    #elseif USE_METHOD == 3
    SendClientCheck(playerid, 0x46, 1598, 0, 28); // 1598 - beachball
    #elseif USE_METHOD == 4
    SendClientCheck(playerid, 0x47, 1598, 0, 48); // 1598 - beachball
    #endif

    SetTimerEx("OnCheckOS", 1500, false, "i", playerid);

	#if defined ACK_OnPlayerConnect
		return ACK_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect ACK_OnPlayerConnect
#if defined ACK_OnPlayerConnect
	forward ACK_OnPlayerConnect(playerid);
#endif

/**
    End hooking callbacks
 */

forward OnCheckOS(playerid);
public OnCheckOS(playerid)
    return ((!isPC[playerid]) ? (CallRemoteFunction("OnCheckOperatingSystem", "dd", playerid, 0)) : (0));

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
    #if USE_METHOD == 1
    if (actionid == 0x2) {
        // CPhysicalSAInterface
        // https://github.com/multitheftauto/mtasa-blue/blob/master/MTA10/game_sa/CPhysicalSA.h#L39-L73
        for(new i = 0; i < 32; i++)
            PhysFlags[playerid][Flags:i] = GetBit(memaddr, i);
        
        CallRemoteFunction("OnCheckOperatingSystem", "dd", playerid, ++isPC[playerid]);
    }
    #elseif USE_METHOD >= 2
    // 0x46 | CBaseModelInfoSAInterface
    // https://github.com/multitheftauto/mtasa-blue/blob/master/MTA10/game_sa/CModelInfoSA.h#L138-L181

    // 0x47 | CColModelSAInterface
    // https://github.com/multitheftauto/mtasa-blue/blob/master/MTA10/game_sa/CColModelSA.h#L87-L91
    if (actionid == 0x46 || actionid == 0x47 || actionid == 0x48)
        CallRemoteFunction("OnCheckOperatingSystem", "dd", playerid, ++isPC[playerid]);
    #endif
    return 1;
}

// SendClientCheck example script by evgen1137
// thanks to MTA devs for structs
