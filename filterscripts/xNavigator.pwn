#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>

new 
	ok[MAX_PLAYERS],
	pNavState[MAX_PLAYERS],
	pNavID[MAX_PLAYERS],
	pNavTimer[MAX_PLAYERS],
	PlayerText:NAVpTD[MAX_PLAYERS],
	Text:NAVTD[2]
;

enum NAV_DATA {
    NAV_NAME[32],
    Float:NAV_X,
    Float:NAV_Y,
    Float:NAV_Z
};

new const NavData[][NAV_DATA] = { // save gps locations
	{"Los Venturas Airport", 1724.4327,1602.1609,10.0156}, //
	{"Los Venturas Railway Station", 2832.8657,1290.8403,10.4016}, //
	{"Los Venturas Police Department", 2287.1914,2427.6108,10.4452}, //
	{"Los Venturas Hospital", 1462.0088,2773.4712,10.3688}, //
	{"Los Venturas View Point", 1048.3199,2919.2104,51.6622}, //
	{"Los Venturas Bank", 2422.1689,1503.6080,10.8203}, //
	{"Los Venturas Mayor Building", 2024.9258,1918.0076,11.9641}, //
	{"Los Venturas Airport Parking", 1723.4642,1303.6382,10.4179}, //
	{"Los Venturas Public Garage", 2057.2224,2444.1162,10.4453}, //
	{"Los Santos Airport", 1679.3344,-2245.6677,13.5563}, //
	{"Los Santos Railway Station", 1714.9763,-1879.8632,13.5666}, //
	{"Los Santos Police Department", 1544.4080,-1675.1555,13.5583}, //
	{"Los Santos Hospital", 1182.5630,-1323.7290,13.5791}, //
	{"Los Santos Beach View Point", 836.7003,-2057.0398,12.8672},
	{"Los Santos Bank", 1462.4419,-1022.3757,23.8281},
	{"Los Santos VineWood View Point", 1376.0093,-861.8572,41.2136},
	{"Los Santos Mayor Building", 1480.4103,-1742.5662,13.5469},
	{"San Fierro Airport", -1543.9722,-429.0924,5.8516},
	{"San Fierro Railway Station", -1989.0590,137.7391,27.5391},
	{"San Fierro Police Department", -1703.3593,683.8533,24.8906}
};

#if defined FILTERSCRIPT
public OnFilterScriptInit()
{

	print("\n+----------------------------------------------------+");
	print("|                                                    |");
	print("|      Manjal Maanagaram GPS System Loadedw");
	print("|                                      by Aadhi    ");
	print("|                                                    |");
	print("+----------------------------------------------------+\n");

	NAVTD[0] = TextDrawCreate(404.319183, 409.916809, "Yuti");
	TextDrawLetterSize(NAVTD[0], 0.000000, 1.941436);
	TextDrawTextSize(NAVTD[0], 498.000000, 0.000000);
	TextDrawAlignment(NAVTD[0], 1);
	TextDrawColor(NAVTD[0], -1);
	TextDrawUseBox(NAVTD[0], 1);
	TextDrawBoxColor(NAVTD[0], 100);
	TextDrawSetShadow(NAVTD[0], 0);
	TextDrawSetOutline(NAVTD[0], 0);
	TextDrawBackgroundColor(NAVTD[0], 255);
	TextDrawFont(NAVTD[0], 1);
	TextDrawSetProportional(NAVTD[0], 1);
	TextDrawSetShadow(NAVTD[0], 0);

	NAVTD[1] = TextDrawCreate(404.787597, 399.999847, "Navigation info");
	TextDrawLetterSize(NAVTD[1], 0.299736, 1.115833);
	TextDrawAlignment(NAVTD[1], 1);
	TextDrawColor(NAVTD[1], -5963521);
	TextDrawSetShadow(NAVTD[1], 1);
	TextDrawSetOutline(NAVTD[1], 0);
	TextDrawBackgroundColor(NAVTD[1], 255);
	TextDrawFont(NAVTD[1], 0);
	TextDrawSetProportional(NAVTD[1], 1);
	TextDrawSetShadow(NAVTD[1], 1);
	return 1;
}
#endif

