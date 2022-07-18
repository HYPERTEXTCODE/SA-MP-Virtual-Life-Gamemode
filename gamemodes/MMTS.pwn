/*******************************************************************************

						MANJAL MAANAGARAM TEST SERVER

*******************************************************************************/
#include <a_samp>
#include <streamer>
#include <sscanf2>
#include <zcmd>
//#include <YSI\y_ini>
#include <dini>

//#include <dudb>
//#include <dutils>

//----------------------------------------------------------------------------//
#define Register 0
#define Logged 1
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
new pTeam[MAX_PLAYERS]; // This variable is used to store player team
new onTeam[MAX_PLAYERS];
//pdvehicle mod
new pvehicle;
new pvehicle1;
new pvehicle2;
new pvehicle3;
new pvehicle4;
new pvehicle5;
new pvehicle6;
new pvehicle7;
new pvehicle8;
new pvehicle9;
new pvehicle10;

//jobtruck mod
new truck1;
new truck2;
new truck3;
new truck4;
new truck5;
new truck6;
new truck7;
new truck8;


//==========TEAM DEFINES==========
#define team_civ    			1   //To Design team Civilians
#define team_mmpd   			2   //To Design team Police Department
#define team_admins 			3   //To Design team Admins
#define team_ems  				4   //To Design team Emergency Department
#define team_mech   			5   //To Design team Mechanic
#define team_vdfuels    		6   //To Design team Vdfuels
#define team_pwautodealers      7   //To Design team pwautodealership


#define state_vdonduty       	8   //To Design team Vdonduty
#define state_vdoffduty       	9   //To Design team Vdonduty
//----------------------------------------------------------------------------//

//colors
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x007700AA
#define COLOR_LIGHTGREEN 0x00FF00AA
#define COLOR_DARKGREEN 0x004400AA
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define BBLUE 0x00BFFFAA
#define COLOR_LIGHTBLUE 0x1C86EEAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BRIGHTRED 0xB22222
#define COLOR_SILVER 0xDDDDDDFF




//------------------------------------------------------------------------------



new Login[MAX_PLAYERS];
new EShutter;
new EGate;
new Shutter;
new Trucker[256];
new vdtruck[256];
new t1;
new t2;
new t3;
new t4;
new t5;
new t6;
new t7;
new t8;
new t9;
new t10;
new Trucking[256];

new vdgate1;
new vdgate2;
new duty;




//=======VD TRUCKS=======//





//=====KAALA=====//
new kaalalandstalkergarage;
new kaalaremingtongarage;
new kaalastretchgarage;
new kaalahotknifegarage;
//===============//

//=====Willsmith=====//
new willsmithhuntleygarage;
//===================//

//====Donaldpump=====//
new donaldpumpstretchgarage;
//===================//

//======ironman=======//
new ironmansultangarage;
new ironmanzr350garage;
new ironmaneurosgarage;
new ironmanbf400garage;
new ironmanhotknifegarage;
//====================//

//====Mrblaza======//
new mrblazabuffalogarage;
new mrblazazr350garage;
//==================//

//==========Mrrohith=============//
new mrrohithbuffalogarage;
//=======================//
//================================prison========================================
new PGate;
new PShutter;
new PCell1;
new PCell2;
new PCell3;
new PCell4;
//--------------------------------ENGINE---------------------------------------
//new Engine[MAX_VEHICLES];

#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
//-----------------------------------------------------------------------------
new Sendloc[MAX_PLAYERS];

//license
//new vehiclelicense;
//new heavylicense;


//------------------------------TEXT DRAW---------------------------------
new Text:Textdraw0;
new Text:Textdraw1;
//------------------------------------------------------------------------

//======================Speedometer with fuel system======================
new PlayerText:SPEEDOMETER[MAX_PLAYERS][10];

new carfuel[MAX_VEHICLES] = {100, ...}; // connect this with your own vehicle fuel code (if you have one)
forward timer_fuel_lower(); //timer for lowering the fuel value
forward timer_refuel(playerid); //timer to refuel vehicle
new isrefuelling[MAX_PLAYERS] = 0; //bool to check if player is already refuelling

new PlayerSpeedo[MAX_PLAYERS]; // 0 = KM/H, 1 = MP/H
//========================================================================

enum PInfo
{
    pHurt,
    pDraggedBy
}

new PlayerInfo[MAX_PLAYERS][PInfo];


forward CheckGate();

//----------------------------------VD FUELS--------------------------------------


//========================================================================

main()
{
	print("\n----------------------------");
	print("Manjal Maanagaram RolePlay 2021");
	print("=========Version.1.0=========");
	print("======Scripted by AADHI & Co======");
	print("------------------------------\n");
}


public OnGameModeInit()
{
	SetGameModeText("MMTS");

    SetWorldTime(12);

	EGate    = CreateObject(19912, 2294.73, 2502.78, 5.09,   0.00, 0.00, 89.42); // pd gate 1
	EShutter = CreateObject(2938, 2334.80, 2443.55, 7.42,   0.00, 0.00, 330.00); //pd shutter

	Shutter	 = CreateObject(11319, 2057.29, 2437.43, 12.62,   0.00, 0.00, 90.65); //parking shutter

    CreateObject(3851, 2066.34, 2437.44, 11.84,   0.00, 0.00, 269.94); //glassparkingshed
    
   	AddPlayerClass(1,1690.6682,1451.0737,10.7661,265.7809,0,0,0,0,0,0); // truth spawn
   
    
	AddStaticVehicle(438,1764.0137,-1863.6029,13.5799,0.5902,6,76); // ls taxi 1
	AddStaticVehicle(438,1767.3678,-1863.5527,13.5783,1.8830,6,76); // ls taxi 2
	AddStaticVehicle(438,1773.5908,-1863.6615,13.5783,1.4652,6,76); // ls taxi 4
	AddStaticVehicle(438,1770.3940,-1863.6864,13.6033,359.9071,6,76); // ls taxi 3
	AddStaticVehicle(438,1776.7084,-1863.6991,13.5770,359.3971,6,76); // ls taxi 5
	AddStaticVehicle(420,1672.8986,1297.5594,10.5859,180.4153,6,1); // lv taxi 1
	AddStaticVehicle(420,1663.5204,1306.4749,10.6058,359.9128,6,1); // lv taxi 2
	AddStaticVehicle(420,1666.6897,1297.7288,10.5999,179.6729,6,1); // lv taxi 3
	AddStaticVehicle(420,1670.0286,1305.7887,10.6763,9.0431,6,1); // lv taxi 4
	AddStaticVehicle(420,1679.2332,1297.6083,10.5991,180.1223,6,1); // lv taxi 5
	AddStaticVehicle(420,1676.2987,1306.5297,10.5876,359.6444,6,1); // lv taxi 6
	AddStaticVehicle(420,1682.8677,1306.5065,10.5981,359.6553,6,1); // lv taxi 7
    AddStaticVehicle(601,2240.3301,2471.2007,-7.6943,269.3290,1,1); // lv swat 1
	AddStaticVehicle(601,2240.3545,2475.6694,-7.6943,269.4935,1,1); // lv swat 2
	AddStaticVehicle(601,2240.1777,2442.3459,-7.6943,270.3445,1,1); // lv swat 4
	AddStaticVehicle(601,2240.2166,2446.5869,-7.6937,271.4826,1,1); // lv swat 3

	pvehicle = AddStaticVehicle(596,2297.2031,2451.9146,2.9948,269.1164,0,1); // lv pd 1
	AddVehicleComponent(pvehicle, 1010);
	ChangeVehicleColor(pvehicle, 198, 194);

	pvehicle1 = AddStaticVehicle(596,2314.8577,2480.3110,2.9937,90.6751,0,1); // lv pd 2
 	AddVehicleComponent(pvehicle1, 1010);
	ChangeVehicleColor(pvehicle1, 198, 194);

	pvehicle2 = AddStaticVehicle(596,2297.4573,2460.1641,2.9981,268.6782,0,1); // lv pd 3
	AddVehicleComponent(pvehicle2, 1010);
	ChangeVehicleColor(pvehicle2, 198, 194);

	pvehicle3 = AddStaticVehicle(596,2315.3511,2499.8992,2.9907,91.0742,0,1); // lv pd 4
	AddVehicleComponent(pvehicle3, 1010);
	ChangeVehicleColor(pvehicle3, 198, 194);

	pvehicle4 = AddStaticVehicle(599,2314.9658,2494.9224,3.4665,88.0032,0,1); // lv pd 5
	AddVehicleComponent(pvehicle4, 1010);
	ChangeVehicleColor(pvehicle4, 198, 194);

	pvehicle5 = AddStaticVehicle(596,2314.8779,2490.4907,2.9967,89.5492,0,1); // lv pd 6
	AddVehicleComponent(pvehicle5, 1010);
	ChangeVehicleColor(pvehicle5, 198, 194);

	pvehicle6 = AddStaticVehicle(599,2314.4370,2484.8420,3.4628,89.1804,0,1); // lv pd 7
	AddVehicleComponent(pvehicle6, 1010);
	ChangeVehicleColor(pvehicle6, 198, 194);

	pvehicle7 = AddStaticVehicle(427,2259.7947,2430.6455,3.4054,0.1167,0,1); // enf 1
	AddVehicleComponent(pvehicle7, 1010);
	ChangeVehicleColor(pvehicle7, 198, 194);

	pvehicle8 = AddStaticVehicle(427,2268.6101,2430.7952,3.4053,1.1488,0,1); // enf 2
	AddVehicleComponent(pvehicle8, 1010);
	ChangeVehicleColor(pvehicle8, 198, 194);

	pvehicle9 = AddStaticVehicle(427,2250.7607,2431.3152,3.4096,355.0013,0,1); // enf 3
	AddVehicleComponent(pvehicle9, 1010);
	ChangeVehicleColor(pvehicle9, 198, 194);

	pvehicle10 = AddStaticVehicle(427,2286.3110,2431.7273,3.4052,358.1365,0,1); // enf 4
	AddVehicleComponent(pvehicle10, 1010);
 	ChangeVehicleColor(pvehicle10, 198, 194);
	
    AddStaticVehicle(449,-1944.3750,118.0765,26.1223,0.0000,1,74); // lf tram 1
	AddStaticVehicle(416,1465.4933,2841.7771,10.9697,179.1827,1,3); // lv amb
	AddStaticVehicle(416,1474.3590,2841.8652,10.9715,178.8992,1,3); // lv amb 2
	AddStaticVehicle(538,2864.7500,1270.6456,11.2473,0.0000,1,74); //lv train1
	AddStaticVehicle(570,2837.2024,1148.8896,11.2473,153.7840,1,74); // train potti
	//IN GAME VIEW
	
	
	//load truck job vehicles
	truck1 = AddStaticVehicle(403,1430.7604,974.9589,11.4257,0.3983,37,1); // t1
	ChangeVehicleColor(truck1, 6, 40);
	truck2 = AddStaticVehicle(403,1435.0698,975.0382,11.4238,1.1450,37,1); // t2
	ChangeVehicleColor(truck2, 6, 40);
	truck3 = AddStaticVehicle(403,1439.3896,975.1854,11.4229,1.1719,37,1); // t3
    ChangeVehicleColor(truck3, 6, 40);
	truck4 = AddStaticVehicle(403,1443.5145,975.2764,11.4227,0.2250,37,1); // t4
    ChangeVehicleColor(truck4, 6, 40);
	truck5 = AddStaticVehicle(403,2346.2903,2770.6638,11.4284,270.3843,28,1); // t5
    ChangeVehicleColor(truck5, 6, 40);
	truck6 = AddStaticVehicle(403,2346.2461,2763.9377,11.4261,271.1401,40,1); // t6
    ChangeVehicleColor(truck6, 6, 40);
	truck7 = AddStaticVehicle(403,2346.1636,2754.3896,11.4258,270.2545,101,1); // t7
    ChangeVehicleColor(truck7, 6, 40);
	truck8 = AddStaticVehicle(403,2346.2014,2747.7810,11.4259,269.5419,25,1); // t8
    ChangeVehicleColor(truck8, 6, 40);
	
	
	CreateObject(11313, 2103.35, 2376.54, 20.32,   0.00, 0.00, 359.90); //public garage block 1
	CreateObject(11313, 2103.24, 2371.72, 20.32,   0.00, 0.00, 359.90); //public garage block 2
	
	
	
	

	

//----------------------------------TEXT DRAW-----------------------------------
	Textdraw0 = TextDrawCreate(391.999938, 4.480785, "Manjal Maanagaram");
	TextDrawLetterSize(Textdraw0, 0.449999, 1.600000);
	TextDrawAlignment(Textdraw0, 1);
	TextDrawColor(Textdraw0, -65281);
	TextDrawSetShadow(Textdraw0, 0);
	TextDrawSetOutline(Textdraw0, 1);
	TextDrawBackgroundColor(Textdraw0, 51);
	TextDrawFont(Textdraw0, 0);
	TextDrawSetProportional(Textdraw0, 1);

	Textdraw1 = TextDrawCreate(504.000000, 6.720054, "RolePlay");
	TextDrawLetterSize(Textdraw1, 0.449999, 1.600000);
	TextDrawAlignment(Textdraw1, 1);
	TextDrawColor(Textdraw1, -1);
	TextDrawSetShadow(Textdraw1, 0);
	TextDrawSetOutline(Textdraw1, 1);
	TextDrawBackgroundColor(Textdraw1, 51);
	TextDrawFont(Textdraw1, 0);
	TextDrawSetProportional(Textdraw1, 1);

//------------------------------------------------------------------------------

//---------------------------------TRUCKER------------------------------------//

	Trucking[0] = CreateVehicle(428,-44.6190,-1155.5164,1.2519,64.7519,-1,-1,5); //Trucking Car 1
	Trucking[1] = CreateVehicle(428,-42.9047,-1151.9404,1.2517,64.0807,-1,-1,5); //Trucking Car 2
    Trucking[2] = CreateVehicle(428,-41.1424,-1148.3170,1.2518,63.6309,-1,-1,5); //Trucking Car 3
    Trucking[3] = CreateVehicle(428,-39.3955,-1144.7775,1.2519,62.9386,-1,-1,5); //Trucking Car 4
    Trucking[4] = CreateVehicle(428,-37.5739,-1141.0938,1.2513,62.9641,-1,-1,5); //Trucking Car 5
   
//----------------------------------------------------------------------------//

	LimitGlobalChatRadius(20.0);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_STREAMED);
	LimitPlayerMarkerRadius(500.0);
	SetNameTagDrawDistance(15.0);
	ShowNameTags(1);
//-----------------------------------------------------------------------------//

