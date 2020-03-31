# OnCheckOperatingSystem
A filterscript that checks if a player is using android, forked from [Fairuz-Afdhal/IsPlayerUsingAndroid](https://github.com/Fairuz-Afdhal/IsPlayerUsingAndroid) and work alongside samp-stdlib (sampctl)

## Installation
1. Load the filterscript
1. Put this to your gamemode
 
```pawn
forward OnCheckOperatingSystem(playerid, OSType);
public OnCheckOperatingSystem(playerid, OSType) {
    if (OSType == OS_TYPE_PC)  {
        print("Kicking player!");
        Kick(playerid);
    }
    else {
        print("Safe!");
    }
    return 1;
}
```
