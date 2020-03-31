#include <a_samp>

native SendClientCheck(playerid, type, arg, offset, size);
forward OnClientCheckResponse(playerid, type, arg, response);

#define GetBit(%0,%1) ((%0 >> %1) & 1)
#pragma warning disable 239

            //One check is enough
//#define CHECK_0x2
#define CHECK_0x46
//#define CHECK_0x47
//#define CHECK_0x48
#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 1)

#if defined CHECK_0x2
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

public OnFilterScriptInit()
{
	print("Android check has been successfully loaded.");
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
    print(" Android check filterscript unloaded");
    print("--------------------------------------\n");
}

public OnPlayerConnect(playerid)
{
    new pName[MAX_PLAYER_NAME + 1 ];
    GetPlayerName(playerid, pName, sizeof(pName));
 
    #if defined CHECK_0x2
 	for(new i = 0; i < 32; i++)
	{
	    PhysFlags[playerid][Flags:i] = 0;
	}
    #endif

	SendClientCheck(playerid, 0x48, 0, 0, 2);
	SendClientCheck(playerid, 0x46, 1598, 0, 28); // 1598 - beachball
	SendClientCheck(playerid, 0x47, 1598, 0, 48); // 1598 - beachball
    
    return 1;
}

public OnClientCheckResponse(playerid, type, arg, response)
{
	new str[128], pName[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, pName, sizeof(pName));
    switch(type)
	{
	    #if defined CHECK_0x2
        case 0x2:
	    {
	        // CPhysicalSAInterface
			// https://github.com/multitheftauto/mtasa-blue/blob/master/MTA10/game_sa/CPhysicalSA.h#L39-L73
			for(new i = 0; i < 32; i++)
			{
			    PhysFlags[playerid][Flags:i] = GetBit(arg, i);
			}
			format(str, sizeof(str), "Player:%s bSubmergedInWater: %d, bOnSolidSurface: %d", pName, PhysFlags[playerid][bSubmergedInWater], PhysFlags[playerid][bOnSolidSurface]);
			printf(str);
        }
        #endif

        #if defined CHECK_0x46
 		case 0x46:
		{
		    // CBaseModelInfoSAInterface
		    // https://github.com/multitheftauto/mtasa-blue/blob/master/MTA10/game_sa/CModelInfoSA.h#L138-L181
		    format(str, sizeof(str), "Player:%s Model %d has checksum 0x%x", pName, arg, response);
			printf(str);
            SetPVarInt(playerid, "NotAndroid", 1);
        
        }
        #endif

        #if defined CHECK_0x47
	    case 0x47: 
		{
		    // CColModelSAInterface
		    // https://github.com/multitheftauto/mtasa-blue/blob/master/MTA10/game_sa/CColModelSA.h#L87-L91
		    format(str, sizeof(str), "Player:%s Col model %d has checksum 0x%x", pName, arg, response);
			printf(str);
            SetPVarInt(playerid, "NotAndroid", 1);
		}
        #endif

        #if defined CHECK_0x48        
		case 0x48:
		{
			format(str, sizeof(str), "Player:%s Your computer has been running for %d!", pName, arg);
			printf(str);
            SetPVarInt(playerid, "NotAndroid", 1);	
        }
        #endif
    }
	return 1;
}

// SendClientCheck example script by evgen1137
// thanks to MTA devs for structs