//PRISON
	CreateObject(8154, 163.07, 1705.61, 18.82,   0.00, 0.00, 0.12);
	CreateObject(8154, 148.00, 1769.13, 18.88,   0.00, 0.00, 90.14);
	CreateObject(8154, 78.04, 1689.81, 18.82,   0.00, 0.00, 270.86);
	CreateObject(8154, 62.61, 1753.69, 18.82,   0.00, 0.00, 180.24);
	CreateObject(986, 93.76, 1795.65, 18.32,   0.00, 0.00, 0.00);
	CreateObject(985, 101.67, 1795.66, 18.31,   0.00, 0.00, 0.00);
	CreateObject(3279, 180.45, 1788.23, 16.82,   0.00, 0.00, 0.00);
	CreateObject(3279, 47.37, 1787.33, 16.82,   0.00, 0.00, 0.00);
	CreateObject(3279, 182.17, 1672.77, 16.82,   0.00, 0.00, 0.00);
	CreateObject(3279, 46.41, 1673.88, 16.82,   0.00, 0.00, 0.00);
	CreateObject(8240, 114.89, 1728.40, 30.12,   0.00, 0.00, 269.81);
	CreateObject(19362, 82.97, 1756.67, 18.08,   90.00, 0.00, 270.32);
	CreateObject(19362, 83.06, 1756.67, 20.92,   90.00, 0.00, 270.32);
	CreateObject(19362, 85.54, 1756.67, 18.08,   90.00, 0.00, 270.32);
	CreateObject(19362, 85.72, 1756.66, 20.82,   90.00, 0.00, 270.32);
	CreateObject(16208, -36.53, 1721.22, 26.20,   0.00, 0.00, 0.00);
	CreateObject(16208, -36.53, 1721.22, 26.20,   0.00, 0.00, 0.00);
	CreateObject(16208, -36.53, 1721.22, 26.20,   0.00, 0.00, 0.00);
	CreateObject(19303, 88.16, 1756.67, 17.90,   0.00, 0.00, 0.00);
	PCell1 = CreateObject(19303, 89.89, 1756.68, 17.91,   0.00, 0.00, 0.00); // Pricon Cell 1 gate
	CreateObject(19362, -146.26, 199.59, 20.82,   90.00, 0.00, 270.32);
	CreateObject(19362, 89.15, 1756.72, 20.82,   90.00, 0.00, 270.32);
	CreateObject(19362, 85.72, 1756.66, 20.92,   90.00, 0.00, 270.32);
	CreateObject(19362, 89.14, 1756.73, 20.92,   90.00, 0.00, 270.62);
	CreateObject(19362, 89.12, 1757.40, 20.72,   90.00, 0.00, 270.32);
	CreateObject(19362, 90.86, 1758.28, 18.21,   0.00, 0.00, 0.00);
	CreateObject(19362, 90.84, 1761.12, 18.22,   0.00, 0.00, 0.00);
	CreateObject(2603, 90.16, 1759.96, 17.00,   0.00, 0.00, 0.15);
	CreateObject(2528, 83.83, 1761.03, 16.63,   0.00, 0.00, 0.58);
	CreateObject(19362, 90.81, 1758.31, 20.74,   0.00, 0.00, 0.00);
	CreateObject(19362, 90.82, 1761.32, 20.74,   0.00, 0.00, 0.00);
	CreateObject(19362, 83.30, 1758.40, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 86.78, 1758.41, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 89.16, 1758.28, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 89.15, 1760.88, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 85.72, 1760.86, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 83.31, 1760.82, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 92.65, 1756.77, 18.08,   90.00, 0.00, 270.32);
	CreateObject(19362, 96.14, 1756.79, 18.08,   90.00, 0.00, 270.32);
	CreateObject(19362, 92.65, 1756.77, 20.91,   90.00, 0.00, 270.32);
	CreateObject(19362, 96.14, 1756.79, 20.91,   90.00, 0.00, 270.32);
	CreateObject(19303, 98.72, 1756.72, 17.90,   0.00, 0.00, 0.00);
	PCell2 = CreateObject(19303, 100.46, 1756.73, 17.91,   0.00, 0.00, 0.00); // Prison Cell 2 gate
	CreateObject(19362, 99.51, 1756.82, 20.91,   90.00, 0.00, 270.32);
	CreateObject(19362, 99.51, 1756.82, 20.71,   90.00, 0.00, 270.32);
	CreateObject(19362, 99.61, 1756.83, 20.71,   90.00, 0.00, 270.32);
	CreateObject(19362, 99.61, 1756.83, 20.91,   90.00, 0.00, 270.32);
	CreateObject(19362, 101.28, 1758.36, 18.21,   0.00, 0.00, 0.00);
	CreateObject(19362, 101.28, 1761.07, 18.21,   0.00, 0.00, 0.00);
	CreateObject(19362, 101.28, 1758.36, 20.76,   0.00, 0.00, 0.00);
	CreateObject(19362, 101.28, 1761.29, 20.76,   0.00, 0.00, 0.00);
	CreateObject(2528, 92.66, 1761.30, 16.63,   0.00, 0.00, 0.00);
	CreateObject(2603, 100.56, 1759.69, 17.00,   0.00, 0.00, 0.00);
	CreateObject(19362, 92.65, 1758.32, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 92.63, 1760.95, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 96.10, 1758.33, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 96.10, 1760.84, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 99.58, 1758.36, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 99.53, 1760.68, 22.42,   0.00, 90.00, 0.00);
	CreateObject(19362, 103.06, 1756.84, 18.08,   90.00, 0.00, 270.32);
	CreateObject(19362, 103.06, 1756.84, 20.92,   90.00, 0.00, 270.32);
	CreateObject(19362, 89.22, 1756.68, 20.72,   90.00, 0.00, 270.32);
	CreateObject(19362, 106.51, 1756.85, 18.08,   90.00, 0.00, 270.32);
	CreateObject(19362, 109.95, 1756.88, 20.92,   90.00, 0.00, 270.42);
	CreateObject(19362, 106.51, 1756.85, 20.92,   90.00, 0.00, 270.32);
	CreateObject(19303, 109.15, 1756.86, 17.90,   0.00, 0.00, 0.00);
	PCell3 = CreateObject(19303, 110.91, 1756.86, 17.90,   0.00, 0.00, 0.00); // Prison Cell 3 gate
	CreateObject(19362, 109.95, 1756.88, 20.72,   90.00, 0.00, 270.42);
	CreateObject(19362, 111.65, 1758.42, 20.76,   0.00, 0.00, 0.00);
	CreateObject(19362, 111.66, 1761.51, 20.76,   0.00, 0.00, 0.00);
	CreateObject(19362, 111.66, 1758.42, 18.16,   0.00, 0.00, 359.74);
	CreateObject(19362, 111.66, 1761.51, 18.13,   0.00, 0.00, 0.00);
	CreateObject(2528, 103.01, 1761.30, 16.63,   0.00, 0.00, 0.00);
	CreateObject(2603, 111.03, 1759.67, 17.00,   0.00, 0.00, 0.00);
	CreateObject(19362, 102.95, 1758.52, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 102.93, 1761.10, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 106.01, 1758.41, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 106.00, 1761.20, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 109.49, 1758.41, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 109.49, 1761.20, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 109.95, 1758.54, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 109.97, 1761.22, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 113.32, 1756.90, 18.08,   90.00, 0.00, 270.32);
	CreateObject(19362, 113.32, 1756.90, 20.92,   90.00, 0.00, 270.32);
	CreateObject(19362, 116.76, 1756.93, 18.08,   90.00, 0.00, 270.32);
	CreateObject(19362, 116.75, 1756.93, 20.92,   90.00, 0.00, 270.32);
	CreateObject(19362, 120.19, 1756.97, 20.72,   90.00, 0.00, 270.32);
	CreateObject(19303, 119.36, 1756.95, 17.90,   0.00, 0.00, 0.00);
	PCell4 = CreateObject(19303, 121.11, 1756.96, 17.90,   0.00, 0.00, 0.00); // Prison Cell 4 gate
	CreateObject(19362, 120.19, 1756.94, 20.92,   90.00, 0.00, 270.32);
	CreateObject(19362, 121.97, 1758.48, 20.76,   0.00, 0.00, 0.00);
	CreateObject(19362, 121.97, 1758.49, 17.70,   0.00, 0.00, 0.00);
	CreateObject(19362, 121.96, 1760.80, 20.76,   0.00, 0.00, 0.00);
	CreateObject(19362, 121.96, 1760.81, 18.23,   0.00, 0.00, 0.00);
	CreateObject(2528, 114.01, 1761.54, 16.63,   0.00, 0.00, 0.00);
	CreateObject(2603, 121.28, 1759.68, 17.00,   0.00, 0.00, 0.00);
	CreateObject(19362, 113.19, 1758.44, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 113.19, 1760.78, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 116.60, 1758.51, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 116.61, 1760.99, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 120.10, 1758.48, 22.43,   0.00, 90.00, 0.00);
	CreateObject(19362, 120.09, 1761.02, 22.43,   0.00, 90.00, 0.00);
	CreateObject(8378, 147.87, 1736.51, 26.42,   0.00, 0.00, 89.76); 
	PGate = CreateObject(19313, 127.46, 1663.82, 19.58,   0.00, 0.00, 0.00); // Prison gate
	CreateObject(8313, 147.97, 1664.18, 18.53,   0.00, 0.00, 107.62);
	PShutter = CreateObject(19313, 148.16, 1701.46, 19.87,   0.00, 0.00, 90.05);//pshutter
	CreateObject(19913, 148.15, 1718.57, 28.70,   0.00, 0.00, 90.13);
	CreateObject(19913, 148.15, 1718.57, 31.11,   0.00, 0.00, 90.13);
	
	
	//pd helipad
	

	CreateObject(6973, 2369.26611, 2373.16602, 10.71586,   0.00000, 0.00000, 269.94275);
	//CreateObject(284, 198.94, 168.27, 1003.00,   90.00, 89.00, 0.00); //pdbot
    CreateObject(19302, 197.20517, 160.32819, 1003.56549,   0.00000, 0.00000, 0.00000);
    CreateObject(19302, 192.96159, 160.29720, 1003.56549,   0.00000, 0.00000, 0.00000);
    
    
	
	//BUS STAND
	CreateObject(7651, 1448.03015, 1551.79810, 12.28874,   0.00000, 0.00000, 0.00000);
	CreateObject(7651, 1421.42139, 1551.80383, 12.28874,   0.00000, 0.00000, -0.06000);
	CreateObject(7651, 1448.14954, 1633.40552, 12.28874,   0.00000, 0.00000, 0.00000);
	CreateObject(7651, 1421.51794, 1633.50598, 12.28874,   0.00000, 0.00000, 0.00000);
	CreateObject(19454, 1410.68823, 1488.03076, 9.80342,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1414.18140, 1488.05029, 9.80342,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1417.66101, 1488.03406, 9.80342,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1421.14661, 1488.03430, 9.80342,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1424.65527, 1488.03394, 9.80340,   0.00000, 90.00000, -0.06000);
	CreateObject(19454, 1428.11938, 1488.03418, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1431.62170, 1497.66394, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1435.11475, 1488.03357, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1438.59985, 1488.03357, 9.80340,   0.00000, 90.00000, -0.06000);
	CreateObject(19454, 1442.07007, 1488.03357, 9.80340,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1445.55493, 1488.03357, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1449.03528, 1497.66394, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1452.52185, 1488.03357, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1456.01807, 1488.03247, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1410.68591, 1497.66394, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1414.17651, 1497.66394, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1417.66101, 1497.66394, 9.80340,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1421.14661, 1497.66394, 9.80340,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1424.65527, 1497.66394, 9.80340,   0.00000, 90.00000, -0.06000);
	CreateObject(19454, 1428.11938, 1497.66394, 9.80340,   0.00000, 90.00000, 0.24000);
	CreateObject(19454, 1431.62170, 1488.03357, 9.80342,   0.00000, 90.00000, -0.06000);
	CreateObject(19454, 1435.11475, 1497.66394, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1438.59985, 1497.66394, 9.80340,   0.00000, 90.00000, -0.06000);
	CreateObject(19454, 1442.07007, 1497.66394, 9.80340,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1445.55493, 1497.66394, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1449.03528, 1488.03357, 9.80340,   0.00000, 90.00000, 0.18000);
	CreateObject(19454, 1452.52185, 1497.66394, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1456.01807, 1497.66394, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1410.68591, 1507.29907, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1414.17651, 1507.29907, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1417.66101, 1507.29907, 9.80340,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1421.14661, 1507.29907, 9.80340,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1424.65527, 1507.29907, 9.80340,   0.00000, 90.00000, -0.06000);
	CreateObject(19454, 1428.11938, 1507.29907, 9.80340,   0.00000, 90.00000, 0.24000);
	CreateObject(19454, 1431.62170, 1507.29907, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1435.11475, 1507.29907, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1438.57983, 1507.29907, 9.80340,   0.00000, 90.00000, -0.06000);
	CreateObject(19454, 1442.08997, 1507.29907, 9.80340,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1445.55493, 1507.29907, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1449.03528, 1507.29907, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1452.52185, 1507.29907, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1456.01807, 1507.29907, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1456.01819, 1516.92053, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1452.52185, 1516.92053, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1449.03528, 1516.92053, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1445.55493, 1516.92053, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1442.08997, 1516.92053, 9.80340,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1438.57983, 1516.92053, 9.80340,   0.00000, 90.00000, -0.06000);
	CreateObject(19454, 1435.11475, 1516.92053, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1431.62170, 1516.92053, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1428.11938, 1516.92053, 9.80340,   0.00000, 90.00000, 0.24000);
	CreateObject(19454, 1424.65527, 1516.92053, 9.80340,   0.00000, 90.00000, -0.06000);
	CreateObject(19454, 1421.14661, 1516.92053, 9.80340,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1417.65979, 1516.92053, 9.80340,   0.00000, 90.00000, -0.12000);
	CreateObject(19454, 1414.17542, 1516.92053, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(19454, 1410.68469, 1516.92053, 9.80340,   0.00000, 90.00000, 0.00000);
	CreateObject(1228, 1410.13684, 1488.93787, 9.66810,   0.00000, 0.00000, 76.07680);
	CreateObject(1228, 1411.77515, 1488.52893, 9.66810,   0.00000, 0.00000, 76.07680);
	CreateObject(1228, 1413.42712, 1488.11792, 9.66810,   0.00000, 0.00000, 76.07680);
	CreateObject(1228, 1415.09753, 1487.69385, 9.66810,   0.00000, 0.00000, 76.07680);
	CreateObject(1228, 1416.76672, 1487.27820, 9.66810,   0.00000, 0.00000, 76.07680);
	CreateObject(1228, 1418.45178, 1486.86047, 9.66810,   0.00000, 0.00000, 76.07680);
	CreateObject(1228, 1418.51196, 1491.23047, 9.66810,   0.00000, 0.00000, 77.54425);
	CreateObject(1228, 1416.82642, 1491.60583, 9.66810,   0.00000, 0.00000, 77.82971);
	CreateObject(1228, 1415.15198, 1491.95886, 9.66810,   0.00000, 0.00000, 77.54264);
	CreateObject(1228, 1413.48083, 1492.34119, 9.66810,   0.00000, 0.00000, 77.63507);
	CreateObject(1228, 1411.82825, 1492.71118, 9.66810,   0.00000, 0.00000, 77.43958);
	CreateObject(1228, 1410.18982, 1493.07764, 9.66810,   0.00000, 0.00000, 77.14211);

	
	//--------------------------------------FUEL DEPOT-----------------------------------------//
	
	
	vdgate1 = CreateObject(985, 2497.33618, 2777.04663, 11.52759,   0.00000, 0.00000, 90.23780);
	vdgate2 = CreateObject(986, 2497.37231, 2769.14404, 11.52242,   0.00000, 0.00000, 90.50033);
	
	CreateObject(19607, 2595.30200, 2790.74780, 9.81416,   0.00000, 0.00000, 0.00000); //pickup entry fuel depot
    CreateObject(19607, 2315.56934, -0.86775, 25.73812,   0.00000, 0.00000, 0.00000); //pickup exit fuel depot

	SetTimer("CheckGate", 1000,true);
	
	CreateObject(3474, 2545.27661, 2714.01416, 16.36750,   360.00000, 0.00000, 270.10001); // crane
	
    CreateObject(1314, 2306.29443, -16.15894, 26.34385,   0.00000, 0.00000, 0.20100); //pickup offduty

    CreateObject(19132, 2586.35474, 2768.60107, 10.49519,   0.00000, 0.00000, 182.94972); // vehicle in pickup  loc --> off rig
	CreateObject(19134, 2578.33545, 2792.80322, 10.62887,   0.00000, 0.00000, 270.75339); // vehicle out pickup --> off rig
	CreateObject(1474, -941.58594, -535.93750, 27.23438,   3.14159, 0.00000, 0.24096);
	CreateObject(1477, -938.68750, -536.65625, 27.23438,   3.14159, 0.00000, 0.24096);
	CreateObject(1473, -940.13281, -536.29688, 28.20313,   3.14159, 0.00000, 0.24096);
	CreateObject(1472, -940.04688, -535.94531, 25.35156,   3.14159, 0.00000, 0.24096);
	CreateObject(1471, -941.60156, -535.94531, 25.35156,   3.14159, 0.00000, 0.24096);
	CreateObject(1470, -943.07031, -535.58594, 25.35156,   3.14159, 0.00000, 0.24096);
	CreateObject(1475, -943.03906, -535.58594, 27.23438,   3.14159, 0.00000, 0.24096);
	CreateObject(1476, -938.68750, -536.66406, 25.35156,   3.14159, 0.00000, 0.24096);
	CreateObject(3168, -940.00781, -538.67188, 24.91406,   356.85840, 0.00000, -1.33179);
	CreateObject(1438, -936.41406, -537.16406, 24.96875,   3.14159, 0.00000, 2.13618);
	CreateObject(1370, -945.35938, -536.06250, 25.50781,   356.85840, 0.00000, 3.14159);
	CreateObject(1438, -958.85156, -512.78125, 24.96875,   3.14159, 0.00000, 2.13618);
	CreateObject(3170, -995.41937, -600.22772, 30.93210,   0.00000, 0.00000, 224.38148);
	CreateObject(1370, -960.64063, -502.03906, 25.50781,   356.85840, 0.00000, 3.14159);
	CreateObject(1314, -997.51428, -601.90192, 32.03395,   0.00000, 0.00000, 356.76654); // pickup onduty
	CreateObject(19134, -977.23248, -623.24786, 32.12856,   0.00000, 0.00000, 359.79391); // vehicle out pickup  loc --> vd rig
	CreateObject(19132, -1000.17456, -623.03265, 31.83460,   0.00000, 0.00000, 0.00000); // vehicle in pickup  loc --> vd rig
	CreateObject(967, -977.31830, -623.29913, 31.00436,   0.00000, 0.00000, 88.51229);
	CreateObject(3851, -1965.21875, 258.77344, 36.46875,   356.85840, 0.00000, 3.14159);
	CreateObject(3851, -1965.21875, 258.77344, 42.04688,   356.85840, 0.00000, 3.14159);
	CreateObject(3851, -1965.21875, 271.91406, 42.04688,   356.85840, 0.00000, 3.14159);
	CreateObject(3851, -1965.21875, 271.91406, 36.46875,   356.85840, 0.00000, 3.14159);
	CreateObject(3851, -1965.21875, 285.06250, 36.46875,   356.85840, 0.00000, 3.14159);
	CreateObject(3851, -1965.21875, 285.06250, 42.04688,   356.85840, 0.00000, 3.14159);
	CreateObject(3851, -1965.21875, 302.85938, 42.04688,   356.85840, 0.00000, 3.14159);
	CreateObject(3851, -1965.21875, 302.85938, 36.46875,   356.85840, 0.00000, 3.14159);
	CreateObject(11318, -1968.25781, 274.36719, 35.53906,   356.85840, 0.00000, 3.14159);
	CreateObject(967, 2578.34229, 2792.83936, 9.81781,   0.00000, 0.00000, 183.58368);
	CreateObject(3456, 2442.77124, 2722.66211, 12.87170,   0.00000, 0.00000, 315.08658);
	CreateObject(3487, 0.00000, 2801.33960, 15.65480,   356.85840, 0.00000, 0.59510);
	CreateObject(3487, 2475.55688, 2800.31348, 16.54910,   0.00000, 0.00000, 0.47577);
	CreateObject(652, 2484.40332, 2790.91650, 9.38310,   4.00000, 0.00000, 356.00000);
	CreateObject(616, 2466.59912, 2813.79980, 8.92421,   356.85840, 0.00000, 1.64934);
	CreateObject(652, 2466.22583, 2784.09204, 9.38722,   356.85840, 0.00000, 356.16632);
	CreateObject(7940, 2481.68896, 2750.43604, 12.70348,   3.14159, 0.00000, 0.00000);
	CreateObject(616, 2472.18457, 2738.58130, 9.16406,   356.85840, 0.00000, 3.14159);
	CreateObject(652, 2494.77441, 2736.75928, 9.59403,   356.85840, 0.00000, -2.35619);

    vdtruck[0] = CreateVehicle(403,-474.2216,-472.6263,26.1268,178.3999,0,0, 0); // ROADTRAIN 1
	vdtruck[1] = CreateVehicle(403,-484.1688,-472.6347,26.1259,178.6898,0,0, 0); // ROADTRAIN 2
	vdtruck[2] = CreateVehicle(403,-494.4005,-472.7699,26.1275,177.4669,0,0, 0); // ROADTRAIN 3
	vdtruck[3] = CreateVehicle(403,-504.4745,-472.6924,26.1269,177.8361,0,0, 0); // ROADTRAIN 4
	vdtruck[4] = CreateVehicle(403,-514.4629,-472.6417,26.1266,177.3156,0,0, 0); // ROADTRAIN 5
	vdtruck[5] = CreateVehicle(403,-524.5288,-472.8740,26.1265,177.2362,0,0, 0); // ROADTRAIN 6
	vdtruck[6] = CreateVehicle(403,-534.3872,-472.6469,26.1410,176.6054,0,0, 0); // ROADTRAIN 7
	vdtruck[7] = CreateVehicle(403,-544.5499,-472.6506,26.1248,178.3725,0,0, 0); // ROADTRAIN 8
	vdtruck[8] = CreateVehicle(403,-554.5793,-472.6190,26.1243,178.6469,0,0, 0); // ROADTRAIN 9
	vdtruck[9] = CreateVehicle(403,-564.6193,-472.6403,26.1278,177.4060,0,0, 0); // ROADTRAIN 10

	t1 =  CreateVehicle(584, -982.6836, -686.7094, 32.9198, 87.2446, -1, -1, 0); // trailer1
	t2 =  CreateVehicle(584, -982.7894, -673.9568, 32.9198, 88.1260, -1, -1, 0); // trailer2
	t3 =  CreateVehicle(584, -982.9393, -661.1679, 32.9198, 89.5616, -1, -1, 0); // trailer3
	t4 =  CreateVehicle(584, -983.0915, -648.6440, 32.9198, 89.5384, -1, -1, 0); // trailer4
	t5 =  CreateVehicle(584, -982.7844, -635.8661, 32.9198, 89.5156, -1, -1, 0); // trailer5
	t6 =  CreateVehicle(584, -1031.8378, -636.1754, 33.4350, 269.5326, -1, -1, 0); // trailer6
	t7 =  CreateVehicle(584, -1031.6934, -648.5875, 32.9198, 269.7012, -1, -1, 0); // trailer7
	t8 =  CreateVehicle(584, -1031.6277, -661.3234, 32.9198, 269.9443, -1, -1, 0); // trailer8
    t9 =  CreateVehicle(584, -1031.8103, -674.1080, 32.9198, 270.1131, -1, -1, 0);// trailer9
    t10 = CreateVehicle(584, -1031.8513, -686.6181, 32.9198, 269.5568, -1, -1, 0);// trailer10

    
    Create3DTextLabel("TRAILER ID:1 \n Type /unloadfuel1 to unload this trailer ", COLOR_YELLOW, -1303.76245, -1774.76935, -469.72824, 20.0, 0, 0);
    Create3DTextLabel("TRAILER ID:2 \n Type /unloadfuel2 to unload this trailer ", COLOR_YELLOW, -1303.55432, -1762.08954, -469.72824, 20.0, 0, 0);
    Create3DTextLabel("TRAILER ID:3 \n Type /unloadfuel3 to unload this trailer ", COLOR_YELLOW,  -1303.87024, -1749.47156, -469.72824, 20.0, 0, 0);
    Create3DTextLabel("TRAILER ID:4 \n Type /unloadfuel4 to unload this trailer ", COLOR_YELLOW, -1303.89563, -1736.94110, -469.72824, 20.0, 0, 0);
    Create3DTextLabel("TRAILER ID:5 \n Type /unloadfuel5 to unload this trailer ", COLOR_YELLOW,  -1303.67249, -1724.20709, -469.72824, 20.0, 0, 0);
	Create3DTextLabel("TRAILER ID:6 \n Type /unloadfuel6 to unload this trailer ", COLOR_YELLOW, -1338.04260, -1775.00800, -469.72824, 20.0, 0, 0);
    Create3DTextLabel("TRAILER ID:7 \n Type /unloadfuel7 to unload this trailer ", COLOR_YELLOW,  -1338.14465, -1762.38879, -469.72824, 20.0, 0, 0);
    Create3DTextLabel("TRAILER ID:8 \n Type /unloadfuel8 to unload this trailer ", COLOR_YELLOW, -1337.79626, -1749.60541, -469.72824, 20.0, 0, 0);
    Create3DTextLabel("TRAILER ID:9 \n Type /unloadfuel9 to unload this trailer ", COLOR_YELLOW,  -1337.68921, -1736.93219, -469.72824, 20.0, 0, 0);
    Create3DTextLabel("TRAILER ID:10 \n Type /unloadfuel10 to unload this trailer ", COLOR_YELLOW, -1337.82141, -1724.56842, -469.72824, 20.0, 0, 0);

    
    
    
	//============================================================================================
	
	SetTimer("Timer", 500, true); //faster == less mistakes



	//===========================Engine=========================
	ManualVehicleEngineAndLights();

	//===========================SPEEDOMETER=========================
    for(new i=0;i<MAX_VEHICLES;i++)
	{
        carfuel[i] = 100; //sets every car's fuel to 100 in a loop
	}
    SetTimer("timer_fuel_lower",15000,true); //sets the timer to drop the fuel

	//=================================================SHOWROOM VEHICLES=========================================//
/*	AddStaticVehicle(400,2301.9050,1422.7728,42.9222,269.2924,101,1); // landstalker
	AddStaticVehicle(409,2352.3179,1422.9211,42.6179,90.3673,1,1); // stretch
	AddStaticVehicle(405,2352.0757,1426.4590,42.6351,90.1777,24,1); // sentinel
	AddStaticVehicle(534,2301.9966,1426.5259,42.5435,269.8439,42,42); // remington
	AddStaticVehicle(445,2301.6621,1429.7806,42.6961,268.5673,35,35); // admiral
	AddStaticVehicle(402,2312.3616,1389.8640,42.6529,359.2325,13,13); // buffalo
	AddStaticVehicle(401,2303.3857,1433.8140,42.6004,267.9448,47,47); // bravura
	AddStaticVehicle(475,2309.0957,1389.9022,42.6127,359.5338,9,39); // sabre
	AddStaticVehicle(477,2305.7268,1389.9419,42.5730,359.1715,94,1); // zr350
	AddStaticVehicle(500,2303.0718,1437.3680,42.9338,268.9242,40,84); // mesa
	AddStaticVehicle(549,2302.7805,1440.8254,42.5176,269.2408,72,39); // tampa
	AddStaticVehicle(550,2302.5483,1444.4066,42.6398,269.6361,42,42); // sunrise
	AddStaticVehicle(559,2302.4229,1390.0677,42.4766,358.4478,58,8); // jester
	AddStaticVehicle(560,2302.9194,1448.0381,42.5249,268.6290,9,39); // sultan
	AddStaticVehicle(579,2303.1450,1451.6227,42.7531,269.8026,42,42); // huntley
	AddStaticVehicle(580,2302.9441,1455.1971,42.6165,269.5773,81,81); // stafford
	AddStaticVehicle(587,2299.0730,1388.6896,42.5470,359.7448,40,1); // euros
	AddStaticVehicle(602,2295.7122,1388.6100,42.6269,0.1202,69,1); // alpha
	AddStaticVehicle(462,2342.3921,1387.1770,42.4198,46.5110,13,13); // swiggy
	AddStaticVehicle(461,2345.2776,1389.8789,42.4042,44.7377,37,1); // pcj
	AddStaticVehicle(581,2351.0510,1398.6218,42.4067,43.7649,58,1); // bf400
	AddStaticVehicle(581,2353.6816,1401.0182,42.4165,45.9491,66,1); // bf400 2
	AddStaticVehicle(545,2351.3274,1447.8975,42.6266,90.1000,47,1); // hustler
	AddStaticVehicle(434,2351.5295,1451.4440,42.7841,88.7229,12,12); */// hotknife
	
	//=======================================PUBLIC Garage========================================//
	CreateObject(19132, 2078.89819, 2416.60034, 10.52221,   0.00000, 0.00000, 0.00000); // vehicle in
	CreateObject(967, 2067.05225, 2422.39478, 9.65819,   0.00000, 0.00000, 269.06564); // oout cabin
	CreateObject(19134, 2067.08105, 2422.40527, 10.87387,   0.00000, 0.00000, 0.00000); // vehicle out
	CreateObject(19132, 2351.66699, 1399.15063, 10.70239,   0.00000, 0.00000, 317.28275); // vehicle in
	CreateObject(967, 2338.67627, 1391.42676, 9.81680,   0.00000, 0.00000, 0.00000); //out cabin
	CreateObject(19134, 2338.65942, 1391.48877, 10.92928,   0.00000, 0.00000, 91.13312); // vehicle out


	return 1;
}



