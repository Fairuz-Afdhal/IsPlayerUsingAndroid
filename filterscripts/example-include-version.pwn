#include <a_samp>
#include <android-check>

public OnFilterScriptInit(){
    printf("Loaded example android-check filterscripts.");
    return 1;
}

public OnFilterScriptExit(){
    printf("Unload example android-check filterscripts.");
    return 1;
}

public OnPlayerConnect(playerid)
{
    printf("Server will check if you using android or not.");
    return 1;
}

public OnCheckOperatingSystem(playerid, OSType){
    if(OSType == OS_TYPE_ANDROID)
        // Do more stuff - if player using android
        printf("Player with id %d is using android", playerid);
    else{
        // Do more stuff - if player not using android
        printf("Player with id %d is using not using android", playerid);  
    }
    return 1;
}