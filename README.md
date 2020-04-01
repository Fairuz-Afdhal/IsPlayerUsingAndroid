# OnCheckOperatingSystem
A filterscript that checks if a player is using android, forked from and work alongside samp-stdlib (sampctl)

## Installation
1. Load the filterscript
1. Put this somewhere to your gamemode
 
```pawn
#define OS_TYPE_ANDROID 0
#define OS_TYPE_PC 1

forward OnCheckOperatingSystem(playerid, OSType);
public OnCheckOperatingSystem(playerid, OSType) {
    return 1;
}
```

## Usage
```pawn
#define OS_TYPE_ANDROID 0
#define OS_TYPE_PC 1

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