new const modelNames[212][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Article Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Article Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stuntplane", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Petrol Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Article Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

Float:GetVehicleSpeed(vehicleid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	if(GetVehicleVelocity(vehicleid, x, y, z))
	{
		return floatsqroot((x * x) + (y * y) + (z * z)) * 181.5;
	}

	return 0.0;
}
Float:GetVehicleSpeedMPH(vehicleid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	if(GetVehicleVelocity(vehicleid, x, y, z))
	{
		return floatsqroot((x * x) + (y * y) + (z * z)) * 100;
	}

	return 0.0;
}
IsAbicycle(vehid)
{
	switch(GetVehicleModel(vehid))
	{
		case 481, 509, 510: return true;
	}
	return false;
}
GetVehicleName(vehicleid)
{
	new
		modelid = GetVehicleModel(vehicleid),
		name[32];

	if(400 <= modelid <= 611)
	    strcat(name, modelNames[modelid - 400]);
	else
	    name = "Unknown";

	return name;
}


public OnGameModeExit()
{
	for(new i=0; i<MAX_OBJECTS; i++)
	{
	    if(IsValidObject(i))
	    {
	        DestroyObject(i);
	 	}
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1690.6682,1451.0737,10.7661);
	SetPlayerCameraPos(playerid, 2001.4497,1400.2395,108.5087); // camera position
	SetPlayerCameraLookAt(playerid, 2001.4497,1400.2395,108.5087); //camera look at
	return 1;
}

public OnPlayerConnect(playerid)
{
	Login[playerid] = 0;
	new nombre[MAX_PLAYER_NAME], archivo[256];
	GetPlayerName(playerid, nombre, sizeof(nombre));
	format(archivo, sizeof(archivo), "/Users/%s.ini", nombre);
	if (!dini_Exists(archivo))
{
    ShowPlayerDialog(playerid, Register, DIALOG_STYLE_INPUT, "Register", "Set your password to register:", "Accept", "Cancel");
}
	else
{
    ShowPlayerDialog(playerid, Logged, DIALOG_STYLE_INPUT, "Login", "Enter your password to login:", "Accept", "Cancel");
}
	SetPlayerPos(playerid, 1690.6682,1451.0737,10.7661);

	TextDrawShowForPlayer(playerid, Textdraw0);
	TextDrawShowForPlayer(playerid, Textdraw1);
	
	pTeam[playerid] = team_civ;
	
	RemoveBuildingForPlayer(playerid, 7149, 2384.6172, 2376.8359, 9.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 6874, 2384.6172, 2376.8359, 9.8203, 0.25);
//pd jail
    RemoveBuildingForPlayer(playerid, 14856, 198.4688, 168.6797, 1003.8984, 0.25);

	RemoveBuildingForPlayer(playerid, 8954, 2397.39, 1503.02, 14.01, 0.25);
    RemoveBuildingForPlayer(playerid, 8957, 2393.77, 1483.69, 12.71, 0.25);
    RemoveBuildingForPlayer(playerid, 8955, 2393.77, 1490.55, 13.00, 0.25);
    
    //-------------------------------FUEL DEPOT---------------------------------//
    
    RemoveBuildingForPlayer(playerid, 985, 2497.4063, 2777.0703, 11.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 986, 2497.4063, 2769.1094, 11.5313, 0.25);


	//==============================SPEEDOMETER=================================
	
	PlayerSpeedo[playerid] = 1; // default speed KM/H

    //------------------------------------------------------------------------//
    SPEEDOMETER[playerid][0] = CreatePlayerTextDraw(playerid, 195.999755, 367.360229, "TURISMO");
	PlayerTextDrawLetterSize(playerid, SPEEDOMETER[playerid][0], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, SPEEDOMETER[playerid][0], 1);
	PlayerTextDrawColor(playerid, SPEEDOMETER[playerid][0], -1378294017);
	PlayerTextDrawSetShadow(playerid, SPEEDOMETER[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, SPEEDOMETER[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, SPEEDOMETER[playerid][0], 51);
	PlayerTextDrawFont(playerid, SPEEDOMETER[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, SPEEDOMETER[playerid][0], 1);

	SPEEDOMETER[playerid][1] = CreatePlayerTextDraw(playerid, 438.800048, 389.766632, "usebox");
	PlayerTextDrawLetterSize(playerid, SPEEDOMETER[playerid][1], 0.000000, 0.512962);
	PlayerTextDrawTextSize(playerid, SPEEDOMETER[playerid][1], 194.799987, 0.000000);
	PlayerTextDrawAlignment(playerid, SPEEDOMETER[playerid][1], 1);
	PlayerTextDrawColor(playerid, SPEEDOMETER[playerid][1], 65535);
	PlayerTextDrawUseBox(playerid, SPEEDOMETER[playerid][1], true);
	PlayerTextDrawBoxColor(playerid, SPEEDOMETER[playerid][1], 65535);
	PlayerTextDrawSetShadow(playerid, SPEEDOMETER[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, SPEEDOMETER[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, SPEEDOMETER[playerid][1], 65535);
	PlayerTextDrawFont(playerid, SPEEDOMETER[playerid][1], 1);

	SPEEDOMETER[playerid][2] = CreatePlayerTextDraw(playerid, 340.800018, 356.906646, "");
	PlayerTextDrawLetterSize(playerid, SPEEDOMETER[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SPEEDOMETER[playerid][2], 76.800018, 25.386688);
	PlayerTextDrawAlignment(playerid, SPEEDOMETER[playerid][2], 1);
	PlayerTextDrawColor(playerid, SPEEDOMETER[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, SPEEDOMETER[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, SPEEDOMETER[playerid][2], 0);
	PlayerTextDrawFont(playerid, SPEEDOMETER[playerid][2], 4);

	SPEEDOMETER[playerid][3] = CreatePlayerTextDraw(playerid, 200.800018, 397.226654, "200");
	PlayerTextDrawLetterSize(playerid, SPEEDOMETER[playerid][3], 0.494800, 1.801599);
	PlayerTextDrawTextSize(playerid, SPEEDOMETER[playerid][3], -3.999996, 12.693334);
	PlayerTextDrawAlignment(playerid, SPEEDOMETER[playerid][3], 1);
	PlayerTextDrawColor(playerid, SPEEDOMETER[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, SPEEDOMETER[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, SPEEDOMETER[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, SPEEDOMETER[playerid][3], 51);
	PlayerTextDrawFont(playerid, SPEEDOMETER[playerid][3], 3);
	PlayerTextDrawSetProportional(playerid, SPEEDOMETER[playerid][3], 1);

	SPEEDOMETER[playerid][4] = CreatePlayerTextDraw(playerid, 197.599899, 412.906585, "KM/H");
	PlayerTextDrawLetterSize(playerid, SPEEDOMETER[playerid][4], 0.365999, 1.338665);
	PlayerTextDrawAlignment(playerid, SPEEDOMETER[playerid][4], 1);
	PlayerTextDrawColor(playerid, SPEEDOMETER[playerid][4], -2147450625);
	PlayerTextDrawSetShadow(playerid, SPEEDOMETER[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, SPEEDOMETER[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, SPEEDOMETER[playerid][4], 51);
	PlayerTextDrawFont(playerid, SPEEDOMETER[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, SPEEDOMETER[playerid][4], 1);

	SPEEDOMETER[playerid][5]= CreatePlayerTextDraw(playerid, 292.799987, 397.226501, "100");
	PlayerTextDrawLetterSize(playerid, SPEEDOMETER[playerid][5], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, SPEEDOMETER[playerid][5], 1);
	PlayerTextDrawColor(playerid, SPEEDOMETER[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, SPEEDOMETER[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, SPEEDOMETER[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, SPEEDOMETER[playerid][5], 51);
	PlayerTextDrawFont(playerid, SPEEDOMETER[playerid][5], 3);
	PlayerTextDrawSetProportional(playerid, SPEEDOMETER[playerid][5], 1);

	SPEEDOMETER[playerid][6] = CreatePlayerTextDraw(playerid, 292.800018, 409.919860, "FUEL");
	PlayerTextDrawLetterSize(playerid, SPEEDOMETER[playerid][6], 0.369998, 1.301332);
	PlayerTextDrawAlignment(playerid, SPEEDOMETER[playerid][6], 1);
	PlayerTextDrawColor(playerid, SPEEDOMETER[playerid][6], 16777215);
	PlayerTextDrawSetShadow(playerid, SPEEDOMETER[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, SPEEDOMETER[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, SPEEDOMETER[playerid][6], 51);
	PlayerTextDrawFont(playerid, SPEEDOMETER[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, SPEEDOMETER[playerid][6], 1);

	SPEEDOMETER[playerid][7] = CreatePlayerTextDraw(playerid, 383.200012, 396.480072, "999.0");
	PlayerTextDrawLetterSize(playerid, SPEEDOMETER[playerid][7], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, SPEEDOMETER[playerid][7], 1);
	PlayerTextDrawColor(playerid, SPEEDOMETER[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, SPEEDOMETER[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, SPEEDOMETER[playerid][7], 1);
	PlayerTextDrawBackgroundColor(playerid, SPEEDOMETER[playerid][7], 51);
	PlayerTextDrawFont(playerid, SPEEDOMETER[playerid][7], 3);
	PlayerTextDrawSetProportional(playerid, SPEEDOMETER[playerid][7], 1);

	SPEEDOMETER[playerid][8] = CreatePlayerTextDraw(playerid, 368.800018, 409.173461, "HEALTH");
	PlayerTextDrawLetterSize(playerid, SPEEDOMETER[playerid][8], 0.409999, 1.375998);
	PlayerTextDrawAlignment(playerid, SPEEDOMETER[playerid][8], 1);
	PlayerTextDrawColor(playerid, SPEEDOMETER[playerid][8], -16776961);
	PlayerTextDrawSetShadow(playerid, SPEEDOMETER[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, SPEEDOMETER[playerid][8], 1);
	PlayerTextDrawBackgroundColor(playerid, SPEEDOMETER[playerid][8], 51);
	PlayerTextDrawFont(playerid, SPEEDOMETER[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, SPEEDOMETER[playerid][8], 1);

	SPEEDOMETER[playerid][9] = CreatePlayerTextDraw(playerid, 438.799987, 350.940002, "usebox");
	PlayerTextDrawLetterSize(playerid, SPEEDOMETER[playerid][9], 0.000000, 8.483331);
	PlayerTextDrawTextSize(playerid, SPEEDOMETER[playerid][9], 418.800018, 0.000000);
	PlayerTextDrawAlignment(playerid, SPEEDOMETER[playerid][9], 1);
	PlayerTextDrawColor(playerid, SPEEDOMETER[playerid][9], 65535);
	PlayerTextDrawUseBox(playerid, SPEEDOMETER[playerid][9], true);
	PlayerTextDrawBoxColor(playerid, SPEEDOMETER[playerid][9], 65535);
	PlayerTextDrawSetShadow(playerid, SPEEDOMETER[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, SPEEDOMETER[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, SPEEDOMETER[playerid][9], 65535);
	PlayerTextDrawFont(playerid, SPEEDOMETER[playerid][9], 0);
	//clock
	if(pTeam[playerid] == team_civ)
	{
	    SetPlayerColor(playerid, COLOR_WHITE);
	}
//==================================SPEEDOMETER=============================

//==================================VD FUELS================================
	RemoveBuildingForPlayer(playerid, 7095, 2545.5469, 2751.3828, 11.9609, 0.25);
    RemoveBuildingForPlayer(playerid, 7023, 2501.5156, 2781.2891, 9.8203, 0.25);

	//=====KAALA=====//
	kaalalandstalkergarage = 1;
	kaalaremingtongarage = 1;
	kaalastretchgarage = 1;
	kaalahotknifegarage = 1;
//===============//

//=====Willsmith=====//
	willsmithhuntleygarage = 1;
//===================//

//====Donaldpump=====//
	donaldpumpstretchgarage = 1;
//===================//

//======ironman=======//
	ironmansultangarage = 1;
	ironmanzr350garage = 1;
	ironmaneurosgarage = 1;
	ironmanbf400garage = 1;
	ironmanhotknifegarage = 1;
//====================//

//====Mrblaza======//
	mrblazabuffalogarage = 1;
	mrblazazr350garage = 1;
//==================//

//==========Mrrohith=============//
	mrrohithbuffalogarage = 1;
//=======================//

	return 1;
}




public OnPlayerDisconnect(playerid, reason)
{
	new file[128], pname[MAX_PLAYER_NAME];
	new Float:x, Float:y, Float:z;
	GetPlayerName(playerid, pname, sizeof(pname));
 	format(file, sizeof(file), "\\SavePos\\%s.ini", pname);
 	if(!dini_Exists(file))
	dini_Create(file);
	GetPlayerPos(playerid, x, y, z);
	dini_FloatSet(file, "posX", x);
	dini_FloatSet(file, "posY", y);
	dini_FloatSet(file, "posZ", z);
	
	//==========================SPEEDOMETER================================
	for(new i = 0; i < 10; i ++)
	{
        PlayerTextDrawDestroy(playerid, SPEEDOMETER[playerid][i]);
		SPEEDOMETER[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}
	

	return 1;
}




public OnPlayerDeath(playerid)
{
	new file[128], pname[MAX_PLAYER_NAME];
	new Float:x, Float:y, Float:z;
	GetPlayerName(playerid, pname, sizeof(pname));
	format(file, sizeof(file), "\\SavePos\\%s.ini", pname);
	if(!dini_Exists(file))
	dini_Create(file);
	GetPlayerPos(playerid, x, y, z);
	dini_FloatSet(file, "posX", x);
	dini_FloatSet(file, "posY", y);
	dini_FloatSet(file, "posZ", z);
	SetPlayerPos(playerid, x, y, z);
    GivePlayerMoney(playerid, -500);
    SendClientMessage(playerid, COLOR_GREEN, "500$ has been reduced from your pocket");
	return 1;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if (dialogid == Register)
	{
    	new nombrejugador[MAX_PLAYER_NAME], archivo[256];
    	if (!strlen(inputtext)) return ShowPlayerDialog(playerid, Register, DIALOG_STYLE_INPUT, "Register", "Set your password to register:", "Accept", "Cancel");
    	if (!response) return ShowPlayerDialog(playerid, Register, DIALOG_STYLE_INPUT, "Register", "Enter your password to login:", "Accept", "Cancel");
    	GetPlayerName(playerid, nombrejugador, sizeof(nombrejugador));
    	format(archivo, sizeof(archivo), "/Users/%s.ini", nombrejugador);
    	dini_Create(archivo);
    	dini_Set(archivo, "User", nombrejugador);
    	dini_Set(archivo, "Password", inputtext);
    	ShowPlayerDialog(playerid, Logged, DIALOG_STYLE_INPUT, "Login", "Enter your password to login", "Accept", "Cancel");
	}
	if (dialogid == Logged)
	{
    	new nombrejugador[MAX_PLAYER_NAME], archivo[256], comprobante[256];
    	if (!strlen(inputtext)) return ShowPlayerDialog(playerid, Logged, DIALOG_STYLE_INPUT, "Login", "Enter your password to login", "Accept", "Cancel");
    	if (!response) return ShowPlayerDialog(playerid, Logged, DIALOG_STYLE_INPUT, "Login", "Enter your password to login", "Accept", "Cancel");
    	GetPlayerName(playerid, nombrejugador, sizeof(nombrejugador));
    	format(archivo, sizeof(archivo), "/Users/%s.ini", nombrejugador);
    	format(comprobante, sizeof(comprobante), "%s", dini_Get(archivo, "Password"));
    	if (!strcmp (inputtext, comprobante))
    	{
        	Login[playerid] = 1;
    	}
    	else
    	{
        	ShowPlayerDialog(playerid, Logged, DIALOG_STYLE_INPUT, "Login", "Enter your password to login", "Accept", "Cancel");
    	}
	}
	
	//===============================================================GARAGE=====================================================================//
	if(response)
	{
		switch(dialogid)
 		{
			case 1: // KAA_LA
			{
				switch(listitem)
				{
					case 0: //Landstalker
					{
						if(kaalalandstalkergarage == 1)
						{
							CreateVehicle(400, 2079.0015, 2430.7710, 10.5744, 90.0135, 0, 0, 0);
 							kaalalandstalkergarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
    						SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
					case 1: //Remington
					{
						if(kaalaremingtongarage == 1)
   						{
							CreateVehicle(534, 2079.0015, 2430.7710, 10.5744, 90.0135, 0, 0, 0);
							kaalaremingtongarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
							SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
					case 2: //Stretch
					{
						if(kaalastretchgarage == 1)
						{
							CreateVehicle(409, 2079.0015, 2430.7710, 10.5744, 90.0135, 0, 0, 0);
							kaalastretchgarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
    						SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
					case 3: //Hotknife
					{
						if(kaalahotknifegarage == 1)
						{
							CreateVehicle(434, 2079.0015, 2430.7710, 10.5744, 90.0135, 0, 0, 0);
							kaalahotknifegarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
	    					SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
				}
			}
			case 2: //Mr_BLAZA
			{
				switch(listitem)
 				{
					case 0: //Buffalo
   					{
						if(mrblazabuffalogarage == 1)
						{
							CreateVehicle(402, 2079.0015, 2430.7710, 10.5744, 90.0135, 3, 3, 0);
							mrblazabuffalogarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
 							SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
					case 1: //ZR-350
					{
						if(mrblazazr350garage == 1)
	 					{
							CreateVehicle(477, 2079.0015, 2430.7710, 10.5744, 90.0135, 0, 0, 0);
							mrblazazr350garage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
	    					SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
				}
			}
			case 3: //Donald_Pump
			{
				switch(listitem)
				{
					case 0: //stretch
   					{
						if(donaldpumpstretchgarage == 1)
						{
							CreateVehicle(409, 2079.0015, 2430.7710, 10.5744, 90.0135, 138, 138, 0);
							donaldpumpstretchgarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
    						SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
				}
			}
			case 4: //ironman
			{
				switch(listitem)
  				{
					case 0: //Sultan
  					{
						if(ironmansultangarage == 1)
						{
							CreateVehicle(560, 2079.0015, 2430.7710, 10.5744, 90.0135, -1, -1, 0);
							ironmansultangarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
	    					SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
					case 1: //ZR-350
					{
						if(ironmanzr350garage == 1)
						{
							CreateVehicle(477, 2079.0015, 2430.7710, 10.5744, 90.0135, -1, -1, 0);
							ironmanzr350garage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
    						SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
					case 2: //Euros
					{
						if(ironmaneurosgarage == 1)
						{
							CreateVehicle(587, 2079.0015, 2430.7710, 10.5744, 90.0135, -1, -1, 0);
							ironmaneurosgarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
    						SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
					case 3: //Hotknife
 					{
						if(ironmanhotknifegarage == 1)
						{
							CreateVehicle(434, 2079.0015, 2430.7710, 10.5744, 90.0135, -1, -1, 0);
							ironmanhotknifegarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
	    					SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
					case 4: //bf400
					{
						if(ironmanbf400garage == 1)
						{
							CreateVehicle(581, 2079.0015, 2430.7710, 10.5744, 90.0135, -1, -1, 0);
							ironmanbf400garage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
	    					SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
				}
			}
   			case 5: // Mr_Rohith
			{
				switch(listitem)
				{
					case 0: //buffelo
   					{
						if(mrrohithbuffalogarage == 1)
						{
							CreateVehicle(402, 2079.0015, 2430.7710, 10.5744, 90.0135, 0, 0, 0);
							mrrohithbuffalogarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
    						SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
				}
			}
			case 6: //Will_smith
			{
				switch(listitem)
				{
					case 0: //huntley
   					{
						if(willsmithhuntleygarage == 1)
						{
							CreateVehicle(579, 2079.0015, 2430.7710, 10.5744, 90.0135, 138, 138, 0);
							willsmithhuntleygarage = 0;
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, "You have already spawned a vehile from your garage");
    						SendClientMessage(playerid, COLOR_RED, "Store it in your garage before trying again");
						}
					}
				}
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	SetPlayerChatBubble(playerid, text, COLOR_ORANGE, 100.0, 10000);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
    {
  		if(GetPlayerVehicleID(playerid) == Trucking[0])
        {

			Trucker[playerid] = 1;
        	new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s is now an on duty as Trucker.", name );
            SendClientMessageToAll(COLOR_SILVER, string);
            GameTextForPlayer(playerid,"~g~Mission Started!",5000,5);
			SetPlayerRaceCheckpoint(playerid, 1, 274.4175, 1408.9670, 10.1056, 0, 0, 0, 5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "Trucking missions enabled, go to the marker to get the shipment.");
  		}
		if(GetPlayerVehicleID(playerid) == Trucking[1])
        {
            Trucker[playerid] = 1;
        	new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s is now an on duty as Trucker.", name );
            SendClientMessageToAll(COLOR_SILVER, string);
            GameTextForPlayer(playerid,"~g~Mission Started!",5000,5);
			SetPlayerRaceCheckpoint(playerid, 1, 274.4175, 1408.9670, 10.1056, 0, 0, 0, 5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "Trucking missions enabled, go to the marker to get the shipment.");
  		}
		if(GetPlayerVehicleID(playerid) == Trucking[2])
        {
            Trucker[playerid] = 1;
        	new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s is now an on duty as Trucker.", name );
            SendClientMessageToAll(COLOR_SILVER, string);
            GameTextForPlayer(playerid,"~g~Mission Started!",5000,5);
			SetPlayerRaceCheckpoint(playerid, 1, 274.4175, 1408.9670, 10.1056, 0, 0, 0, 5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "Trucking missions enabled, go to the marker to get the shipment.");
  		}
        if(GetPlayerVehicleID(playerid) == Trucking[3])
        {
            Trucker[playerid] = 1;
        	new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s is now an on duty as Trucker.", name );
            SendClientMessageToAll(COLOR_SILVER, string);
            GameTextForPlayer(playerid,"~g~Mission Started!",5000,5);
			SetPlayerRaceCheckpoint(playerid, 1, 274.4175, 1408.9670, 10.1056, 0, 0, 0, 5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "Trucking missions enabled, go to the marker to get the shipment.");
  		}
        if(GetPlayerVehicleID(playerid) == Trucking[4])
        {
            Trucker[playerid] = 1;
        	new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s is now an on duty as Trucker.", name );
            SendClientMessageToAll(COLOR_SILVER, string);
            GameTextForPlayer(playerid,"~g~Mission Started!",5000,5);
			SetPlayerRaceCheckpoint(playerid, 1, 274.4175, 1408.9670, 10.1056, 0, 0, 0, 5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "Trucking missions enabled, go to the marker to get the shipment.");
  		}
	}
    if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	{
		if(Trucker[playerid] > 0 )
		{
			Trucker[playerid] = 0;
			new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s has left his job as Trucker.", name );
            SendClientMessageToAll(COLOR_RED, string);
            DisablePlayerRaceCheckpoint(playerid);
            PlayerPlaySound(playerid, 1139, 0.0, 0.0, 10.0);
        	GameTextForPlayer(playerid,"~r~Mission Canceled!",5000,5);
      		SendClientMessage(playerid, 0xFF0000FF, "You have canceled the mission - Dont left the vehicles!");
		}
 	}
 	
//-----------------------------------------------------------------ENGINE---------------------------------------------------------------------------------

  	//---------------------------------------------------------------------------------------------------------------------------------------------------------
  	
  	//=========================================================SPEEDOMETER=============================================================
   	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
		if(!IsAbicycle(vehicleid))
		{
	        new vstr[30];
			format(vstr, sizeof(vstr), "%s", GetVehicleName(vehicleid));
			PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][0], vstr);

	        PlayerTextDrawSetPreviewModel(playerid, SPEEDOMETER[playerid][2], GetVehicleModel(GetPlayerVehicleID(playerid)));
		    PlayerTextDrawShow(playerid, SPEEDOMETER[playerid][2]);

			for(new i = 0; i < 10; i++) {
				PlayerTextDrawShow(playerid, SPEEDOMETER[playerid][i]);
			}
		}
	}
	else if(oldstate == PLAYER_STATE_DRIVER)
	{
        for(new i = 0; i < 10; i++) {
 			PlayerTextDrawHide(playerid, SPEEDOMETER[playerid][i]);
		}
	}
//fule
	if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
        new vid = GetPlayerVehicleID(playerid);
        new string[125];format(string,sizeof string,"%i",carfuel[vid]); //quickly doing a small update on fuel (so it wont jump from 100 to its real value)
       	PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][5], "100");
        PlayerTextDrawShow(playerid, SPEEDOMETER[playerid][5]); //showing if an player is a driver or passenger of the ar
    } else {
        PlayerTextDrawHide(playerid, SPEEDOMETER[playerid][5]); //hiding if a player isnt driving/or an passenger
    }
    
    //-------------------------------------------------------------FUEL DEPOT------------------------------------------------------//
    //-------------------------------------------------------------VD FUEL JOB-----------------------------------------------------//
    new Float:health;
    new veh = GetPlayerVehicleID(playerid);
    new vehicle = GetPlayerVehicleID(playerid);
    new engine,lights,alarm,doors,bonnet,boot,objective;
    GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
    GetVehicleHealth(veh, health);
    if(health < 350)
    {
        SetVehicleParamsEx(vehicle,0,0,alarm,doors,bonnet,boot,objective);
	}

    if (newstate == PLAYER_STATE_ONFOOT || newstate == PLAYER_STATE_DRIVER)
	{
        if(GetVehicleModel(veh) == 403)
		{
			if(onTeam[playerid] == state_vdonduty)
        	{
        		if(GetPlayerVehicleID(playerid) == vdtruck[0])
				{
					SetPlayerCheckpoint(playerid, -1308.55511, -1774.41376, -473.32587, 5.0);
    				SendClientMessage(playerid, COLOR_ORANGE, " Go to marked location and connect the trailer");
				}
				else if(GetPlayerVehicleID(playerid) == vdtruck[1])
				{
					SetPlayerCheckpoint(playerid, -1308.62494, -1761.74139, -473.32587, 5.0);
					SendClientMessage(playerid, COLOR_ORANGE, " Go to marked location and connect the trailer");
				}
				else if(GetPlayerVehicleID(playerid) == vdtruck[2])
				{
					SetPlayerCheckpoint(playerid, -1308.46912, -1749.40625, -473.32587, 5.0);
					SendClientMessage(playerid, COLOR_ORANGE, " Go to marked location and connect the trailer");
				}
				else if(GetPlayerVehicleID(playerid) == vdtruck[3])
				{
					SetPlayerCheckpoint(playerid, -1308.88275, -1736.76324, -473.32587, 5.0);
					SendClientMessage(playerid, COLOR_ORANGE, " Go to marked location and connect the trailer");
				}
				else if(GetPlayerVehicleID(playerid) == vdtruck[4])
				{
					SetPlayerCheckpoint(playerid,  -1308.68439, -1723.98145, -473.32587, 5.0);
					SendClientMessage(playerid, COLOR_ORANGE, " Go to marked location and connect the trailer");
				}
				else if(GetPlayerVehicleID(playerid) == vdtruck[5])
				{
					SetPlayerCheckpoint(playerid, -1333.08160, -1775.07941, -473.32587, 5.0);
					SendClientMessage(playerid, COLOR_ORANGE, " Go to marked location and connect the trailer");
				}
				else if(GetPlayerVehicleID(playerid) == vdtruck[6])
				{
					SetPlayerCheckpoint(playerid, -1333.35297, -1762.55609, -473.32587, 5.0);
					SendClientMessage(playerid, COLOR_ORANGE, " Go to marked location and connect the trailer");
				}
				else if(GetPlayerVehicleID(playerid) == vdtruck[7])
				{
					SetPlayerCheckpoint(playerid, -1333.41504, -1749.75519, -473.32587, 5.0);
					SendClientMessage(playerid, COLOR_ORANGE, " Go to marked location and connect the trailer");
				}
				else if(GetPlayerVehicleID(playerid) == vdtruck[8])
				{
					SetPlayerCheckpoint(playerid, -1333.10620, -1737.00507, -473.32587, 5.0);
					SendClientMessage(playerid, COLOR_ORANGE, " Go to marked location and connect the trailer");
				}
				else if(GetPlayerVehicleID(playerid) == vdtruck[9])
				{
					SetPlayerCheckpoint(playerid, -1333.25494, -1724.73651, -473.32587, 5.0);
					SendClientMessage(playerid, COLOR_ORANGE, " Go to marked location and connect the trailer");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_RED, "You are not on-duty");
				RemovePlayerFromVehicle(playerid);
			}
		}

	}
	
 	return 1;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------
public OnPlayerEnterRaceCheckpoint(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == Trucking[0],Trucking[1],Trucking[2],Trucking[3],Trucking[4])
	{
		if(Trucker[playerid] == 1)
		{
  			Trucker[playerid] = 2;
     		SendClientMessage(playerid, COLOR_YELLOW, "You have got the shipment, now make your way to the dealer.");
     		SetPlayerRaceCheckpoint(playerid, 1, -1643.4783, -2686.9014, 48.2021, 0, 0, 0, 5.0);
	 	 	return 1;
		}
		if(Trucker[playerid] == 2)
		{
            Trucker[playerid] = 0;
            TogglePlayerControllable(playerid, 0);
            DisablePlayerRaceCheckpoint(playerid);
   	        TogglePlayerControllable(playerid, 1);
   	        GameTextForPlayer(playerid,"~g~Mission Completed!",5000,5);
   	        SendClientMessage(playerid, 0xFF00FF, "Congratulations! You have earned $3000 from finished the Trucking Missions.");
            PlayerPlaySound(playerid, 1139, 0.0, 0.0, 10.0);
			GivePlayerMoney(playerid,3000);
   			RemovePlayerFromVehicle(playerid);
	   		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		}
  	}
  	
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == vdtruck[0],vdtruck[1],vdtruck[2],vdtruck[3],vdtruck[4],vdtruck[5],vdtruck[6],vdtruck[7],vdtruck[8],vdtruck[9])
	{
        DisablePlayerRaceCheckpoint(playerid);
		SendClientMessage(playerid, COLOR_ORANGE, "Type /unloadfuel<trailerid> to unload your trailer");
	}
	return 1;
}




public OnPlayerSpawn(playerid)
{
	new file[128], pname[MAX_PLAYER_NAME];
	new Float:x, Float:y, Float:z;
	GetPlayerName(playerid, pname, sizeof(pname));
	format(file, sizeof(file), "\\SavePos\\%s.ini", pname);
	x = dini_Float(file, "posX");
	y = dini_Float(file, "posY");
	z = dini_Float(file, "posZ");
	SetPlayerPos(playerid, x, y, z);
	
	{
        new playername[64];
		GetPlayerName(playerid,playername,64);
		if(!strcmp(playername,"Vakil_Vandumurugan",true))
		{
 		
		    pTeam[playerid] = team_vdfuels;
			SetPlayerSkin(playerid, 240);
 		}
 		else if(!strcmp(playername,"Donald_Pump",true))
		{
  		//<-------------PD--------------->//
		    pTeam[playerid] = team_mmpd;
		    SetPlayerColor(playerid, COLOR_RED);
		//<-------------PD--------------->//
		    SetPlayerSkin(playerid, 59);
 		}
 		else if(!strcmp(playername,"Paul_Walker",true))
		{
			SetPlayerSkin(playerid, 164);
 		}
 		else if(!strcmp(playername,"Will_Smith",true))
		{
		    GivePlayerWeapon(playerid, 31, 500);
			SetPlayerSkin(playerid, 271);
 		}
 		else if(!strcmp(playername,"KAA_LA",true))
		{
		    GivePlayerWeapon(playerid, 31, 500);
		    pTeam[playerid] = team_vdfuels;
			SetPlayerSkin(playerid, 294);
 		}
 		else if(!strcmp(playername,"Mr_BLAZA",true))
		{
		    pTeam[playerid] = team_vdfuels;
			SetPlayerSkin(playerid, 299);
 		}
 		else if(!strcmp(playername,"Mr_Rohith_",true))
		{
			SetPlayerSkin(playerid, 115);
 		}
 		else if(!strcmp(playername,"ironman",true))
		{
		    pTeam[playerid] = team_mech;
			SetPlayerSkin(playerid, 289);
 		}
 		else if(!strcmp(playername,"Suna_Pana",true))
 		{
 		    SetPlayerSkin(playerid, 46);
			pTeam[playerid] = team_pwautodealers;
		}
	}
	return 1;
}
//===============================================================SPEEDOMETER===============================================================
public OnPlayerUpdate(playerid)
{
	new vehicle = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsAbicycle(vehicle)) // Making sure the player is in a vehicle as driver
	{
	    if(PlayerSpeedo[playerid] == 0)
	    {
			new Float:H;
			GetVehicleHealth(vehicle, H);
			new speed[24];
			format(speed, sizeof(speed), "%.0f", GetVehicleSpeed(vehicle));
			PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][3], speed);
			new vehfuel[24];
			format(vehfuel, sizeof(vehfuel), "%d", carfuel[vehicle]);
			PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][5], vehfuel);
	        new vehiclehealth[24];
	        format(vehiclehealth, sizeof(vehiclehealth), "%.0f", H);
			PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][7], vehiclehealth);
		}
		else if(PlayerSpeedo[playerid] == 1)
		{
			new Float:H;
			GetVehicleHealth(vehicle, H);
			new speed[24];
			format(speed, sizeof(speed), "%.0f", GetVehicleSpeedMPH(vehicle));
			PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][3], speed);
			new vehfuel[24];
			format(vehfuel, sizeof(vehfuel), "%d", carfuel[vehicle]);
			PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][5], vehfuel);
	        new vehiclehealth[24];
	        format(vehiclehealth, sizeof(vehiclehealth), "%.0f", H);
			PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][7], vehiclehealth);
			PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][4], "KM/H");
		}
	}
	return 1;
}

public timer_fuel_lower()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{ //loop for all players
 		//new vehicleid = GetPlayerVehicleID(i);
        new vehicle = GetPlayerVehicleID(i);
		new engine,lights,alarm,doors,bonnet,boot,objective;
        GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
		if(engine == 1)
		{
        	if (isrefuelling[i]) continue; //stop when a player is already refuelling
        	new vid = GetPlayerVehicleID(i); //getting vehicle ID
        	if (GetPlayerVehicleSeat(i) == 0)
			{ //if the player is a driver (it should only lower the fuel when theres an driver!)
            	carfuel[vid] = carfuel[vid] -1; //lowering fuel value
            	if (carfuel[vid]<1) //if fuel is empty
            	{
                	carfuel[vid] = 0; //setting fuel to 0 (else the timer will set it to -1 -2 -3 etc before removing player)
                	engine = 0;
   					TogglePlayerControllable(i, 0);
			 		//RemovePlayerFromVehicle(i); //remove player out of vehicle
                	GameTextForPlayer(i,"~r~You are out of ~w~fuel~r~!",5000,4); //show text
            	}
        	}
        	new string[125];format(string,sizeof string,"%i",carfuel[vid]); //preparing string with next fuel value
        	PlayerTextDrawSetString(i, SPEEDOMETER[i][5], string); //updating textdraw
    	}
	}
	return 1;
}

public timer_refuel(playerid)
{
    new vid = GetPlayerVehicleID(playerid);
    carfuel[vid] = carfuel[vid] = 100; //restoring fuel to 100
    isrefuelling[playerid] = 0;//resetting anti-spam thingy :3
    PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][5], "100"); //small update on textdraw
    TogglePlayerControllable(playerid,1); //unfreeze player
}
//======================================================================SPEEDOMETER==================================================================
//-----------------------------------------------------------------------ENGINE------------------------------------------------------------------------------
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_SUBMISSION))
    {
    	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    	{
    		new vehicle = GetPlayerVehicleID(playerid);
    		new engine,lights,alarm,doors,bonnet,boot,objective;
    		GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
    		if(engine == 1)
    		{
    			SetVehicleParamsEx(vehicle,0,0,alarm,doors,bonnet,boot,objective);
    			SendClientMessage(playerid,-1,"You Stopped Vehicles Engine!");
    		}
    		else
    		{
    			SetVehicleParamsEx(vehicle,1,1,alarm,doors,bonnet,boot,objective);
    			SendClientMessage(playerid,-1,"You Started Vehicles Engine!");
    		}
  		}
	}

    if (newkeys & KEY_SECONDARY_ATTACK)
    {
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2595.30200, 2790.74780, 9.81416))
 		{
  			SetPlayerPos(playerid, 2315.952000,-1.610174,26.742107);
     		SetCameraBehindPlayer(playerid);
      		SendClientMessage(playerid,-1,"[VD BROTHERS]: Welcome!");
   		}
   		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 2315.952000,-1.610174,26.742107))
   		{
  			SetPlayerPos(playerid, 2595.30200, 2790.74780, 9.81416);
     		SetCameraBehindPlayer(playerid);
      		SendClientMessage(playerid,-1,"[VD BROTHERS]: bye See You Soon!");
		}
  	}
  	
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid) == 403)
    {
        SendClientMessage(playerid, COLOR_ORANGE, "Connect with a trailer and type /startvdjob");
	}

    DisablePlayerCheckpoint(playerid);
    SendClientMessage(playerid, COLOR_LIGHTGREEN, "You have reached the location");


	return 1;
}



public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == BULLET_HIT_TYPE_VEHICLE)
	{
	    static Float:X, Float:Y, Float:Z;
	    /* Aseve Mushaobs Rodesac Shignit Vinme Zis... */
		GetVehicleModelInfo(GetVehicleModel(hitid), VEHICLE_MODEL_INFO_PETROLCAP, X, Y, Z);

		if(VectorSize(fX-X, fY-Y, fZ-Z) < 0.15)
		{
		    SetVehicleHealth(hitid, -1000.0);
		    return 1;
		}

		/* Carieli Manqanaze Srola */
		for(new i = GetPlayerPoolSize(); i > -1; i--)
		{
			if(GetPlayerVehicleID(i) == hitid && GetPlayerVehicleSeat(i) == 0)
				return 1;
		}

		GetVehicleHealth(hitid, X);
		if(X > 0)
		{
			switch(weaponid)
			{
				case 0 .. 15: SetVehicleHealth(hitid, X - 10);
				case 22 .. 23: SetVehicleHealth(hitid, X - 15);
                case 24: SetVehicleHealth(hitid, X - 50);
				case 25 .. 27: SetVehicleHealth(hitid, X - 30);
				case 28, 29, 32: SetVehicleHealth(hitid, X - 5);
				case 30, 31: SetVehicleHealth(hitid, X - 10);
				case 33, 34: SetVehicleHealth(hitid, X - 40);
				case 35 .. 38: SetVehicleHealth(hitid, X - 80);
				default: return 1;
			}
		}
	}
    return 1;
}


new Float:PlayerVehHP[MAX_PLAYERS];

forward Timer();
public Timer()
{
    for(new i = GetPlayerPoolSize(); i > -1; i--)
	{
	    if(GetPlayerState(i) != PLAYER_STATE_DRIVER) continue;

		GetVehicleHealth(GetPlayerVehicleID(i), PlayerVehHP[i]);
	}
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		static Float:hp, Float:hpa;
		GetVehicleHealth(GetPlayerVehicleID(playerid), hp);
		if(hp < PlayerVehHP[playerid])
		{
		    if(GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z) < 15.0)
		    {
				GetVehicleHealth(vehicleid, hpa);
				SetVehicleHealth(vehicleid, hpa - (PlayerVehHP[playerid] - hp));
		    }
		}
		PlayerVehHP[playerid] = hp;
	    return 1;
	}
    return 1;
}

//================================================FUEL DEPO=======================================
forward CheckGate();

public CheckGate()
{
	{
		new vdgate1_status;
    	for(new i;i<MAX_PLAYERS;i++)
    	{
        	if(!IsPlayerConnected(i)) continue;
        	if(IsPlayerInRangeOfPoint(i,20.0,2497.33618, 2777.04663, 11.52759))vdgate1_status=1;
    	}
    	if(vdgate1_status)MoveObject(vdgate1, 2497.45557, 2784.91821, 11.52759,2);
    	else MoveObject(vdgate1, 2497.33618, 2777.04663, 11.52759, 2);
	}
	{
	    new vdgate2_status;
    	for(new i;i<MAX_PLAYERS;i++)
    	{
        	if(!IsPlayerConnected(i)) continue;
        	if(IsPlayerInRangeOfPoint(i,20.0,2497.37231, 2769.14404, 11.52242))vdgate2_status=1;
    	}
    	if(vdgate2_status)MoveObject(vdgate2, 2497.34180, 2761.37695, 11.52242,2);
    	else MoveObject(vdgate2, 2497.37231, 2769.14404, 11.52242, 2);
	}
}

forward CheckPdGate1(playerid);

public CheckPdGate1(playerid)
{
	if(pTeam[playerid] == team_mmpd)
	{
		new egate_status;
		for(new i;i<MAX_PLAYERS;i++)
		{
 			if(!IsPlayerConnected(i)) continue;
   			if(IsPlayerInRangeOfPoint(i,15.0,2294.73, 2502.78, 5.09))egate_status=1;
		}
		if(egate_status)MoveObject(EGate, 2294.72, 2492.78, 5.09, 2);
		else MoveObject(EGate, 2294.73, 2502.78, 5.09, 2);
	}
	else SendClientMessage(playerid, COLOR_RED, "Restricted Area");
}



//------------------------------------------------------------------------------------------------------------------------------------------------------------


//===================================================================COMMANDS===================================================================================




//------------------------------------------------GENERAL COMMANDS------------------------------------------


CMD:vlock(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new State=GetPlayerState(playerid);
		if(State!=PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid,0xFF004040,"You can only lock the doors as the driver.");
			return 1;
		}
		new i;
		for(i=0;i<MAX_PLAYERS;i++)
		{
			if(i != playerid)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
			}
		}
		SendClientMessage(playerid, 0x33AA33AA, "Vehicle locked!");
		new Float:pX, Float:pY, Float:pZ;
		GetPlayerPos(playerid,pX,pY,pZ);
		PlayerPlaySound(playerid,1056,pX,pY,pZ);
	}
	else
	{
	SendClientMessage(playerid, 0xFF004040, "You're not in a vehicle!");
	}
  	return 1;
}
CMD:vunlock(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid))
	{
		new State=GetPlayerState(playerid);
		if(State!=PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid,0xFF004040,"You can only unlock the doors as the driver.");
			return 1;
		}
		new i;
		for(i=0;i<MAX_PLAYERS;i++)
		{
			SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
		}
		SendClientMessage(playerid, 0x33AA33AA, "Vehicle unlocked!");
		new Float:pX, Float:pY, Float:pZ;
		GetPlayerPos(playerid,pX,pY,pZ);
		PlayerPlaySound(playerid,1057,pX,pY,pZ);
	}
	else
	{
	SendClientMessage(playerid, 0xFF004040, "You're not in a vehicle!");
	}
	return 1;
}

CMD:ogarage(playerid, params[])
{
		if(IsPlayerInRangeOfPoint(playerid, 15.0, 2057.29, 2437.43, 12.62))
		{
		MoveObject(Shutter,	2057.29, 2437.43, 16.94, 2);
		SetTimer("Shutters", 10000,0);
		}
		else return 0;
		return 1;
}
forward Shutters();
public Shutters()
{
	MoveObject(Shutter, 2057.29, 2437.43, 12.62, 2);
	SetTimer("Shutters", 10000,0);
}

CMD:myteam(playerid, params[])
{
	if(pTeam[playerid] == team_mmpd)
	{
	SendClientMessage(playerid, BBLUE, "You are a MMPD Officer");
	return 1;
	}
	if(pTeam[playerid] == team_civ)
	{
	SendClientMessage(playerid, COLOR_YELLOW, "You are a Civilian");
	return 1;
	}
	return 1;
}

CMD:robj(playerid, params[])
{
	for(new i=0; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
 	{
  		if (IsPlayerAttachedObjectSlotUsed(playerid, i)) RemovePlayerAttachedObject(playerid, i);
   	}
    return 1;
}

CMD:sendloc(playerid, params[])
{

	new string[128], targetid, target[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
	GetPlayerName(targetid, target, sizeof(target));
	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_LIGHTGREEN, "USAGE: /sendloc [ID]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_RED, "Player Does Not Exist!!!");
	format(string, sizeof(string), "%s sent his location", name);
    SendClientMessage(targetid, COLOR_LIGHTGREEN, string);
	SendClientMessage(targetid, COLOR_LIGHTGREEN, "Use /acceptloc to get the location");
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "You have sent your location successfully");
	Sendloc[targetid] = 1;
	return 1;
}

CMD:acceptloc(playerid, params[])
{
	if(Sendloc[playerid] == 1) //return SendClientMessage(playerid, COLOR_LIGHTGREEN,"You have not recived any location to accept");
	{
	new Float:x, Float:y, Float:z;
	new string[128], targetid, target[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	GetPlayerName(targetid, target, sizeof(target));
	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_LIGHTGREEN, "USAGE: /acceptloc [ID]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_RED, "Player Does Not Exist!!!");
	format(string, sizeof(string), "%s accepted to see your location", name);
    GetPlayerPos(targetid, x, y, z);
    SetPlayerCheckpoint(playerid, x, y, z, 3.0);
	SendClientMessage(targetid, COLOR_GREEN, string);
	}
	else return SendClientMessage(playerid, COLOR_LIGHTGREEN, "You have not recived any location to accept");
	return 1;
}

CMD:refuel(playerid, params[])
{
    	if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,0xFFC800FF,"You are not in an vehicle!"); //if a player isnt in a vehicle, it stops here
        if (isrefuelling[playerid]) return SendClientMessage(playerid,0xFFC800FF,"You are already refuelling!"); //if a player is already refuelling, it stops here
        if (GetPlayerMoney(playerid) - 80 <0) return SendClientMessage(playerid,0xFFC800FF,"You dont have enough money!"); //if a player doesnt have $80 anymore, it stops here
        GivePlayerMoney(playerid,-80); //Sets the player's cash -$80
        SetCameraBehindPlayer(playerid); //Sets the camera behind the player (looks better because the player will be frozen for a few secs)
        TogglePlayerControllable(playerid,0); //freezes the player so he cant drive and refuel at the same time
        isrefuelling[playerid] = 1; //setting isrefuelling to 1 so the player cant spam /refuel
        PlayerTextDrawSetString(playerid, SPEEDOMETER[playerid][5], "Refuelling...."); //changing textdraw to /refuel
        SetTimerEx("timer_refuel",4500,false,"i",playerid); //setting refueltimer
        return 1;
}
	
//-----------------------------------------------ENGINE----------------------------------------------



//-------------------------------------------ENGINE CMD END------------------------------------------------------

//=================================================================================================================


//---------------------------POLICE DEPARTMENT COMMANDS-------------------------

CMD:fbitruck(playerid, params[])
{
	if(pTeam[playerid] == team_mmpd)
	{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(528, x+5, y+5, z, az, -1, -1, 528);
 	}
 	else
 	{
 	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
 	return 1;
}
CMD:openpd1(playerid, params[])
{
	if(pTeam[playerid] == team_mmpd)
	{
		if(IsPlayerInRangeOfPoint(playerid, 15.0, 2294.73, 2502.78, 5.09))
		{
			MoveObject(EGate,  2294.72, 2492.78, 5.09, 3);
	 		SetTimer("EGates", 10000,0);
		}
		else
		{
	  		SendClientMessage(playerid, COLOR_RED, "You are not close to the gate, get closer and try again!");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
forward EGates();
public EGates()
{
    MoveObject(EGate, 2294.73, 2502.78, 5.09, 2);
	SetTimer("EGates", 10000,0);
}

CMD:openpd2(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		if(IsPlayerInRangeOfPoint(playerid, 15.0,  2334.80, 2443.55, 7.42))
		{
  		MoveObject(EShutter,  2334.80, 2443.55, 12.51, 2);
	 	SetTimer("EShutters", 10000,0);
  		}
	  	else
	  	{
	  		SendClientMessage(playerid, COLOR_RED, "You are not close to the gate, get closer and try again!");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
forward EShutters();
public EShutters()
{
    MoveObject(EShutter, 2334.80, 2443.55, 7.42, 2);
	SetTimer("EShutters", 10000,0);
}

CMD:panzer(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(432, x+5, y+5, z, az, -1, -1, 432);
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}

CMD:pdbike(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(523, x+5, y+5, z, az, -1, -1, 523);
	}
	else
	{
	     SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}

CMD:pdchopper(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(497, x+5, y+5, z, az, -1, -1, 497);
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}

CMD:pd1(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(596, x+5, y+5, z, az, -1, -1, 596);
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
CMD:pd2(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(597, x+5, y+5, z, az, -1, -1, 597);
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
CMD:pd3(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(598, x+5, y+5, z, az, -1, -1, 598);
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
 	}
 	return 1;
}
CMD:pd4(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(599, x+5, y+5, z, az, -1, -1, 599);
	}
	else
	{
 		SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
CMD:swat(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(601, x+5, y+5, z, az, -1, -1, 601);
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
 	return 1;
}


CMD:pdmsg(playerid, params[])
{
	for(new i=0; i <= MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(pTeam[i] == team_mmpd)
	        {
	        SendClientMessage(i, BBLUE, "A message has been sent to all online police officers.");
	        }
		}
	}
	return 1;
}

CMD:cuff(playerid, params[])//This is will create you cmd so you can continue your codes.
{
    new targetid;//this defines the id of the player you want to cuff((playerid id your id and the target id that I defined it the id of the player you want to cuff))
    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[USAGE]: /cuff [Part of Name/Player ID]");
    if(IsPlayerConnected(targetid))//this will check that if the player you want to cuff is connected to the server or not.
    {
		new Float:x, Float:y, Float:z;//these are the defines of your x,y and z position.
 		GetPlayerPos(playerid, x, y, z);//this will store your position to be used in the following codes.((this stores the your x,y, and z position in to the variables we created.))
    	if(IsPlayerInRangeOfPoint(targetid, 5.0, x, y, z))//this will check that if the player you want to cuff is near you or not.
		{
    		new str[512];//this it the define for the string you will format further.((str means string.You can also change it to string but this seems to be easy.))
    		new name[MAX_PLAYER_NAME];//this is the variable you created to store the your name.
    		GetPlayerName(playerid, name, sizeof(name));//this will get your name and store it in the variable you defines as name.
    		new target[MAX_PLAYER_NAME];//this is the variable you created to store the name of the player you want to cuff.
    		GetPlayerName(targetid, target, sizeof(target));//this will get the name of the person you want to cuff and will store it into a variable we defined as target.
    		format(str, sizeof(str), "INFO: You have cuffed %s!",target);//explained at the end of the tutorial.
    		SendClientMessage(playerid, 0xE01B1B, str);//this will send the formated message to you that you created before.
    		format(str, sizeof(str), "WARNING: You have been cuffed by %s!",name);//explained at the end of the tutorial.
    		SendClientMessage(targetid, 0xE01B1B, str);//this will send the formated message to the player you cuffed.
    		SetPlayerAttachedObject(targetid, 0, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977,-81.700035, 0.891999, 1.000000, 1.168000);//this will set the object cuffs at the hand of the player you want to cuff.
    		SetPlayerSpecialAction(targetid,SPECIAL_ACTION_CUFFED);//this will set players hand backwards.
			return 1;
     	}
 	}
	return 1;
}

CMD:uncuff(playerid, params[])//sfcs cmd.
{

	new targetid;//this defines the id of the player you want to cuff((playerid id your id and the target id that I defined it the id of the player you want to cuff))
 	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[USAGE]: /uncuff [Part of Name/Player ID]");
  	if(IsPlayerConnected(targetid))//this will check that if the player you want to cuff is connected to the server or not.
   	{
    	new Float:x, Float:y, Float:z;//these are the defines of your x,y and z position.
    	GetPlayerPos(playerid, x, y, z);//this will store your position to be used in the following codes.((this stores the your x,y, and z position in to the variables we created.))
     	if(IsPlayerInRangeOfPoint(targetid, 5.0, x, y, z))//this will check that if the player you want to cuff is near you or not.
    	{
    		if(!SetPlayerAttachedObject(targetid, 0, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977,-81.700035, 0.891999, 1.000000, 1.168000))return SendClientMessage(playerid,-1,"ERROR: The player is not cuffed!");//this will check that if the player is not cuffed and you are trying to apply this cmd,this will send him a error message.
    		SetPlayerSpecialAction(targetid,SPECIAL_ACTION_NONE);//this will remove the players cuffs and his arms will go normal.
    		new str[512];//this it the define for the string you will format further.((str means string.You can also change it to string but this seems to be easy.))
    		new name[MAX_PLAYER_NAME];//this is the variable you created to store the your name.
    		GetPlayerName(playerid, name, sizeof(name));//this will get your name and store it in the variable you defines as name.
    		new target[MAX_PLAYER_NAME];//this is the variable you created to store the name of the player you want to cuff.
    		GetPlayerName(targetid, target, sizeof(target));//this will get the name of the person you want to cuff and will store it into a variable we defined as target.
    		format(str, sizeof(str), "INFO: You have uncuffed %s!",target);//explained at the end of the tutorial.
    		SendClientMessage(playerid, 0xE01B1B, str);//will send the formated message to you that you created above.
    		format(str, sizeof(str), "WARNING: You have been uncuffed by %s!",name);//explained bellow.
    		SendClientMessage(targetid, 0xE01B1B, str);//will send the formated message to the player you want to cuff that you created above.
    		return 1;
    	}
	}
	return 1;
}

CMD:opshutter(playerid, params[])
{
	if(pTeam[playerid] == team_mmpd)
	{
		if(IsPlayerInRangeOfPoint(playerid, 25.0,  148.16, 1701.46, 19.87))
		{
  		MoveObject(PShutter,  148.18, 1709.74, 19.87, 4);
	 	SetTimer("PShutters", 10000,0);
  		}
	  	else
	  	{
	  		SendClientMessage(playerid, COLOR_RED, "You are not close to the gate, get closer and try again!");
		}
	}
	else
	{
        SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
forward PShutters();
public PShutters()
{
    MoveObject(PShutter, 148.16, 1701.46, 19.87, 4);
	SetTimer("PShutters", 10000,0);
}

CMD:opgate(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		if(IsPlayerInRangeOfPoint(playerid, 25.0,  127.46, 1663.82, 19.58))
		{
  		MoveObject(PGate,  113.71, 1663.82, 19.58, 4);
	 	SetTimer("PGates", 10000,0);
  		}
	  	else
	  	{
            SendClientMessage(playerid, COLOR_RED, "You are not close to the gate, get closer and try again!");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
forward PGates();
public PGates()
{
    MoveObject(PGate, 127.46, 1663.82, 19.58, 4);
	SetTimer("PGates", 10000,0);
}

CMD:prison1(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		if(IsPlayerInRangeOfPoint(playerid, 25.0,  89.89, 1756.68, 17.91))
		{
  		MoveObject(PCell1,  88.13, 1756.61, 17.91, 2);
	 	SetTimer("PCells1", 10000,0);
  		}
	  	else
	  	{
	  	    SendClientMessage(playerid, COLOR_RED, "You are not close to the gate, get closer and try again!");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
forward PCells1();
public PCells1()
{
    MoveObject(PCell1, 89.89, 1756.68, 17.91, 2);
	SetTimer("PCells1", 10000,0);
}

CMD:prison2(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		if(IsPlayerInRangeOfPoint(playerid, 25.0,  100.46, 1756.73, 17.91))
		{
  		MoveObject(PCell2,  98.73, 1756.71, 17.91, 2);
	 	SetTimer("PCells2", 10000,0);
  		}
	  	else
	  	{
	  	    SendClientMessage(playerid, COLOR_RED, "You are not close to the gate, get closer and try again!");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
forward PCells2();
public PCells2()
{
    MoveObject(PCell2, 100.46, 1756.73, 17.91, 2);
	SetTimer("PCells2", 10000,0);
}

CMD:prison3(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		if(IsPlayerInRangeOfPoint(playerid, 25.0,  110.91, 1756.86, 17.90))
		{
  		MoveObject(PCell3,  109.16, 1756.84, 17.90, 2);
	 	SetTimer("PCells3", 10000,0);
  		}
	  	else
	  	{
	  	    SendClientMessage(playerid, COLOR_RED, "You are not close to the gate, get closer and try again!");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
forward PCells3();
public PCells3()
{
    MoveObject(PCell3, 110.91, 1756.86, 17.90, 2);
	SetTimer("PCells3", 10000,0);
}

CMD:prison4(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
		if(IsPlayerInRangeOfPoint(playerid, 25.0,  121.11, 1756.96, 17.90))
		{
  		MoveObject(PCell4,  119.38, 1756.92, 17.90, 2);
	 	SetTimer("PCells4", 10000,0);
  		}
	  	else
	  	{
	  	    SendClientMessage(playerid, COLOR_RED, "You are not close to the gate, get closer and try again!");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}
forward PCells4();
public PCells4()
{
    MoveObject(PCell4, 121.11, 1756.96, 17.90, 2);
	SetTimer("PCells4", 10000,0);
}

/*CMD:jail(playerid, params[])
{
    new targetid;//this defines the id of the player you want to cuff((playerid id your id and the target id that I defined it the id of the player you want to cuff))
 	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[USAGE]: /jail [Part of Name/Player ID]");
  	if(IsPlayerConnected(targetid))//this will check that if the player you want to jail is connected to the server or not.
  	{
	  	new Float:x, Float:y, Float:z;//these are the defines of your x,y and z position.
    	GetPlayerPos(playerid, x, y, z);//this will store your position to be used in the following codes.((this stores the your x,y, and z position in to the variables we created.))
    	if(IsPlayerInRangeOfPoint(targetid, 5.0, x, y, z))//this will check that if the player you want to cuff is near you or not.
  		{
  		    SetPlayerPos(targetid, 198.9056,159.9787,1003.0234);
		}
	}
	return 1;
}*/

CMD:pdonduty(playerid, params[])
{
	if(pTeam[playerid] == team_mmpd)
	{
	    
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 198.94, 168.27, 1003.00))
		{
			duty = 1;
			SendClientMessage(playerid, BBLUE, "You are on duty now");
        	SendClientMessage(playerid, BBLUE, "Use /uniform to put on your uniform");
        	GivePlayerWeapon(playerid, 24, 200);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "Get near to the pd register officr");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not authorised to use this command");
	}
	return 1;
}

CMD:uniform(playerid, params[])
{
    if(pTeam[playerid] == team_mmpd)
    {
        if(duty == 1)
        {
            SetPlayerSkin(playerid, 266);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "You're not on duty");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_RED, "You're not a pd officer");
	}
	return 1;
}
//-------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------ADMIN COMMANDS------------------------------------------------------------------

CMD:dump(playerid, params[])
{
   		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(406, x+5, y+5, z, az, -1, -1, 406);
   		return 1;
}
CMD:bmx(playerid, params[])
{
        new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(481, x+5, y+5, z, az, -1, -1, 481);
   		return 1;
}
CMD:landstalker(playerid, params[])
{
   		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(400, x+5, y+5, z, az, -1, -1, 400);
   		return 1;
}
CMD:admiral(playerid, params[])
{
   		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(445, x+5, y+5, z, az, -1, -1, 445);
   		return 1;
}
CMD:dune(playerid, params[])
{
   		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(573, x+5, y+5, z, az, -1, -1, 573);
   		return 1;
}
CMD:swiggy(playerid, params[])
{
   		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(462, x+5, y+5, z, az, -1, -1, 462);
   		return 1;
}
CMD:patriot(playerid, params[])
{
   		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(470, x+5, y+5, z, az, -1, -1, 470);
   		return 1;
}

CMD:bravura(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(401, x+5, y+5, z, az, -1, -1, 401);
   		return 1;
}
CMD:buffalo(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(402, x+5, y+5, z, az, -1, -1, 402);
   		return 1;
}
CMD:linerunner(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(403, x+5, y+5, z, az, -1, -1, 403);
   		return 1;
}
CMD:perennial(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(404, x+5, y+5, z, az, -1, -1, 404);
   		return 1;
}
CMD:sentinel(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(405, x+5, y+5, z, az, -1, -1, 405);
   		return 1;
}
CMD:firetruck(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(407, x+5, y+5, z, az, -1, -1, 407);
   		return 1;
}
CMD:ambulance(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(416, x+5, y+5, z, az, -1, -1, 416);
   		return 1;
}
CMD:enforcer(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(427, x+5, y+5, z, az, -1, -1, 427);
   		return 1;
}
CMD:tram(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(449, x+5, y+5, z, az, -1, -1, 449);
   		return 1;
}
CMD:turismo(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(451, x+5, y+5, z, az, -1, -1, 451);
   		return 1;
}
CMD:freeway(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(463, x+5, y+5, z, az, -1, -1, 463);
   		return 1;
}
CMD:sanchez(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(468, x+5, y+5, z, az, -1, -1, 468);
   		return 1;
}
CMD:fcr(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(521, x+5, y+5, z, az, -1, -1, 521);
   		return 1;
}
CMD:nrg(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(522, x+5, y+5, z, az, -1, -1, 522);
   		return 1;
}
CMD:hustler(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(545, x+5, y+5, z, az, -1, -1, 545);
   		return 1;
}

CMD:suicid(playerid, params[])
{
		SetPlayerHealth(playerid, 0);
		return 1;
}
CMD:armour(playerid, params[])
{
		SetPlayerArmour(playerid, 125);
		return 1;
}
CMD:taxi1(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(420, x+5, y+5, z, az, -1, -1, 420);
   		return 1;
}
CMD:taxi2(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(438, x+5, y+5, z, az, -1, -1, 438);
   		return 1;
}
CMD:skimmer(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(460, x+5, y+5, z, az, -1, -1, 460);
   		return 1;
}
CMD:seasparrow(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(447, x+5, y+5, z, az, -1, -1, 447);
   		return 1;
}
CMD:collector(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(428, x+5, y+5, z, az, -1, -1, 428);
   		return 1;
}
CMD:hunter(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(425, x+5, y+5, z, az, -1, -1, 425);
   		return 1;
}
CMD:rustler(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(476, x+5, y+5, z, az, -1, -1, 476);
   		return 1;
}
CMD:newschopper(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(488, x+5, y+5, z, az, -1, -1, 488);
   		return 1;
}
CMD:privatechopper(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(487, x+5, y+5, z, az, -1, -1, 487);
   		return 1;
}

CMD:supergt(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(506, x+5, y+5, z, az, -1, -1, 506);
   		return 1;
}
CMD:beagle(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(511, x+5, y+5, z, az, -1, -1, 511);
   		return 1;
}
CMD:cropduster(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(512, x+5, y+5, z, az, -1, -1, 512);
   		return 1;
}
CMD:stuntplane(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(513, x+5, y+5, z, az, -1, -1, 513);
   		return 1;
}
CMD:shamal(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(519, x+5, y+5, z, az, -1, -1, 519);
   		return 1;
}
CMD:hydra(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(520, x+5, y+5, z, az, -1, -1, 520);
   		return 1;
}
CMD:nevada(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(553, x+5, y+5, z, az, -1, -1, 553);
   		return 1;
}
CMD:at400(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(577, x+5, y+5, z, az, -1, -1, 577);
   		return 1;
}
CMD:cheetah(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(415, x+5, y+5, z, az, -1, -1, 415);
   		return 1;
}
CMD:hotknife(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(434, x+5, y+5, z, az, -1, -1, 434);
   		return 1;
}

CMD:bus1(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(437, x+5, y+5, z, az, -1, -1, 437);
   		return 1;
}
CMD:andromada(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(592, x+5, y+5, z, az, -1, -1, 592);
   		return 1;
}
CMD:bus2(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(431, x+5, y+5, z, az, -1, -1, 431);
   		return 1;
}

CMD:newsvan(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(582, x+5, y+5, z, az, -1, -1, 582);
   		return 1;
}

CMD:rvcmdlist(playerid, params[])
{
		SendClientMessage(playerid, COLOR_GREEN, "---------------------------------------VEHICLES---------------------------------------");
		SendClientMessage(playerid, COLOR_GREEN, "</dump> </bmx> </landstalker> </swiggy> </hustler> </collector> </nrg> ");
		SendClientMessage(playerid, COLOR_GREEN, "</bravura> </buffalo> </linerunner> </perennial> </sentinel> </supergt> </fcr> </sanchez>");
		SendClientMessage(playerid, COLOR_GREEN, "</tram> </turismo> </freeway> </taxi1> </taxi2> </cheetah> </hotknife> </bus1> </bus2>");
		return 1;
}
CMD:avcmdlist(playerid, params[])
{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "------------------------------------AIR VEHICLES------------------------------------");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "</skimmer> </seasparrow> </rustler> </privatechopper> </beagle> </cropduster>");
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "</stuntplane> </shamal> </hydra> </nevada> </at400> </andromada>");
		return 1;
}
CMD:deptvcmdlist(playerid, params[])
{
		SendClientMessage(playerid, 	BBLUE, "------------------------------------POLICE DEPARTMENT------------------------------------");
		SendClientMessage(playerid, 	BBLUE, "</pd1> </pd2> </pd3> </pd4> </pdbike> </pdchopper> </fbitruck> </swat> </enforcer>");
        SendClientMessage(playerid,	COLOR_ORANGE, "------------------------------------EMERGENCY DEPARTMENT------------------------------------");
        SendClientMessage(playerid, COLOR_ORANGE, "</firetruck> </ambulance>");
        SendClientMessage(playerid, COLOR_PINK, "------------------------------------NEWS DEPARTMENT------------------------------------");
		SendClientMessage(playerid, COLOR_PINK, "</newschopper> </newsvan>");
		SendClientMessage(playerid, COLOR_YELLOW, "------------------------------------MILITARY DEPARTMENT------------------------------------");
		SendClientMessage(playerid, COLOR_YELLOW, "</patriot> </panzer> </hunter>");
		return 1;
}
CMD:cmdlist(playerid, params[])
{
        SendClientMessage(playerid,	COLOR_WHITE, "------------------------------------COMMAND LIST------------------------------------");
        SendClientMessage(playerid,	COLOR_WHITE, "</heal>		 	--> 100 HP");
        SendClientMessage(playerid,	COLOR_WHITE, "</suicid>      	--> 0 HP (Kills yourself");
        SendClientMessage(playerid,	COLOR_WHITE, "</armour>      	--> Gives you a armor");
        SendClientMessage(playerid,	COLOR_WHITE, "</openpd1>     	--> Opens police department gate 1");
        SendClientMessage(playerid,	COLOR_WHITE, "</openpd2>     	--> Opens police department gate 2");
        SendClientMessage(playerid,	COLOR_WHITE, "</ogarage>     	--> Opens public garage shutter");
        SendClientMessage(playerid,	COLOR_WHITE, "</rvcmdlist>   	--> Displays vehicle commands");
        SendClientMessage(playerid,	COLOR_WHITE, "</avcmdlist>   	--> Displays air vehicle commands");
        SendClientMessage(playerid,	COLOR_WHITE, "</deptvcmdlist>	--> Displays department vehicle commands");
		return 1;
}

CMD:euros(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(587, x+5, y+5, z, az, -1, -1, 587);
   		return 1;
}
CMD:pheonix(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(603, x+5, y+5, z, az, -1, -1, 603);
   		return 1;
}
CMD:infernus(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(411, x+5, y+5, z, az, -1, -1, 411);
   		return 1;
}
CMD:alpha(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(602, x+5, y+5, z, az, -1, -1, 602);
   		return 1;
}
CMD:banshee(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(429, x+5, y+5, z, az, -1, -1, 429);
   		return 1;
}
CMD:bullet(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(541, x+5, y+5, z, az, -1, -1, 541);
   		return 1;
}
CMD:jester(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(559, x+5, y+5, z, az, -1, -1, 559);
   		return 1;
}
CMD:zr350(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(477, x+5, y+5, z, az, -1, -1, 477);
   		return 1;
}
CMD:racecar1(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(502, x+5, y+5, z, az, -1, -1, 502);
   		return 1;
}
CMD:racecar2(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(503, x+5, y+5, z, az, -1, -1, 503);
   		return 1;
}
CMD:racecar3(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(494, x+5, y+5, z, az, -1, -1, 494);
   		return 1;
}
CMD:jetpack(playerid, params[])
{
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
	return 1;
}


CMD:petroltank(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(584, x+5, y+5, z, az, -1, -1, 584);
   		return 1;
}
CMD:trailer1(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(435, x+5, y+5, z, az, -1, -1, 435);
   		return 1;
}
CMD:trailer2(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(450, x+5, y+5, z, az, -1, -1, 450);
   		return 1;
}
CMD:tanker(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(514, x+5, y+5, z, az, -1, -1, 514);
   		return 1;
}
CMD:roadtrain(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(515, x+5, y+5, z, az, -1, -1, 515);
   		return 1;
}
CMD:flatbed(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(455, x+5, y+5, z, az, -1, -1, 455);
   		return 1;
}
CMD:dft30(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(578, x+5, y+5, z, az, -1, -1, 578);
   		return 1;
}
CMD:pcj(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(461, x+5, y+5, z, az, -1, -1, 461);
   		return 1;
}
CMD:bf(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(581, x+5, y+5, z, az, -1, -1, 581);
   		return 1;
}
CMD:wayfarer(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(586, x+5, y+5, z, az, -1, -1, 586);
   		return 1;
}
CMD:boat1(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(446, x+5, y+5, z, az, -1, -1, 446);
   		return 1;
}
CMD:sabre(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(475, x+5, y+5, z, az, -1, -1, 475);
   		return 1;
}
CMD:leviathan(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(417, x+5, y+5, z, az, -1, -1, 417);
   		return 1;
}
CMD:cargobob(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(548, x+5, y+5, z, az, -1, -1, 548);
   		return 1;
}
CMD:raindance(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(563, x+5, y+5, z, az, -1, -1, 563);
   		return 1;
}
CMD:vortex(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(539, x+5, y+5, z, az, -1, -1, 539);
   		return 1;
}
CMD:kart(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(571, x+5, y+5, z, az, -1, -1, 571);
   		return 1;
}
CMD:harvester(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(532, x+5, y+5, z, az, -1, -1, 532);
   		return 1;
}
CMD:comet(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(480, x+5, y+5, z, az, -1, -1, 480);
   		return 1;
}
CMD:monster1(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(444, x+5, y+5, z, az, -1, -1, 444);
   		return 1;
}
CMD:monster2(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(556, x+5, y+5, z, az, -1, -1, 556);
   		return 1;
}
CMD:monster3(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(557, x+5, y+5, z, az, -1, -1, 557);
   		return 1;
}
CMD:bandito(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(568, x+5, y+5, z, az, -1, -1, 568);
   		return 1;
}
CMD:sandking(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(495, x+5, y+5, z, az, -1, -1, 495);
   		return 1;
}
CMD:mesa(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(500, x+5, y+5, z, az, -1, -1, 500);
   		return 1;
}

CMD:trash(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(408, x+5, y+5, z, az, -1, -1, 408);
   		return 1;
}

CMD:heal(playerid, params[])
{
		SetPlayerHealth(playerid, 125);
   		return 1;
}


//-------------------------------------------------------------------------------------------------------------------------------------------------------------
//==========================================================================Team Login==========================================================================

//====================================================================MMPD LOGIN CREDENTIALS=====================================================================

//*********Donald_Pump == MMPD*********
CMD:donaldpumppdofficer123(playerid, params[])
{
		if(pTeam[playerid] == team_mmpd) return SendClientMessage(playerid, BBLUE, "You are already a police officer");
 		if(pTeam[playerid] == team_mech) return SendClientMessage(playerid, BBLUE, "Resign your mechanic job first");
  		if(pTeam[playerid] == team_ems)  return SendClientMessage(playerid, BBLUE, "Resign your MM Emergency job first");

		if(pTeam[playerid] == team_civ)
		{
 		   pTeam[playerid] = team_mmpd;
 		   SetPlayerColor(playerid, COLOR_RED);
		}
		return 1;
}

CMD:sa26nd11(playerid, params[])
{
        if(pTeam[playerid] == team_mmpd) return SendClientMessage(playerid, BBLUE, "You are already a police officer");
 		if(pTeam[playerid] == team_mech) return SendClientMessage(playerid, BBLUE, "Resign your mechanic job first");
  		if(pTeam[playerid] == team_ems)  return SendClientMessage(playerid, BBLUE, "Resign your MM Emergency job first");

		if(pTeam[playerid] == team_civ)
		{
 		   pTeam[playerid] = team_mmpd;
 		   SetPlayerColor(playerid, COLOR_RED);
		}
		return 1;
}

CMD:vakilpd321(playerid, params[])
{
        if(pTeam[playerid] == team_mmpd) return SendClientMessage(playerid, BBLUE, "You are already a police officer");
 		if(pTeam[playerid] == team_mech) return SendClientMessage(playerid, BBLUE, "Resign your mechanic job first");
  		if(pTeam[playerid] == team_ems)  return SendClientMessage(playerid, BBLUE, "Resign your MM Emergency job first");

		if(pTeam[playerid] == team_civ)
		{
 		   pTeam[playerid] = team_mmpd;
 		   SetPlayerColor(playerid, COLOR_RED);
		}
		return 1;
}

CMD:hs(playerid, params[])
{
	SetPlayerPos(playerid, 1452.63, 2776.25, 10.90);
	return 1;
}

CMD:nitro(playerid, params[])
{
	AddVehicleComponent(playerid, 1010);
	return 1;
}


CMD:restart(playerid, params[])
{
	new string[64];
	format( string, sizeof(string), "~w~ Puyal Yecharikkai");
    GameTextForAll( string, 5000, 3 );
    SetWeather(16);
    return 1;
}



CMD:freeze(playerid, params[])
{
    new targetid;

	if(sscanf(params, "u", targetid))
	{
	    return SendClientMessage(playerid, COLOR_RED, "Usage: /freeze [playerid]");
	}
	if(targetid == playerid)
	{
	    return SendClientMessage(playerid, COLOR_RED, "You can't freeze yourself.");
	}
	if(PlayerInfo[targetid][pDraggedBy] == INVALID_PLAYER_ID)
	{
		PlayerInfo[targetid][pDraggedBy] = playerid;
		TogglePlayerControllable(targetid, 0);
		
	}
	else
	{
	    PlayerInfo[targetid][pDraggedBy] = INVALID_PLAYER_ID;
	    TogglePlayerControllable(targetid, 1);
	}

	return 1;
}

CMD:tune_hyd(playerid, params[])
{
 	//new playervehicle = GetPlayerVehicleID(playerid);
    if(IsPlayerInAnyVehicle(playerid))
 	{
			AddVehicleComponent(playerid, 1087);
			SendClientMessage(playerid, COLOR_GREEN, "Hydralics System Successfully Installed in your Vehicle");
 	}
	return 1;
}

CMD:money(playerid, params[])
{
	if(pTeam[playerid] == team_admins) 
	{
	    GivePlayerMoney(playerid, 500000);
	}
	else
	{
	 	SendClientMessage(playerid, COLOR_RED, "You are not authorised to use this command");
	}
	return 1;
}

CMD:mmadmin(playerid, params[])
{
    pTeam[playerid] = team_admins;
    return 1;
}

CMD:lim(playerid, params[])
{
 		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(409, x+5, y+5, z, az, -1, -1, 409);
   		return 1;
}

CMD:tp(playerid, params[])
{
	SetPlayerPos(playerid, 1690.6682,1451.0737,10.7661);
	return 1;
}

CMD:sunrise(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(550, x+5, y+5, z, az, -1, -1, 550);
   		return 1;
}

CMD:club(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(589, x+5, y+5, z, az, -1, -1, 589);
   		return 1;
}

CMD:sultan(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(560, x+5, y+5, z, az, -1, -1, 560);
   		return 1;
}

CMD:tampa(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(549, x+5, y+5, z, az, -1, -1, 549);
   		return 1;
}

CMD:sperant(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(419, x+5, y+5, z, az, -1, -1, 419);
   		return 1;
}

CMD:bfinjection(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(424, x+5, y+5, z, az, -1, -1, 424);
   		return 1;
}

CMD:feltzer(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(533, x+5, y+5, z, az, -1, -1, 533);
   		return 1;
}

CMD:remington(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(534, x+5, y+5, z, az, -1, -1, 534);
   		return 1;
}

CMD:huntley(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(579, x+5, y+5, z, az, -1, -1, 579);
   		return 1;
}

CMD:stafford(playerid, params[])
{
		new Float:x, Float:y, Float:z, Float:az;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, az);
		CreateVehicle(580, x+5, y+5, z, az, -1, -1, 580);
   		return 1;
}


//=======================================================================vd job==============================================

CMD:vdhire(playerid, params[])
{
	new playername[64];
	GetPlayerName(playerid,playername,64);
	if(!strcmp(playername,"KAA_LA",true))
	{
        new targetid, target[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, name, sizeof(name));
		GetPlayerName(targetid, target, sizeof(target));
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /vdhire [ID]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_RED, "Player Does Not Exist!!!");
		SendClientMessage(targetid, COLOR_ORANGE, "You are hired to VD FUELS  !!");
		SendClientMessage(targetid, COLOR_ORANGE, "Start working after PUYAL");
        pTeam[targetid] = team_vdfuels;
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You are not authorised to hire a person to this company");
	}
	return 1;
}

CMD:vdfire(playerid, params[])
{
    new playername[64];
	GetPlayerName(playerid,playername,64);
	if(!strcmp(playername,"KAA_LA",true))
	{
        new targetid, target[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, name, sizeof(name));
		GetPlayerName(targetid, target, sizeof(target));
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /vdfire [ID]");
		SendClientMessage(targetid, COLOR_ORANGE, "You are fired from VD FUELS  !!");
        pTeam[targetid] = team_civ;

	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You are not authorised to fire a person to this company");
	}
	return 1;
}

CMD:vdonduty(playerid, params[])
{
	if(pTeam[playerid] == team_vdfuels)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, -997.51428, -601.90192, 32.03395))
	    {
			onTeam[playerid] = state_vdonduty;
	        SendClientMessage(playerid, COLOR_ORANGE, "Take one of the company vehicle to start job");
			SetPlayerSkin(playerid, 116);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "You're not in the position to mark onduty");
	    }
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're unauthorised personnel");
	}
	return 1;
}

CMD:vdoffduty(playerid, params[])
{
	if(onTeam[playerid] == state_vdonduty)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, 2306.29443, -16.15894, 26.34385))
	    {
			onTeam[playerid] = state_vdoffduty;
			SendClientMessage(playerid, COLOR_RED, "You're offduty now");
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "You're not in the position to mark offduty");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You're not on duty");       //5907
	}
	new playername[64];
	GetPlayerName(playerid,playername,64);
	if(!strcmp(playername,"Vakil_Vandumurugan",true))
	{
		SetPlayerSkin(playerid, 240);
	}
	else if(!strcmp(playername,"Donald_Pump",true))
	{
		SetPlayerSkin(playerid, 59);
	}
	else if(!strcmp(playername,"Paul_Walker",true))
	{
		SetPlayerSkin(playerid, 164);
	}
	else if(!strcmp(playername,"Will_Smith",true))
	{
		SetPlayerSkin(playerid, 271);
	}
	else if(!strcmp(playername,"KAA_LA",true))
	{
		SetPlayerSkin(playerid, 294);
	}
	else if(!strcmp(playername,"Mr_BLAZA",true))
	{
		SetPlayerSkin(playerid, 299);
	}
	else if(!strcmp(playername,"Mr_Rohith_",true))
	{
		SetPlayerSkin(playerid, 115);
	}
	else if(!strcmp(playername,"ironman",true))
	{
		SetPlayerSkin(playerid, 289);
	}
	return 1;
}

CMD:startvdjob(playerid, params[])
{
	if(onTeam[playerid] == state_vdonduty)
	{
    	new vehicleid = GetPlayerVehicleID(playerid);
		if(GetPlayerVehicleID(playerid) == vdtruck[0])
 		{
 	    	if(IsTrailerAttachedToVehicle(vehicleid))
	  		{
				SetPlayerRaceCheckpoint(playerid, 1, 2524.5291,2817.5466,11.4272, 0, 0, 0, 5.0);
				SendClientMessage(playerid, COLOR_ORANGE, "Take the trailer safely to the destination");
			}
			else SendClientMessage(playerid, COLOR_RED, "You have not attached any trailer to your vehicle");
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[1])
 		{
 	    	if(IsTrailerAttachedToVehicle(vehicleid))
 	    	{
				SetPlayerRaceCheckpoint(playerid, 1, 2524.5291,2817.5466,11.4272, 0, 0, 0, 5.0);
				SendClientMessage(playerid, COLOR_ORANGE, "Take the trailer safely to the destination");
			}
			else SendClientMessage(playerid, COLOR_RED, "You have not attached any trailer to your vehicle");
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[2])
	 	{
	 	    if(IsTrailerAttachedToVehicle(vehicleid))
	 	    {
	 	    	SetPlayerRaceCheckpoint(playerid, 1, 2524.5291,2817.5466,11.4272, 0, 0, 0, 5.0);
				SendClientMessage(playerid, COLOR_ORANGE, "Take the trailer safely to the destination");
			}
			else SendClientMessage(playerid, COLOR_RED, "You have not attached any trailer to your vehicle");
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[3])
	 	{
	 	    if(IsTrailerAttachedToVehicle(vehicleid))
	 	    {
				SetPlayerRaceCheckpoint(playerid, 1, 2524.5291,2817.5466,11.4272, 0, 0, 0, 5.0);
				SendClientMessage(playerid, COLOR_ORANGE, "Take the trailer safely to the destination");
			}
			else SendClientMessage(playerid, COLOR_RED, "You have not attached any trailer to your vehicle");
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[4])
	 	{
	        if(IsTrailerAttachedToVehicle(vehicleid))
	        {
				SetPlayerRaceCheckpoint(playerid, 1, 2524.5291,2817.5466,11.4272, 0, 0, 0, 5.0);
				SendClientMessage(playerid, COLOR_ORANGE, "Take the trailer safely to the destination");
			}
			else SendClientMessage(playerid, COLOR_RED, "You have not attached any trailer to your vehicle");
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[5])
	 	{
	        if(IsTrailerAttachedToVehicle(vehicleid))
			{
				SetPlayerRaceCheckpoint(playerid, 1, 2524.5291,2817.5466,11.4272, 0, 0, 0, 5.0);
				SendClientMessage(playerid, COLOR_ORANGE, "Take the trailer safely to the destination");
			}
			else SendClientMessage(playerid, COLOR_RED, "You have not attached any trailer to your vehicle");
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[6])
	 	{
	        if(IsTrailerAttachedToVehicle(vehicleid))
	        {
	        	SetPlayerRaceCheckpoint(playerid, 1, 2524.5291,2817.5466,11.4272, 0, 0, 0, 5.0);
				SendClientMessage(playerid, COLOR_ORANGE, "Take the trailer safely to the destination");
			}
			else SendClientMessage(playerid, COLOR_RED, "You have not attached any trailer to your vehicle");
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[7])
	 	{
	        if(IsTrailerAttachedToVehicle(vehicleid))
	        {
				SetPlayerRaceCheckpoint(playerid, 1, 2524.5291,2817.5466,11.4272, 0, 0, 0, 5.0);
				SendClientMessage(playerid, COLOR_ORANGE, "Take the trailer safely to the destination");
			}
			else SendClientMessage(playerid, COLOR_RED, "You have not attached any trailer to your vehicle");
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[8])
	 	{
	        if(IsTrailerAttachedToVehicle(vehicleid))
	        {
				SetPlayerRaceCheckpoint(playerid, 1, 2524.5291,2817.5466,11.4272, 0, 0, 0, 5.0);
				SendClientMessage(playerid, COLOR_ORANGE, "Take the trailer safely to the destination");
			}
            else SendClientMessage(playerid, COLOR_RED, "You have not attached any trailer to your vehicle");
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[9])
	 	{
	        if(IsTrailerAttachedToVehicle(vehicleid))
	        {
				SetPlayerRaceCheckpoint(playerid, 1, 2524.5291,2817.5466,11.4272, 0, 0, 0, 5.0);
				SendClientMessage(playerid, COLOR_ORANGE, "Take the trailer safely to the destination");
			}
			else SendClientMessage(playerid, COLOR_RED, "You have not attached any trailer to your vehicle");
		}
	}
	else SendClientMessage(playerid, COLOR_RED, "You are not on-duty");
	return 1;
}


/*CMD:vdunload(playerid, params[])
{
	if(onteam == state_vdonduty)
	{
    	if(IsPlayerInRangeOfPoint(playerid, 5.0, 2524.2332, 2815.1272, 9.8068))
    	{
			RemovePlayerFromVehicle(playerid);
            SetVehicleToRespawn(GetPlayerVehicleID(playerid));
            DestroyVehicle(trailerid);
		}
	}
	return 1;
}*/

CMD:kick(playerid, params[])
{
	if(pTeam[playerid] == team_pwautodealers)
	{
		new targetid, target[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		GetPlayerName(targetid, target, sizeof(target));
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /kick [ID]");
    	RemovePlayerFromVehicle(targetid);
		SendClientMessage(targetid, COLOR_ORANGE, "You are kicked from the vehicle  !!");
	}
	return 1;
}


CMD:pwhire(playerid, params[])
{
	new playername[64];
	GetPlayerName(playerid,playername,64);
	if(!strcmp(playername,"Paul_Walker",true))
	{
        new targetid, target[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, name, sizeof(name));
		GetPlayerName(targetid, target, sizeof(target));
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /pwhire [ID]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_RED, "Player Does Not Exist!!!");
		SendClientMessage(targetid, COLOR_GREEN, "You are hired to PW AUTO DEALERSHIP  !!");
        pTeam[targetid] = team_pwautodealers;
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You are not authorised to hire a person to this company");
	}
	return 1;
}

CMD:mygarage(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 2067.08105, 2422.40527, 10.87387)) //public garage
	{
     	new playername[64];
		GetPlayerName(playerid,playername,64);
		if(!strcmp(playername,"KAA_LA",true))
		{
			ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "MY GARAGE" , "Landstalker\nRemington\nStretch\nHotknife" , "Select" , "Cancel");
		}
		else if(!strcmp(playername,"Mr_BLAZA",true))
		{
        	ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "MY GARAGE" , "Buffalo\nZR-350" , "Select" , "Cancel");
		}
		else if(!strcmp(playername,"Donald_Pump",true))
		{
	    	ShowPlayerDialog(playerid, 3, DIALOG_STYLE_LIST, "MY GARAGE" , "Stretch" , "Select" , "Cancel");
		}
    	else if(!strcmp(playername,"ironman",true))
    	{
        	ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, "MY GARAGE" , "Sultan\nZR-350\nEuros\nHotknife\nBF-400" , "Select" , "Cancel");
		}
		else if(!strcmp(playername,"Mr_Rohith_",true))
		{
	    	ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "MY GARAGE" , "Buffalo" , "Select" , "Cancel");
		}
		else if(!strcmp(playername,"Will_Smith",true))
		{
	    	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "MY GARAGE" , "Huntley" , "Select" , "Cancel");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "#ERROR: Get to the nearest public garage and try again");
	}
	return 1;
}

CMD:parkv(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new playername[64];
	GetPlayerName(playerid,playername,64);
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 2078.89819, 2416.60034, 10.52221)) //public garage
	{
	    if(!strcmp(playername,"KAA_LA",true))
     	{
	    	if(GetVehicleModel(vehicleid) == 400)//landstalker
	    	{
				
				DestroyVehicle(vehicleid);
				kaalalandstalkergarage = 1;
				return 1;
			}
			else if(GetVehicleModel(vehicleid) == 534) //remington
	    	{

				DestroyVehicle(vehicleid);
				kaalaremingtongarage = 1;
				return 1;
			}
			else if(GetVehicleModel(vehicleid) == 409) //stretch
	    	{

				DestroyVehicle(vehicleid);
				kaalastretchgarage = 1;
				return 1;
			}
			else if(GetVehicleModel(vehicleid) == 434) //hotknife
	    	{

				DestroyVehicle(vehicleid);
				kaalahotknifegarage = 1;
				return 1;
			}
		}
		else if(!strcmp(playername,"Mr_BLAZA",true))
     	{
	    	if(GetVehicleModel(vehicleid) == 402)//buffalo
	    	{

				DestroyVehicle(vehicleid);
				mrblazabuffalogarage = 1;
				return 1;
			}
			else if(GetVehicleModel(vehicleid) == 477)//zr350
	    	{

				DestroyVehicle(vehicleid);
				mrblazazr350garage = 1;
				return 1;
			}
		}
		else if(!strcmp(playername,"ironman",true))
     	{
	    	if(GetVehicleModel(vehicleid) == 477)//zr350
	    	{

				DestroyVehicle(vehicleid);
				ironmanzr350garage = 1;
				return 1;
			}
			else if(GetVehicleModel(vehicleid) == 560)//sultan
	    	{

				DestroyVehicle(vehicleid);
				ironmansultangarage = 1;
				return 1;
			}
			else if(GetVehicleModel(vehicleid) == 587)//euros
	    	{

				DestroyVehicle(vehicleid);
				ironmaneurosgarage = 1;
				return 1;
			}
			else if(GetVehicleModel(vehicleid) == 434) //hotknife
	    	{

				DestroyVehicle(vehicleid);
				ironmanhotknifegarage = 1;
				return 1;
			}
			else if(GetVehicleModel(vehicleid) == 581) //bf400
	    	{

				DestroyVehicle(vehicleid);
				ironmanbf400garage = 1;
				return 1;
			}
		}
		else if(!strcmp(playername,"Donald_Pump",true))
     	{
	    	if(GetVehicleModel(vehicleid) == 409) //stretch
	    	{

				DestroyVehicle(vehicleid);
				donaldpumpstretchgarage = 1;
				return 1;
			}
		}
		else if(!strcmp(playername,"Will_Smith",true))
     	{
	    	if(GetVehicleModel(vehicleid) == 579) //huntley
	    	{

				DestroyVehicle(vehicleid);
				willsmithhuntleygarage = 1;
				return 1;
			}
		}
		else if(!strcmp(playername,"Mr_Rohith_",true))
     	{
	    	if(GetVehicleModel(vehicleid) == 402)//buffalo
	    	{

				DestroyVehicle(vehicleid);
				mrrohithbuffalogarage = 1;
				return 1;
			}
		}
	}
	return 0;
}

CMD:donaldpump(playerid, params[])
{
	CreateVehicle(409, 2338.3962, 1399.9623, 10.5749, 89.5187, 138, 138, 0);
	return 1;
}

CMD:kaala1(playerid, params[])
{
	CreateVehicle(409, 2338.3962, 1399.9623, 10.5749, 89.5187, 0, 0, 0);
	return 1;
}

CMD:kaala2(playerid, params[])
{
    CreateVehicle(400, 2338.3962, 1399.9623, 10.5749, 89.5187, 0, 0, 0);
    return 1;
}

CMD:kaala3(playerid, params[])
{
    CreateVehicle(534, 2338.3962, 1399.9623, 10.5749, 89.5187, 0, 0, 0);
    return 1;
}

CMD:kaala4(playerid, params[])
{
    CreateVehicle(434, 2338.3962, 1399.9623, 10.5749, 89.5187, 0, 0, 0);
    return 1;
}

CMD:blaza1(playerid, params[])
{
    CreateVehicle(402, 2338.3962, 1399.9623, 10.5749, 89.5187, -1, -1, 0);
    return 1;
}

CMD:blaza2(playerid, params[])
{
    CreateVehicle(477, 2338.3962, 1399.9623, 10.5749, 89.5187, -1, -1, 0);
	return 1;
}

CMD:ironman1(playerid, params[])
{
    CreateVehicle(560, 2338.3962, 1399.9623, 10.5749, 89.5187, -1, -1, 0);
    return 1;
}

CMD:ironman2(playerid, params[])
{
    CreateVehicle(477, 2338.3962, 1399.9623, 10.5749, 89.5187, -1, -1, 0);
    return 1;
}

CMD:ironman3(playerid, params[])
{
    CreateVehicle(559, 2338.3962, 1399.9623, 10.5749, 89.5187, -1, -1, 0);
    return 1;
}

CMD:ironman4(playerid, params[])
{
    CreateVehicle(434, 2338.3962, 1399.9623, 10.5749, 89.5187, -1, -1, 0);
    return 1;
}

CMD:ironman5(playerid, params[])
{
    CreateVehicle(581, 2338.3962, 1399.9623, 10.5749, 89.5187, -1, -1, 0);
    return 1;
}

CMD:vrepair(playerid, params[])
{
	/**new playername[64];
	GetPlayerName(playerid,playername,64);
	if(pTeam[playerid] == team_mech)*/
	{
 		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xFFFFFFFF, "You are not in a vehicle!");
		RepairVehicle(GetPlayerVehicleID(playerid));
		SendClientMessage(playerid, 0xFFFFFFFF, "You've repaired a vehicle!");
	}
 	return 1;
}

/*CMD:changecolor(playerid, params[])
{
    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "COLORS" , "128 \n 129 \n 130 \n 131 \n 132 \n 133 \n 134 \n 135 \n 136 \n 137 \n 138 \n 139 \n 140 \n 141 \n 142 \n 143 \n 144 \n 145 \n 146 \n 147 \n 148 \n 149 \n 150 \n 151 \n 152 \n 153 \n 154 \n 155 \n 156 \n 157 \n 158 \n 159 \n 160 \n 161 \n 162 \n 163 \n 164 \n 165 \n 166 \n 167 \n 168 \n 169 \n 170 \n 171 \n 172 \n 173 \n 174 \n 175 \n 176" , "Select" , "Cancel");*/


CMD:changecolor(playerid ,params[])
{
	new
	color1,
	color2;
	new vehicleid = GetPlayerVehicleID(playerid);
	if (sscanf(params, "ud", color1, color2)) SendClientMessage(playerid, 0xFF0000AA, "Usage: /changecolor [color1] [color2]");
	else
	{
		ChangeVehicleColor(vehicleid, color1, color2);
	}
	return 1;
}

CMD:parktruckloc(playerid, params[])
{
	if(onTeam[playerid] == state_vdonduty)
	{
	    SetPlayerCheckpoint(playerid, 2543.8770, 2713.4563, 11.2757, 5.0);
		SendClientMessage(playerid, COLOR_ORANGE, "Go to location and type /parkjobv to park your job vehicle");
	}
	return 1;
}

CMD:parkjobv(playerid, params[])
{
	if(onTeam[playerid] == state_vdonduty)
	{
        if(GetPlayerVehicleID(playerid) == vdtruck[0])
        {
	    	if(IsPlayerInRangeOfPoint(playerid, 5.0, 2543.8770, 2713.4563, 11.2757))
	    	{
                RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(vdtruck[0]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in the location to park the job vehicle");
                SendClientMessage(playerid, COLOR_RED, "Type /parktruckloc to get the parking location");
			}
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[1])
        {
	    	if(IsPlayerInRangeOfPoint(playerid, 5.0, 2543.8770, 2713.4563, 11.2757))
	    	{
                RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(vdtruck[1]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in the location to park the job vehicle");
                SendClientMessage(playerid, COLOR_RED, "Type /parktruckloc to get the parking location");
			}
		}
        else if(GetPlayerVehicleID(playerid) == vdtruck[2])
        {
	    	if(IsPlayerInRangeOfPoint(playerid,5.0, 2543.8770, 2713.4563, 11.2757))
	    	{
                RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(vdtruck[2]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in the location to park the job vehicle");
                SendClientMessage(playerid, COLOR_RED, "Type /parktruckloc to get the parking location");
			}
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[3])
        {
	    	if(IsPlayerInRangeOfPoint(playerid,5.0, 2543.8770, 2713.4563, 11.2757))
	    	{
                RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(vdtruck[3]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in the location to park the job vehicle");
                SendClientMessage(playerid, COLOR_RED, "Type /parktruckloc to get the parking location");
			}
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[4])
        {
	    	if(IsPlayerInRangeOfPoint(playerid,5.0, 2543.8770, 2713.4563, 11.2757))
	    	{
                RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(vdtruck[4]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in the location to park the job vehicle");
                SendClientMessage(playerid, COLOR_RED, "Type /parktruckloc to get the parking location");
			}
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[5])
        {
	    	if(IsPlayerInRangeOfPoint(playerid, 5.0, 2543.8770, 2713.4563, 11.2757))
	    	{
                RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(vdtruck[5]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in the location to park the job vehicle");
                SendClientMessage(playerid, COLOR_RED, "Type /parktruckloc to get the parking location");
			}
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[6])
        {
	    	if(IsPlayerInRangeOfPoint(playerid, 5.0, 2543.8770, 2713.4563, 11.2757))
	    	{
                RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(vdtruck[6]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in the location to park the job vehicle");
                SendClientMessage(playerid, COLOR_RED, "Type /parktruckloc to get the parking location");
			}
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[7])
        {
	    	if(IsPlayerInRangeOfPoint(playerid, 5.0, 2543.8770, 2713.4563, 11.2757))
	    	{
                RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(vdtruck[7]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in the location to park the job vehicle");
                SendClientMessage(playerid, COLOR_RED, "Type /parktruckloc to get the parking location");
			}
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[8])
        {
	    	if(IsPlayerInRangeOfPoint(playerid, 5.0, 2543.8770, 2713.4563, 11.2757))
	    	{
                RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(vdtruck[8]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in the location to park the job vehicle");
                SendClientMessage(playerid, COLOR_RED, "Type /parktruckloc to get the parking location");
			}
		}
		else if(GetPlayerVehicleID(playerid) == vdtruck[9])
        {
	    	if(IsPlayerInRangeOfPoint(playerid, 5.0, 2543.8770, 2713.4563, 11.2757))
	    	{
                RemovePlayerFromVehicle(playerid);
				SetVehicleToRespawn(vdtruck[9]);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in the location to park the job vehicle");
                SendClientMessage(playerid, COLOR_RED, "Type /parktruckloc to get the parking location");
			}
		}
	}
	return 1;
}


CMD:unloadfuel1(playerid, params[])
{
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(t1, vehx, vehy, vehz);
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2524.5291,2817.5466,11.4272))
    	{
    		if(GetVehicleModel(vehicleid) == 403)
			{
				SetVehicleToRespawn(t1);

			}
			
		}
		else SendClientMessage(playerid, COLOR_RED, "You are not in the location to unload");
	}
	else SendClientMessage(playerid, COLOR_RED, "You not connected this trailer");
	return 1;
}

CMD:unloadfuel2(playerid, params[])
{
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(t2, vehx, vehy, vehz);
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2524.5291,2817.5466,11.4272))
    	{
    		if(GetVehicleModel(vehicleid) == 403)
			{
				SetVehicleToRespawn(t2);
				
			}
			
		}
		else SendClientMessage(playerid, COLOR_RED, "You are not in the location to unload");
	}
	else SendClientMessage(playerid, COLOR_RED, "You not connected this trailer");
	return 1;
}

CMD:unloadfuel3(playerid, params[])
{
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(t3, vehx, vehy, vehz);
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2524.5291,2817.5466,11.4272))
    	{
    		if(GetVehicleModel(vehicleid) == 403)
			{
				SetVehicleToRespawn(t3);

			}
		}
		else SendClientMessage(playerid, COLOR_RED, "You are not in the location to unload");
	}
	else SendClientMessage(playerid, COLOR_RED, "You not connected this trailer");
	return 1;
}

CMD:unloadfuel4(playerid, params[])
{
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(t4, vehx, vehy, vehz);
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2524.5291,2817.5466,11.4272))
    	{
    		if(GetVehicleModel(vehicleid) == 403)
			{
				SetVehicleToRespawn(t4);

			}
		}
		else SendClientMessage(playerid, COLOR_RED, "You are not in the location to unload");
	}
	else SendClientMessage(playerid, COLOR_RED, "You not connected this trailer");
	return 1;
}

CMD:unloadfuel5(playerid, params[])
{
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(t5, vehx, vehy, vehz);
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2524.5291,2817.5466,11.4272))
    	{
    		if(GetVehicleModel(vehicleid) == 403)
			{
				SetVehicleToRespawn(t5);

			}
		}
		else SendClientMessage(playerid, COLOR_RED, "You are not in the location to unload");
	}
	else SendClientMessage(playerid, COLOR_RED, "You not connected this trailer");
	return 1;
}

