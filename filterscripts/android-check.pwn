
#include <a_samp>

native SendClientCheck(playerid, type, arg, offset, size);
forward OnClientCheckResponse(playerid, type, arg, response);

#pragma warning disable 239

#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0

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

    SendClientCheck(playerid, 0x48, 0, 0, 2);
    return 1;
}

public OnClientCheckResponse(playerid, type, arg, response)
{
    switch(type)
    {       
        case 0x48:
        {
            SetPVarInt(playerid, "NotAndroid", 1);	
        }
    }
    return 1;
}

// SendClientCheck example script by evgen1137
// thanks to MTA devs for structs
