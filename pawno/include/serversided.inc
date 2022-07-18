/*
	Server sided stats Include (serversided.inc)
    * Protects from hacks of such like Score & Money only!

	Author: (creator)
 	* Gammix

	(c) Copyright 2015
  	* This file is provided as is (no warranties).
*/

static bool:g_Toggle_Updating[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
	SetPVarInt(playerid, "SERVER_SIDED_MONEY", 0);
	SetPVarInt(playerid, "SERVER_SIDED_SCORE", 0);

	if(GetPVarType(playerid, "SERVER_SIDED_UPDATING") == PLAYER_VARTYPE_NONE)
	{
	    g_Toggle_Updating[playerid] = true;
	    SetPVarInt(playerid, "SERVER_SIDED_UPDATING", 1);
	}
	else
	{
	    g_Toggle_Updating[playerid] = false;
	}

	#if defined SS_OnPlayerConnect
       	return SS_OnPlayerConnect(playerid);
	#else
	   	return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect SS_OnPlayerConnect
#if defined SS_OnPlayerConnect
    forward SS_OnPlayerConnect(playerid);
#endif

public OnPlayerUpdate(playerid)
{
	if(g_Toggle_Updating[playerid])
	{
		//server sided money
	 	if(GetPVarInt(playerid, "SERVER_SIDED_MONEY") != GetPlayerMoney(playerid))
		{
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, GetPVarInt(playerid, "SERVER_SIDED_MONEY"));
		}

		//server sided score
		if(GetPVarInt(playerid, "SERVER_SIDED_SCORE") != GetPlayerScore(playerid))
		{
			SetPlayerScore(playerid, GetPVarInt(playerid, "SERVER_SIDED_SCORE"));
		}
	}

    #if defined SS_OnPlayerUpdate
       	return SS_OnPlayerUpdate(playerid);
	#else
	   	return 1;
	#endif
}
#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate SS_OnPlayerUpdate
#if defined SS_OnPlayerUpdate
    forward SS_OnPlayerUpdate(playerid);
#endif

//server sided money - hooked functions
stock SS_GetPlayerMoney(playerid)
{
	return GetPVarInt(playerid, "SERVER_SIDED_MONEY");
}
#if defined _ALS_GetPlayerMoney
    #undef GetPlayerMoney
#else
    #define _ALS_GetPlayerMoney
#endif
#define GetPlayerMoney SS_GetPlayerMoney

stock SS_GivePlayerMoney(playerid, money)
{
    SetPVarInt(playerid, "SERVER_SIDED_MONEY", (GetPVarInt(playerid, "SERVER_SIDED_MONEY") + money));
	return GivePlayerMoney(playerid, money);
}
#if defined _ALS_GivePlayerMoney
    #undef GivePlayerMoney
#else
    #define _ALS_GivePlayerMoney
#endif
#define GivePlayerMoney SS_GivePlayerMoney

stock SS_ResetPlayerMoney(playerid)
{
    SetPVarInt(playerid, "SERVER_SIDED_MONEY", 0);
    return ResetPlayerMoney(playerid);
}
#if defined _ALS_ResetPlayerMoney
    #undef ResetPlayerMoney
#else
    #define _ALS_ResetPlayerMoney
#endif
#define ResetPlayerMoney SS_ResetPlayerMoney

//server sided score - hooked functions
stock SS_GetPlayerScore(playerid)
{
	return GetPVarInt(playerid, "SERVER_SIDED_SCORE");
}
#if defined _ALS_GetPlayerScore
    #undef GetPlayerScore
#else
    #define _ALS_GetPlayerScore
#endif
#define GetPlayerScore SS_GetPlayerScore

stock SS_SetPlayerScore(playerid, score)
{
    SetPVarInt(playerid, "SERVER_SIDED_SCORE", score);
	return SetPlayerScore(playerid, score);
}
#if defined _ALS_SetPlayerScore
    #undef SetPlayerScore
#else
    #define _ALS_SetPlayerScore
#endif
#define SetPlayerScore SS_SetPlayerScore