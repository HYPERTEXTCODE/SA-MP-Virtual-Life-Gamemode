//-------------------------------------------------
//
//  NPC initialisation for Grand Larceny
//
//-------------------------------------------------

#pragma tabsize 0
#include <a_samp>
new bus;
new bus1;
new bus2;
//-------------------------------------------------

public OnFilterScriptInit()
{
	ConnectNPC("BusDriver","busroute1");
	ConnectNPC("BusDriver2","busroute2");
	ConnectNPC("BusDriver3","busroute3");

	bus = CreateVehicle(437, 0.0, 0.0, 5.0, 0.0, 3, 3, 5000);

	bus1 = CreateVehicle(437, 0.0, 0.0, 5.0, 0.0, 3, 3, 5000);

	bus2 = CreateVehicle(437, 0.0, 0.0, 5.0, 0.0, 3, 3, 5000);

	// Testing
	//ConnectNPC("OnfootTest","onfoot_test");
	//ConnectNPC("DriverTest","mat_test2");
	//ConnectNPC("DriverTest2","driver_test2");

	return 1;
}

//-------------------------------------------------
// IMPORTANT: This restricts NPCs connecting from
// an IP address outside this server. If you need
// to connect NPCs externally you will need to modify
// the code in this callback.

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid)) {
	    new ip_addr_npc[64+1];
	    new ip_addr_server[64+1];
	    GetServerVarAsString("bind",ip_addr_server,64);
	    GetPlayerIp(playerid,ip_addr_npc,64);

		if(!strlen(ip_addr_server)) {
		    ip_addr_server = "127.0.0.1";
		}

		if(strcmp(ip_addr_npc,ip_addr_server,true) != 0) {
		    // this bot is remote connecting
		    printf("NPC: Got a remote NPC connecting from %s and I'm kicking it.",ip_addr_npc);
		    Kick(playerid);
		    return 0;
		}
        printf("NPC: Connection from %s is allowed.",ip_addr_npc);
	}

	return 1;
}

//-------------------------------------------------



//-------------------------------------------------

stock SetVehicleTireStatus(vehicleid, tirestatus)
{
    new panels, doors, lights, tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tirestatus);
}

//-------------------------------------------------

public OnPlayerSpawn(playerid)
{
	if(!IsPlayerNPC(playerid)) return 1; // We only deal with NPC players in this script

	new playername[64];
	GetPlayerName(playerid,playername,64);

	if(!strcmp(playername,"BusDriver",true)) {
        PutPlayerInVehicle(playerid,bus,0);
        SetPlayerColor(playerid,0xFFFFFFFF);
 	}
    else if(!strcmp(playername,"BusDriver2",true)) {
        PutPlayerInVehicle(playerid,bus1,0);
        SetPlayerColor(playerid,0xFFFFFFFF);
 	}
 	else if(!strcmp(playername,"BusDriver3",true)) {
        PutPlayerInVehicle(playerid,bus2,0);
        SetPlayerColor(playerid,0xFFFFFFFF);
 	}

	return 1;
}


public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(IsPlayerInVehicle(playerid, bus))
	{
     GivePlayerMoney(playerid, -5);
	}
    else if(IsPlayerInVehicle(playerid, bus1))
	{
     GivePlayerMoney(playerid, -5);
	}
	else if(IsPlayerInVehicle(playerid, bus2))
	{
     GivePlayerMoney(playerid, -5);
	}
	
	return 1;
}
//-------------------------------------------------
// EOF