CMD:unloadfuel6(playerid, params[])
{
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(t6, vehx, vehy, vehz);
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2524.5291,2817.5466,11.4272))
    	{
    		if(GetVehicleModel(vehicleid) == 403)
			{
				SetVehicleToRespawn(t6);

			}
		}
		else SendClientMessage(playerid, COLOR_RED, "You are not in the location to unload");
	}
	else SendClientMessage(playerid, COLOR_RED, "You not connected this trailer");
	return 1;
}

CMD:unloadfuel7(playerid, params[])
{
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(t7, vehx, vehy, vehz);
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2524.5291,2817.5466,11.4272))
    	{
    		if(GetVehicleModel(vehicleid) == 403)
			{
				SetVehicleToRespawn(t7);

			}
		}
		else SendClientMessage(playerid, COLOR_RED, "You are not in the location to unload");
	}
	else SendClientMessage(playerid, COLOR_RED, "You not connected this trailer");
	return 1;
}

CMD:unloadfuel8(playerid, params[])
{
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(t8, vehx, vehy, vehz);
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2524.5291,2817.5466,11.4272))
    	{
    		if(GetVehicleModel(vehicleid) == 403)
			{
				SetVehicleToRespawn(t8);

			}
		}
		else SendClientMessage(playerid, COLOR_RED, "You are not in the location to unload");
	}
	else SendClientMessage(playerid, COLOR_RED, "You not connected this trailer");
	return 1;
}

