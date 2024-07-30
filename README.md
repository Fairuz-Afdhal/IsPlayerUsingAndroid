# WARNING
Some android clients has bypassed this function, please use [open.mp](https://www.open.mp/) IsPlayerUsingOfficialClient() function, you can use both at the same time.

## Installation
1. Load the filterscript
2. Put the define in your gamemode to make it easier
```pawn
#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0
```
 
## Usage 
The script may only be loaded as filterscript because SendClientCheck is only called when you do so, [read](https://github.com/Zeex/sampgdk/issues/124).
```pawn
public OnPlayerSpawn(playerid)
{
    if(IsPlayerAndroid(playerid))
        SendClientMessage(playerid, "You're connected from android");
 return 1;
}
```
