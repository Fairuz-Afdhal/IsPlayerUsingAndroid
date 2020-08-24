# IsPlayerAndroid
Check if a player is using android

## Installation
1. Load the filterscript
2. Put the define in your gamemode to make it easier
```pawn
#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0
```
 
## Usage 
```pawn
public OnPlayerSpawn( playerid )
{
 if ( IsPlayerAndroid(playerid) )
  SendClientMessage(playerid, "You're connected from android");
 return 1;
}
```

## Note
You may use it in another callback, but not OnPlayerConnect!
SendClientCheck and OnClientCheckResponse only works with filterscript, please see
https://github.com/Zeex/sampgdk/issues/124