public OnPlayerConnect(playerid)
{
	NAVpTD[playerid] = CreatePlayerTextDraw(playerid, 405.724487, 415.166564, "Distance Left: ~y~0000.00m");
	PlayerTextDrawLetterSize(playerid, NAVpTD[playerid], 0.179326, 1.109999);
	PlayerTextDrawAlignment(playerid, NAVpTD[playerid], 1);
	PlayerTextDrawColor(playerid, NAVpTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, NAVpTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, NAVpTD[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, NAVpTD[playerid], 255);
	PlayerTextDrawFont(playerid, NAVpTD[playerid], 2);
	PlayerTextDrawSetProportional(playerid, NAVpTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, NAVpTD[playerid], 0);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(pNavState[playerid])
	{
		KillTimer(pNavTimer[playerid]);
		DestroyObject(ok[playerid]);
		DisablePlayerCheckpoint(playerid);
		pNavState[playerid] = 0;
	}
	return 1;
}

CMD:gps(playerid, params[])
{
	static string[sizeof(NavData) * 64];

	if (string[0] == EOS) 
	{
		for (new i; i < sizeof(NavData); i++) 
		{
			format(string, sizeof string, "%s{f4a442}» {f7f5bb}%s\n", string, NavData[i][NAV_NAME]);
		}
	} 
	ShowPlayerDialog(playerid, 112, DIALOG_STYLE_LIST, "GPS SYSTEM", string, "Choose", "Cancel");
	return 1;
}

CMD:closegps(playerid, params[])
{
	if(pNavState[playerid])
	{
		KillTimer(pNavTimer[playerid]);
		DestroyObject(ok[playerid]);
		for(new i; i<sizeof(NAVTD); i++) TextDrawHideForPlayer(playerid, NAVTD[i]);
		PlayerTextDrawHide(playerid, NAVpTD[playerid]);	
		PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
		DisablePlayerCheckpoint(playerid);
		pNavState[playerid] = 0;
		SendClientMessage(playerid, -1, "{FF0000}<!> GPS Closed!");
	} else SendClientMessage(playerid, -1, "{FF0000}<!> You are not in the Vehicle");
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(pNavState[playerid])
	{
		KillTimer(pNavTimer[playerid]);
		DestroyObject(ok[playerid]);
		for(new i; i<sizeof(NAVTD); i++) TextDrawHideForPlayer(playerid, NAVTD[i]);
		PlayerTextDrawHide(playerid, NAVpTD[playerid]);	
		PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
		DisablePlayerCheckpoint(playerid);
		pNavState[playerid] = 0;
		SendClientMessage(playerid, -1, "{FF0000}<!> Navigacia gauqmebulia rata manqanashi ar xart!");
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 112)
	{
		if(response)
		{
			pNavID[playerid] = listitem;
			new str[128];
			SetPlayerCheckpoint(playerid, NavData[pNavID[playerid]][NAV_X], NavData[pNavID[playerid]][NAV_Y], NavData[pNavID[playerid]][NAV_Z], 3.0);
			format(str, 128, "{00FF00}<!> Your Destination is set to {FFA500}%s", NavData[pNavID[playerid]][NAV_NAME]);
			SendClientMessage(playerid, -1, str);
			SendClientMessage(playerid, -1, "{00FF00}<!> Type {FF7D0A}/closegps {00FF00}to turnoff GPS.");
			if(IsValidObject(ok[playerid])) DestroyObject(ok[playerid]);
			ok[playerid] = CreateObject(19134, 0, 0, 0, 0, 0, 0);
			Refresh(playerid);
			KillTimer(pNavTimer[playerid]);
			pNavTimer[playerid] = SetTimerEx("Refresh", 100, true, "d", playerid);
			for(new i; i<sizeof(NAVTD); i++) TextDrawShowForPlayer(playerid, NAVTD[i]);
			PlayerTextDrawShow(playerid, NAVpTD[playerid]);
			PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
			pNavState[playerid] = 1;
		}
	}
	return 1;
}

stock Float:PointAngle(playerid, Float:xa, Float:ya, Float:xb, Float:yb) // Don't know the owner.
{
	new Float:carangle;
	new Float:xc, Float:yc;
	new Float:angle;
	xc = floatabs(floatsub(xa,xb));
	yc = floatabs(floatsub(ya,yb));
	if (yc == 0.0 || xc == 0.0)
	{
		if(yc == 0 && xc > 0) angle = 0.0;
		else if(yc == 0 && xc < 0) angle = 180.0;
		else if(yc > 0 && xc == 0) angle = 90.0;
		else if(yc < 0 && xc == 0) angle = 270.0;
		else if(yc == 0 && xc == 0) angle = 0.0;
	}
	else
	{
		angle = atan(xc/yc);
		if(xb > xa && yb <= ya) angle += 90.0;
		else if(xb <= xa && yb < ya) angle = floatsub(90.0, angle);
		else if(xb < xa && yb >= ya) angle -= 90.0;
		else if(xb >= xa && yb > ya) angle = floatsub(270.0, angle);
	}
	GetVehicleZAngle(GetPlayerVehicleID(playerid), carangle);
	return floatadd(angle, -carangle);
}

forward Refresh(playerid);
public Refresh(playerid)
{
	new Float:pos[3], Float:pPos[3];
	pPos[0] = NavData[pNavID[playerid]][NAV_X];
	pPos[1] = NavData[pNavID[playerid]][NAV_Y];
	pPos[2] = NavData[pNavID[playerid]][NAV_Z];
	GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
	new Float:rot = PointAngle(playerid, pos[0], pos[1], pPos[0], pPos[1]);
	AttachObjectToVehicle(ok[playerid], GetPlayerVehicleID(playerid), 0.000000, 0.000000, 1.399998, 0.000000, 90.0, rot + 180);
	new Float:mesafe, str[32];
	mesafe = GetPlayerDistanceFromPoint(playerid, pPos[0], pPos[1], pPos[2]);
	format(str, sizeof(str), "Distance Left: ~y~%0.2fm", mesafe);
	PlayerTextDrawSetString(playerid, NAVpTD[playerid], str);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, pPos[0], pPos[1], pPos[2]))
	{
		KillTimer(pNavTimer[playerid]);
		DestroyObject(ok[playerid]);
		for(new i; i<sizeof(NAVTD); i++) TextDrawHideForPlayer(playerid, NAVTD[i]);
		PlayerTextDrawHide(playerid, NAVpTD[playerid]);	
		DisablePlayerCheckpoint(playerid);
		PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
		pNavState[playerid] = 0;
		SendClientMessage(playerid, -1, "{00FF00}<!> You have reached the destination");
	}
	return 1;
}