CMD:unloadfuel9(playerid, params[])
{
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(t9, vehx, vehy, vehz);
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2524.5291,2817.5466,11.4272))
    	{
    		if(GetVehicleModel(vehicleid) == 403)
			{
				SetVehicleToRespawn(t9);

			}
		}
		else SendClientMessage(playerid, COLOR_RED, "You are not in the location to unload");
	}
	else SendClientMessage(playerid, COLOR_RED, "You not connected this trailer");
	return 1;
}

CMD:unloadfuel10(playerid, params[])
{
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(t10, vehx, vehy, vehz);
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2524.5291,2817.5466,11.4272))
    	{
    		if(GetVehicleModel(vehicleid) == 403)
			{
				SetVehicleToRespawn(t10);

			}
		}
		else SendClientMessage(playerid, COLOR_RED, "You are not in the location to unload");
	}
	else SendClientMessage(playerid, COLOR_RED, "You not connected this trailer");
	return 1;
}

CMD:respawnall(playerid, params[])
{
	SetVehicleToRespawn(t1);
	SetVehicleToRespawn(t2);
	SetVehicleToRespawn(t3);
	SetVehicleToRespawn(t4);
	SetVehicleToRespawn(t5);
	SetVehicleToRespawn(t6);
	SetVehicleToRespawn(t7);
	SetVehicleToRespawn(t8);
	SetVehicleToRespawn(t9);
	SetVehicleToRespawn(t10);
	return 1;
}

CMD:spawn(playerid, params[])
{
	SetPlayerPos(playerid, 1448.03015, 1551.79810, 12.28874);
	return 1;
}





