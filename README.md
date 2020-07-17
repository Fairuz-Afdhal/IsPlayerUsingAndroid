# OnCheckOperatingSystem
Check if a player is using android, forked from and work alongside samp-stdlib (sampctl)

# Include Version
## Installation
1. Put this into your `pawno/include` folder
2. Add to the top of your scripts `#include <android-check>`

## Usage
Do some stuff, depends on players `OSType`
```pawn
 public OnCheckOperatingSystem(playerid, OSType){
     if(OSType == OS_TYPE_ANDROID)
        printf("Player with id %d is using android", playerid);
     else
        printf("Player with id %d is using not using android", playerid);     
     return 1;
 }
```

## Definition
```pawn
#define OS_TYPE_ANDROID 0
#define OS_TYPE_PC 1
```

## Notes
> **Notice that you no longer needs filterscripts version if you already use this one.**


# Filterscript Version
## Installation
1. Load the filterscript
2. Put this somewhere to your gamemode
 
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
