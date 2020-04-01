#include <a_samp>

#if !defined SendClientCheck
    native SendClientCheck(playerid, type, arg, offset, size);
#endif 

#if !defined OnClientCheckResponse
    forward OnClientCheckResponse(playerid, actionid, memaddr, retndata);
#endif


#define GetBit(%0,%1) ((%0 >> %1) & 1)
#pragma warning disable 239

//configuration
#define USE_METHOD 3 // 1 - 4

//Just to sure user not inserting the wrong configuration
#if USE_METHOD > 4 || USE_METHOD < 1
    #error USE_METHOD must contain 1 - 4
#endif

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

public OnFilterScriptInit()
{
    print("-----------------------------------------");
    print("    Android Check filterscript Loaded    ");
    print("-----------------------------------------");
    print("Usage: make a callback, example:         ");
    print("                                         ");
    print("forward OnCheckOperatingSystem(playerid);");
    print("public OnCheckOperatingSystem(playerid) {");
    print("    //your code below here               ");
    print("    return 1;                            ");
    print("}                                        ");
    print("                                         ");
    print("-----------------------------------------");
}

public OnFilterScriptExit()
{
    print("-----------------------------------------");
    print("   Android Check filterscript unloaded   ");
    print("-----------------------------------------");
}

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

    SetTimerEx(#OnCheckOS, 1500, false, "i", playerid);
    return 1;
}

forward OnCheckOS(playerid);
public OnCheckOS(playerid)
    return ((!isPC[playerid]) ? (CallRemoteFunction(#OnCheckOperatingSystem, "dd", playerid, 0)) : (0));

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{

    #if USE_METHOD == 1
    if (actionid == 0x2) {

        // CPhysicalSAInterface
        // https://github.com/multitheftauto/mtasa-blue/blob/master/MTA10/game_sa/CPhysicalSA.h#L39-L73
        for(new i = 0; i < 32; i++)
            PhysFlags[playerid][Flags:i] = GetBit(memaddr, i);
        
        CallRemoteFunction(#OnCheckOperatingSystem, "dd", playerid, ++isPC[playerid]);
    }
    #elseif USE_METHOD >= 2
    // 0x46 | CBaseModelInfoSAInterface
    // https://github.com/multitheftauto/mtasa-blue/blob/master/MTA10/game_sa/CModelInfoSA.h#L138-L181

    // 0x47 | CColModelSAInterface
    // https://github.com/multitheftauto/mtasa-blue/blob/master/MTA10/game_sa/CColModelSA.h#L87-L91
    if (actionid == 0x46 || actionid == 0x47 || actionid == 0x48)
        CallRemoteFunction(#OnCheckOperatingSystem, "dd", playerid, ++isPC[playerid]);
    #endif
    return 1;
}

// SendClientCheck example script by evgen1137
// thanks to MTA devs for structs
