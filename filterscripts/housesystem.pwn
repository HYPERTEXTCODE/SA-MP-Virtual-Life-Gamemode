
#include <a_samp>
#include <DOF2.pwn>

#define MAX_PLAYERS_EX 100


#define GiveMoney               GivePlayerMoney
#define dini_Exists		        DOF2_FileExists
#define dini_Remove         	DOF2_RemoveFile
#define dini_Create         	DOF2_CreateFile
#define dini_Set			    DOF2_SetString
#define dini_Get         		DOF2_GetString
#define dini_IntSet   			DOF2_SetInt
#define dini_Int         		DOF2_GetInt
#define dini_BoolSet            DOF2_SetBool
#define dini_Bool               DOF2_GetBool
#define dini_FloatSet 			DOF2_SetFloat
#define dini_Float      		DOF2_GetFloat
#define dini_Unset       		DOF2_Unset
#define dini_Isset       		DOF2_IsSet
#define dini_Write              DOF2_Exit

#define SCM(%0,%1,%2) SendClientMessage(%0,%1,%2)
#define SCMTA(%0,%1) SendClientMessageToAll(%0,%1)


#define MAX_PAY 100000

#define MAX_HOUSES 1000
#define MAX_CARS 5
#define MAX_WEAPON_SLOT 5
#define MAX_SKIN_SLOT 5

#define HOUSE_DIALOG 1150
#define CAR_DIALOG 1151
#define VEHICLE_DIALOG 1152
#define VEHLIST_DIALOG 1153
#define INVENTORY_MENU 1154
#define INVENTORY_BANK 1155
#define INVENTORY_WITHDRAW 1156
#define INVENTORY_SAVE 1157
#define INVENTORY_SKINS 1158
#define INVENTORY_WEAPONS 1159
#define SKIN_LOAD 1160
#define SKIN_SAVE 1161
#define WEAPON_LOAD 1162
#define WEAPON_SAVE 1163
#define AMMO_LOAD 1164
#define AMMO_SAVE 1165
#define INVENTORY_WEAP 1166
#define PASS_SET 1167
#define PASS_PRESS 1168
#define INTERIOR_SELECT 1169
#define HOUSE_STEAL 1170
#define HOUSE_SECURITY 1171

forward Float:GetHealth(playerid);

#define HaveNotMoney(%1,%2) if(GetPlayerMoney(%1) < %2) return SCM(%1,0xFFFFFFFF,"Nem·ö dostatok peÚazÌ !")
//-------------------------------------|
enum HOUSE_DATA
{
Float:p_X,
Float:p_Y,
Float:p_Z,
PickInHouse,
IntTyp,
Cena,
Text3D:Text,
Owner[MAX_PLAYER_NAME],
Pickup,
bool:Zamek,
CarSlots,
HousePick,
Bank,
Weapon[MAX_WEAPON_SLOT],
Ammo[MAX_WEAPON_SLOT],
Skins[MAX_SKIN_SLOT],
Password[32],
bool:Break,
VW
};

new HouseInfo[MAX_HOUSES][HOUSE_DATA];

new Float:VX[MAX_HOUSES][MAX_CARS];
new Float:VY[MAX_HOUSES][MAX_CARS];
new Float:VZ[MAX_HOUSES][MAX_CARS];
new Float:VA[MAX_HOUSES][MAX_CARS];
new Color1[MAX_HOUSES][MAX_CARS];
new Color2[MAX_HOUSES][MAX_CARS];
new Paintjob[MAX_HOUSES][MAX_CARS];
new Vehicle[MAX_HOUSES][MAX_CARS];
new Vmod[17][MAX_HOUSES][MAX_CARS];
new bool:ShowedPlayerDialog[MAX_PLAYERS_EX];
new InHouse[MAX_PLAYERS_EX] = {-1,...};
new SetSpawn[MAX_PLAYERS_EX] = {-1,...};
new HouseCount = -1;

new spoiler[20][0] = {
{1000},{1001},{1002},{1003},{1014},{1015},{1016},{1023},{1058},{1060},{1049},{1050},{1138},{1139},{1146},{1147},
{1158},{1162},{1163},{1164}
};

new nitro[3][0] = { {1008},{1009},{1010}
};

new fbumper[23][0] = {
{1117},{1152},{1153},{1155},{1157},{1160},{1165},{1167},{1169},{1170},{1171},{1172},{1173},
{1174},{1175},{1179},{1181},{1182},{1185},{1188},{1189},{1192},{1193}
};

new rbumper[22][0] = {{1140},{1141},{1148},{1149},{1150},{1151},
{1154},{1156},{1159},{1161},{1166},{1168},{1176},{1177},{1178},{1180},{1183},{1184},{1186},{1187},{1190},{1191}
};

new exhaust[28][0] = {
{1018},{1019},{1020},{1021},{1022},{1028},{1029},{1037},{1043},{1044},{1045},{1046},{1059},{1064},{1065},{1066},
{1089},{1092},{1104},{1105},{1113},{1114},{1126},{1127},{1129},{1132},{1135},{1136}
};

new bventr[2][0] = {{1042},{1044}
};

new bventl[2][0] = {{1043},{1045}
};

new bscoop[4][0] = {{1004},{1005},{1011},{1012}
};

new rscoop[13][0] = {
{1006},{1032},{1033},{1035},{1038},{1053},{1054},{1055},{1061},{1067},{1068},{1088},{1091}
};

new lskirt[21][0] = {{1007},{1026},{1031},{1036},{1039},{1042},{1047},{1048},{1056},{1057},{1069},{1070},{1090},
{1093},{1106},{1108},{1118},{1119},{1133},{1122},{1134}
};

new rskirt[21][0] = {{1017},{1027},{1030},{1040},{1041},{1051},{1052},
{1062},{1063},{1071},{1072},{1094},{1095},{1099},{1101},{1102},{1107},{1120},{1121},{1124},{1137}
};

new hydraulics[1][0] = {{1087}
};

new base[1][0] = {{1086}
};

new rbbars[2][0] = {{1109},{1110}
};

new fbbars[2][0] = {{1115},{1116}
};

new wheels[17][0] = {{1025},{1073},{1074},{1075},{1076},{1077},{1078},
{1079},{1080},{1081},{1082},{1083},{1084},{1085},{1096},{1097},{1098}
};

new lights[2][0] = {{1013},{1024}
};

enum PortPosition
{
Float:I_X,
Float:I_Y,
Float:I_Z,
Int,
Float:P_X,
Float:P_Y,
Float:P_Z
}
//HousePick
#define MAX_INT 15
#define MAX_INTERIOR MAX_INT-1
//3 7 12 5 6 9(delete) 13 15 4 1 2 8 14 11    10
new HouseInterior[MAX_INT][PortPosition] = {
{2496.0837,-1694.6823,1014.7422,3,2496.0349,-1710.4407,1014.7422},
{2319.4561,-1025.5547,1050.2109,9,2325.4846,-1020.2195,1050.2109},
{234.6087,1187.8195,1080.2578,3,224.5846,1189.9032,1080.2578},
{225.5700,1240.1743,1082.1406,2,220.3822,1241.1073,1082.1406},
{226.6689,1114.2357,1080.9949,5,244.7964,1107.0814,1080.9922},// 5
{295.1211,1472.4385,1080.2578,15,294.7233,1487.4790,1080.2578},
{446.5904,1397.3353,1084.3047,2,455.7391,1416.5289,1084.3080},
{260.9645,1286.1227,1080.2578,4,256.2693,1287.0570,1080.2578},
//{-262.1759,1456.6158,1084.3672,4,-277.5753,1449.5579,1084.3672},
{20002.8521,1404.1110,1084.4297,5,30.7995,1412.9910,1084.4297},// 10
{140.1565,1367.6558,1083.8618,5,151.0000,1372.9969,1083.8594},
{234.0911,1064.3892,1084.2113,6,234.5299,1081.1587,1084.2415},
{-68.4557,1353.2141,1080.2109,6,-69.6661,1365.0118,1080.2109},// 13
{2365.2805,-1133.7350,1050.8750,8,2372.9531,-1126.4886,1050.8750},
{84.5941,1323.0470,1083.8594,9,91.4217,1328.6946,1083.8594},//15
{0.0,0.0,0.0,0,0.0,0.0,0.0}//16
};

new vehName[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratium", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car",
    "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};
forward TuneThisCar(houseid,carslot,vehicleid);

#define M(%0) (%0*100000)

#define LV_HOUSES // Ak chceö domy v Las Venturas, zmaû tie lomÌtka '//' pred #define
#define RITCH_HOUSES // Ak chceö domy v Ritch zmaû tie lomÌtka '//' pred #define
#define SF_HOUSES // Ak chceö domy v San Fierro, zmaû tie lomÌtka '//' pred #define
#define LS_HOUSES // Ak chceö domy v Los Santos, zmaû tie lomÌtka '//' pred #define

public OnFilterScriptInit()
{
new houseid;
#if defined LV_HOUSES
/*                   START LV HOUSES                  */

	houseid = CreateHouse(1846.750488,661.081298,11.460937,M(3));
				AddHouseCar(houseid,1843.377441,653.925048,11.184819,268.631988);
				AddHouseCar(houseid,1854.446289,657.430297,10.892458,270.043914);
				AddHouseCar(houseid,1862.090209,663.900878,10.471583,182.883621);

	houseid = CreateHouse(1845.542236,690.265441,11.453125,M(3));
				AddHouseCar(houseid,1848.880126,700.417968,11.132609,270.437103);
				AddHouseCar(houseid,1848.914794,695.311828,11.172795,270.438385);
				AddHouseCar(houseid,1862.145629,688.483642,10.470879,2.270250);

	houseid = CreateHouse(1844.856323,718.777587,11.468292,M(2));
				AddHouseCar(houseid,1840.406982,726.859985,11.174000,269.176147);
				AddHouseCar(houseid,1852.890502,723.465209,10.924471,269.005615);
	houseid = CreateHouse(1846.173217,741.166931,11.460937,M(2));
				AddHouseCar(houseid,1843.493408,733.971984,11.189518,269.685699);
				AddHouseCar(houseid,1853.740966,737.567077,10.954670,269.672363);
	houseid = CreateHouse(1955.748168,715.052612,10.820312,M(2));
				AddHouseCar(houseid,1954.674804,711.472900,10.548891,88.915405);
				AddHouseCar(houseid,1954.802978,718.252136,10.548891,88.915405);
	houseid = CreateHouse(1955.893798,722.030151,10.820312,M(1));
				AddHouseCar(houseid,1942.022216,708.399353,10.545270,357.475769);
	houseid = CreateHouse(1956.354003,724.579711,10.820312,M(1));
				AddHouseCar(houseid,1938.937744,708.536926,10.546768,357.561614);
	houseid = CreateHouse(1956.573730,731.530395,10.820312,M(1));
				AddHouseCar(houseid,1935.414306,708.683532,10.548265,357.647369);
	houseid = CreateHouse(1956.040649,738.375061,10.820312,M(1));
				AddHouseCar(houseid,1951.837768,740.139404,10.547394,177.316848);
	houseid = CreateHouse(1949.160644,742.456665,10.820312,M(1));
				AddHouseCar(houseid,1945.560791,740.103027,10.548893,177.402481);
	houseid = CreateHouse(1942.527465,742.218383,10.820312,M(1));
				AddHouseCar(houseid,1939.086181,740.398376,10.566316,177.488281);
	houseid = CreateHouse(1935.924804,742.302673,10.820312,M(1));
				AddHouseCar(houseid,1932.252441,740.697387,10.567085,177.524230);
	houseid = CreateHouse(1929.327636,742.195373,10.820312,M(1));
				AddHouseCar(houseid,1925.936157,740.969421,10.568581,177.589126);
	houseid = CreateHouse(1922.492431,741.712463,10.820312,M(1));
				AddHouseCar(houseid,1919.697021,740.123901,10.552816,177.674926);
	houseid = CreateHouse(1915.879394,742.056274,10.819780,M(1));
				AddHouseCar(houseid,1911.797607,740.446044,10.565011,177.760772);
	houseid = CreateHouse(1908.835693,742.314453,10.819780,M(1));
				AddHouseCar(houseid,1905.320190,740.370910,10.557054,177.846588);
	houseid = CreateHouse(1901.711547,742.346679,10.819780,M(1));
				AddHouseCar(houseid,1899.087158,739.060791,10.547118,268.876586);
	houseid = CreateHouse(1897.903442,736.371459,10.819780,M(1));
				AddHouseCar(houseid,1898.968017,732.895568,10.548615,268.962249);
	houseid = CreateHouse(1897.426635,729.176147,10.819780,M(2));
				AddHouseCar(houseid,1898.842773,725.947509,10.550259,269.009857);
				AddHouseCar(houseid,1898.770874,721.803161,10.569496,269.009826);
	houseid = CreateHouse(1896.965454,681.851867,10.820312,M(2));
				AddHouseCar(houseid,1900.436889,685.016296,10.559784,268.842407);
				AddHouseCar(houseid,1899.253906,679.417907,10.542950,268.842437);
	houseid = CreateHouse(1897.411621,675.379516,10.820312,M(1));
				AddHouseCar(houseid,1899.103271,671.551452,10.555010,268.938110);
	houseid = CreateHouse(1897.363037,668.739929,10.820312,M(1));
				AddHouseCar(houseid,1901.041259,665.827270,10.548513,358.989929);
	houseid = CreateHouse(1905.000000,664.099975,10.820312,M(1));
				AddHouseCar(houseid,1908.699951,665.693176,10.565489,359.037658);
	houseid = CreateHouse(1911.569458,663.983215,10.820312,M(1));
				AddHouseCar(houseid,1915.841674,665.574951,10.566884,359.123413);
	houseid = CreateHouse(1918.644287,664.040588,10.820312,M(1));
				AddHouseCar(houseid,1922.790161,666.099243,10.567717,359.170776);
	houseid = CreateHouse(1925.513793,664.261413,10.820312,M(1));
				AddHouseCar(houseid,1929.131591,666.009277,10.548990,359.256896);
	houseid = CreateHouse(1931.961791,664.096618,10.820312,M(1));
				AddHouseCar(houseid,1935.812011,665.924194,10.566497,359.342834);
	houseid = CreateHouse(1938.333984,664.375427,10.820312,M(1));
				AddHouseCar(houseid,1942.479736,665.849548,10.553320,359.450897);
	houseid = CreateHouse(1945.254760,663.780883,10.820312,M(1));
				AddHouseCar(houseid,1948.861206,665.790100,10.554550,359.537750);
	houseid = CreateHouse(1951.898193,664.207641,10.820312,M(1));
				AddHouseCar(houseid,1954.760009,667.813049,10.555467,89.646324);
	houseid = CreateHouse(1956.642578,671.206237,10.820312,M(1));
				AddHouseCar(houseid,1954.801879,674.636352,10.555780,89.692657);
	houseid = CreateHouse(1956.645385,678.025329,10.820312,M(1));
				AddHouseCar(houseid,1954.836181,681.257690,10.557420,89.765853);
	houseid = CreateHouse(1956.105102,684.750915,10.820312,M(1));
				AddHouseCar(houseid,1954.862792,687.957641,10.569230,89.834602);
	houseid = CreateHouse(1956.917846,691.459472,10.820312,M(1));
				AddHouseCar(houseid,1954.880004,694.095214,10.552972,89.874427);
	houseid = CreateHouse(2014.010498,651.123352,11.460937,M(3));
				AddHouseCar(houseid,2003.832153,654.020751,11.145784,0.966194);
				AddHouseCar(houseid,2008.572265,654.095458,11.194678,0.975277);
				AddHouseCar(houseid,2013.793334,668.538085,10.470794,274.555938);
	houseid = CreateHouse(2043.655273,652.361816,11.460937,M(3));
				AddHouseCar(houseid,2051.146240,649.697326,11.189666,1.543513);
				AddHouseCar(houseid,2047.296508,659.349121,10.975446,1.633396);
				AddHouseCar(houseid,2037.712402,667.943542,10.470845,281.239440);
	houseid = CreateHouse(2065.622314,650.948486,11.468292,M(2));
				AddHouseCar(houseid,2058.052490,646.230773,11.186738,0.140579);
				AddHouseCar(houseid,2068.609619,656.886962,10.960167,72.808570);
	houseid = CreateHouse(2094.219970,651.344848,11.460937,M(2));
				AddHouseCar(houseid,2084.101318,654.820129,11.120592,1.539741);
				AddHouseCar(houseid,2088.443115,654.934387,11.144295,1.540009);
	houseid = CreateHouse(2123.345458,652.054687,11.460937,M(2));
				AddHouseCar(houseid,2130.835449,649.363220,11.188216,357.451904);
				AddHouseCar(houseid,2127.175537,658.987487,10.997743,359.189880);
	houseid = CreateHouse(2120.567626,695.690979,11.453125,M(4));
				AddHouseCar(houseid,2130.174316,691.240051,11.090230,177.940612);
				AddHouseCar(houseid,2126.204833,691.865844,11.144206,177.940277);
				AddHouseCar(houseid,2117.511718,685.958190,10.737016,267.496337);
				AddHouseCar(houseid,2113.620361,690.748413,10.994876,269.130126);
	houseid = CreateHouse(2091.043945,694.048950,11.460937,M(2));
				AddHouseCar(houseid,2083.699218,697.032958,11.184733,179.612335);
				AddHouseCar(houseid,2087.293457,687.584228,10.999936,179.689331);
	houseid = CreateHouse(2069.117187,695.854736,11.468292,M(3));
				AddHouseCar(houseid,2077.017089,699.311157,11.187661,179.034088);
				AddHouseCar(houseid,2059.172119,686.923339,10.772642,269.134094);
				AddHouseCar(houseid,2061.475097,690.713684,10.999452,250.755935);
	houseid = CreateHouse(2040.567749,695.110961,11.453125,M(1));
				AddHouseCar(houseid,2049.216064,692.543334,11.149794,182.629394);
	houseid = CreateHouse(2011.475219,694.171691,11.460937,M(2));
				AddHouseCar(houseid,2004.262084,697.264221,11.187802,179.681015);
				AddHouseCar(houseid,2007.533325,687.424377,11.001205,179.628753);
	houseid = CreateHouse(2013.145019,730.510620,11.453125,M(1));
				AddHouseCar(houseid,2005.296386,734.688537,11.126977,1.077859);
	houseid = CreateHouse(2042.537109,732.414733,11.460937,M(3));
				AddHouseCar(houseid,2050.198730,729.696472,11.206054,359.721984);
				AddHouseCar(houseid,2046.661376,738.241271,11.038367,359.967773);
				AddHouseCar(houseid,2041.569091,748.724731,10.470601,267.040313);
	houseid = CreateHouse(2064.778320,730.473632,11.468292,M(4));
				AddHouseCar(houseid,2057.080078,727.269470,11.196953,359.108459);
				AddHouseCar(houseid,2067.329833,735.266235,11.043961,90.979202);
				AddHouseCar(houseid,2067.269775,738.759704,10.884075,90.975502);
				AddHouseCar(houseid,2066.675781,747.746215,10.467161,272.972778);
	houseid = CreateHouse(2093.385742,731.008789,11.453125,M(1));
				AddHouseCar(houseid,2085.474365,735.324829,11.096500,356.398529);
	houseid = CreateHouse(2122.289306,731.970947,11.460937,M(2));
				AddHouseCar(houseid,2130.018066,729.242858,11.206039,359.916076);
				AddHouseCar(houseid,2126.423339,738.918090,10.995223,0.277528);
	houseid = CreateHouse(2123.441406,775.332153,11.445312,M(3));
				AddHouseCar(houseid,2133.502685,772.788085,11.135715,180.115188);
				AddHouseCar(houseid,2119.207763,770.064025,10.955618,269.913238);
				AddHouseCar(houseid,2119.492431,765.816589,10.718255,270.016632);
	houseid = CreateHouse(2094.109863,774.383422,11.453125,M(2));
				AddHouseCar(houseid,2086.775390,776.946838,11.181750,181.215316);
				AddHouseCar(houseid,2090.557861,767.662231,10.994431,181.114273);
	houseid = CreateHouse(2071.639648,776.283447,11.460479,M(1));
				AddHouseCar(houseid,2079.496093,780.077331,11.181578,178.424789);
	houseid = CreateHouse(2043.347045,775.563720,11.453125,M(2));
				AddHouseCar(houseid,2053.331298,771.423706,11.106024,180.635116);
				AddHouseCar(houseid,2048.661376,771.375671,11.145799,180.636199);
	houseid = CreateHouse(2013.802490,773.967895,11.460937,M(2));
				AddHouseCar(houseid,2006.458862,776.969787,11.189565,180.919418);
				AddHouseCar(houseid,2009.970703,767.210571,10.967511,181.046798);
	houseid = CreateHouse(2168.090332,772.365722,11.460937,M(4));
				AddHouseCar(houseid,2171.293945,779.785705,11.189605,90.920402);
				AddHouseCar(houseid,2160.134033,776.068969,10.876075,90.918632);
				AddHouseCar(houseid,2152.853759,770.256347,10.470787,0.901571);
				AddHouseCar(houseid,2164.201904,788.305664,10.110859,88.373352);
	houseid = CreateHouse(2177.928955,655.247192,11.460937,M(3));
				AddHouseCar(houseid,2188.031250,652.779907,11.162480,179.481567);
				AddHouseCar(houseid,2183.339355,652.813781,11.204412,179.436050);
				AddHouseCar(houseid,2177.345703,647.000183,10.826148,248.189605);
	houseid = CreateHouse(2206.425292,655.759033,11.468292,M(3));
				AddHouseCar(houseid,2214.054687,659.802062,11.196178,176.623107);
				AddHouseCar(houseid,2194.109375,650.705078,10.893389,268.893859);
				AddHouseCar(houseid,2198.831298,647.222045,10.801004,270.785339);
	houseid = CreateHouse(2228.756347,654.169311,11.460937,M(2));
				AddHouseCar(houseid,2221.264892,656.457946,11.189616,180.019790);
				AddHouseCar(houseid,2224.961914,647.856323,11.036314,180.686309);
	houseid = CreateHouse(2258.037597,655.593383,11.453125,M(1));
				AddHouseCar(houseid,2266.456298,651.256652,11.127194,179.810028);
	houseid = CreateHouse(2177.150634,690.930969,11.460937,M(3));
				AddHouseCar(houseid,2167.297119,694.690734,11.057515,1.379623);
				AddHouseCar(houseid,2171.897949,693.723754,11.126087,1.382477);
				AddHouseCar(houseid,2178.869873,699.804321,10.723273,71.777687);
	houseid = CreateHouse(2206.373046,692.192871,11.460937,M(2));
				AddHouseCar(houseid,2213.660644,688.684814,11.123620,0.081606);
				AddHouseCar(houseid,2209.785888,698.518859,10.949187,0.655713);
	houseid = CreateHouse(2228.238037,690.848632,11.460479,M(2));
				AddHouseCar(houseid,2220.287109,689.137817,11.108850,1.317005);
				AddHouseCar(houseid,2226.878906,696.556152,10.934706,37.386802);
	houseid = CreateHouse(2256.712646,691.452087,11.453125,M(2));
				AddHouseCar(houseid,2247.030761,693.006835,11.137276,1.964808);
				AddHouseCar(houseid,2252.290771,693.185607,11.110175,1.966327);
	houseid = CreateHouse(2257.375244,735.876953,11.460937,M(4));
				AddHouseCar(houseid,2267.477050,732.807250,11.100534,180.074584);
				AddHouseCar(houseid,2263.405273,732.804809,11.143460,180.071090);
				AddHouseCar(houseid,2254.803466,730.737426,10.945199,250.986206);
				AddHouseCar(houseid,2248.100341,726.414733,10.686348,268.783569);
	houseid = CreateHouse(2228.460205,734.232788,11.460937,M(2));
				AddHouseCar(houseid,2220.643554,737.343200,11.139377,177.282455);
				AddHouseCar(houseid,2224.399658,726.097717,10.825101,177.331573);
	houseid = CreateHouse(2206.501953,736.068786,11.468292,M(3));
				AddHouseCar(houseid,2213.725097,740.194885,11.133622,180.682006);
				AddHouseCar(houseid,2195.312500,731.066284,10.938885,270.564117);
				AddHouseCar(houseid,2195.698974,727.606689,10.750220,270.563232);
	houseid = CreateHouse(2177.629882,735.773437,11.460937,M(2));
				AddHouseCar(houseid,2187.827880,732.906494,11.102881,179.881713);
				AddHouseCar(houseid,2178.399658,728.308898,10.849352,226.167968);
	houseid = CreateHouse(2318.107177,655.744384,11.453125,M(4));
				AddHouseCar(houseid,2328.041992,652.483581,11.080714,181.353134);
				AddHouseCar(houseid,2323.412353,652.920776,11.118966,181.282073);
				AddHouseCar(houseid,2308.951904,651.115356,10.952520,271.978881);
				AddHouseCar(houseid,2309.140136,645.631530,10.642540,271.989898);
	houseid = CreateHouse(2346.483886,655.918029,11.460479,M(3));
				AddHouseCar(houseid,2353.922607,659.400573,11.116974,180.918167);
				AddHouseCar(houseid,2337.169921,651.381164,10.952692,269.160156);
				AddHouseCar(houseid,2342.032226,647.455871,10.775538,269.158843);
	houseid = CreateHouse(2368.413574,654.709350,11.460937,M(1));
				AddHouseCar(houseid,2360.851318,657.685974,11.125938,180.037048);
	houseid = CreateHouse(2397.681152,655.538696,11.460937,M(2));
				AddHouseCar(houseid,2407.741455,652.216186,11.101935,182.426330);
				AddHouseCar(houseid,2402.399658,652.868225,11.124279,182.495193);
	houseid = CreateHouse(2449.778564,662.753417,11.460937,M(4));
				AddHouseCar(houseid,2446.346679,652.389343,11.079690,90.120010);
				AddHouseCar(houseid,2446.774658,657.970886,11.143383,90.110954);
				AddHouseCar(houseid,2445.134033,668.270874,10.938240,181.677886);
				AddHouseCar(houseid,2440.544677,668.140563,10.712418,181.643447);
	houseid = CreateHouse(2447.176513,689.625854,11.460937,M(3));
				AddHouseCar(houseid,2453.052490,699.004455,11.116771,89.539688);
				AddHouseCar(houseid,2453.029541,695.961120,11.149283,269.595092);
				AddHouseCar(houseid,2434.644287,689.477478,10.475847,22.074548);
	houseid = CreateHouse(2450.029052,714.063232,11.468292,M(2));
				AddHouseCar(houseid,2455.108398,706.716613,11.130756,90.890792);
				AddHouseCar(houseid,2432.195312,715.130432,10.429013,180.058807);
	houseid = CreateHouse(2449.707763,742.263488,11.460937,M(1));
				AddHouseCar(houseid,2445.654541,733.856994,11.052758,91.577163);
	houseid = CreateHouse(2398.482421,735.175415,11.460937,M(2));
				AddHouseCar(houseid,2398.261230,729.750549,10.909283,240.289718);
				AddHouseCar(houseid,2395.917480,725.763732,10.708668,270.744018);
	houseid = CreateHouse(2369.557617,734.283935,11.460937,M(1));
				AddHouseCar(houseid,2361.485839,736.380187,11.113842,179.344131);
	houseid = CreateHouse(2346.853515,736.307312,11.468292,M(3));
				AddHouseCar(houseid,2354.194091,740.598632,11.132435,181.238632);
				AddHouseCar(houseid,2335.373779,727.369079,10.727018,270.278747);
				AddHouseCar(houseid,2335.355957,730.883972,10.938157,270.278991);
	houseid = CreateHouse(2316.859130,690.791381,11.460937,M(3));
				AddHouseCar(houseid,2307.870605,693.658142,11.101902,0.879349);
				AddHouseCar(houseid,2322.213378,696.359619,10.899351,93.403572);
				AddHouseCar(houseid,2321.964355,700.568054,10.676393,93.373817);
	houseid = CreateHouse(2346.475341,692.095336,11.460937,M(1));
				AddHouseCar(houseid,2353.995361,689.984130,11.103446,359.775360);
	houseid = CreateHouse(2367.865966,690.734680,11.460479,M(3));
				AddHouseCar(houseid,2360.883056,686.722595,11.125288,2.133515);
				AddHouseCar(houseid,2379.995605,696.102050,10.878067,87.441398);
				AddHouseCar(houseid,2375.763427,699.453735,10.716143,89.561584);
	houseid = CreateHouse(2396.900146,691.217285,11.453125,M(3));
				AddHouseCar(houseid,2388.302246,694.235534,11.072696,5.861442);
				AddHouseCar(houseid,2405.877197,695.563720,10.938570,91.164344);
				AddHouseCar(houseid,2405.772460,700.766601,10.656280,91.156135);
	houseid = CreateHouse(2613.026611,2071.998779,10.820312,M(1));
				AddHouseCar(houseid,2607.682128,2071.931884,10.484264,88.538177);
	houseid = CreateHouse(2613.201171,2069.778320,10.820312,M(1));
				AddHouseCar(houseid,2606.835693,2068.396240,10.495651,88.671615);
	houseid = CreateHouse(2613.216796,2062.792236,10.812986,M(1));
				AddHouseCar(houseid,2606.756591,2064.899169,10.472875,88.776268);
	houseid = CreateHouse(2613.059570,2060.346679,10.812986,M(1));
				AddHouseCar(houseid,2606.675537,2061.260742,10.481776,89.220062);
	houseid = CreateHouse(2613.011718,2053.392578,10.812986,M(2));
				AddHouseCar(houseid,2606.634521,2058.101074,10.483280,89.346313);
				AddHouseCar(houseid,2606.601562,2055.218017,10.504346,89.345138);
	houseid = CreateHouse(2613.117431,2051.267333,10.820312,M(1));
				AddHouseCar(houseid,2606.566162,2051.972412,10.505397,89.440704);
	houseid = CreateHouse(2612.691650,2043.954223,10.820312,M(2));
				AddHouseCar(houseid,2606.533203,2048.608642,10.478444,89.443260);
				AddHouseCar(houseid,2606.499267,2045.125000,10.490128,89.444854);
	houseid = CreateHouse(2613.270751,2041.683105,10.820312,M(1));
				AddHouseCar(houseid,2606.504638,2041.941040,10.512717,90.488586);
	houseid = CreateHouse(2624.593017,2018.619262,10.820312,M(2));
				AddHouseCar(houseid,2619.661376,2008.068725,10.468769,180.829498);
				AddHouseCar(houseid,2622.988037,2008.117187,10.498099,180.831222);
	houseid = CreateHouse(2627.204589,2018.752563,10.820312,M(1));
				AddHouseCar(houseid,2626.189453,2008.165649,10.472544,180.944122);
	houseid = CreateHouse(2634.249023,2018.158203,10.820312,M(2));
				AddHouseCar(houseid,2629.674072,2008.281005,10.455024,182.843154);
				AddHouseCar(houseid,2633.282958,2008.637817,10.492465,178.933624);
	houseid = CreateHouse(2636.764160,2018.125000,10.820312,M(1));
				AddHouseCar(houseid,2636.429443,2008.581420,10.488597,179.026748);
	houseid = CreateHouse(2643.490722,2018.857910,10.816330,M(2));
				AddHouseCar(houseid,2639.827392,2008.525878,10.495882,179.153976);
				AddHouseCar(houseid,2643.573974,2008.470703,10.505134,179.152786);
	houseid = CreateHouse(2646.044677,2018.083251,10.816954,M(2));
				AddHouseCar(houseid,2646.914306,2008.422973,10.503400,179.245910);
				AddHouseCar(houseid,2649.861083,2008.384155,10.504175,179.245925);
	houseid = CreateHouse(2652.056884,1979.766723,10.820312,M(1));
				AddHouseCar(houseid,2656.724609,1989.379638,10.468889,179.288146);
	houseid = CreateHouse(2649.451660,1979.485107,10.820312,M(1));
				AddHouseCar(houseid,2650.390869,1989.460571,10.483591,179.415985);
	houseid = CreateHouse(2642.906738,1979.392578,10.820312,M(1));
				AddHouseCar(houseid,2643.659423,1989.532470,10.500294,179.513610);
	houseid = CreateHouse(2640.181640,1979.912841,10.820312,M(1));
				AddHouseCar(houseid,2640.363281,1989.562133,10.502352,179.616394);
	houseid = CreateHouse(2633.875976,1979.692993,10.820312,M(1));
				AddHouseCar(houseid,2633.860595,1989.608398,10.478737,179.709930);
	houseid = CreateHouse(2630.810546,1979.433959,10.820312,M(1));
				AddHouseCar(houseid,2627.032226,1988.512329,10.504373,179.715713);
	houseid = CreateHouse(2610.061035,2132.863525,10.820312,M(1));
				AddHouseCar(houseid,2602.809326,2132.699462,10.473920,271.687683);
	houseid = CreateHouse(2609.715820,2135.341064,10.820312,M(1));
				AddHouseCar(houseid,2603.221191,2136.078125,10.504626,271.781219);
	houseid = CreateHouse(2610.097412,2141.974853,10.820312,M(1));
				AddHouseCar(houseid,2603.014404,2142.732177,10.504594,271.781219);
	houseid = CreateHouse(2610.227050,2144.462158,10.820312,M(1));
				AddHouseCar(houseid,2602.912841,2146.086914,10.502923,270.520141);
	houseid = CreateHouse(2609.671875,2151.503906,10.820312,M(1));
				AddHouseCar(houseid,2603.429687,2149.796386,10.502300,270.520141);
	houseid = CreateHouse(2609.756835,2154.184326,10.820312,M(1));
				AddHouseCar(houseid,2603.400878,2153.075683,10.476241,270.226898);
	houseid = CreateHouse(2609.265625,2160.811523,10.820312,M(1));
				AddHouseCar(houseid,2603.379394,2159.727050,10.502505,269.819671);
	houseid = CreateHouse(2609.871582,2163.397460,10.820312,M(1));
				AddHouseCar(houseid,2603.391357,2163.497558,10.502357,269.819702);
	houseid = CreateHouse(2641.090087,2185.248779,10.820312,M(1));
				AddHouseCar(houseid,2640.649169,2179.111328,10.478906,1.251796);
	houseid = CreateHouse(2638.713134,2185.138916,10.820312,M(1));
				AddHouseCar(houseid,2637.401367,2179.040039,10.504471,1.253202);
	houseid = CreateHouse(2632.296386,2185.042724,10.820312,M(1));
				AddHouseCar(houseid,2634.196533,2178.966064,10.478778,1.465137);
	houseid = CreateHouse(2628.960205,2185.142822,10.820312,M(1));
				AddHouseCar(houseid,2630.822998,2178.881347,10.508323,1.570099);
	houseid = CreateHouse(2622.957763,2184.851318,10.820312,M(1));
				AddHouseCar(houseid,2623.912841,2178.692871,10.509578,1.642110);
	houseid = CreateHouse(2620.182617,2184.997070,10.820312,M(1));
				AddHouseCar(houseid,2616.979736,2178.756591,10.470639,359.060485);
	houseid = CreateHouse(2613.503662,2185.045166,10.812986,M(1));
				AddHouseCar(houseid,2613.886962,2178.808593,10.492586,359.167480);
	houseid = CreateHouse(2610.967773,2185.021728,10.812986,M(1));
				AddHouseCar(houseid,2610.208740,2178.859375,10.474390,358.664398);
	houseid = CreateHouse(2577.003173,2202.112060,10.820312,M(1));
				AddHouseCar(houseid,2578.544677,2196.312988,10.489980,358.515228);
	houseid = CreateHouse(2574.829833,2202.316894,10.820312,M(1));
				AddHouseCar(houseid,2575.317138,2196.397949,10.491566,358.606475);
	houseid = CreateHouse(2567.923583,2203.047607,10.820312,M(1));
				AddHouseCar(houseid,2568.476806,2196.564697,10.502492,358.605895);
	houseid = CreateHouse(2565.373046,2202.496337,10.820312,M(1));
				AddHouseCar(houseid,2565.229980,2196.645263,10.503398,358.516143);
	houseid = CreateHouse(2558.602539,2202.746093,10.820312,M(1));
				AddHouseCar(houseid,2558.356445,2196.824707,10.513735,358.565216);
	houseid = CreateHouse(2555.700927,2202.404296,10.820312,M(1));
				AddHouseCar(houseid,2554.932373,2196.911621,10.476865,358.654754);
	houseid = CreateHouse(2549.195800,2202.725830,10.820312,M(1));
				AddHouseCar(houseid,2551.594238,2196.991210,10.489652,358.717163);
	houseid = CreateHouse(2546.754882,2202.663574,10.820312,M(1));
				AddHouseCar(houseid,2548.440917,2197.063232,10.503953,358.806640);
	houseid = CreateHouse(2498.324218,1643.643310,11.015666,M(1));
				AddHouseCar(houseid,2502.114257,1648.884033,10.502825,358.738250);
	houseid = CreateHouse(2503.390869,1643.578735,11.023437,M(1));
				AddHouseCar(houseid,2505.302734,1648.814331,10.503647,358.786132);
	houseid = CreateHouse(2508.684814,1643.582885,11.023437,M(1));
				AddHouseCar(houseid,2508.278564,1648.751953,10.504487,358.834167);
	houseid = CreateHouse(2516.114746,1653.763793,11.023437,M(1));
				AddHouseCar(houseid,2511.489990,1654.838378,10.489258,88.881881);
	houseid = CreateHouse(2516.627197,1658.999633,11.023437,M(1));
				AddHouseCar(houseid,2511.558349,1658.234619,10.490761,88.967979);
	houseid = CreateHouse(2516.419677,1664.461791,11.023437,M(2));
				AddHouseCar(houseid,2511.603271,1661.628173,10.502888,89.293670);
				AddHouseCar(houseid,2511.638671,1664.497436,10.502868,89.293678);
	houseid = CreateHouse(2516.391113,1669.473022,11.023437,M(2));
				AddHouseCar(houseid,2511.683349,1667.997802,10.504364,89.379844);
				AddHouseCar(houseid,2511.714599,1671.064941,10.511200,88.584678);
	houseid = CreateHouse(2516.643798,1674.322387,11.023437,M(1));
				AddHouseCar(houseid,2511.806640,1674.775512,10.478116,88.585571);
	houseid = CreateHouse(2506.352783,1682.324462,11.023437,M(1));
				AddHouseCar(houseid,2504.659912,1677.445556,10.496216,178.669677);
	houseid = CreateHouse(2501.358398,1682.781494,11.023437,M(1));
				AddHouseCar(houseid,2501.672607,1677.516235,10.497720,178.755249);
	houseid = CreateHouse(2496.264892,1682.772705,11.023437,M(2));
				AddHouseCar(houseid,2498.309326,1677.589355,10.497723,178.755249);
				AddHouseCar(houseid,2495.294677,1677.654907,10.497726,178.755096);
	houseid = CreateHouse(2491.373291,1682.610473,11.023437,M(2));
				AddHouseCar(houseid,2491.899902,1677.731323,10.490205,179.238937);
				AddHouseCar(houseid,2488.864013,1677.578491,10.479256,179.239196);
	houseid = CreateHouse(2486.371582,1682.432373,11.023437,M(1));
				AddHouseCar(houseid,2485.292236,1676.918945,10.480598,179.286727);
	houseid = CreateHouse(2481.384521,1682.126220,11.023437,M(2));
				AddHouseCar(houseid,2481.964111,1676.964233,10.500410,180.231140);
				AddHouseCar(houseid,2479.034667,1676.952270,10.510466,180.231140);
	houseid = CreateHouse(2476.210449,1682.559570,11.023437,M(1));
				AddHouseCar(houseid,2475.971923,1676.944213,10.475986,181.147583);
	houseid = CreateHouse(2471.438232,1682.393432,11.023437,M(2));
				AddHouseCar(houseid,2472.860107,1676.883300,10.484392,181.232589);
				AddHouseCar(houseid,2469.643798,1676.813964,10.484418,181.232666);
	houseid = CreateHouse(2466.287841,1682.411254,11.023437,M(1));
				AddHouseCar(houseid,2466.273681,1676.739135,10.486140,181.406188);
	houseid = CreateHouse(2461.387451,1682.353393,11.023437,M(1));
				AddHouseCar(houseid,2459.935058,1676.923095,10.564617,181.371383);
	houseid = CreateHouse(2373.406494,1642.616210,11.023437,M(1));
				AddHouseCar(houseid,2372.899169,1648.459960,10.506791,0.627449);
	houseid = CreateHouse(2368.683593,1643.206176,11.023437,M(1));
				AddHouseCar(houseid,2369.414306,1648.423095,10.508294,0.713267);
	houseid = CreateHouse(2358.239990,1653.632568,11.023437,M(1));
				AddHouseCar(houseid,2363.550292,1652.571289,10.483951,270.886840);
	houseid = CreateHouse(2357.743652,1659.188842,11.023437,M(2));
				AddHouseCar(houseid,2363.503906,1655.660400,10.485443,270.973052);
				AddHouseCar(houseid,2363.446289,1659.060180,10.485432,270.973052);
	houseid = CreateHouse(2357.978271,1664.279174,11.023437,M(1));
				AddHouseCar(houseid,2363.396972,1661.991210,10.501682,271.019866);
	houseid = CreateHouse(2358.640869,1669.057250,11.023437,M(1));
				AddHouseCar(houseid,2363.340087,1665.290283,10.483832,271.107696);
	houseid = CreateHouse(2358.590087,1669.104736,11.023437,M(1));
				AddHouseCar(houseid,2363.281005,1668.437744,10.504006,271.194976);
	houseid = CreateHouse(2358.522460,1674.542480,11.023437,M(2));
				AddHouseCar(houseid,2363.209960,1671.848266,10.483895,271.193756);
				AddHouseCar(houseid,2363.141113,1675.125122,10.502540,271.192260);
	houseid = CreateHouse(2371.287109,1682.475952,11.023437,M(1));
				AddHouseCar(houseid,2371.617675,1677.148315,10.484390,180.638748);
	houseid = CreateHouse(2375.932617,1682.006103,11.023437,M(2));
				AddHouseCar(houseid,2374.874511,1677.185791,10.485889,180.724304);
				AddHouseCar(houseid,2378.332275,1677.229492,10.485874,180.724700);
	houseid = CreateHouse(2381.062988,1682.519531,11.023437,M(2));
				AddHouseCar(houseid,2381.364990,1677.268554,10.504551,180.770263);
				AddHouseCar(houseid,2384.558349,1677.311523,10.504580,180.770004);
	houseid = CreateHouse(2386.470458,1682.207885,11.023437,M(1));
				AddHouseCar(houseid,2387.571044,1677.352539,10.514624,180.818542);
	houseid = CreateHouse(2391.187011,1682.442382,11.023437,M(1));
				AddHouseCar(houseid,2390.938476,1677.401123,10.515458,180.866165);
	houseid = CreateHouse(2396.072509,1682.124755,11.023437,M(1));
				AddHouseCar(houseid,2394.150634,1677.450195,10.516283,180.913650);
	houseid = CreateHouse(2401.228027,1682.498291,11.023437,M(2));
				AddHouseCar(houseid,2397.443359,1677.502441,10.516254,180.913650);
				AddHouseCar(houseid,2400.268554,1677.547607,10.516156,180.913864);
	houseid = CreateHouse(2406.438720,1682.326293,11.023437,M(1));
				AddHouseCar(houseid,2403.765136,1677.603881,10.484855,180.961547);
 	houseid = CreateHouse(886.117309,1980.287597,11.460937,M(2));
			AddHouseCar(houseid,882.642700,1972.900756,11.125531,269.771301);
			AddHouseCar(houseid,892.703552,1976.696166,10.936532,269.745422);
	houseid = CreateHouse(886.135192,2047.087768,11.460937,M(2));
			AddHouseCar(houseid,882.881652,2039.461791,11.124760,266.600952);
			AddHouseCar(houseid,892.782165,2043.281494,10.933774,266.528808);
	houseid = CreateHouse(929.789062,2027.662109,11.468292,M(3));
			AddHouseCar(houseid,934.267150,2019.945800,11.122293,90.797203);
			AddHouseCar(houseid,922.008239,2037.273193,10.760688,180.034835);
			AddHouseCar(houseid,925.098937,2028.844604,11.016989,164.233062);
	houseid = CreateHouse(928.141174,2007.970825,11.460937,M(2));
			AddHouseCar(houseid,933.633666,2012.954956,11.113464,89.702079);
			AddHouseCar(houseid,933.619323,2010.065551,11.137545,269.703063);
	houseid = CreateHouse(930.497680,1928.277587,11.468292,M(3));
			AddHouseCar(houseid,934.681640,1920.021850,11.127808,89.942031);
			AddHouseCar(houseid,921.726623,1939.111938,10.727608,180.334182);
			AddHouseCar(houseid,925.690246,1938.393432,11.005721,181.135040);
	houseid = CreateHouse(984.553344,1878.960815,11.468292,M(4));
			AddHouseCar(houseid,980.351684,1886.458374,11.123092,271.095947);
			AddHouseCar(houseid,989.662048,1869.848632,10.930142,1.033984);
			AddHouseCar(houseid,993.288940,1867.033935,10.698106,0.701488);
			AddHouseCar(houseid,1002.348815,1871.257202,10.388592,0.645836);
	houseid = CreateHouse(986.225524,1901.038574,11.460937,M(2));
			AddHouseCar(houseid,982.934814,1893.446899,11.114657,268.476074);
			AddHouseCar(houseid,993.039978,1897.603027,10.962033,268.755920);
	houseid = CreateHouse(985.147033,1930.684448,11.468750,M(1));
			AddHouseCar(houseid,989.033081,1938.818481,11.084056,272.053985);
	houseid = CreateHouse(984.497192,1978.532592,11.468292,M(2));
			AddHouseCar(houseid,980.550781,1985.982666,11.125843,272.418792);
			AddHouseCar(houseid,989.919677,1979.230224,10.962690,335.438964);
	houseid = CreateHouse(986.290466,2000.611206,11.460937,M(1));
			AddHouseCar(houseid,982.858764,1993.004882,11.114919,268.275573);
	houseid = CreateHouse(985.251159,2030.111083,11.468750,M(1));
			AddHouseCar(houseid,988.505310,2038.471191,11.085844,272.532165);
	houseid = CreateHouse(1030.066772,2028.093505,11.468292,M(2));
			AddHouseCar(houseid,1034.124755,2020.426879,11.125246,89.852661);
			AddHouseCar(houseid,1024.331176,2029.729736,10.934062,179.549652);
	houseid = CreateHouse(1028.263549,2005.358276,11.460937,M(1));
			AddHouseCar(houseid,1026.424194,2011.950561,11.120410,107.461639);
	houseid = CreateHouse(1029.981933,1976.371337,11.468750,M(1));
			AddHouseCar(houseid,1026.610473,1967.729614,11.101026,91.579223);
	houseid = CreateHouse(1030.204345,1927.476562,11.468292,M(2));
			AddHouseCar(houseid,1034.245727,1920.375610,11.120708,91.816085);
			AddHouseCar(houseid,1023.428100,1928.157470,10.877779,181.986572);
	houseid = CreateHouse(1028.623901,1906.172119,11.460937,M(1));
			AddHouseCar(houseid,1032.099121,1913.470947,11.112036,89.652755);
	houseid = CreateHouse(1029.572509,1876.586914,11.468750,M(1));
			AddHouseCar(houseid,1026.858154,1868.433349,11.107567,89.135414);
	houseid = CreateHouse(1030.617553,1848.159301,11.468292,M(2));
			AddHouseCar(houseid,1033.702148,1840.131347,11.119811,87.488014);
			AddHouseCar(houseid,1022.713562,1848.123046,10.848903,177.119812);
	houseid = CreateHouse(1085.159301,1976.592285,11.468750,M(4));
			AddHouseCar(houseid,1088.115966,1986.845092,11.094335,270.196655);
			AddHouseCar(houseid,1089.887939,1967.903930,10.980177,1.181710);
			AddHouseCar(houseid,1094.617431,1967.682373,10.669123,1.117001);
			AddHouseCar(houseid,1102.376220,1972.607788,10.372838,1.017546);
	houseid = CreateHouse(1086.311889,2000.661254,11.460937,M(2));
			AddHouseCar(houseid,1082.926635,1993.135375,11.114764,268.880676);
			AddHouseCar(houseid,1092.047241,1997.074340,10.982232,269.799804);
	houseid = CreateHouse(1084.754028,2031.739990,11.468292,M(3));
			AddHouseCar(houseid,1082.187011,2039.773193,11.126841,269.487854);
			AddHouseCar(houseid,1092.274291,2030.957397,10.840535,358.570739);
			AddHouseCar(houseid,1102.154418,2030.709594,10.416416,358.576049);
	houseid = CreateHouse(956.764038,2270.801025,11.468750,M(4));
			AddHouseCar(houseid,948.658020,2274.239501,11.085780,1.963590);
			AddHouseCar(houseid,965.444458,2275.962646,10.903906,91.933120);
			AddHouseCar(houseid,965.279174,2280.958496,10.647299,91.946166);
			AddHouseCar(houseid,957.820922,2288.395751,10.415854,91.938446);
	houseid = CreateHouse(986.744628,2271.901367,11.460937,M(2));
			AddHouseCar(houseid,994.178405,2269.076416,11.135497,359.545440);
			AddHouseCar(houseid,989.964172,2278.718994,10.958183,359.659149);
	houseid = CreateHouse(1032.373535,2316.008789,11.468292,M(3));
			AddHouseCar(houseid,1040.234619,2320.493652,11.120165,180.079132);
			AddHouseCar(houseid,1021.793090,2306.985351,10.707515,268.283508);
			AddHouseCar(houseid,1021.929382,2311.552734,10.988069,268.289733);
			AddHouseCar(houseid,1028.335693,2298.202148,10.398199,259.061401);
	houseid = CreateHouse(986.625183,2314.418701,11.460937,M(2));
			AddHouseCar(houseid,983.400573,2306.827392,11.115299,269.894226);
			AddHouseCar(houseid,1001.344726,2318.685302,10.470921,4.611554);
	houseid = CreateHouse(985.461425,2344.018066,11.468750,M(3));
			AddHouseCar(houseid,987.064758,2350.963867,11.124280,267.908081);
			AddHouseCar(houseid,990.264099,2334.451171,10.909842,181.187744);
			AddHouseCar(houseid,994.757629,2334.544433,10.664906,1.186464);
			AddHouseCar(houseid,1002.180969,2343.101318,10.425709,0.931020);
	houseid = CreateHouse(1320.034545,2028.051757,11.468292,M(1));
			AddHouseCar(houseid,1323.632202,2020.355957,11.136847,88.679351);
	houseid = CreateHouse(1318.472290,2005.769775,11.460937,M(2));
			AddHouseCar(houseid,1321.508544,2013.548583,11.121800,88.971168);
			AddHouseCar(houseid,1301.981811,2003.395507,10.407058,178.717605);
	houseid = CreateHouse(1319.724853,1975.668457,11.468750,M(3));
			AddHouseCar(houseid,1317.196899,1968.008544,11.122746,90.849403);
			AddHouseCar(houseid,1314.534912,1981.075195,10.916768,178.727722);
			AddHouseCar(houseid,1302.022827,1981.652832,10.405147,178.364837);
	houseid = CreateHouse(1309.503417,1932.246093,11.460937,M(1));
			AddHouseCar(houseid,1316.919921,1928.997558,11.125106,0.184517);
	houseid = CreateHouse(1336.489501,1932.114624,11.460937,M(1));
			AddHouseCar(houseid,1344.195800,1928.789550,11.115103,359.183868);
	houseid = CreateHouse(1365.357910,1896.919677,11.468750,M(1));
			AddHouseCar(houseid,1367.696777,1904.417358,11.118111,269.212066);
	houseid = CreateHouse(1364.598144,1931.699584,11.468292,M(1));
			AddHouseCar(houseid,1361.682006,1939.555419,11.121564,269.168579);
	houseid = CreateHouse(1366.729980,1973.769897,11.460937,M(1));
			AddHouseCar(houseid,1363.446899,1966.484375,11.112280,269.590576);
	houseid = CreateHouse(1364.749389,2004.148071,11.460937,M(1));
			AddHouseCar(houseid,1369.801391,2011.686523,11.033431,286.501373);
	houseid = CreateHouse(1366.170532,2027.817016,11.460937,M(1));
			AddHouseCar(houseid,1363.584716,2020.216064,11.114261,268.341278);
	houseid = CreateHouse(1408.704223,1919.969970,11.468750,M(2));
			AddHouseCar(houseid,1404.528808,1911.919311,11.085026,92.038543);
			AddHouseCar(houseid,1401.473388,1920.853637,10.839749,181.126235);
	houseid = CreateHouse(1464.949462,1895.068237,11.460937,M(2));
			AddHouseCar(houseid,1466.871826,1901.881591,11.116089,270.025207);
			AddHouseCar(houseid,1475.370239,1893.566284,10.624332,0.968917);
	houseid = CreateHouse(1464.711669,1920.178588,11.460937,M(2));
			AddHouseCar(houseid,1468.452270,1929.162963,11.072841,274.945190);
			AddHouseCar(houseid,1470.581420,1918.138183,10.904006,0.733869);
	houseid = CreateHouse(1554.615844,2074.390869,11.359375,M(3));
			AddHouseCar(houseid,1562.879882,2081.591796,11.035935,89.908935);
			AddHouseCar(houseid,1556.726562,2078.219238,11.022402,89.922515);
			AddHouseCar(houseid,1532.346313,2071.713867,10.407240,0.087283);
	houseid = CreateHouse(1550.220214,2096.290283,11.460937,M(1));
			AddHouseCar(houseid,1545.195068,2088.218994,11.066601,272.053131);
	houseid = CreateHouse(1548.316162,2125.361572,11.460937,M(1));
			AddHouseCar(houseid,1550.978149,2133.471679,11.117532,93.487464);
	houseid = CreateHouse(1597.324340,2147.282470,11.460937,M(2));
			AddHouseCar(houseid,1594.343994,2139.994140,11.114163,267.928802);
	houseid = CreateHouse(1595.830322,2123.238281,11.460937,M(2));
			AddHouseCar(houseid,1599.471191,2131.489746,11.081867,270.675842);
			AddHouseCar(houseid,1613.359741,2121.901855,10.401012,183.463821);
 	houseid = CreateHouse(886.117309,1980.287597,11.460937,M(2));
			AddHouseCar(houseid,882.642700,1972.900756,11.125531,269.771301);
			AddHouseCar(houseid,892.703552,1976.696166,10.936532,269.745422);
	houseid = CreateHouse(886.135192,2047.087768,11.460937,M(2));
			AddHouseCar(houseid,882.881652,2039.461791,11.124760,266.600952);
			AddHouseCar(houseid,892.782165,2043.281494,10.933774,266.528808);
	houseid = CreateHouse(929.789062,2027.662109,11.468292,M(3));
			AddHouseCar(houseid,934.267150,2019.945800,11.122293,90.797203);
			AddHouseCar(houseid,922.008239,2037.273193,10.760688,180.034835);
			AddHouseCar(houseid,925.098937,2028.844604,11.016989,164.233062);
	houseid = CreateHouse(928.141174,2007.970825,11.460937,M(2));
			AddHouseCar(houseid,933.633666,2012.954956,11.113464,89.702079);
			AddHouseCar(houseid,933.619323,2010.065551,11.137545,269.703063);
	houseid = CreateHouse(930.497680,1928.277587,11.468292,M(3));
			AddHouseCar(houseid,934.681640,1920.021850,11.127808,89.942031);
			AddHouseCar(houseid,921.726623,1939.111938,10.727608,180.334182);
			AddHouseCar(houseid,925.690246,1938.393432,11.005721,181.135040);
	houseid = CreateHouse(984.553344,1878.960815,11.468292,M(4));
			AddHouseCar(houseid,980.351684,1886.458374,11.123092,271.095947);
			AddHouseCar(houseid,989.662048,1869.848632,10.930142,1.033984);
			AddHouseCar(houseid,993.288940,1867.033935,10.698106,0.701488);
			AddHouseCar(houseid,1002.348815,1871.257202,10.388592,0.645836);
	houseid = CreateHouse(986.225524,1901.038574,11.460937,M(2));
			AddHouseCar(houseid,982.934814,1893.446899,11.114657,268.476074);
			AddHouseCar(houseid,993.039978,1897.603027,10.962033,268.755920);
	houseid = CreateHouse(985.147033,1930.684448,11.468750,M(1));
			AddHouseCar(houseid,989.033081,1938.818481,11.084056,272.053985);
	houseid = CreateHouse(984.497192,1978.532592,11.468292,M(2));
			AddHouseCar(houseid,980.550781,1985.982666,11.125843,272.418792);
			AddHouseCar(houseid,989.919677,1979.230224,10.962690,335.438964);
	houseid = CreateHouse(986.290466,2000.611206,11.460937,M(1));
			AddHouseCar(houseid,982.858764,1993.004882,11.114919,268.275573);
	houseid = CreateHouse(985.251159,2030.111083,11.468750,M(1));
			AddHouseCar(houseid,988.505310,2038.471191,11.085844,272.532165);
	houseid = CreateHouse(1030.066772,2028.093505,11.468292,M(2));
			AddHouseCar(houseid,1034.124755,2020.426879,11.125246,89.852661);
			AddHouseCar(houseid,1024.331176,2029.729736,10.934062,179.549652);
	houseid = CreateHouse(1028.263549,2005.358276,11.460937,M(1));
			AddHouseCar(houseid,1026.424194,2011.950561,11.120410,107.461639);
	houseid = CreateHouse(1029.981933,1976.371337,11.468750,M(1));
			AddHouseCar(houseid,1026.610473,1967.729614,11.101026,91.579223);
	houseid = CreateHouse(1030.204345,1927.476562,11.468292,M(2));
			AddHouseCar(houseid,1034.245727,1920.375610,11.120708,91.816085);
			AddHouseCar(houseid,1023.428100,1928.157470,10.877779,181.986572);
	houseid = CreateHouse(1028.623901,1906.172119,11.460937,M(1));
			AddHouseCar(houseid,1032.099121,1913.470947,11.112036,89.652755);
	houseid = CreateHouse(1029.572509,1876.586914,11.468750,M(1));
			AddHouseCar(houseid,1026.858154,1868.433349,11.107567,89.135414);
	houseid = CreateHouse(1030.617553,1848.159301,11.468292,M(2));
			AddHouseCar(houseid,1033.702148,1840.131347,11.119811,87.488014);
			AddHouseCar(houseid,1022.713562,1848.123046,10.848903,177.119812);
	houseid = CreateHouse(1085.159301,1976.592285,11.468750,M(4));
			AddHouseCar(houseid,1088.115966,1986.845092,11.094335,270.196655);
			AddHouseCar(houseid,1089.887939,1967.903930,10.980177,1.181710);
			AddHouseCar(houseid,1094.617431,1967.682373,10.669123,1.117001);
			AddHouseCar(houseid,1102.376220,1972.607788,10.372838,1.017546);
	houseid = CreateHouse(1086.311889,2000.661254,11.460937,M(2));
			AddHouseCar(houseid,1082.926635,1993.135375,11.114764,268.880676);
			AddHouseCar(houseid,1092.047241,1997.074340,10.982232,269.799804);
	houseid = CreateHouse(1084.754028,2031.739990,11.468292,M(3));
			AddHouseCar(houseid,1082.187011,2039.773193,11.126841,269.487854);
			AddHouseCar(houseid,1092.274291,2030.957397,10.840535,358.570739);
			AddHouseCar(houseid,1102.154418,2030.709594,10.416416,358.576049);
	houseid = CreateHouse(956.764038,2270.801025,11.468750,M(4));
			AddHouseCar(houseid,948.658020,2274.239501,11.085780,1.963590);
			AddHouseCar(houseid,965.444458,2275.962646,10.903906,91.933120);
			AddHouseCar(houseid,965.279174,2280.958496,10.647299,91.946166);
			AddHouseCar(houseid,957.820922,2288.395751,10.415854,91.938446);
	houseid = CreateHouse(986.744628,2271.901367,11.460937,M(2));
			AddHouseCar(houseid,994.178405,2269.076416,11.135497,359.545440);
			AddHouseCar(houseid,989.964172,2278.718994,10.958183,359.659149);
	houseid = CreateHouse(1032.373535,2316.008789,11.468292,M(3));
			AddHouseCar(houseid,1040.234619,2320.493652,11.120165,180.079132);
			AddHouseCar(houseid,1021.793090,2306.985351,10.707515,268.283508);
			AddHouseCar(houseid,1021.929382,2311.552734,10.988069,268.289733);
			AddHouseCar(houseid,1028.335693,2298.202148,10.398199,259.061401);
	houseid = CreateHouse(986.625183,2314.418701,11.460937,M(2));
			AddHouseCar(houseid,983.400573,2306.827392,11.115299,269.894226);
			AddHouseCar(houseid,1001.344726,2318.685302,10.470921,4.611554);
	houseid = CreateHouse(985.461425,2344.018066,11.468750,M(3));
			AddHouseCar(houseid,987.064758,2350.963867,11.124280,267.908081);
			AddHouseCar(houseid,990.264099,2334.451171,10.909842,181.187744);
			AddHouseCar(houseid,994.757629,2334.544433,10.664906,1.186464);
			AddHouseCar(houseid,1002.180969,2343.101318,10.425709,0.931020);
	houseid = CreateHouse(1320.034545,2028.051757,11.468292,M(1));
			AddHouseCar(houseid,1323.632202,2020.355957,11.136847,88.679351);
	houseid = CreateHouse(1318.472290,2005.769775,11.460937,M(2));
			AddHouseCar(houseid,1321.508544,2013.548583,11.121800,88.971168);
			AddHouseCar(houseid,1301.981811,2003.395507,10.407058,178.717605);
	houseid = CreateHouse(1319.724853,1975.668457,11.468750,M(3));
			AddHouseCar(houseid,1317.196899,1968.008544,11.122746,90.849403);
			AddHouseCar(houseid,1314.534912,1981.075195,10.916768,178.727722);
			AddHouseCar(houseid,1302.022827,1981.652832,10.405147,178.364837);
	houseid = CreateHouse(1309.503417,1932.246093,11.460937,M(1));
			AddHouseCar(houseid,1316.919921,1928.997558,11.125106,0.184517);
	houseid = CreateHouse(1336.489501,1932.114624,11.460937,M(1));
			AddHouseCar(houseid,1344.195800,1928.789550,11.115103,359.183868);
	houseid = CreateHouse(1365.357910,1896.919677,11.468750,M(1));
			AddHouseCar(houseid,1367.696777,1904.417358,11.118111,269.212066);
	houseid = CreateHouse(1364.598144,1931.699584,11.468292,M(1));
			AddHouseCar(houseid,1361.682006,1939.555419,11.121564,269.168579);
	houseid = CreateHouse(1366.729980,1973.769897,11.460937,M(1));
			AddHouseCar(houseid,1363.446899,1966.484375,11.112280,269.590576);
	houseid = CreateHouse(1364.749389,2004.148071,11.460937,M(1));
			AddHouseCar(houseid,1369.801391,2011.686523,11.033431,286.501373);
	houseid = CreateHouse(1366.170532,2027.817016,11.460937,M(1));
			AddHouseCar(houseid,1363.584716,2020.216064,11.114261,268.341278);
	houseid = CreateHouse(1408.704223,1919.969970,11.468750,M(2));
			AddHouseCar(houseid,1404.528808,1911.919311,11.085026,92.038543);
			AddHouseCar(houseid,1401.473388,1920.853637,10.839749,181.126235);
	houseid = CreateHouse(1464.949462,1895.068237,11.460937,M(2));
			AddHouseCar(houseid,1466.871826,1901.881591,11.116089,270.025207);
			AddHouseCar(houseid,1475.370239,1893.566284,10.624332,0.968917);
	houseid = CreateHouse(1464.711669,1920.178588,11.460937,M(2));
			AddHouseCar(houseid,1468.452270,1929.162963,11.072841,274.945190);
			AddHouseCar(houseid,1470.581420,1918.138183,10.904006,0.733869);
	houseid = CreateHouse(1554.615844,2074.390869,11.359375,M(3));
			AddHouseCar(houseid,1562.879882,2081.591796,11.035935,89.908935);
			AddHouseCar(houseid,1556.726562,2078.219238,11.022402,89.922515);
			AddHouseCar(houseid,1532.346313,2071.713867,10.407240,0.087283);
	houseid = CreateHouse(1550.220214,2096.290283,11.460937,M(1));
			AddHouseCar(houseid,1545.195068,2088.218994,11.066601,272.053131);
	houseid = CreateHouse(1548.316162,2125.361572,11.460937,M(1));
			AddHouseCar(houseid,1550.978149,2133.471679,11.117532,93.487464);
	houseid = CreateHouse(1597.324340,2147.282470,11.460937,M(2));
			AddHouseCar(houseid,1594.343994,2139.994140,11.114163,267.928802);
	houseid = CreateHouse(1595.830322,2123.238281,11.460937,M(2));
			AddHouseCar(houseid,1599.471191,2131.489746,11.081867,270.675842);
			AddHouseCar(houseid,1613.359741,2121.901855,10.401012,183.463821);
	houseid = CreateHouse(1597.177856,2093.511230,11.312500,M(2));
			AddHouseCar(houseid,1593.267456,2085.862792,10.975867,271.835052);
			AddHouseCar(houseid,1603.754028,2089.932617,10.785626,271.829620);
	houseid = CreateHouse(1596.000732,2038.250610,11.468750,M(1));
			AddHouseCar(houseid,1599.417846,2046.609985,11.089862,272.662109);
	houseid = CreateHouse(1640.903564,2044.635498,11.319854,M(1));
			AddHouseCar(houseid,1644.385131,2036.888305,10.982048,88.582702);
	houseid = CreateHouse(1639.801879,2075.705078,11.312500,M(1));
			AddHouseCar(houseid,1643.196166,2082.704101,10.975718,90.419105);
	houseid = CreateHouse(1639.740600,2102.628173,11.312500,M(1));
			AddHouseCar(houseid,1636.999023,2109.992431,10.944985,92.502822);
			AddHouseCar(houseid,1623.439941,2103.251464,10.267103,179.548171);
	houseid = CreateHouse(1645.514892,2127.379882,11.203125,M(2));
			AddHouseCar(houseid,1654.725952,2134.637695,10.867224,87.986984);
			AddHouseCar(houseid,1647.387207,2131.188232,10.859574,87.901748);
	houseid = CreateHouse(1641.038330,2149.892089,11.312500,M(1));
			AddHouseCar(houseid,1637.417358,2141.471435,10.944512,91.626129);
	houseid = CreateHouse(1684.868530,2123.089843,11.460937,M(1));
			AddHouseCar(houseid,1687.798339,2131.384765,11.106827,271.782257);
	houseid = CreateHouse(1686.375976,2093.748046,11.460937,M(1));
			AddHouseCar(houseid,1692.221801,2086.192138,10.945013,270.076171);
	houseid = CreateHouse(1680.059692,2068.869140,11.359375,M(2));
			AddHouseCar(houseid,1680.390014,2063.163818,11.015745,267.959960);
			AddHouseCar(houseid,1702.770751,2074.466308,10.407809,356.986999);
	houseid = CreateHouse(1685.005371,2046.491455,11.468750,M(1));
			AddHouseCar(houseid,1688.328002,2054.912597,11.094480,89.252159);
	houseid = CreateHouse(1225.294433,2584.822265,10.820312,M(2));
			AddHouseCar(houseid,1234.939331,2589.109375,10.480113,269.402923);
			AddHouseCar(houseid,1235.005859,2595.509521,10.480124,269.402923);
	houseid = CreateHouse(1223.015869,2616.796386,10.826543,M(2));
			AddHouseCar(houseid,1234.375122,2606.350097,10.484279,270.841735);
			AddHouseCar(houseid,1234.289916,2612.135986,10.502644,270.840759);
	houseid = CreateHouse(1265.590209,2609.426513,10.820312,M(2));
			AddHouseCar(houseid,1272.140136,2602.588867,10.482320,221.140197);
	houseid = CreateHouse(1285.207885,2610.301513,10.820312,M(2));
			AddHouseCar(houseid,1289.201171,2601.180175,10.481299,268.687713);
	houseid = CreateHouse(1313.659179,2609.387207,11.054918,M(2));
			AddHouseCar(houseid,1315.528930,2601.664306,10.476721,181.085372);
	houseid = CreateHouse(1344.477172,2609.967041,11.298933,M(2));
			AddHouseCar(houseid,1347.041015,2603.551757,10.506577,0.808424);
	houseid = CreateHouse(1516.054199,2610.012939,11.298933,M(2));
			AddHouseCar(houseid,1518.557250,2605.083496,10.477893,1.269184);
	houseid = CreateHouse(1534.908081,2609.268554,10.820312,M(2));
			AddHouseCar(houseid,1542.067993,2601.900390,10.507431,244.134552);
	houseid = CreateHouse(1554.521240,2610.321533,10.820312,M(2));
			AddHouseCar(houseid,1561.069458,2601.938720,10.499315,110.307220);
	houseid = CreateHouse(1600.462036,2609.704101,10.820312,M(2));
			AddHouseCar(houseid,1608.023071,2603.263427,10.483923,145.673995);
	houseid = CreateHouse(1618.632934,2609.741210,10.820312,M(2));
			AddHouseCar(houseid,1625.615356,2603.549316,10.491143,132.370666);
	houseid = CreateHouse(1638.248657,2609.900146,10.820312,M(2));
			AddHouseCar(houseid,1644.602905,2601.941162,10.476967,127.409835);
	houseid = CreateHouse(1666.936767,2610.164306,11.298933,M(2));
			AddHouseCar(houseid,1669.402099,2604.639892,10.475492,1.771448);
	houseid = CreateHouse(1665.540283,2570.043457,11.054918,M(2));
			AddHouseCar(houseid,1663.103271,2574.306396,10.472265,178.469390);
	houseid = CreateHouse(1646.680786,2570.007812,10.820312,M(2));
			AddHouseCar(houseid,1640.138183,2576.199462,10.489848,94.080322);
	houseid = CreateHouse(1623.378417,2567.800781,10.820312,M(2));
			AddHouseCar(houseid,1609.343261,2577.970214,10.483327,0.535589);
	houseid = CreateHouse(1596.627807,2568.022705,10.820312,M(2));
			AddHouseCar(houseid,1591.781982,2577.639648,10.477983,302.468444);
	houseid = CreateHouse(1564.771850,2566.119384,10.820312,M(2));
			AddHouseCar(houseid,1571.642944,2576.563964,10.484012,326.616027);
	houseid = CreateHouse(1551.660522,2567.725830,10.820312,M(2));
			AddHouseCar(houseid,1538.601928,2577.516357,10.483505,313.012939);
	houseid = CreateHouse(1513.377685,2565.922607,10.826543,M(2));
			AddHouseCar(houseid,1521.578369,2576.125244,10.498824,316.471557);
	houseid = CreateHouse(1503.458862,2568.098144,10.820312,M(2));
			AddHouseCar(houseid,1496.187744,2577.523437,10.478097,302.413696);
	houseid = CreateHouse(1500.092529,2535.529541,10.820312,M(2));
			AddHouseCar(houseid,1496.960571,2540.435546,10.478819,89.646507);
	houseid = CreateHouse(1454.413940,2525.571533,10.820312,M(2));
			AddHouseCar(houseid,1459.047973,2519.925537,10.485668,271.976867);
	houseid = CreateHouse(1451.287231,2566.635009,10.820312,M(2));
			AddHouseCar(houseid,1458.871459,2576.593994,10.476991,131.767822);
	houseid = CreateHouse(1441.661987,2567.854736,10.820312,M(2));
			AddHouseCar(houseid,1434.066528,2578.010498,10.488245,295.338409);
	houseid = CreateHouse(1417.807617,2568.611328,10.820312,M(2));
			AddHouseCar(houseid,1406.201904,2577.583496,10.486886,314.343994);
	houseid = CreateHouse(1407.589111,2524.610107,10.820312,M(2));
			AddHouseCar(houseid,1397.620727,2539.619140,10.478739,180.138488);
	houseid = CreateHouse(1362.465209,2525.742919,10.820312,M(2));
			AddHouseCar(houseid,1366.742797,2519.523681,10.474376,268.468505);
	houseid = CreateHouse(1359.891723,2565.889648,10.826543,M(2));
			AddHouseCar(houseid,1366.413818,2577.842041,10.479126,37.094383);
	houseid = CreateHouse(1349.680053,2567.977539,10.820312,M(2));
			AddHouseCar(houseid,1343.106689,2577.701171,10.511833,315.573364);
	houseid = CreateHouse(1325.901977,2568.041992,10.820312,M(2));
			AddHouseCar(houseid,1312.548461,2577.490722,10.484419,308.314392);
	houseid = CreateHouse(1315.606933,2524.499023,10.820312,M(2));
			AddHouseCar(houseid,1303.694946,2529.167724,10.473457,87.713676);
	houseid = CreateHouse(1276.961791,2522.770019,10.820312,M(2));
			AddHouseCar(houseid,1282.331420,2528.767333,10.477299,271.653930);
	houseid = CreateHouse(1270.508911,2554.477050,10.820312,M(2));
			AddHouseCar(houseid,1280.655151,2546.886230,10.477859,272.005981);
	houseid = CreateHouse(1272.496948,2564.552734,10.820312,M(2));
			AddHouseCar(houseid,1282.301879,2571.619873,10.525420,271.836334);
	houseid = CreateHouse(1611.213867,2648.096191,10.826543,M(5));
			AddHouseCar(houseid,1599.616088,2652.691650,10.477069,90.552780);
			AddHouseCar(houseid,1599.564697,2658.037353,10.484815,90.553482);
	houseid = CreateHouse(1607.037719,2679.418457,10.820312,M(5));
			AddHouseCar(houseid,1601.125366,2675.975341,10.485889,90.683944);
			AddHouseCar(houseid,1601.189697,2670.585937,10.504986,90.682556);
	houseid = CreateHouse(1573.264038,2659.061767,10.820312,M(5));
			AddHouseCar(houseid,1564.980957,2668.238037,10.480965,357.487579);
	houseid = CreateHouse(1556.141845,2659.211181,10.820312,M(5));
			AddHouseCar(houseid,1550.620117,2664.669677,10.480990,357.652862);
	houseid = CreateHouse(1570.361450,2711.295410,10.820312,M(5));
			AddHouseCar(houseid,1561.286865,2721.290771,10.483796,305.689025);
	houseid = CreateHouse(1580.057739,2708.860595,10.826543,M(5));
			AddHouseCar(houseid,1588.366699,2720.104003,10.476665,38.166439);
	houseid = CreateHouse(1601.020141,2709.527587,10.820312,M(5));
			AddHouseCar(houseid,1608.679443,2719.680175,10.478944,49.311195);
	houseid = CreateHouse(1627.206665,2711.827392,10.820312,M(5));
			AddHouseCar(houseid,1622.800781,2714.335693,10.478734,0.876704);
	houseid = CreateHouse(1652.335327,2709.440673,10.826543,M(5));
			AddHouseCar(houseid,1657.938354,2720.087890,10.471661,181.971908);
			AddHouseCar(houseid,1661.993408,2720.227294,10.503774,181.973495);
	houseid = CreateHouse(1663.305664,2753.416015,10.820312,M(5));
			AddHouseCar(houseid,1670.369384,2745.510986,10.472484,119.066772);
	houseid = CreateHouse(1643.595092,2752.799804,10.820312,M(5));
			AddHouseCar(houseid,1650.053833,2746.440429,10.483434,227.095825);
	houseid = CreateHouse(1626.740844,2753.651123,10.820312,M(5));
			AddHouseCar(houseid,1633.388305,2744.624267,10.484026,45.104148);
	houseid = CreateHouse(1608.433349,2754.094970,10.820312,M(5));
			AddHouseCar(houseid,1615.197998,2745.198486,10.499040,243.102661);
	houseid = CreateHouse(1599.509643,2756.935546,10.820312,M(5));
			AddHouseCar(houseid,1591.048095,2746.465332,10.477041,232.545425);
	houseid = CreateHouse(1564.419433,2757.189697,10.820312,M(5));
			AddHouseCar(houseid,1556.252807,2750.835205,10.477115,42.928218);
	houseid = CreateHouse(1564.234252,2776.652832,10.820312,M(5));
			AddHouseCar(houseid,1557.957397,2769.071044,10.492681,44.014286);
	houseid = CreateHouse(1564.557128,2793.651367,10.820312,M(5));
			AddHouseCar(houseid,1556.314819,2789.052978,10.470563,148.844238);
	houseid = CreateHouse(1575.703247,2843.868652,10.820312,M(5));
			AddHouseCar(houseid,1580.607177,2840.795166,10.547389,180.212158);
	houseid = CreateHouse(1601.867797,2845.279785,10.820312,M(6));
			AddHouseCar(houseid,1597.026000,2834.948486,10.548228,182.560791);
			AddHouseCar(houseid,1591.798095,2835.352050,10.547414,179.451049);
	houseid = CreateHouse(1622.707031,2845.019531,10.820312,M(5));
			AddHouseCar(houseid,1616.567504,2834.140869,10.564188,131.713607);
	houseid = CreateHouse(1632.890747,2843.329589,10.820312,M(5));
			AddHouseCar(houseid,1639.645996,2833.821044,10.548221,141.787063);
	houseid = CreateHouse(1664.802734,2845.393798,10.820312,M(5));
			AddHouseCar(houseid,1658.669189,2834.357177,10.548213,138.778823);
	houseid = CreateHouse(1673.027832,2801.389648,10.820312,M(5));
			AddHouseCar(houseid,1667.199218,2810.168701,10.548223,288.768585);
	houseid = CreateHouse(1655.099121,2801.500000,10.820312,M(5));
			AddHouseCar(houseid,1649.335815,2809.953369,10.548223,308.029785);
	houseid = CreateHouse(1638.015136,2802.374755,10.820312,M(7));
			AddHouseCar(houseid,1626.478149,2808.587402,10.554459,1.474588);
			AddHouseCar(houseid,1630.189697,2808.682861,10.554518,1.474787);
			AddHouseCar(houseid,1634.772460,2808.800048,10.554592,1.474720);
	houseid = CreateHouse(1618.382324,2801.749267,10.820312,M(5));
			AddHouseCar(houseid,1611.830688,2810.661132,10.545351,316.667205);
	houseid = CreateHouse(1588.397338,2797.878173,10.826543,M(5));
			AddHouseCar(houseid,1595.581542,2808.666259,10.548216,323.072174);
	houseid = CreateHouse(1703.780029,2689.158203,10.826543,M(5));
			AddHouseCar(houseid,1710.854370,2699.896728,10.548887,47.291362);
	houseid = CreateHouse(1735.701049,2691.111083,10.820312,M(5));
			AddHouseCar(houseid,1727.275878,2701.253662,10.548979,269.497314);
	houseid = CreateHouse(1921.764526,2664.561767,10.820312,M(5));
			AddHouseCar(houseid,1928.391967,2656.436523,10.548228,119.912727);
	houseid = CreateHouse(1950.673095,2664.665527,11.298933,M(5));
			AddHouseCar(houseid,1952.563720,2659.931396,10.544081,0.939723);
	houseid = CreateHouse(1969.653320,2663.562500,10.820312,M(5));
			AddHouseCar(houseid,1976.326660,2658.069824,10.555461,143.809295);
	houseid = CreateHouse(1989.015625,2664.738769,10.820312,M(5));
			AddHouseCar(houseid,1995.770263,2656.333984,10.548921,134.728347);
	houseid = CreateHouse(2018.067260,2664.664062,11.298933,M(5));
			AddHouseCar(houseid,2020.438354,2659.692871,10.548889,357.667694);
	houseid = CreateHouse(2037.163940,2663.917236,10.820312,M(5));
			AddHouseCar(houseid,2045.338256,2657.270507,10.555269,134.144042);
	houseid = CreateHouse(2056.547119,2664.823242,10.820312,M(5));
			AddHouseCar(houseid,2063.650146,2655.648437,10.549712,136.136840);
	houseid = CreateHouse(2066.072021,2721.545898,10.820312,M(5));
			AddHouseCar(houseid,2059.716552,2729.891113,10.549151,294.763031);
	houseid = CreateHouse(2037.210937,2721.763183,11.298933,M(5));
			AddHouseCar(houseid,2035.076782,2726.900878,10.549043,178.022842);
	houseid = CreateHouse(2018.293823,2722.340332,10.820312,M(5));
			AddHouseCar(houseid,2010.734252,2729.174560,10.556103,142.685119);
	houseid = CreateHouse(1998.730712,2722.134521,10.820312,M(5));
			AddHouseCar(houseid,1992.192382,2730.602783,10.548322,121.033088);
	houseid = CreateHouse(1969.896728,2721.795898,11.298933,M(5));
			AddHouseCar(houseid,1967.838867,2726.056884,10.562458,179.855972);
	houseid = CreateHouse(1950.850708,2722.990478,10.820312,M(5));
			AddHouseCar(houseid,1944.655761,2729.364501,10.554410,148.289993);
	houseid = CreateHouse(1931.332031,2721.446289,10.820312,M(5));
			AddHouseCar(houseid,1924.498413,2730.970703,10.549032,300.335662);
	houseid = CreateHouse(1929.485473,2774.309082,10.820312,M(5));
			AddHouseCar(houseid,1919.706665,2762.621826,10.555260,36.672660);
	houseid = CreateHouse(1967.193969,2766.546630,10.826543,M(5));
			AddHouseCar(houseid,1960.444458,2755.129150,10.548230,227.618392);
	houseid = CreateHouse(1992.774169,2764.347167,10.820312,M(5));
			AddHouseCar(houseid,1997.716430,2761.312988,10.544722,179.100814);
	houseid = CreateHouse(2018.489624,2766.250976,10.826543,M(5));
			AddHouseCar(houseid,2011.317138,2756.537109,10.541407,137.627410);
	houseid = CreateHouse(2039.651123,2765.578125,10.820312,M(5));
			AddHouseCar(houseid,2031.880859,2755.064208,10.547773,137.351379);
	houseid = CreateHouse(2049.206542,2764.202880,10.820312,M(5));
			AddHouseCar(houseid,2054.614501,2754.430908,10.548892,118.545776);

/*                    END LV HOUSES                   */
#endif

#if defined RITCH_HOUSES
/*                 START RITCH HOUSES                 */
	houseid = CreateHouse(-2523.700439,2239.138183,5.398437,M(6));
	AddHouseCar(houseid,-2529.302001,2248.562255,4.687685,335.172088);
	AddHouseCar(houseid,-2515.386718,2240.359375,4.689988,335.168670);
	AddHouseCar(houseid,-2519.210937,2242.218505,4.711380,338.498260);
	AddHouseCar(houseid,-2526.265136,2245.072265,4.689486,335.165649);
	AddHouseCar(houseid,-2523.497070,2243.791259,4.689607,335.165649);
	houseid = CreateHouse(-2437.547363,2354.917480,5.443065,M(6));
	AddHouseCar(houseid,-2423.565917,2347.205322,4.679184,191.044891);
	AddHouseCar(houseid,-2426.173583,2346.696289,4.688474,191.046005);
	AddHouseCar(houseid,-2429.221923,2346.101074,4.696327,191.047561);
	AddHouseCar(houseid,-2447.577636,2336.683593,4.614558,278.966735);
	AddHouseCar(houseid,-2434.223632,2339.605712,4.614949,278.876678);
	houseid = CreateHouse(-2348.987304,2422.541992,7.342868,M(6));
	AddHouseCar(houseid,-2364.249511,2421.615234,7.476651,232.343551);
	AddHouseCar(houseid,-2358.677246,2417.258300,6.989325,232.053680);
	AddHouseCar(houseid,-2350.560791,2412.451171,6.372281,231.573196);
	AddHouseCar(houseid,-2345.397949,2408.542968,6.061335,231.605377);
	AddHouseCar(houseid,-2337.147949,2402.505126,5.698689,241.818588);
	houseid = CreateHouse(-2379.364990,2443.958984,10.169355,M(6));
	AddHouseCar(houseid,-2366.597900,2432.554931,8.229817,138.791625);
	AddHouseCar(houseid,-2369.743408,2433.711669,8.526362,151.061508);
	AddHouseCar(houseid,-2372.906005,2435.431884,8.794822,151.071426);
	AddHouseCar(houseid,-2394.106933,2436.203369,10.218517,75.215164);
	AddHouseCar(houseid,-2381.799316,2432.121582,8.941645,69.232513);
	houseid = CreateHouse(-2424.813232,2448.308837,13.165367,M(6));
	AddHouseCar(houseid,-2429.558105,2447.719970,13.345427,181.449676);
	AddHouseCar(houseid,-2420.013183,2446.191162,12.661707,97.802246);
	AddHouseCar(houseid,-2406.935302,2454.075439,12.608323,179.766510);
	AddHouseCar(houseid,-2402.441162,2452.098144,12.219336,179.768859);
	AddHouseCar(houseid,-2417.430175,2439.045654,12.289124,92.784538);
	houseid = CreateHouse(-2480.039306,2449.709472,17.323022,M(6));
	AddHouseCar(houseid,-2455.520996,2439.433105,14.591206,91.465904);
	AddHouseCar(houseid,-2462.493652,2438.563232,15.002972,97.647285);
	AddHouseCar(houseid,-2471.070312,2437.359619,15.378831,97.985961);
	AddHouseCar(houseid,-2480.331542,2435.989013,15.786783,98.393821);
	AddHouseCar(houseid,-2491.048583,2432.731445,16.137836,108.940032);
	houseid = CreateHouse(-2552.034423,2266.432128,5.475524,M(6));
	AddHouseCar(houseid,-2554.179687,2271.074951,4.766026,335.286743);
	AddHouseCar(houseid,-2544.249023,2276.414550,4.613311,243.109146);
	AddHouseCar(houseid,-2530.534912,2269.616210,4.612952,63.746543);
	AddHouseCar(houseid,-2537.099609,2264.282714,4.723991,334.462036);
	AddHouseCar(houseid,-2545.504394,2269.172851,4.739918,335.048858);
	houseid = CreateHouse(-2582.200683,2300.381103,7.002885,M(6));
	AddHouseCar(houseid,-2569.190917,2289.721435,5.030637,308.965789);
	AddHouseCar(houseid,-2566.941406,2286.934814,5.006344,309.023376);
	AddHouseCar(houseid,-2565.979248,2301.840576,4.613014,15.653062);
	AddHouseCar(houseid,-2568.087402,2310.697998,4.612452,2.375823);
	AddHouseCar(houseid,-2570.027832,2323.161132,4.612871,27.609266);
	houseid = CreateHouse(-2626.569824,2283.434814,8.306278,M(6));
	AddHouseCar(houseid,-2628.820556,2273.477783,8.015316,271.111389);
	AddHouseCar(houseid,-2628.749023,2269.802001,7.882690,271.092559);
	AddHouseCar(houseid,-2619.741699,2274.536865,7.915923,340.964538);
	AddHouseCar(houseid,-2618.893554,2285.356689,7.920714,359.820892);
	AddHouseCar(houseid,-2618.806152,2293.562744,7.920962,359.446075);
	houseid = CreateHouse(-2626.438964,2309.763183,8.305223,M(6));
	AddHouseCar(houseid,-2618.586425,2303.470458,7.921304,358.940490);
	AddHouseCar(houseid,-2618.351318,2313.075683,7.926210,358.593688);
	AddHouseCar(houseid,-2618.139892,2320.789550,7.896294,358.360931);
	AddHouseCar(houseid,-2619.486328,2330.355957,7.952637,4.038228);
	AddHouseCar(houseid,-2624.064453,2329.549560,8.026854,359.042999);
	houseid = CreateHouse(-2626.429443,2359.585693,8.925094,M(6));
	AddHouseCar(houseid,-2618.738037,2352.073730,8.234479,0.093773);
	AddHouseCar(houseid,-2618.669433,2361.434570,8.464952,359.697174);
	AddHouseCar(houseid,-2619.121582,2370.411376,8.901893,1.813393);
	AddHouseCar(houseid,-2621.637207,2342.935546,8.103265,331.154052);
	houseid = CreateHouse(-2634.537597,2402.684082,11.238020,M(6));
	AddHouseCar(houseid,-2620.119873,2387.657226,10.139542,308.494262);
	AddHouseCar(houseid,-2619.395263,2392.731933,10.671976,308.440765);
	AddHouseCar(houseid,-2618.786621,2398.039062,11.190682,308.338470);
	AddHouseCar(houseid,-2618.354248,2404.165039,11.890844,308.226684);
	AddHouseCar(houseid,-2617.710937,2408.279052,12.376542,308.120666);
	houseid = CreateHouse(-2630.094726,2428.322509,14.340354,M(6));
	AddHouseCar(houseid,-2634.535888,2434.987060,15.033589,251.404846);
	AddHouseCar(houseid,-2632.026367,2442.077392,15.921294,251.165710);
	AddHouseCar(houseid,-2629.578369,2448.922607,17.126178,251.474487);
	AddHouseCar(houseid,-2615.341308,2443.927734,15.421276,190.613265);
	AddHouseCar(houseid,-2619.716308,2425.830810,14.163002,256.167999);
	houseid = CreateHouse(-2598.718261,2356.961425,9.882995,M(6));
	AddHouseCar(houseid,-2589.994628,2343.437744,8.419844,92.018493);
	AddHouseCar(houseid,-2595.800292,2346.752441,8.629262,89.590576);
	AddHouseCar(houseid,-2600.067871,2350.046142,8.756733,90.473342);
	AddHouseCar(houseid,-2600.096923,2353.378906,8.767308,90.478744);
	AddHouseCar(houseid,-2610.648193,2359.292968,8.390298,359.306579);
/*                   END RITCH HOUSES                  */
#endif
#if defined SF_HOUSES
/*                   START SF HOUSES                  */
	houseid = CreateHouse(-2574.521484,1150.708251,55.726562,M(0));
	AddHouseCar(houseid,-2571.949707,1148.598266,55.391555,154.279785);
	AddHouseCar(houseid,-2568.118652,1146.752685,55.391548,154.279876);
	AddHouseCar(houseid,-2564.085449,1145.760986,55.392814,154.279953);
	AddHouseCar(houseid,-2557.324218,1144.576538,55.395580,154.280029);
	houseid = CreateHouse(-2549.415283,1144.338867,55.726562,M(2));
	AddHouseCar(houseid,-2545.699707,1142.227416,55.391193,163.392074);
	AddHouseCar(houseid,-2542.336181,1141.788085,55.390266,163.270263);
	houseid = CreateHouse(-2523.881103,1141.801269,55.726562,M(3));
	AddHouseCar(houseid,-2534.961914,1140.796508,55.382556,169.275680);
	AddHouseCar(houseid,-2531.052246,1140.056396,55.402015,169.274017);
	AddHouseCar(houseid,-2527.620361,1139.575805,55.402191,169.274002);
	houseid = CreateHouse(-2517.073486,1141.833496,55.726562,M(3));
	AddHouseCar(houseid,-2514.254638,1138.748901,55.416271,169.359970);
	AddHouseCar(houseid,-2510.327636,1138.858276,55.388957,170.235107);
	AddHouseCar(houseid,-2506.294189,1139.016235,55.391998,171.632812);
	houseid = CreateHouse(-2493.292480,1141.501831,55.726562,M(2));
	AddHouseCar(houseid,-2489.749267,1138.576416,55.390899,181.144165);
	AddHouseCar(houseid,-2485.712158,1138.657104,55.390991,181.144424);
	houseid = CreateHouse(-2468.526611,1141.597412,55.733268,M(2));
	AddHouseCar(houseid,-2475.353759,1138.811645,55.410724,181.231552);
	AddHouseCar(houseid,-2471.429443,1138.895507,55.420837,181.230682);
	houseid = CreateHouse(-2479.048828,1141.080200,55.726562,M(1));
	AddHouseCar(houseid,-2482.653808,1138.654174,55.392456,181.278488);
	houseid = CreateHouse(-2461.818359,1141.208007,55.726562,M(1));
	AddHouseCar(houseid,-2458.797363,1138.768188,55.393806,178.866409);
	houseid = CreateHouse(-2451.124267,1141.058227,55.733276,M(1));
	AddHouseCar(houseid,-2455.263183,1138.699584,55.412357,178.913024);
	houseid = CreateHouse(-2444.550292,1140.428710,55.726562,M(1));
	AddHouseCar(houseid,-2447.832519,1138.559814,55.395408,178.998764);
	houseid = CreateHouse(-2438.620605,1140.423950,55.726562,M(2));
	AddHouseCar(houseid,-2434.912597,1138.279174,55.412052,178.999649);
	AddHouseCar(houseid,-2430.802734,1137.516357,55.411308,178.999938);
	houseid = CreateHouse(-2424.217285,1138.849731,55.726562,M(1));
	AddHouseCar(houseid,-2427.159179,1136.603393,55.420536,179.084197);
	houseid = CreateHouse(-2413.819091,1137.353759,55.726562,M(2));
	AddHouseCar(houseid,-2421.047851,1135.667480,55.382389,169.133346);
	AddHouseCar(houseid,-2417.321044,1134.952026,55.386661,169.132949);
	houseid = CreateHouse(-2574.521484,1150.708251,55.726562,M(0));
	AddHouseCar(houseid,-2571.949707,1148.598266,55.391555,154.279785);
	AddHouseCar(houseid,-2568.118652,1146.752685,55.391548,154.279876);
	AddHouseCar(houseid,-2564.085449,1145.760986,55.392814,154.279953);
	AddHouseCar(houseid,-2557.324218,1144.576538,55.395580,154.280029);
	houseid = CreateHouse(-2549.415283,1144.338867,55.726562,M(2));
	AddHouseCar(houseid,-2545.699707,1142.227416,55.391193,163.392074);
	AddHouseCar(houseid,-2542.336181,1141.788085,55.390266,163.270263);
	houseid = CreateHouse(-2523.881103,1141.801269,55.726562,M(3));
	AddHouseCar(houseid,-2534.961914,1140.796508,55.382556,169.275680);
	AddHouseCar(houseid,-2531.052246,1140.056396,55.402015,169.274017);
	AddHouseCar(houseid,-2527.620361,1139.575805,55.402191,169.274002);
	houseid = CreateHouse(-2517.073486,1141.833496,55.726562,M(3));
	AddHouseCar(houseid,-2514.254638,1138.748901,55.416271,169.359970);
	AddHouseCar(houseid,-2510.327636,1138.858276,55.388957,170.235107);
	AddHouseCar(houseid,-2506.294189,1139.016235,55.391998,171.632812);
	houseid = CreateHouse(-2493.292480,1141.501831,55.726562,M(2));
	AddHouseCar(houseid,-2489.749267,1138.576416,55.390899,181.144165);
	AddHouseCar(houseid,-2485.712158,1138.657104,55.390991,181.144424);
	houseid = CreateHouse(-2468.526611,1141.597412,55.733268,M(2));
	AddHouseCar(houseid,-2475.353759,1138.811645,55.410724,181.231552);
	AddHouseCar(houseid,-2471.429443,1138.895507,55.420837,181.230682);
	houseid = CreateHouse(-2479.048828,1141.080200,55.726562,M(1));
	AddHouseCar(houseid,-2482.653808,1138.654174,55.392456,181.278488);
	houseid = CreateHouse(-2461.818359,1141.208007,55.726562,M(1));
	AddHouseCar(houseid,-2458.797363,1138.768188,55.393806,178.866409);
	houseid = CreateHouse(-2451.124267,1141.058227,55.733276,M(1));
	AddHouseCar(houseid,-2455.263183,1138.699584,55.412357,178.913024);
	houseid = CreateHouse(-2444.550292,1140.428710,55.726562,M(1));
	AddHouseCar(houseid,-2447.832519,1138.559814,55.395408,178.998764);
	houseid = CreateHouse(-2438.620605,1140.423950,55.726562,M(2));
	AddHouseCar(houseid,-2434.912597,1138.279174,55.412052,178.999649);
	AddHouseCar(houseid,-2430.802734,1137.516357,55.411308,178.999938);
	houseid = CreateHouse(-2424.217285,1138.849731,55.726562,M(1));
	AddHouseCar(houseid,-2427.159179,1136.603393,55.420536,179.084197);
	houseid = CreateHouse(-2413.819091,1137.353759,55.726562,M(2));
	AddHouseCar(houseid,-2421.047851,1135.667480,55.382389,169.133346);
	AddHouseCar(houseid,-2417.321044,1134.952026,55.386661,169.132949);
	houseid = CreateHouse(-2407.183837,1135.003051,55.726562,M(1));
	AddHouseCar(houseid,-2404.482177,1131.987670,55.390735,165.142440);
	houseid = CreateHouse(-2396.859619,1132.636962,55.733276,M(1));
	AddHouseCar(houseid,-2400.966308,1131.056396,55.412609,165.236831);
	houseid = CreateHouse(-2389.777099,1129.828979,55.726562,M(1));
	AddHouseCar(houseid,-2393.944824,1129.206787,55.413696,165.287185);
	houseid = CreateHouse(-2383.841796,1127.551757,55.726562,M(2));
	AddHouseCar(houseid,-2381.303466,1123.975708,55.381233,161.409698);
	AddHouseCar(houseid,-2377.385009,1122.657714,55.401428,161.409072);
	houseid = CreateHouse(-2369.783447,1121.506225,55.733276,M(1));
	AddHouseCar(houseid,-2373.713867,1121.424560,55.402919,161.494827);
	houseid = CreateHouse(-2359.068115,1117.704223,55.726562,M(2));
	AddHouseCar(houseid,-2366.822021,1117.719238,55.401016,161.495254);
	AddHouseCar(houseid,-2362.833984,1116.384887,55.400566,161.495300);
	houseid = CreateHouse(-2401.336425,885.942993,45.445312,M(2));
	AddHouseCar(houseid,-2399.898925,880.491333,45.109733,269.592590);
	AddHouseCar(houseid,-2393.895996,889.912475,45.022373,4.429633);
	houseid = CreateHouse(-2412.843505,920.834350,45.497325,M(3));
	AddHouseCar(houseid,-2406.462402,918.748535,45.171401,178.539169);
	AddHouseCar(houseid,-2414.508789,912.725646,45.183319,87.466682);
	AddHouseCar(houseid,-2398.991455,914.588989,45.067142,116.630668);
	houseid = CreateHouse(-2472.020263,920.678283,63.159530,M(2));
	AddHouseCar(houseid,-2464.437011,918.339111,62.628318,179.740493);
	AddHouseCar(houseid,-2474.130615,912.994506,62.824863,93.890991);
	houseid = CreateHouse(-2471.640136,895.651672,63.164806,M(2));
	AddHouseCar(houseid,-2464.470214,898.717163,62.621791,2.770771);
	AddHouseCar(houseid,-2472.585449,903.618225,62.771228,89.159927);
	houseid = CreateHouse(-2502.969482,920.861511,65.187004,M(1));
	AddHouseCar(houseid,-2497.256347,918.946838,64.607284,180.909255);
	houseid = CreateHouse(-2502.770996,896.249206,65.152961,M(1));
	AddHouseCar(houseid,-2496.812255,897.882751,64.585510,1.395620);
	houseid = CreateHouse(-2511.367187,1053.989501,65.049301,M(1));
	AddHouseCar(houseid,-2513.187011,1056.596679,64.230720,125.061668);
	houseid = CreateHouse(-2511.812744,1045.549072,65.507812,M(1));
	AddHouseCar(houseid,-2513.980957,1041.295043,68.965629,269.560607);
	houseid = CreateHouse(-2511.669921,1028.747314,73.668952,M(1));
	AddHouseCar(houseid,-2514.624511,1033.483642,72.181846,265.029876);
	houseid = CreateHouse(-2511.956542,1021.025939,77.159866,M(1));
	AddHouseCar(houseid,-2514.422363,1017.143798,77.206802,262.783508);
	houseid = CreateHouse(-2512.246093,1008.822204,78.343750,M(1));
	AddHouseCar(houseid,-2514.398925,1011.975769,78.004562,92.554115);
	houseid = CreateHouse(-2512.257324,1000.540588,78.343750,M(1));
	AddHouseCar(houseid,-2514.057373,1004.335632,78.019683,92.602149);
	houseid = CreateHouse(-2511.912109,992.531433,78.333801,M(1));
	AddHouseCar(houseid,-2514.182373,996.131896,77.978584,92.584495);
	houseid = CreateHouse(-2512.424560,987.875061,78.343750,M(1));
	AddHouseCar(houseid,-2514.487548,983.927368,78.003776,272.677612);
	houseid = CreateHouse(-2511.982421,975.713500,77.167884,M(1));
	AddHouseCar(houseid,-2514.491455,979.691284,77.362144,91.103630);
	houseid = CreateHouse(-2511.909667,967.635864,73.551391,M(1));
	AddHouseCar(houseid,-2513.409423,955.663330,69.204895,277.248718);
	houseid = CreateHouse(-2512.156982,951.496337,65.945587,M(1));
	AddHouseCar(houseid,-2513.304931,947.063110,65.715568,254.702499);
	houseid = CreateHouse(-2511.280029,942.999084,65.289062,M(1));
	AddHouseCar(houseid,-2513.282958,939.139404,64.895912,270.263244);
	houseid = CreateHouse(-2536.016845,929.566833,65.045562,M(1));
	AddHouseCar(houseid,-2533.751220,934.857299,64.730476,269.896789);
	houseid = CreateHouse(-2542.126220,942.749084,64.000000,M(1));
	AddHouseCar(houseid,-2540.043701,938.932617,63.947792,270.013153);
	houseid = CreateHouse(-2541.759765,951.164489,65.505256,M(1));
	AddHouseCar(houseid,-2539.959472,946.936401,65.481971,269.966308);
	houseid = CreateHouse(-2541.747070,967.594726,73.551651,M(2));
	AddHouseCar(houseid,-2539.363037,955.292236,69.139663,85.894973);
	AddHouseCar(houseid,-2539.346923,963.476745,72.594245,86.078834);
	houseid = CreateHouse(-2541.356445,988.076965,78.289062,M(3));
	AddHouseCar(houseid,-2539.297119,983.856079,77.897621,270.034332);
	AddHouseCar(houseid,-2539.480468,979.437622,77.317214,269.131103);
	AddHouseCar(houseid,-2539.435058,975.427978,76.653518,271.296173);
	houseid = CreateHouse(-2564.083496,992.875000,78.273437,M(3));
	AddHouseCar(houseid,-2553.451904,995.718811,77.968330,180.467391);
	AddHouseCar(houseid,-2557.070800,995.297607,77.973373,180.465850);
	AddHouseCar(houseid,-2560.792968,995.267272,77.973304,180.466476);
	houseid = CreateHouse(-2573.458251,992.567321,78.273437,M(3));
	AddHouseCar(houseid,-2576.652099,995.139770,77.942131,180.550033);
	AddHouseCar(houseid,-2580.560791,995.102294,77.942123,180.550201);
	AddHouseCar(houseid,-2583.663574,995.725280,77.946044,180.550735);
	houseid = CreateHouse(-2655.353515,986.384948,64.991287,M(5));
	AddHouseCar(houseid,-2676.225097,984.876037,64.623741,359.520690);
	AddHouseCar(houseid,-2671.748535,985.084960,64.636604,359.698028);
	AddHouseCar(houseid,-2660.300781,990.188903,64.661155,359.678833);
	AddHouseCar(houseid,-2663.459472,990.223510,64.555679,359.651214);
	AddHouseCar(houseid,-2667.283203,990.263793,64.493644,359.618103);
	houseid = CreateHouse(-2710.493652,968.517333,54.460937,M(4));
	AddHouseCar(houseid,-2724.365234,976.959289,54.114681,5.650283);
	AddHouseCar(houseid,-2721.074707,977.284667,54.119167,5.649546);
	AddHouseCar(houseid,-2717.876953,977.601074,54.142398,5.651285);
	AddHouseCar(houseid,-2731.558349,980.647277,53.989669,12.402647);
	houseid = CreateHouse(-2640.985595,935.482055,71.953125,M(2));
	AddHouseCar(houseid,-2629.631103,927.758666,70.679840,220.468215);
	AddHouseCar(houseid,-2635.271972,926.638916,70.603660,219.784057);
	houseid = CreateHouse(-2675.860595,909.902404,79.683471,M(2));
	AddHouseCar(houseid,-2662.881103,913.370666,79.334892,178.689483);
	AddHouseCar(houseid,-2666.271484,912.158081,79.328849,180.997100);
	houseid = CreateHouse(-2659.932373,877.269653,79.773796,M(3));
	AddHouseCar(houseid,-2653.862304,879.206420,79.435302,85.020492);
	AddHouseCar(houseid,-2653.800048,882.274902,79.434982,85.020515);
	AddHouseCar(houseid,-2666.483642,879.262145,79.437072,271.058227);
	AddHouseCar(houseid,-2681.959228,867.588623,76.068397,6.474543);
	AddHouseCar(houseid,-2678.268554,868.007446,76.084411,6.541469);
	houseid = CreateHouse(-2706.705078,865.529907,70.703125,M(3));
	AddHouseCar(houseid,-2701.232177,871.468139,70.622451,90.049888);
	AddHouseCar(houseid,-2711.988281,867.429626,70.366828,78.099761);
	AddHouseCar(houseid,-2693.897705,860.552185,71.222473,16.273832);
	houseid = CreateHouse(-2721.607421,923.648864,67.593750,M(2));
	AddHouseCar(houseid,-2723.156494,916.981750,67.246345,92.723930);
	AddHouseCar(houseid,-2722.093261,934.027221,67.245368,357.982879);
	houseid = CreateHouse(-2904.060546,1178.925781,13.664062,M(1));
	AddHouseCar(houseid,-2900.989990,1175.695556,12.806153,269.804748);
	houseid = CreateHouse(-2904.272460,1172.040527,13.664062,M(1));
	AddHouseCar(houseid,-2900.979980,1168.156250,13.035434,269.984893);
	houseid = CreateHouse(-2904.752197,1165.024658,13.664062,M(1));
	AddHouseCar(houseid,-2900.978027,1161.995361,13.187301,270.059204);
	houseid = CreateHouse(-2904.884033,1154.929931,13.664062,M(1));
	AddHouseCar(houseid,-2900.975830,1151.904907,13.485323,270.080688);
	houseid = CreateHouse(-2904.339599,1111.621093,27.070312,M(3));
	AddHouseCar(houseid,-2901.011230,1114.978881,26.392335,273.510467);
	AddHouseCar(houseid,-2901.237548,1118.638549,26.339399,273.451904);
	AddHouseCar(houseid,-2901.424316,1122.104858,26.306280,273.567169);
	houseid = CreateHouse(-2903.873779,1101.192626,27.070312,M(2));
	AddHouseCar(houseid,-2901.737060,1104.823364,26.715673,273.099853);
	AddHouseCar(houseid,-2901.416503,1097.849731,26.925926,273.784851);
	houseid = CreateHouse(-2899.666748,1080.916137,32.132812,M(1));
	AddHouseCar(houseid,-2897.545654,1077.775390,31.555847,272.034271);
	houseid = CreateHouse(-2900.230224,1073.847656,32.132812,M(1));
	AddHouseCar(houseid,-2897.272949,1070.232299,31.631376,272.149841);
	houseid = CreateHouse(-2900.172851,1067.016235,32.139984,M(1));
	AddHouseCar(houseid,-2897.073486,1063.940795,31.738008,272.427429);
	houseid = CreateHouse(-2898.967773,1056.518676,32.132812,M(1));
	AddHouseCar(houseid,-2896.780761,1053.596435,32.025478,272.752899);
	houseid = CreateHouse(-2898.269042,1027.158691,36.835315,M(3));
	AddHouseCar(houseid,-2896.903808,1031.213500,36.100257,290.507202);
	AddHouseCar(houseid,-2898.330322,1035.063476,36.019927,290.458007);
	AddHouseCar(houseid,-2899.434814,1038.048583,36.016235,290.475799);
	houseid = CreateHouse(-2894.144042,1017.324707,36.828125,M(2));
	AddHouseCar(houseid,-2892.996826,1020.898864,36.331146,292.221923);
	AddHouseCar(houseid,-2890.748779,1015.286926,36.516223,292.427337);
	houseid = CreateHouse(-2887.975585,1001.667968,40.718750,M(1));
	AddHouseCar(houseid,-2882.397949,1001.322448,39.426651,298.991149);
	houseid = CreateHouse(-2883.635986,995.995422,40.718750,M(1));
	AddHouseCar(houseid,-2878.670654,995.026733,39.898685,298.900573);
	houseid = CreateHouse(-2880.429443,990.035888,40.718750,M(1));
	AddHouseCar(houseid,-2875.533691,989.417541,40.248600,299.076965);
	houseid = CreateHouse(-2875.679199,981.208740,40.725959,M(1));
	AddHouseCar(houseid,-2870.663818,980.629455,40.668071,298.999664);
	houseid = CreateHouse(-2859.523925,964.034606,44.054687,M(1));
	AddHouseCar(houseid,-2859.206787,968.576904,43.627357,298.781799);
	houseid = CreateHouse(-2856.802734,957.386169,44.054687,M(1));
	AddHouseCar(houseid,-2855.408447,961.659851,43.683380,298.838317);
	houseid = CreateHouse(-2853.260742,947.589782,44.054687,M(2));
	AddHouseCar(houseid,-2850.577880,952.875976,43.717407,298.889007);
	AddHouseCar(houseid,-2848.018798,946.460266,43.721897,298.895965);
	houseid = CreateHouse(-2844.209472,928.569030,44.054687,M(1));
	AddHouseCar(houseid,-2839.599365,925.590881,43.727748,274.216278);
	houseid = CreateHouse(-2844.668701,921.044677,44.054687,M(1));
	AddHouseCar(houseid,-2839.049560,918.141296,43.740219,274.279876);
	houseid = CreateHouse(-2843.721923,914.744995,44.054687,M(1));
	AddHouseCar(houseid,-2838.524169,911.156799,43.717666,274.367065);
	houseid = CreateHouse(-2842.244140,904.686462,44.054687,M(1));
	AddHouseCar(houseid,-2837.796142,901.640930,43.719154,274.453247);
	houseid = CreateHouse(-2839.229248,884.342956,44.054687,M(1));
	AddHouseCar(houseid,-2836.280761,888.112731,43.712787,268.674926);
	houseid = CreateHouse(-2838.566162,877.378662,44.061824,M(1));
	AddHouseCar(houseid,-2836.447753,880.888977,43.711727,268.472869);
	houseid = CreateHouse(-2839.168212,866.960632,44.054687,M(2));
	AddHouseCar(houseid,-2836.729248,870.225952,43.716205,268.286865);
	AddHouseCar(houseid,-2836.927490,863.616149,43.720550,268.287506);
	houseid = CreateHouse(-2855.400390,840.965881,40.260509,M(1));
	AddHouseCar(houseid,-2852.081298,835.695556,40.681304,239.538757);
	houseid = CreateHouse(-2858.945556,835.023620,39.989109,M(1));
	AddHouseCar(houseid,-2855.858154,829.098571,40.089584,239.563323);
	houseid = CreateHouse(-2862.554199,829.568359,39.617870,M(1));
	AddHouseCar(houseid,-2859.131591,823.360595,39.449012,239.692077);
	houseid = CreateHouse(-2868.373046,820.691650,39.396903,M(1));
	AddHouseCar(houseid,-2866.399169,816.106140,38.743232,241.418899);
	houseid = CreateHouse(-2880.248291,790.478027,35.432224,M(3));
	AddHouseCar(houseid,-2875.827392,800.670288,35.716022,263.470031);
	AddHouseCar(houseid,-2876.209960,797.006286,35.556552,263.546447);
	AddHouseCar(houseid,-2876.559570,793.692687,35.359600,263.536865);
	houseid = CreateHouse(-2880.542480,779.856628,35.251304,M(2));
	AddHouseCar(houseid,-2877.226318,783.168395,34.511157,265.697875);
	AddHouseCar(houseid,-2877.453613,776.167785,33.858676,266.319946);
	houseid = CreateHouse(-2883.692871,750.847351,29.280162,M(1));
	AddHouseCar(houseid,-2881.481689,748.051635,29.388143,276.551116);
	houseid = CreateHouse(-2883.049316,743.828186,29.344673,M(1));
	AddHouseCar(houseid,-2880.569335,740.501770,29.285818,276.620178);
	houseid = CreateHouse(-2883.140869,736.952697,29.261716,M(1));
	AddHouseCar(houseid,-2879.799804,734.379150,29.159595,276.707824);
	houseid = CreateHouse(-2881.944335,726.923217,29.215305,M(1));
	AddHouseCar(houseid,-2878.519531,723.969604,28.863077,276.838867);
	houseid = CreateHouse(-2868.042968,691.395507,23.483318,M(3));
	AddHouseCar(houseid,-2867.093994,696.064086,23.254522,114.876113);
	AddHouseCar(houseid,-2868.628906,699.357727,23.340755,114.906028);
	AddHouseCar(houseid,-2870.146240,702.599182,23.416408,114.900154);
	houseid = CreateHouse(-2864.171630,681.862792,23.469953,M(2));
	AddHouseCar(houseid,-2862.449462,686.179809,23.041500,114.919624);
	AddHouseCar(houseid,-2859.621826,680.137634,22.879367,114.869209);
    	houseid = CreateHouse(1575.703247,2843.868652,10.820312,M(5));
			AddHouseCar(houseid,1580.607177,2840.795166,10.547389,180.212158);
	houseid = CreateHouse(1601.867797,2845.279785,10.820312,M(6));
			AddHouseCar(houseid,1597.026000,2834.948486,10.548228,182.560791);
			AddHouseCar(houseid,1591.798095,2835.352050,10.547414,179.451049);
	houseid = CreateHouse(1622.707031,2845.019531,10.820312,M(5));
			AddHouseCar(houseid,1616.567504,2834.140869,10.564188,131.713607);
	houseid = CreateHouse(1632.890747,2843.329589,10.820312,M(5));
			AddHouseCar(houseid,1639.645996,2833.821044,10.548221,141.787063);
	houseid = CreateHouse(1664.802734,2845.393798,10.820312,M(5));
			AddHouseCar(houseid,1658.669189,2834.357177,10.548213,138.778823);
	houseid = CreateHouse(1673.027832,2801.389648,10.820312,M(5));
			AddHouseCar(houseid,1667.199218,2810.168701,10.548223,288.768585);
	houseid = CreateHouse(1655.099121,2801.500000,10.820312,M(5));
			AddHouseCar(houseid,1649.335815,2809.953369,10.548223,308.029785);
	houseid = CreateHouse(1638.015136,2802.374755,10.820312,M(7));
			AddHouseCar(houseid,1626.478149,2808.587402,10.554459,1.474588);
			AddHouseCar(houseid,1630.189697,2808.682861,10.554518,1.474787);
			AddHouseCar(houseid,1634.772460,2808.800048,10.554592,1.474720);
	houseid = CreateHouse(1618.382324,2801.749267,10.820312,M(5));
			AddHouseCar(houseid,1611.830688,2810.661132,10.545351,316.667205);
	houseid = CreateHouse(1588.397338,2797.878173,10.826543,M(5));
			AddHouseCar(houseid,1595.581542,2808.666259,10.548216,323.072174);
	houseid = CreateHouse(1703.780029,2689.158203,10.826543,M(5));
			AddHouseCar(houseid,1710.854370,2699.896728,10.548887,47.291362);
	houseid = CreateHouse(1735.701049,2691.111083,10.820312,M(5));
			AddHouseCar(houseid,1727.275878,2701.253662,10.548979,269.497314);
	houseid = CreateHouse(1921.764526,2664.561767,10.820312,M(5));
			AddHouseCar(houseid,1928.391967,2656.436523,10.548228,119.912727);
	houseid = CreateHouse(1950.673095,2664.665527,11.298933,M(5));
			AddHouseCar(houseid,1952.563720,2659.931396,10.544081,0.939723);
	houseid = CreateHouse(1969.653320,2663.562500,10.820312,M(5));
			AddHouseCar(houseid,1976.326660,2658.069824,10.555461,143.809295);
	houseid = CreateHouse(1989.015625,2664.738769,10.820312,M(5));
			AddHouseCar(houseid,1995.770263,2656.333984,10.548921,134.728347);
	houseid = CreateHouse(2018.067260,2664.664062,11.298933,M(5));
			AddHouseCar(houseid,2020.438354,2659.692871,10.548889,357.667694);
	houseid = CreateHouse(2037.163940,2663.917236,10.820312,M(5));
			AddHouseCar(houseid,2045.338256,2657.270507,10.555269,134.144042);
	houseid = CreateHouse(2056.547119,2664.823242,10.820312,M(5));
			AddHouseCar(houseid,2063.650146,2655.648437,10.549712,136.136840);
	houseid = CreateHouse(2066.072021,2721.545898,10.820312,M(5));
			AddHouseCar(houseid,2059.716552,2729.891113,10.549151,294.763031);
	houseid = CreateHouse(2037.210937,2721.763183,11.298933,M(5));
			AddHouseCar(houseid,2035.076782,2726.900878,10.549043,178.022842);
	houseid = CreateHouse(2018.293823,2722.340332,10.820312,M(5));
			AddHouseCar(houseid,2010.734252,2729.174560,10.556103,142.685119);
	houseid = CreateHouse(1998.730712,2722.134521,10.820312,M(5));
			AddHouseCar(houseid,1992.192382,2730.602783,10.548322,121.033088);
	houseid = CreateHouse(1969.896728,2721.795898,11.298933,M(5));
			AddHouseCar(houseid,1967.838867,2726.056884,10.562458,179.855972);
	houseid = CreateHouse(1950.850708,2722.990478,10.820312,M(5));
			AddHouseCar(houseid,1944.655761,2729.364501,10.554410,148.289993);
	houseid = CreateHouse(1931.332031,2721.446289,10.820312,M(5));
			AddHouseCar(houseid,1924.498413,2730.970703,10.549032,300.335662);
	houseid = CreateHouse(1929.485473,2774.309082,10.820312,M(5));
			AddHouseCar(houseid,1919.706665,2762.621826,10.555260,36.672660);
	houseid = CreateHouse(1967.193969,2766.546630,10.826543,M(5));
			AddHouseCar(houseid,1960.444458,2755.129150,10.548230,227.618392);
	houseid = CreateHouse(1992.774169,2764.347167,10.820312,M(5));
			AddHouseCar(houseid,1997.716430,2761.312988,10.544722,179.100814);
	houseid = CreateHouse(2018.489624,2766.250976,10.826543,M(5));
			AddHouseCar(houseid,2011.317138,2756.537109,10.541407,137.627410);
	houseid = CreateHouse(2039.651123,2765.578125,10.820312,M(5));
			AddHouseCar(houseid,2031.880859,2755.064208,10.547773,137.351379);
	houseid = CreateHouse(2049.206542,2764.202880,10.820312,M(5));
			AddHouseCar(houseid,2054.614501,2754.430908,10.548892,118.545776);
	houseid = CreateHouse(-2351.873535,1226.527587,33.070213,M(5));
			AddHouseCar(houseid,-2353.891601,1232.189086,31.862110,86.964485);
	houseid = CreateHouse(-2351.708251,1244.476318,29.697811,M(5));
			AddHouseCar(houseid,-2353.017578,1250.780517,28.464294,86.342468);
	houseid = CreateHouse(-2352.145996,1263.034667,26.331293,M(5));
			AddHouseCar(houseid,-2354.096679,1268.913208,25.015617,90.482360);
	houseid = CreateHouse(-2351.682128,1280.949584,22.940965,M(5));
			AddHouseCar(houseid,-2354.199951,1286.661987,21.696445,90.121665);
	houseid = CreateHouse(-2351.717285,1299.647705,19.568719,M(5));
			AddHouseCar(houseid,-2354.227783,1305.037231,18.253213,89.791374);
	houseid = CreateHouse(-2351.524169,1317.978515,16.208190,M(5));
			AddHouseCar(houseid,-2354.070556,1323.626464,14.773368,89.238601);
	houseid = CreateHouse(-2351.643554,1336.361694,12.760780,M(5));
			AddHouseCar(houseid,-2353.984375,1341.685058,11.345723,88.313049);
	houseid = CreateHouse(-2382.636962,1336.638183,12.781478,M(5));
			AddHouseCar(houseid,-2380.018554,1342.131958,11.298821,273.303436);
	houseid = CreateHouse(-2382.526123,1317.702148,16.212863,M(5));
			AddHouseCar(houseid,-2380.154052,1323.760375,14.773091,274.877746);
	houseid = CreateHouse(-2382.560302,1299.649047,19.585056,M(5));
			AddHouseCar(houseid,-2380.084228,1305.669189,18.163349,276.338745);
	houseid = CreateHouse(-2382.434814,1281.466308,22.958969,M(5));
			AddHouseCar(houseid,-2380.431396,1287.453002,21.607959,274.166137);
	houseid = CreateHouse(-2382.181640,1262.977539,26.342193,M(5));
			AddHouseCar(houseid,-2380.071289,1269.070922,24.988138,275.453186);
	houseid = CreateHouse(-2382.618652,1244.766845,29.701574,M(5));
			AddHouseCar(houseid,-2380.198974,1250.371948,28.436201,273.094116);
	houseid = CreateHouse(-2382.602539,1226.268554,33.069152,M(5));
			AddHouseCar(houseid,-2379.710205,1232.303222,31.854188,277.203735);
	houseid = CreateHouse(-2433.715087,1244.416503,33.617187,M(5));
			AddHouseCar(houseid,-2436.648925,1247.859863,33.145065,89.039962);
			AddHouseCar(houseid,-2436.350585,1257.504638,30.297420,266.091522);
	houseid = CreateHouse(-2433.074218,1264.396606,28.257812,M(5));
			AddHouseCar(houseid,-2435.995117,1267.236572,27.960973,85.328781);
	houseid = CreateHouse(-2434.565917,1274.213378,25.529163,M(5));
			AddHouseCar(houseid,-2436.589843,1277.912719,24.946886,90.072334);
	houseid = CreateHouse(-2433.752197,1281.550415,23.742187,M(5));
			AddHouseCar(houseid,-2436.007080,1284.867797,23.254190,91.680564);
			AddHouseCar(houseid,-2436.282714,1294.863769,20.274021,267.503662);
	houseid = CreateHouse(-2433.049804,1301.135131,18.382812,M(5));
			AddHouseCar(houseid,-2436.160888,1304.299072,17.964590,85.557899);
	houseid = CreateHouse(-2434.282470,1311.019897,15.500025,M(5));
			AddHouseCar(houseid,-2436.729736,1314.429077,15.055542,93.717536);
	houseid = CreateHouse(-2434.074462,1318.489257,13.867187,M(5));
			AddHouseCar(houseid,-2435.986572,1322.111572,13.206900,90.791038);
			AddHouseCar(houseid,-2436.300048,1331.594848,10.287212,270.851776);
	houseid = CreateHouse(-2433.465820,1338.390991,8.507812,M(5));
			AddHouseCar(houseid,-2436.197998,1341.102661,7.947793,89.521186);
	houseid = CreateHouse(-2476.986816,1338.080932,8.503883,M(5));
			AddHouseCar(houseid,-2474.458984,1341.484130,7.827658,91.490966);
			AddHouseCar(houseid,-2474.613525,1331.797485,10.228425,279.338348);
	houseid = CreateHouse(-2477.027343,1318.407104,13.851562,M(5));
			AddHouseCar(houseid,-2474.660888,1322.115600,13.116450,94.722854);
	houseid = CreateHouse(-2476.617919,1311.110595,15.511125,M(5));
			AddHouseCar(houseid,-2474.379882,1315.054931,14.904807,96.901603);
	houseid = CreateHouse(-2477.904785,1301.036987,18.375000,M(5));
			AddHouseCar(houseid,-2475.092773,1304.773437,17.925184,91.766357);
			AddHouseCar(houseid,-2474.665039,1294.574584,20.294818,275.456298);
	houseid = CreateHouse(-2477.221435,1281.371093,23.726562,M(5));
			AddHouseCar(houseid,-2474.573730,1285.059204,23.116559,95.685943);
	houseid = CreateHouse(-2476.669189,1274.245361,25.416082,M(5));
			AddHouseCar(houseid,-2474.379882,1277.866821,24.951002,92.068679);
	houseid = CreateHouse(-2477.928466,1264.122314,28.250000,M(5));
			AddHouseCar(houseid,-2475.327880,1267.457519,27.911436,99.790550);
			AddHouseCar(houseid,-2474.833007,1257.991210,30.197269,282.536376);
	houseid = CreateHouse(-2477.109619,1244.669799,33.609375,M(5));
			AddHouseCar(houseid,-2474.674560,1247.936889,33.158348,90.873962);
	houseid = CreateHouse(1575.703247,2843.868652,10.820312,M(5));
			AddHouseCar(houseid,1580.607177,2840.795166,10.547389,180.212158);
	houseid = CreateHouse(1601.867797,2845.279785,10.820312,M(6));
			AddHouseCar(houseid,1597.026000,2834.948486,10.548228,182.560791);
			AddHouseCar(houseid,1591.798095,2835.352050,10.547414,179.451049);
	houseid = CreateHouse(1622.707031,2845.019531,10.820312,M(5));
			AddHouseCar(houseid,1616.567504,2834.140869,10.564188,131.713607);
	houseid = CreateHouse(1632.890747,2843.329589,10.820312,M(5));
			AddHouseCar(houseid,1639.645996,2833.821044,10.548221,141.787063);
	houseid = CreateHouse(1664.802734,2845.393798,10.820312,M(5));
			AddHouseCar(houseid,1658.669189,2834.357177,10.548213,138.778823);
	houseid = CreateHouse(1673.027832,2801.389648,10.820312,M(5));
			AddHouseCar(houseid,1667.199218,2810.168701,10.548223,288.768585);
	houseid = CreateHouse(1655.099121,2801.500000,10.820312,M(5));
			AddHouseCar(houseid,1649.335815,2809.953369,10.548223,308.029785);
	houseid = CreateHouse(1638.015136,2802.374755,10.820312,M(7));
			AddHouseCar(houseid,1626.478149,2808.587402,10.554459,1.474588);
			AddHouseCar(houseid,1630.189697,2808.682861,10.554518,1.474787);
			AddHouseCar(houseid,1634.772460,2808.800048,10.554592,1.474720);
	houseid = CreateHouse(1618.382324,2801.749267,10.820312,M(5));
			AddHouseCar(houseid,1611.830688,2810.661132,10.545351,316.667205);
	houseid = CreateHouse(1588.397338,2797.878173,10.826543,M(5));
			AddHouseCar(houseid,1595.581542,2808.666259,10.548216,323.072174);
	houseid = CreateHouse(1703.780029,2689.158203,10.826543,M(5));
			AddHouseCar(houseid,1710.854370,2699.896728,10.548887,47.291362);
	houseid = CreateHouse(1735.701049,2691.111083,10.820312,M(5));
			AddHouseCar(houseid,1727.275878,2701.253662,10.548979,269.497314);
	houseid = CreateHouse(1921.764526,2664.561767,10.820312,M(5));
			AddHouseCar(houseid,1928.391967,2656.436523,10.548228,119.912727);
	houseid = CreateHouse(1950.673095,2664.665527,11.298933,M(5));
			AddHouseCar(houseid,1952.563720,2659.931396,10.544081,0.939723);
	houseid = CreateHouse(1969.653320,2663.562500,10.820312,M(5));
			AddHouseCar(houseid,1976.326660,2658.069824,10.555461,143.809295);
	houseid = CreateHouse(1989.015625,2664.738769,10.820312,M(5));
			AddHouseCar(houseid,1995.770263,2656.333984,10.548921,134.728347);
	houseid = CreateHouse(2018.067260,2664.664062,11.298933,M(5));
			AddHouseCar(houseid,2020.438354,2659.692871,10.548889,357.667694);
	houseid = CreateHouse(2037.163940,2663.917236,10.820312,M(5));
			AddHouseCar(houseid,2045.338256,2657.270507,10.555269,134.144042);
	houseid = CreateHouse(2056.547119,2664.823242,10.820312,M(5));
			AddHouseCar(houseid,2063.650146,2655.648437,10.549712,136.136840);
	houseid = CreateHouse(2066.072021,2721.545898,10.820312,M(5));
			AddHouseCar(houseid,2059.716552,2729.891113,10.549151,294.763031);
	houseid = CreateHouse(2037.210937,2721.763183,11.298933,M(5));
			AddHouseCar(houseid,2035.076782,2726.900878,10.549043,178.022842);
	houseid = CreateHouse(2018.293823,2722.340332,10.820312,M(5));
			AddHouseCar(houseid,2010.734252,2729.174560,10.556103,142.685119);
	houseid = CreateHouse(1998.730712,2722.134521,10.820312,M(5));
			AddHouseCar(houseid,1992.192382,2730.602783,10.548322,121.033088);
	houseid = CreateHouse(1969.896728,2721.795898,11.298933,M(5));
			AddHouseCar(houseid,1967.838867,2726.056884,10.562458,179.855972);
	houseid = CreateHouse(1950.850708,2722.990478,10.820312,M(5));
			AddHouseCar(houseid,1944.655761,2729.364501,10.554410,148.289993);
	houseid = CreateHouse(1931.332031,2721.446289,10.820312,M(5));
			AddHouseCar(houseid,1924.498413,2730.970703,10.549032,300.335662);
	houseid = CreateHouse(1929.485473,2774.309082,10.820312,M(5));
			AddHouseCar(houseid,1919.706665,2762.621826,10.555260,36.672660);
	houseid = CreateHouse(1967.193969,2766.546630,10.826543,M(5));
			AddHouseCar(houseid,1960.444458,2755.129150,10.548230,227.618392);
	houseid = CreateHouse(1992.774169,2764.347167,10.820312,M(5));
			AddHouseCar(houseid,1997.716430,2761.312988,10.544722,179.100814);
	houseid = CreateHouse(2018.489624,2766.250976,10.826543,M(5));
			AddHouseCar(houseid,2011.317138,2756.537109,10.541407,137.627410);
	houseid = CreateHouse(2039.651123,2765.578125,10.820312,M(5));
			AddHouseCar(houseid,2031.880859,2755.064208,10.547773,137.351379);
	houseid = CreateHouse(2049.206542,2764.202880,10.820312,M(5));
			AddHouseCar(houseid,2054.614501,2754.430908,10.548892,118.545776);
	houseid = CreateHouse(-2351.873535,1226.527587,33.070213,M(5));
			AddHouseCar(houseid,-2353.891601,1232.189086,31.862110,86.964485);
	houseid = CreateHouse(-2351.708251,1244.476318,29.697811,M(5));
			AddHouseCar(houseid,-2353.017578,1250.780517,28.464294,86.342468);
	houseid = CreateHouse(-2352.145996,1263.034667,26.331293,M(5));
			AddHouseCar(houseid,-2354.096679,1268.913208,25.015617,90.482360);
	houseid = CreateHouse(-2351.682128,1280.949584,22.940965,M(5));
			AddHouseCar(houseid,-2354.199951,1286.661987,21.696445,90.121665);
	houseid = CreateHouse(-2351.717285,1299.647705,19.568719,M(5));
			AddHouseCar(houseid,-2354.227783,1305.037231,18.253213,89.791374);
	houseid = CreateHouse(-2351.524169,1317.978515,16.208190,M(5));
			AddHouseCar(houseid,-2354.070556,1323.626464,14.773368,89.238601);
	houseid = CreateHouse(-2351.643554,1336.361694,12.760780,M(5));
			AddHouseCar(houseid,-2353.984375,1341.685058,11.345723,88.313049);
	houseid = CreateHouse(-2382.636962,1336.638183,12.781478,M(5));
			AddHouseCar(houseid,-2380.018554,1342.131958,11.298821,273.303436);
	houseid = CreateHouse(-2382.526123,1317.702148,16.212863,M(5));
			AddHouseCar(houseid,-2380.154052,1323.760375,14.773091,274.877746);
	houseid = CreateHouse(-2382.560302,1299.649047,19.585056,M(5));
			AddHouseCar(houseid,-2380.084228,1305.669189,18.163349,276.338745);
	houseid = CreateHouse(-2382.434814,1281.466308,22.958969,M(5));
			AddHouseCar(houseid,-2380.431396,1287.453002,21.607959,274.166137);
	houseid = CreateHouse(-2382.181640,1262.977539,26.342193,M(5));
			AddHouseCar(houseid,-2380.071289,1269.070922,24.988138,275.453186);
	houseid = CreateHouse(-2382.618652,1244.766845,29.701574,M(5));
			AddHouseCar(houseid,-2380.198974,1250.371948,28.436201,273.094116);
	houseid = CreateHouse(-2382.602539,1226.268554,33.069152,M(5));
			AddHouseCar(houseid,-2379.710205,1232.303222,31.854188,277.203735);
	houseid = CreateHouse(-2433.715087,1244.416503,33.617187,M(5));
			AddHouseCar(houseid,-2436.648925,1247.859863,33.145065,89.039962);
			AddHouseCar(houseid,-2436.350585,1257.504638,30.297420,266.091522);
	houseid = CreateHouse(-2433.074218,1264.396606,28.257812,M(5));
			AddHouseCar(houseid,-2435.995117,1267.236572,27.960973,85.328781);
	houseid = CreateHouse(-2434.565917,1274.213378,25.529163,M(5));
			AddHouseCar(houseid,-2436.589843,1277.912719,24.946886,90.072334);
	houseid = CreateHouse(-2433.752197,1281.550415,23.742187,M(5));
			AddHouseCar(houseid,-2436.007080,1284.867797,23.254190,91.680564);
			AddHouseCar(houseid,-2436.282714,1294.863769,20.274021,267.503662);
	houseid = CreateHouse(-2433.049804,1301.135131,18.382812,M(5));
			AddHouseCar(houseid,-2436.160888,1304.299072,17.964590,85.557899);
	houseid = CreateHouse(-2434.282470,1311.019897,15.500025,M(5));
			AddHouseCar(houseid,-2436.729736,1314.429077,15.055542,93.717536);
	houseid = CreateHouse(-2434.074462,1318.489257,13.867187,M(5));
			AddHouseCar(houseid,-2435.986572,1322.111572,13.206900,90.791038);
			AddHouseCar(houseid,-2436.300048,1331.594848,10.287212,270.851776);
	houseid = CreateHouse(-2433.465820,1338.390991,8.507812,M(5));
			AddHouseCar(houseid,-2436.197998,1341.102661,7.947793,89.521186);
	houseid = CreateHouse(-2476.986816,1338.080932,8.503883,M(5));
			AddHouseCar(houseid,-2474.458984,1341.484130,7.827658,91.490966);
			AddHouseCar(houseid,-2474.613525,1331.797485,10.228425,279.338348);
	houseid = CreateHouse(-2477.027343,1318.407104,13.851562,M(5));
			AddHouseCar(houseid,-2474.660888,1322.115600,13.116450,94.722854);
	houseid = CreateHouse(-2476.617919,1311.110595,15.511125,M(5));
			AddHouseCar(houseid,-2474.379882,1315.054931,14.904807,96.901603);
	houseid = CreateHouse(-2477.904785,1301.036987,18.375000,M(5));
			AddHouseCar(houseid,-2475.092773,1304.773437,17.925184,91.766357);
			AddHouseCar(houseid,-2474.665039,1294.574584,20.294818,275.456298);
	houseid = CreateHouse(-2477.221435,1281.371093,23.726562,M(5));
			AddHouseCar(houseid,-2474.573730,1285.059204,23.116559,95.685943);
	houseid = CreateHouse(-2476.669189,1274.245361,25.416082,M(5));
			AddHouseCar(houseid,-2474.379882,1277.866821,24.951002,92.068679);
	houseid = CreateHouse(-2477.928466,1264.122314,28.250000,M(5));
			AddHouseCar(houseid,-2475.327880,1267.457519,27.911436,99.790550);
			AddHouseCar(houseid,-2474.833007,1257.991210,30.197269,282.536376);
	houseid = CreateHouse(-2477.109619,1244.669799,33.609375,M(5));
			AddHouseCar(houseid,-2474.674560,1247.936889,33.158348,90.873962);
	houseid = CreateHouse(-2590.733642,-185.876770,4.321073,M(5));
			AddHouseCar(houseid,-2593.609863,-190.908966,4.043446,88.201438);
	houseid = CreateHouse(-2590.918457,-158.794387,4.314481,M(5));
			AddHouseCar(houseid,-2593.241210,-153.793457,4.045399,88.570419);
	houseid = CreateHouse(-2590.890380,-105.875877,4.316833,M(5));
			AddHouseCar(houseid,-2593.599609,-110.862754,4.036810,89.472000);
	houseid = CreateHouse(-2591.324218,-95.384941,4.295700,M(5));
			AddHouseCar(houseid,-2593.691406,-101.027473,4.031438,91.480934);
	houseid = CreateHouse(-2591.163818,-95.737228,4.301500,M(5));
			AddHouseCar(houseid,-2594.042236,-90.967002,4.025636,89.801719);
	houseid = CreateHouse(-2622.029785,-198.011764,4.335937,M(5));
			AddHouseCar(houseid,-2616.176757,-194.360626,4.067565,269.652954);
	houseid = CreateHouse(-2620.840332,-185.608474,7.203125,M(5));
			AddHouseCar(houseid,-2616.139892,-188.520050,4.066985,269.761901);
	houseid = CreateHouse(-2620.717529,-173.200790,5.000000,M(5));
			AddHouseCar(houseid,-2615.809570,-178.293762,4.064293,270.268646);
	houseid = CreateHouse(-2621.526367,-169.570617,4.342578,M(5));
			AddHouseCar(houseid,-2616.129394,-166.357467,4.070634,268.417480);
	houseid = CreateHouse(-2619.069091,-153.684494,4.335937,M(5));
			AddHouseCar(houseid,-2616.224121,-159.611709,4.066551,268.337799);
	houseid = CreateHouse(-2620.877197,-146.761474,7.203125,M(5));
			AddHouseCar(houseid,-2616.082763,-143.912216,4.065387,90.592010);
	houseid = CreateHouse(-2620.577148,-134.755661,5.000000,M(5));
			AddHouseCar(houseid,-2616.038330,-139.890899,4.065265,268.595092);
	houseid = CreateHouse(-2619.170410,-127.843566,4.335937,M(5));
			AddHouseCar(houseid,-2615.595947,-131.326980,4.064457,270.469146);
	houseid = CreateHouse(-2620.782714,-120.076812,7.203125,M(5));
			AddHouseCar(houseid,-2608.592773,-116.355690,3.979906,5.588388);
	houseid = CreateHouse(-2621.834228,-112.450714,4.342578,M(5));
			AddHouseCar(houseid,-2616.901123,-109.892265,4.068712,270.905761);
	houseid = CreateHouse(-2622.788330,-99.354377,7.183060,M(5));
			AddHouseCar(houseid,-2615.673828,-96.699363,4.063002,269.317840);
	houseid = CreateHouse(-2618.762451,57.743854,4.335937,M(5));
			AddHouseCar(houseid,-2616.395751,51.737308,4.066582,270.355712);
	houseid = CreateHouse(-2619.483398,67.903060,4.573123,M(5));
			AddHouseCar(houseid,-2616.365478,61.518638,4.084882,270.489410);
	houseid = CreateHouse(-2622.298095,71.653892,4.335937,M(5));
			AddHouseCar(houseid,-2616.007080,75.486640,4.065268,268.139312);
	houseid = CreateHouse(-2621.037109,96.831405,5.000000,M(5));
			AddHouseCar(houseid,-2615.992431,91.702758,4.065767,269.375000);
	houseid = CreateHouse(-2620.860351,103.299324,7.203125,M(5));
			AddHouseCar(houseid,-2616.447753,105.782661,4.064455,91.042716);
	houseid = CreateHouse(-2620.807617,114.777366,5.000000,M(5));
			AddHouseCar(houseid,-2615.876953,109.552848,4.065156,268.986206);
	houseid = CreateHouse(-2620.627197,120.950744,7.203125,M(5));
			AddHouseCar(houseid,-2616.017822,118.248619,4.064771,269.265594);
	houseid = CreateHouse(-2623.091796,131.566726,7.203125,M(5));
			AddHouseCar(houseid,-2615.888427,134.426193,4.081726,269.446014);
	houseid = CreateHouse(-2621.967041,168.677841,7.195312,M(5));
			AddHouseCar(houseid,-2621.108154,162.475738,3.976061,271.344238);
	houseid = CreateHouse(-2627.967285,168.343231,5.000000,M(5));
			AddHouseCar(houseid,-2629.559814,162.247192,3.981217,92.769889);
	houseid = CreateHouse(-2639.719726,168.730102,7.195312,M(5));
			AddHouseCar(houseid,-2640.770507,161.943679,3.974149,87.396766);
	houseid = CreateHouse(-2687.117675,-187.927062,7.203125,M(5));
			AddHouseCar(houseid,-2694.820556,-190.762298,4.063529,268.607879);
	houseid = CreateHouse(-2688.416259,-174.891525,4.342578,M(5));
			AddHouseCar(houseid,-2694.565185,-179.172943,4.049865,271.643005);
	houseid = CreateHouse(-2689.577636,-167.952972,7.203125,M(5));
			AddHouseCar(houseid,-2702.204345,-163.930221,3.980847,8.602314);
	houseid = CreateHouse(-2690.685058,-159.691543,4.640194,M(5));
			AddHouseCar(houseid,-2694.469970,-156.213058,4.064402,270.498016);
	houseid = CreateHouse(-2689.605468,-152.472747,5.000000,M(5));
			AddHouseCar(houseid,-2694.540527,-147.823242,4.085116,90.606979);
	houseid = CreateHouse(-2689.274658,-141.272216,7.203125,M(5));
			AddHouseCar(houseid,-2694.583251,-143.566238,4.087376,270.736022);
	houseid = CreateHouse(-2691.839599,-133.783706,4.335937,M(5));
			AddHouseCar(houseid,-2694.268310,-127.724983,4.066180,90.858932);
	houseid = CreateHouse(-2688.516113,-117.797477,4.342578,M(5));
			AddHouseCar(houseid,-2694.348388,-122.272239,4.067713,90.946952);
	houseid = CreateHouse(-2689.766601,-114.205230,5.000000,M(5));
			AddHouseCar(houseid,-2694.563720,-109.094863,4.069375,91.044486);
	houseid = CreateHouse(-2689.555175,-101.622032,7.203125,M(5));
			AddHouseCar(houseid,-2694.746582,-98.981346,4.070173,91.131568);
	houseid = CreateHouse(-2688.491455,-89.477310,4.335937,M(5));
			AddHouseCar(houseid,-2694.855468,-93.389129,4.047212,91.238494);
	houseid = CreateHouse(-2689.452880,56.742599,7.203125,M(5));
			AddHouseCar(houseid,-2701.875000,54.639049,3.984742,190.398437);
	houseid = CreateHouse(-2691.214843,64.720436,4.335937,M(5));
			AddHouseCar(houseid,-2693.630615,68.352310,4.064651,89.514999);
	houseid = CreateHouse(-2689.363525,74.765716,7.203125,M(5));
			AddHouseCar(houseid,-2693.596435,72.120124,4.067230,89.663169);
	houseid = CreateHouse(-2689.716064,96.029945,7.203125,M(5));
			AddHouseCar(houseid,-2693.775146,98.686912,4.065123,88.991394);
	houseid = CreateHouse(-2690.776123,102.321876,4.571991,M(5));
			AddHouseCar(houseid,-2694.012207,108.887229,4.063969,89.488273);
	houseid = CreateHouse(-2686.880126,115.405281,7.195312,M(5));
			AddHouseCar(houseid,-2694.626220,118.244163,4.065925,89.625549);
	houseid = CreateHouse(-2690.545898,123.889862,4.726326,M(5));
			AddHouseCar(houseid,-2694.563964,127.500122,4.088569,89.732322);
    	houseid = CreateHouse(1575.703247,2843.868652,10.820312,M(5));
			AddHouseCar(houseid,1580.607177,2840.795166,10.547389,180.212158);
	houseid = CreateHouse(1601.867797,2845.279785,10.820312,M(6));
			AddHouseCar(houseid,1597.026000,2834.948486,10.548228,182.560791);
			AddHouseCar(houseid,1591.798095,2835.352050,10.547414,179.451049);
	houseid = CreateHouse(1622.707031,2845.019531,10.820312,M(5));
			AddHouseCar(houseid,1616.567504,2834.140869,10.564188,131.713607);
	houseid = CreateHouse(1632.890747,2843.329589,10.820312,M(5));
			AddHouseCar(houseid,1639.645996,2833.821044,10.548221,141.787063);
	houseid = CreateHouse(1664.802734,2845.393798,10.820312,M(5));
			AddHouseCar(houseid,1658.669189,2834.357177,10.548213,138.778823);
	houseid = CreateHouse(1673.027832,2801.389648,10.820312,M(5));
			AddHouseCar(houseid,1667.199218,2810.168701,10.548223,288.768585);
	houseid = CreateHouse(1655.099121,2801.500000,10.820312,M(5));
			AddHouseCar(houseid,1649.335815,2809.953369,10.548223,308.029785);
	houseid = CreateHouse(1638.015136,2802.374755,10.820312,M(7));
			AddHouseCar(houseid,1626.478149,2808.587402,10.554459,1.474588);
			AddHouseCar(houseid,1630.189697,2808.682861,10.554518,1.474787);
			AddHouseCar(houseid,1634.772460,2808.800048,10.554592,1.474720);
	houseid = CreateHouse(1618.382324,2801.749267,10.820312,M(5));
			AddHouseCar(houseid,1611.830688,2810.661132,10.545351,316.667205);
	houseid = CreateHouse(1588.397338,2797.878173,10.826543,M(5));
			AddHouseCar(houseid,1595.581542,2808.666259,10.548216,323.072174);
	houseid = CreateHouse(1703.780029,2689.158203,10.826543,M(5));
			AddHouseCar(houseid,1710.854370,2699.896728,10.548887,47.291362);
	houseid = CreateHouse(1735.701049,2691.111083,10.820312,M(5));
			AddHouseCar(houseid,1727.275878,2701.253662,10.548979,269.497314);
	houseid = CreateHouse(1921.764526,2664.561767,10.820312,M(5));
			AddHouseCar(houseid,1928.391967,2656.436523,10.548228,119.912727);
	houseid = CreateHouse(1950.673095,2664.665527,11.298933,M(5));
			AddHouseCar(houseid,1952.563720,2659.931396,10.544081,0.939723);
	houseid = CreateHouse(1969.653320,2663.562500,10.820312,M(5));
			AddHouseCar(houseid,1976.326660,2658.069824,10.555461,143.809295);
	houseid = CreateHouse(1989.015625,2664.738769,10.820312,M(5));
			AddHouseCar(houseid,1995.770263,2656.333984,10.548921,134.728347);
	houseid = CreateHouse(2018.067260,2664.664062,11.298933,M(5));
			AddHouseCar(houseid,2020.438354,2659.692871,10.548889,357.667694);
	houseid = CreateHouse(2037.163940,2663.917236,10.820312,M(5));
			AddHouseCar(houseid,2045.338256,2657.270507,10.555269,134.144042);
	houseid = CreateHouse(2056.547119,2664.823242,10.820312,M(5));
			AddHouseCar(houseid,2063.650146,2655.648437,10.549712,136.136840);
	houseid = CreateHouse(2066.072021,2721.545898,10.820312,M(5));
			AddHouseCar(houseid,2059.716552,2729.891113,10.549151,294.763031);
	houseid = CreateHouse(2037.210937,2721.763183,11.298933,M(5));
			AddHouseCar(houseid,2035.076782,2726.900878,10.549043,178.022842);
	houseid = CreateHouse(2018.293823,2722.340332,10.820312,M(5));
			AddHouseCar(houseid,2010.734252,2729.174560,10.556103,142.685119);
	houseid = CreateHouse(1998.730712,2722.134521,10.820312,M(5));
			AddHouseCar(houseid,1992.192382,2730.602783,10.548322,121.033088);
	houseid = CreateHouse(1969.896728,2721.795898,11.298933,M(5));
			AddHouseCar(houseid,1967.838867,2726.056884,10.562458,179.855972);
	houseid = CreateHouse(1950.850708,2722.990478,10.820312,M(5));
			AddHouseCar(houseid,1944.655761,2729.364501,10.554410,148.289993);
	houseid = CreateHouse(1931.332031,2721.446289,10.820312,M(5));
			AddHouseCar(houseid,1924.498413,2730.970703,10.549032,300.335662);
	houseid = CreateHouse(1929.485473,2774.309082,10.820312,M(5));
			AddHouseCar(houseid,1919.706665,2762.621826,10.555260,36.672660);
	houseid = CreateHouse(1967.193969,2766.546630,10.826543,M(5));
			AddHouseCar(houseid,1960.444458,2755.129150,10.548230,227.618392);
	houseid = CreateHouse(1992.774169,2764.347167,10.820312,M(5));
			AddHouseCar(houseid,1997.716430,2761.312988,10.544722,179.100814);
	houseid = CreateHouse(2018.489624,2766.250976,10.826543,M(5));
			AddHouseCar(houseid,2011.317138,2756.537109,10.541407,137.627410);
	houseid = CreateHouse(2039.651123,2765.578125,10.820312,M(5));
			AddHouseCar(houseid,2031.880859,2755.064208,10.547773,137.351379);
	houseid = CreateHouse(2049.206542,2764.202880,10.820312,M(5));
			AddHouseCar(houseid,2054.614501,2754.430908,10.548892,118.545776);
	houseid = CreateHouse(-2351.873535,1226.527587,33.070213,M(5));
			AddHouseCar(houseid,-2353.891601,1232.189086,31.862110,86.964485);
	houseid = CreateHouse(-2351.708251,1244.476318,29.697811,M(5));
			AddHouseCar(houseid,-2353.017578,1250.780517,28.464294,86.342468);
	houseid = CreateHouse(-2352.145996,1263.034667,26.331293,M(5));
			AddHouseCar(houseid,-2354.096679,1268.913208,25.015617,90.482360);
	houseid = CreateHouse(-2351.682128,1280.949584,22.940965,M(5));
			AddHouseCar(houseid,-2354.199951,1286.661987,21.696445,90.121665);
	houseid = CreateHouse(-2351.717285,1299.647705,19.568719,M(5));
			AddHouseCar(houseid,-2354.227783,1305.037231,18.253213,89.791374);
	houseid = CreateHouse(-2351.524169,1317.978515,16.208190,M(5));
			AddHouseCar(houseid,-2354.070556,1323.626464,14.773368,89.238601);
	houseid = CreateHouse(-2351.643554,1336.361694,12.760780,M(5));
			AddHouseCar(houseid,-2353.984375,1341.685058,11.345723,88.313049);
	houseid = CreateHouse(-2382.636962,1336.638183,12.781478,M(5));
			AddHouseCar(houseid,-2380.018554,1342.131958,11.298821,273.303436);
	houseid = CreateHouse(-2382.526123,1317.702148,16.212863,M(5));
			AddHouseCar(houseid,-2380.154052,1323.760375,14.773091,274.877746);
	houseid = CreateHouse(-2382.560302,1299.649047,19.585056,M(5));
			AddHouseCar(houseid,-2380.084228,1305.669189,18.163349,276.338745);
	houseid = CreateHouse(-2382.434814,1281.466308,22.958969,M(5));
			AddHouseCar(houseid,-2380.431396,1287.453002,21.607959,274.166137);
	houseid = CreateHouse(-2382.181640,1262.977539,26.342193,M(5));
			AddHouseCar(houseid,-2380.071289,1269.070922,24.988138,275.453186);
	houseid = CreateHouse(-2382.618652,1244.766845,29.701574,M(5));
			AddHouseCar(houseid,-2380.198974,1250.371948,28.436201,273.094116);
	houseid = CreateHouse(-2382.602539,1226.268554,33.069152,M(5));
			AddHouseCar(houseid,-2379.710205,1232.303222,31.854188,277.203735);
	houseid = CreateHouse(-2433.715087,1244.416503,33.617187,M(5));
			AddHouseCar(houseid,-2436.648925,1247.859863,33.145065,89.039962);
			AddHouseCar(houseid,-2436.350585,1257.504638,30.297420,266.091522);
	houseid = CreateHouse(-2433.074218,1264.396606,28.257812,M(5));
			AddHouseCar(houseid,-2435.995117,1267.236572,27.960973,85.328781);
	houseid = CreateHouse(-2434.565917,1274.213378,25.529163,M(5));
			AddHouseCar(houseid,-2436.589843,1277.912719,24.946886,90.072334);
	houseid = CreateHouse(-2433.752197,1281.550415,23.742187,M(5));
			AddHouseCar(houseid,-2436.007080,1284.867797,23.254190,91.680564);
			AddHouseCar(houseid,-2436.282714,1294.863769,20.274021,267.503662);
	houseid = CreateHouse(-2433.049804,1301.135131,18.382812,M(5));
			AddHouseCar(houseid,-2436.160888,1304.299072,17.964590,85.557899);
	houseid = CreateHouse(-2434.282470,1311.019897,15.500025,M(5));
			AddHouseCar(houseid,-2436.729736,1314.429077,15.055542,93.717536);
	houseid = CreateHouse(-2434.074462,1318.489257,13.867187,M(5));
			AddHouseCar(houseid,-2435.986572,1322.111572,13.206900,90.791038);
			AddHouseCar(houseid,-2436.300048,1331.594848,10.287212,270.851776);
	houseid = CreateHouse(-2433.465820,1338.390991,8.507812,M(5));
			AddHouseCar(houseid,-2436.197998,1341.102661,7.947793,89.521186);
	houseid = CreateHouse(-2476.986816,1338.080932,8.503883,M(5));
			AddHouseCar(houseid,-2474.458984,1341.484130,7.827658,91.490966);
			AddHouseCar(houseid,-2474.613525,1331.797485,10.228425,279.338348);
	houseid = CreateHouse(-2477.027343,1318.407104,13.851562,M(5));
			AddHouseCar(houseid,-2474.660888,1322.115600,13.116450,94.722854);
	houseid = CreateHouse(-2476.617919,1311.110595,15.511125,M(5));
			AddHouseCar(houseid,-2474.379882,1315.054931,14.904807,96.901603);
	houseid = CreateHouse(-2477.904785,1301.036987,18.375000,M(5));
			AddHouseCar(houseid,-2475.092773,1304.773437,17.925184,91.766357);
			AddHouseCar(houseid,-2474.665039,1294.574584,20.294818,275.456298);
	houseid = CreateHouse(-2477.221435,1281.371093,23.726562,M(5));
			AddHouseCar(houseid,-2474.573730,1285.059204,23.116559,95.685943);
	houseid = CreateHouse(-2476.669189,1274.245361,25.416082,M(5));
			AddHouseCar(houseid,-2474.379882,1277.866821,24.951002,92.068679);
	houseid = CreateHouse(-2477.928466,1264.122314,28.250000,M(5));
			AddHouseCar(houseid,-2475.327880,1267.457519,27.911436,99.790550);
			AddHouseCar(houseid,-2474.833007,1257.991210,30.197269,282.536376);
	houseid = CreateHouse(-2477.109619,1244.669799,33.609375,M(5));
			AddHouseCar(houseid,-2474.674560,1247.936889,33.158348,90.873962);
	houseid = CreateHouse(-2590.733642,-185.876770,4.321073,M(5));
			AddHouseCar(houseid,-2593.609863,-190.908966,4.043446,88.201438);
	houseid = CreateHouse(-2590.918457,-158.794387,4.314481,M(5));
			AddHouseCar(houseid,-2593.241210,-153.793457,4.045399,88.570419);
	houseid = CreateHouse(-2590.890380,-105.875877,4.316833,M(5));
			AddHouseCar(houseid,-2593.599609,-110.862754,4.036810,89.472000);
	houseid = CreateHouse(-2591.324218,-95.384941,4.295700,M(5));
			AddHouseCar(houseid,-2593.691406,-101.027473,4.031438,91.480934);
	houseid = CreateHouse(-2591.163818,-95.737228,4.301500,M(5));
			AddHouseCar(houseid,-2594.042236,-90.967002,4.025636,89.801719);
	houseid = CreateHouse(-2622.029785,-198.011764,4.335937,M(5));
			AddHouseCar(houseid,-2616.176757,-194.360626,4.067565,269.652954);
	houseid = CreateHouse(-2620.840332,-185.608474,7.203125,M(5));
			AddHouseCar(houseid,-2616.139892,-188.520050,4.066985,269.761901);
	houseid = CreateHouse(-2620.717529,-173.200790,5.000000,M(5));
			AddHouseCar(houseid,-2615.809570,-178.293762,4.064293,270.268646);
	houseid = CreateHouse(-2621.526367,-169.570617,4.342578,M(5));
			AddHouseCar(houseid,-2616.129394,-166.357467,4.070634,268.417480);
	houseid = CreateHouse(-2619.069091,-153.684494,4.335937,M(5));
			AddHouseCar(houseid,-2616.224121,-159.611709,4.066551,268.337799);
	houseid = CreateHouse(-2620.877197,-146.761474,7.203125,M(5));
			AddHouseCar(houseid,-2616.082763,-143.912216,4.065387,90.592010);
	houseid = CreateHouse(-2620.577148,-134.755661,5.000000,M(5));
			AddHouseCar(houseid,-2616.038330,-139.890899,4.065265,268.595092);
	houseid = CreateHouse(-2619.170410,-127.843566,4.335937,M(5));
			AddHouseCar(houseid,-2615.595947,-131.326980,4.064457,270.469146);
	houseid = CreateHouse(-2620.782714,-120.076812,7.203125,M(5));
			AddHouseCar(houseid,-2608.592773,-116.355690,3.979906,5.588388);
	houseid = CreateHouse(-2621.834228,-112.450714,4.342578,M(5));
			AddHouseCar(houseid,-2616.901123,-109.892265,4.068712,270.905761);
	houseid = CreateHouse(-2622.788330,-99.354377,7.183060,M(5));
			AddHouseCar(houseid,-2615.673828,-96.699363,4.063002,269.317840);
	houseid = CreateHouse(-2618.762451,57.743854,4.335937,M(5));
			AddHouseCar(houseid,-2616.395751,51.737308,4.066582,270.355712);
	houseid = CreateHouse(-2619.483398,67.903060,4.573123,M(5));
			AddHouseCar(houseid,-2616.365478,61.518638,4.084882,270.489410);
	houseid = CreateHouse(-2622.298095,71.653892,4.335937,M(5));
			AddHouseCar(houseid,-2616.007080,75.486640,4.065268,268.139312);
	houseid = CreateHouse(-2621.037109,96.831405,5.000000,M(5));
			AddHouseCar(houseid,-2615.992431,91.702758,4.065767,269.375000);
	houseid = CreateHouse(-2620.860351,103.299324,7.203125,M(5));
			AddHouseCar(houseid,-2616.447753,105.782661,4.064455,91.042716);
	houseid = CreateHouse(-2620.807617,114.777366,5.000000,M(5));
			AddHouseCar(houseid,-2615.876953,109.552848,4.065156,268.986206);
	houseid = CreateHouse(-2620.627197,120.950744,7.203125,M(5));
			AddHouseCar(houseid,-2616.017822,118.248619,4.064771,269.265594);
	houseid = CreateHouse(-2623.091796,131.566726,7.203125,M(5));
			AddHouseCar(houseid,-2615.888427,134.426193,4.081726,269.446014);
	houseid = CreateHouse(-2621.967041,168.677841,7.195312,M(5));
			AddHouseCar(houseid,-2621.108154,162.475738,3.976061,271.344238);
	houseid = CreateHouse(-2627.967285,168.343231,5.000000,M(5));
			AddHouseCar(houseid,-2629.559814,162.247192,3.981217,92.769889);
	houseid = CreateHouse(-2639.719726,168.730102,7.195312,M(5));
			AddHouseCar(houseid,-2640.770507,161.943679,3.974149,87.396766);
	houseid = CreateHouse(-2687.117675,-187.927062,7.203125,M(5));
			AddHouseCar(houseid,-2694.820556,-190.762298,4.063529,268.607879);
	houseid = CreateHouse(-2688.416259,-174.891525,4.342578,M(5));
			AddHouseCar(houseid,-2694.565185,-179.172943,4.049865,271.643005);
	houseid = CreateHouse(-2689.577636,-167.952972,7.203125,M(5));
			AddHouseCar(houseid,-2702.204345,-163.930221,3.980847,8.602314);
	houseid = CreateHouse(-2690.685058,-159.691543,4.640194,M(5));
			AddHouseCar(houseid,-2694.469970,-156.213058,4.064402,270.498016);
	houseid = CreateHouse(-2689.605468,-152.472747,5.000000,M(5));
			AddHouseCar(houseid,-2694.540527,-147.823242,4.085116,90.606979);
	houseid = CreateHouse(-2689.274658,-141.272216,7.203125,M(5));
			AddHouseCar(houseid,-2694.583251,-143.566238,4.087376,270.736022);
	houseid = CreateHouse(-2691.839599,-133.783706,4.335937,M(5));
			AddHouseCar(houseid,-2694.268310,-127.724983,4.066180,90.858932);
	houseid = CreateHouse(-2688.516113,-117.797477,4.342578,M(5));
			AddHouseCar(houseid,-2694.348388,-122.272239,4.067713,90.946952);
	houseid = CreateHouse(-2689.766601,-114.205230,5.000000,M(5));
			AddHouseCar(houseid,-2694.563720,-109.094863,4.069375,91.044486);
	houseid = CreateHouse(-2689.555175,-101.622032,7.203125,M(5));
			AddHouseCar(houseid,-2694.746582,-98.981346,4.070173,91.131568);
	houseid = CreateHouse(-2688.491455,-89.477310,4.335937,M(5));
			AddHouseCar(houseid,-2694.855468,-93.389129,4.047212,91.238494);
	houseid = CreateHouse(-2689.452880,56.742599,7.203125,M(5));
			AddHouseCar(houseid,-2701.875000,54.639049,3.984742,190.398437);
	houseid = CreateHouse(-2691.214843,64.720436,4.335937,M(5));
			AddHouseCar(houseid,-2693.630615,68.352310,4.064651,89.514999);
	houseid = CreateHouse(-2689.363525,74.765716,7.203125,M(5));
			AddHouseCar(houseid,-2693.596435,72.120124,4.067230,89.663169);
	houseid = CreateHouse(-2689.716064,96.029945,7.203125,M(5));
			AddHouseCar(houseid,-2693.775146,98.686912,4.065123,88.991394);
	houseid = CreateHouse(-2690.776123,102.321876,4.571991,M(5));
			AddHouseCar(houseid,-2694.012207,108.887229,4.063969,89.488273);
	houseid = CreateHouse(-2686.880126,115.405281,7.195312,M(5));
			AddHouseCar(houseid,-2694.626220,118.244163,4.065925,89.625549);
	houseid = CreateHouse(-2690.545898,123.889862,4.726326,M(5));
			AddHouseCar(houseid,-2694.563964,127.500122,4.088569,89.732322);
	houseid = CreateHouse(-2688.396728,136.963668,4.342578,M(5));
	houseid = CreateHouse(-2688.818847,137.169097,4.342578,M(5));
			AddHouseCar(houseid,-2694.121337,133.395401,4.065243,90.651672);
	houseid = CreateHouse(-2724.260742,-191.277587,4.335937,M(5));
			AddHouseCar(houseid,-2718.210205,-187.818496,4.079670,266.340148);
	houseid = CreateHouse(-2723.002685,-178.446014,7.203125,M(5));
			AddHouseCar(houseid,-2718.106689,-181.614746,4.064011,269.493377);
	houseid = CreateHouse(-2722.927734,-166.538619,5.000000,M(5));
			AddHouseCar(houseid,-2718.711669,-171.386306,4.065312,271.037384);
	houseid = CreateHouse(-2724.032470,-162.738174,4.342578,M(5));
			AddHouseCar(houseid,-2718.424804,-158.886993,4.074677,271.431793);
	houseid = CreateHouse(-2721.159912,-146.877700,4.335937,M(5));
			AddHouseCar(houseid,-2719.057617,-152.826873,4.064972,269.432403);
	houseid = CreateHouse(-2723.067138,-139.684890,7.203125,M(5));
			AddHouseCar(houseid,-2718.641357,-136.890655,4.085662,90.548820);
	houseid = CreateHouse(-2722.919433,-127.980003,5.000000,M(5));
			AddHouseCar(houseid,-2718.553710,-133.065841,4.065384,270.773681);
	houseid = CreateHouse(-2721.594238,-120.728446,4.335937,M(5));
			AddHouseCar(houseid,-2718.464599,-124.320678,4.063204,270.516235);
	houseid = CreateHouse(-2723.065429,-112.903900,7.203125,M(5));
			AddHouseCar(houseid,-2710.960937,-113.183341,3.980322,0.734884);
	houseid = CreateHouse(-2723.938964,-105.438865,4.342578,M(5));
			AddHouseCar(houseid,-2718.681152,-101.777877,4.065777,270.596618);
	houseid = CreateHouse(-2725.509277,-92.464477,7.203125,M(5));
			AddHouseCar(houseid,-2717.800781,-89.711570,4.064086,91.076942);
	houseid = CreateHouse(-2724.263671,-58.254085,4.342578,M(5));
			AddHouseCar(houseid,-2718.290039,-54.365066,4.064653,91.855087);
	houseid = CreateHouse(-2721.675292,-44.855842,4.335937,M(5));
			AddHouseCar(houseid,-2718.603759,-48.327606,4.068354,270.444274);
	houseid = CreateHouse(-2725.470947,-36.584758,7.195312,M(5));
			AddHouseCar(houseid,-2721.238769,-33.774288,3.965912,271.983123);
	houseid = CreateHouse(-2721.782714,-23.457105,4.554044,M(5));
			AddHouseCar(houseid,-2718.561279,-29.627218,4.068954,272.018005);
	houseid = CreateHouse(-2723.123046,-17.269594,7.203125,M(5));
			AddHouseCar(houseid,-2718.822021,-19.844507,4.069412,270.606262);
	houseid = CreateHouse(-2723.074462,4.114427,7.203125,M(5));
			AddHouseCar(houseid,-2718.725585,7.171898,4.065798,90.253402);
	houseid = CreateHouse(-2722.105224,14.293816,4.771776,M(5));
			AddHouseCar(houseid,-2718.740478,10.931377,4.075106,270.318511);
	houseid = CreateHouse(-2723.115722,22.357666,7.203125,M(5));
			AddHouseCar(houseid,-2710.765136,20.508644,3.980030,0.313778);
	houseid = CreateHouse(-2789.399902,-181.280120,10.062500,M(5));
			AddHouseCar(houseid,-2796.134277,-183.913421,6.923847,270.496185);
	houseid = CreateHouse(-2791.005859,-168.120086,7.201953,M(5));
			AddHouseCar(houseid,-2797.357910,-172.329025,6.914537,270.552673);
	houseid = CreateHouse(-2791.799316,-160.769180,10.054687,M(5));
			AddHouseCar(houseid,-2803.798095,-160.006561,6.835649,180.668670);
	houseid = CreateHouse(-2792.891113,-153.152984,7.595574,M(5));
			AddHouseCar(houseid,-2796.832275,-149.326461,6.916116,90.710281);
	houseid = CreateHouse(-2791.816162,-145.958038,7.859375,M(5));
			AddHouseCar(houseid,-2796.842285,-140.581970,6.931716,88.311843);
	houseid = CreateHouse(-2791.780761,-134.467437,10.054687,M(5));
			AddHouseCar(houseid,-2797.039306,-137.048538,6.916173,268.986663);
	houseid = CreateHouse(-2793.458984,-127.213783,7.187500,M(5));
			AddHouseCar(houseid,-2796.149414,-120.826469,6.920446,91.067695);
	houseid = CreateHouse(-2791.123291,-111.338439,7.201953,M(5));
			AddHouseCar(houseid,-2796.244384,-114.794815,6.905984,89.355171);
	houseid = CreateHouse(-2792.031005,-107.341796,7.859375,M(5));
			AddHouseCar(houseid,-2796.462646,-102.322547,6.919730,90.683418);
	houseid = CreateHouse(-2791.870605,-95.160842,10.054687,M(5));
			AddHouseCar(houseid,-2796.336181,-92.287643,6.916679,89.473434);
	houseid = CreateHouse(-2790.740478,-82.617332,7.195312,M(5));
			AddHouseCar(houseid,-2797.238037,-86.366508,6.916582,269.588226);
	houseid = CreateHouse(-2789.639160,-52.412456,10.062500,M(5));
			AddHouseCar(houseid,-2796.813720,-55.598300,6.915611,90.276092);
	houseid = CreateHouse(-2791.796875,-42.128505,10.054687,M(5));
			AddHouseCar(houseid,-2796.047119,-39.368980,6.912263,270.793762);
	houseid = CreateHouse(-2792.193847,-35.822772,7.859375,M(5));
			AddHouseCar(houseid,-2796.166015,-30.689634,6.940910,90.871772);
	houseid = CreateHouse(-2791.803466,-24.359975,10.054687,M(5));
			AddHouseCar(houseid,-2797.040039,-27.120134,6.917760,271.457733);
	houseid = CreateHouse(-2791.834960,-17.749279,7.859375,M(5));
			AddHouseCar(houseid,-2797.413574,-12.463347,6.904213,91.554824);
	houseid = CreateHouse(-2790.857910,7.293058,7.195312,M(5));
			AddHouseCar(houseid,-2796.370361,3.666720,6.917759,89.891723);
	houseid = CreateHouse(-2793.161376,11.216133,7.419402,M(5));
			AddHouseCar(houseid,-2796.685546,17.659637,6.915071,90.890625);
	houseid = CreateHouse(-2793.746093,21.224723,7.187500,M(5));
			AddHouseCar(houseid,-2795.933349,27.475669,6.916594,87.095741);
	houseid = CreateHouse(-2790.594482,69.779083,7.201953,M(5));
			AddHouseCar(houseid,-2796.724365,67.100288,6.917660,79.208724);
	houseid = CreateHouse(-2792.068603,77.293266,10.054687,M(5));
			AddHouseCar(houseid,-2803.644775,75.951667,6.835964,7.674192);
	houseid = CreateHouse(-2793.407470,84.857681,7.187500,M(5));
			AddHouseCar(houseid,-2796.885253,87.961402,6.916878,98.435791);
	houseid = CreateHouse(-2791.753417,92.094703,7.859375,M(5));
			AddHouseCar(houseid,-2796.934814,97.245620,6.917654,90.387550);
	houseid = CreateHouse(-2791.993652,104.166603,10.054687,M(5));
			AddHouseCar(houseid,-2796.497070,101.175987,6.935023,271.923400);
	houseid = CreateHouse(-2793.614501,111.114685,7.187500,M(5));
			AddHouseCar(houseid,-2795.905517,117.071640,6.919784,89.584274);
	houseid = CreateHouse(-2790.809570,126.966133,7.201953,M(5));
			AddHouseCar(houseid,-2796.842529,122.956008,6.923234,270.104156);
	houseid = CreateHouse(-2792.118652,130.465377,7.859375,M(5));
			AddHouseCar(houseid,-2797.547119,135.385208,6.910387,88.928497);
	houseid = CreateHouse(-2791.814453,143.109588,10.054687,M(5));
			AddHouseCar(houseid,-2796.086914,145.554306,6.937158,89.464225);
	houseid = CreateHouse(-2789.427734,183.632934,10.062500,M(5));
			AddHouseCar(houseid,-2796.594482,180.892913,6.916383,269.189025);
	houseid = CreateHouse(-2791.722900,194.242111,10.054687,M(5));
			AddHouseCar(houseid,-2797.266601,196.875442,6.916604,89.264587);
	houseid = CreateHouse(-2792.021484,200.682846,7.859375,M(5));
			AddHouseCar(houseid,-2795.957763,205.643585,6.916648,91.617736);
	houseid = CreateHouse(-2791.658203,212.047271,10.054687,M(5));
			AddHouseCar(houseid,-2796.478515,209.478713,6.916119,269.791992);
	houseid = CreateHouse(-2792.198242,218.762161,7.859375,M(5));
			AddHouseCar(houseid,-2796.426269,223.523681,6.917644,89.878051);

#endif

#if defined LS_HOUSES
	houseid = CreateHouse(125.843551,-1490.537353,18.652648,M(3));
	AddHouseCar(houseid,133.762954,-1492.813476,18.430860,59.305648);
	AddHouseCar(houseid,135.765930,-1489.416015,18.382261,59.327316);
	AddHouseCar(houseid,135.431518,-1482.637084,18.681762,91.338165);
	houseid = CreateHouse(143.231018,-1469.808593,25.203598,M(4));
	AddHouseCar(houseid,156.701507,-1474.206787,25.316030,347.039398);
	AddHouseCar(houseid,149.350296,-1473.848144,24.936161,47.801895);
	AddHouseCar(houseid,151.836135,-1471.106933,25.137746,47.801895);
	AddHouseCar(houseid,154.511581,-1468.303222,25.227546,54.407066);
	houseid = CreateHouse(152.378524,-1449.119262,32.844982,M(5));
	AddHouseCar(houseid,160.211776,-1460.672119,36.037185,337.134521);
	AddHouseCar(houseid,154.233123,-1457.737670,36.037189,326.690093);
	AddHouseCar(houseid,148.692367,-1452.739013,36.037181,317.175506);
	AddHouseCar(houseid,165.358352,-1446.250244,36.036975,7.437696);
	AddHouseCar(houseid,168.211624,-1441.203369,36.103023,52.923931);
	houseid = CreateHouse(228.118240,-1405.193725,51.609375,M(3));
	AddHouseCar(houseid,230.787719,-1410.725830,51.327758,333.101745);
	AddHouseCar(houseid,215.338516,-1398.901611,51.336875,358.760284);
	AddHouseCar(houseid,224.951766,-1393.463378,51.301033,60.108547);
	houseid = CreateHouse(254.355636,-1366.959716,53.109375,M(5));
	AddHouseCar(houseid,267.151123,-1376.151855,52.836971,301.998535);
	AddHouseCar(houseid,265.171295,-1372.983398,52.855392,301.998535);
	AddHouseCar(houseid,252.629135,-1358.810546,52.855144,301.998535);
	AddHouseCar(houseid,250.229629,-1354.970458,52.873317,301.998535);
	AddHouseCar(houseid,279.452728,-1353.341308,52.853622,38.372653);
	houseid = CreateHouse(298.308288,-1337.698120,53.441539,M(4));
	AddHouseCar(houseid,309.723266,-1330.105346,53.173603,50.814888);
	AddHouseCar(houseid,305.880859,-1319.303588,53.178249,82.987037);
	AddHouseCar(houseid,288.260986,-1341.115234,53.164329,20.444129);
	AddHouseCar(houseid,292.204895,-1338.774169,53.171459,20.444147);
	houseid = CreateHouse(334.633148,-1303.897460,50.759044,M(4));
	AddHouseCar(houseid,335.478546,-1303.464233,53.951190,11.498447);
	AddHouseCar(houseid,340.320587,-1305.843505,53.951251,29.969953);
	AddHouseCar(houseid,349.151885,-1302.263793,53.951198,29.969886);
	AddHouseCar(houseid,345.090789,-1305.568847,53.951259,344.086242);
	houseid = CreateHouse(355.054351,-1280.973144,53.703639,M(3));
	AddHouseCar(houseid,361.879058,-1274.515502,53.448020,27.052352);
	AddHouseCar(houseid,358.644744,-1276.173217,53.481136,27.052103);
	AddHouseCar(houseid,355.740783,-1277.666870,53.518211,27.032928);
	houseid = CreateHouse(398.307373,-1270.999755,50.019790,M(2));
	AddHouseCar(houseid,408.022399,-1264.302490,50.045806,24.652006);
	AddHouseCar(houseid,405.331359,-1265.542724,50.069564,24.753429);
	houseid = CreateHouse(431.960815,-1253.553100,51.580940,M(2));
	AddHouseCar(houseid,426.996948,-1266.671875,51.309555,23.195146);
	AddHouseCar(houseid,422.321380,-1267.950805,51.309555,203.195144);
	houseid = CreateHouse(553.185668,-1200.181640,44.831535,M(1));
	AddHouseCar(houseid,541.349670,-1202.331298,44.248607,358.637298);
	houseid = CreateHouse(571.053527,-1128.247924,50.685512,M(1));
	AddHouseCar(houseid,567.713012,-1132.044921,50.371101,212.255157);
	houseid = CreateHouse(471.100128,-1164.291259,67.197166,M(1));
	AddHouseCar(houseid,472.488464,-1170.264038,65.096885,196.088180);
	houseid = CreateHouse(416.492462,-1154.290405,76.687614,M(2));
	AddHouseCar(houseid,404.789794,-1150.616821,76.694465,151.470947);
	AddHouseCar(houseid,408.081604,-1152.391967,76.699935,331.248016);
	houseid = CreateHouse(190.188049,-1308.372802,70.260864,M(5));
	AddHouseCar(houseid,197.723846,-1313.202514,69.870857,177.273178);
	AddHouseCar(houseid,179.534973,-1331.061157,69.795410,188.567077);
	AddHouseCar(houseid,159.481231,-1334.452148,69.731857,183.230850);
	AddHouseCar(houseid,166.901687,-1341.170043,69.404197,183.300735);
	AddHouseCar(houseid,192.828094,-1295.135253,69.985572,196.946548);
	houseid = CreateHouse(251.277404,-1220.321777,76.102371,M(4));
	AddHouseCar(houseid,272.656951,-1209.745117,74.965309,152.026824);
	AddHouseCar(houseid,259.492584,-1216.160644,75.006858,182.018707);
	AddHouseCar(houseid,242.300476,-1232.528808,74.787666,278.765808);
	AddHouseCar(houseid,248.472152,-1225.565673,74.963096,258.836791);
	houseid = CreateHouse(300.270385,-1154.481567,81.389801,M(5));
	AddHouseCar(houseid,287.515594,-1156.356811,80.634979,228.423889);
	AddHouseCar(houseid,283.749084,-1160.603393,80.652915,228.423919);
	AddHouseCar(houseid,283.909240,-1172.052124,80.640075,254.864639);
	AddHouseCar(houseid,289.779754,-1178.678588,80.641159,257.158264);
	AddHouseCar(houseid,317.575408,-1167.099609,80.632888,133.712234);
	houseid = CreateHouse(352.776031,-1197.621582,76.515625,M(2));
	AddHouseCar(houseid,346.621643,-1199.342163,76.242950,40.565761);
	AddHouseCar(houseid,348.847106,-1197.437011,76.262496,220.622650);
	houseid = CreateHouse(497.481445,-1094.848388,82.359191,M(2));
	AddHouseCar(houseid,477.668243,-1091.844726,82.106422,359.599700);
	AddHouseCar(houseid,481.602508,-1091.872558,82.114013,359.599243);
	houseid = CreateHouse(558.644226,-1076.184814,72.921989,M(2));
	AddHouseCar(houseid,568.087036,-1068.689086,72.841133,208.056045);
	AddHouseCar(houseid,565.005432,-1070.348510,72.888893,207.862670);
	houseid = CreateHouse(645.873168,-1117.542846,44.207038,M(1));
	AddHouseCar(houseid,635.742004,-1122.085449,44.564056,43.729125);
	houseid = CreateHouse(647.976196,-1057.882934,52.579917,M(3));
	AddHouseCar(houseid,660.101257,-1063.330932,48.705715,228.059463);
	AddHouseCar(houseid,657.677917,-1066.028564,48.518436,228.059417);
	AddHouseCar(houseid,655.951843,-1067.949707,48.380550,228.059555);
	houseid = CreateHouse(700.111267,-1060.005004,49.421691,M(1));
	AddHouseCar(houseid,689.497680,-1073.016357,49.188850,56.478149);
	houseid = CreateHouse(672.862182,-1018.823059,55.759605,M(2));
	AddHouseCar(houseid,685.677429,-1022.188598,51.305618,240.785522);
	AddHouseCar(houseid,683.788269,-1025.597412,51.225635,240.780700);
	houseid = CreateHouse(730.859130,-1013.727966,52.737854,M(3));
	AddHouseCar(houseid,725.199584,-997.208435,52.413307,60.501995);
	AddHouseCar(houseid,727.481506,-993.179199,52.410820,60.467826);
	AddHouseCar(houseid,738.055053,-1016.810729,52.464931,96.671867);
	houseid = CreateHouse(786.123962,-828.389160,70.289581,M(3));
	AddHouseCar(houseid,796.072937,-842.257141,60.367004,188.570816);
	AddHouseCar(houseid,785.861267,-844.842834,60.372116,188.570831);
	AddHouseCar(houseid,797.467224,-857.735046,60.351551,160.208984);
	houseid = CreateHouse(827.888061,-858.242797,70.330810,M(1));
	AddHouseCar(houseid,830.136901,-853.473266,69.653030,198.708801);
	houseid = CreateHouse(835.972045,-894.688537,68.768898,M(1));
	AddHouseCar(houseid,833.188110,-888.931457,68.515350,319.796691);
	houseid = CreateHouse(837.351013,-931.605041,55.250000,M(1));
	AddHouseCar(houseid,828.705200,-922.870361,54.966911,255.304779);
	houseid = CreateHouse(863.397705,-844.287109,77.375000,M(2));
	AddHouseCar(houseid,860.411315,-848.632202,77.032104,207.305160);
	AddHouseCar(houseid,870.193725,-847.791320,77.160186,183.805084);
	houseid = CreateHouse(879.566955,-874.227905,77.774353,M(2));
	AddHouseCar(houseid,870.584167,-875.031799,77.377273,9.467340);
	AddHouseCar(houseid,874.615722,-873.634582,77.349685,21.063261);
	houseid = CreateHouse(924.042297,-852.917297,93.456520,M(2));
	AddHouseCar(houseid,935.494689,-855.166748,93.234321,22.501228);
	AddHouseCar(houseid,930.928466,-857.059448,93.219352,22.501274);
	houseid = CreateHouse(937.901672,-848.220397,93.639289,M(2));
	AddHouseCar(houseid,945.665588,-840.575622,93.891418,79.751632);
	AddHouseCar(houseid,938.877502,-845.607360,93.624229,29.634876);
	houseid = CreateHouse(910.111633,-816.818420,103.126029,M(1));
	AddHouseCar(houseid,917.977172,-832.259948,93.111137,290.612060);
	houseid = CreateHouse(989.568908,-828.175109,95.468574,M(1));
	AddHouseCar(houseid,979.920837,-830.728942,95.376014,27.264074);
	houseid = CreateHouse(1035.198486,-812.664978,101.851562,M(2));
	AddHouseCar(houseid,1027.660034,-810.996704,101.600143,20.528884);
	AddHouseCar(houseid,1031.326538,-802.968872,101.658554,20.759998);
	houseid = CreateHouse(1093.680786,-805.782348,107.419548,M(2));
	AddHouseCar(houseid,1100.435791,-780.020935,106.414451,31.188814);
	AddHouseCar(houseid,1096.000488,-787.508605,106.711196,67.122924);
	houseid = CreateHouse(1111.867553,-741.743957,100.132926,M(4));
	AddHouseCar(houseid,1120.253051,-720.141357,100.263656,101.377525);
	AddHouseCar(houseid,1119.044311,-726.565002,99.961372,97.468521);
	AddHouseCar(houseid,1110.247192,-732.999206,100.057975,95.031623);
	AddHouseCar(houseid,1099.185791,-723.626831,101.853164,123.136650);
	houseid = CreateHouse(1257.510864,-781.710266,92.030181,M(4));
	AddHouseCar(houseid,1242.950805,-804.045959,83.867713,179.210922);
	AddHouseCar(houseid,1248.861083,-804.127380,83.893432,179.211166);
	AddHouseCar(houseid,1254.690429,-804.207763,83.893432,179.211166);
	AddHouseCar(houseid,1254.514038,-814.490661,83.873237,90.898933);
	houseid = CreateHouse(1496.876953,-688.442260,95.418510,M(2));
	AddHouseCar(houseid,1516.968750,-689.649780,94.478576,117.415901);
	AddHouseCar(houseid,1516.772705,-695.624816,94.477081,96.475059);
	houseid = CreateHouse(1527.701416,-772.752502,80.578125,M(2));
	AddHouseCar(houseid,1513.378173,-765.993164,80.244918,132.606307);
	AddHouseCar(houseid,1518.032958,-769.460754,79.614166,130.463302);
	houseid = CreateHouse(1534.567016,-800.278076,72.849456,M(2));
	AddHouseCar(houseid,1530.424682,-815.482299,71.562698,87.434661);
	AddHouseCar(houseid,1530.626586,-810.984680,71.706085,87.333457);
	houseid = CreateHouse(1540.056640,-851.310363,64.336059,M(1));
	AddHouseCar(houseid,1534.721069,-841.976501,64.714942,92.779716);
	houseid = CreateHouse(1536.457031,-884.988830,57.657482,M(3));
	AddHouseCar(houseid,1532.822875,-894.211486,60.849689,43.656871);
	AddHouseCar(houseid,1539.686157,-887.662109,60.867210,43.656860);
	AddHouseCar(houseid,1525.578369,-889.710754,60.849468,43.659660);
	houseid = CreateHouse(1468.824218,-905.066284,54.835937,M(3));
	AddHouseCar(houseid,1480.036987,-900.446472,55.307701,357.168090);
	AddHouseCar(houseid,1475.968872,-900.237731,55.000099,357.172515);
	AddHouseCar(houseid,1464.388305,-901.664550,54.563056,357.350952);
	houseid = CreateHouse(1421.900268,-885.343261,50.653873,M(3));
	AddHouseCar(houseid,1438.393676,-892.881530,50.342247,275.545532);
	AddHouseCar(houseid,1426.739990,-883.871887,50.423870,4.528915);
	AddHouseCar(houseid,1430.067749,-883.892517,50.472774,24.838262);
	houseid = CreateHouse(1442.544433,-629.044494,95.718566,M(4));
	AddHouseCar(houseid,1446.334350,-634.531677,95.320472,178.371490);
	AddHouseCar(houseid,1449.811889,-634.623413,95.428253,178.396453);
	AddHouseCar(houseid,1453.979248,-634.721130,95.439155,178.419418);
	AddHouseCar(houseid,1459.408935,-634.840270,95.589324,178.439819);
	houseid = CreateHouse(1335.335449,-630.557434,109.134902,M(4));
	AddHouseCar(houseid,1361.494873,-620.189880,108.859893,97.123817);
	AddHouseCar(houseid,1361.078125,-616.840942,108.878860,97.209861);
	AddHouseCar(houseid,1359.968994,-609.877990,108.845565,96.960311);
	AddHouseCar(houseid,1341.739501,-622.221740,108.861984,290.675292);
	houseid = CreateHouse(1095.171386,-646.743591,113.648437,M(4));
	AddHouseCar(houseid,1111.362060,-647.613891,112.822517,48.853836);
	AddHouseCar(houseid,1110.208129,-639.916748,111.563995,60.281520);
	AddHouseCar(houseid,1088.141113,-641.321350,112.926803,85.515296);
	AddHouseCar(houseid,1088.501220,-635.433776,112.633537,85.011749);
	houseid = CreateHouse(1044.963867,-642.326538,120.117187,M(3));
	AddHouseCar(houseid,1034.244262,-642.167846,119.844268,315.813720);
	AddHouseCar(houseid,1049.259033,-638.282043,119.848838,45.813686);
	AddHouseCar(houseid,1041.288208,-640.656066,119.844291,8.487091);
	houseid = CreateHouse(980.225769,-676.825927,121.976257,M(2));
	AddHouseCar(houseid,1006.671630,-663.164184,120.873428,32.465469);
	AddHouseCar(houseid,1011.798156,-659.902343,120.876548,32.465450);
	AddHouseCar(houseid,1000.719055,-666.950805,120.892295,32.465492);
	houseid = CreateHouse(898.338562,-677.614013,116.890441,M(2));
	AddHouseCar(houseid,910.199279,-665.071228,116.667266,234.407135);
	AddHouseCar(houseid,911.499145,-675.680053,116.598251,158.649673);
	houseid = CreateHouse(946.085754,-710.333801,122.619873,M(2));
	AddHouseCar(houseid,943.935974,-714.575805,121.938209,30.883083);
	AddHouseCar(houseid,946.516601,-703.166320,121.941963,31.674777);
	AddHouseCar(houseid,951.116333,-690.418762,121.621635,31.789348);
	AddHouseCar(houseid,947.659240,-692.532348,121.509841,31.775407);
	houseid = CreateHouse(891.232543,-783.097534,101.313583,M(2));
	AddHouseCar(houseid,879.486816,-785.765502,100.979759,294.356536);
	houseid = CreateHouse(868.062805,-716.670776,105.679687,M(2));
	AddHouseCar(houseid,864.817626,-712.374450,105.413841,332.337280);
	AddHouseCar(houseid,892.210571,-708.216491,109.496459,243.542907);
	houseid = CreateHouse(848.555419,-745.489685,94.969268,M(2));
	AddHouseCar(houseid,851.233459,-741.611694,94.700187,222.101257);
	AddHouseCar(houseid,853.147277,-748.866882,94.696243,232.967712);
	AddHouseCar(houseid,836.478393,-755.643554,85.035812,221.559631);
	houseid = CreateHouse(808.360412,-759.188537,76.531364,M(3));
	AddHouseCar(houseid,813.357788,-767.997558,76.441368,194.638031);
	AddHouseCar(houseid,817.991149,-766.822937,77.171348,194.797958);
	AddHouseCar(houseid,821.016418,-766.064270,77.673126,194.868637);
	houseid = CreateHouse(785.997314,-828.038879,70.289581,M(2));
	AddHouseCar(houseid,794.085327,-824.369018,69.845535,9.168760);
	AddHouseCar(houseid,790.017272,-825.027038,69.822692,9.172779);
		houseid = CreateHouse(2637.083496,-1992.095458,13.993547,M(5));
			AddHouseCar(houseid,2638.423095,-1997.826049,13.208826,301.320251);	houseid = CreateHouse(2635.812500,-2012.276367,13.813860,M(5));
			AddHouseCar(houseid,2639.768066,-2009.889160,13.203079,210.934585);
	houseid = CreateHouse(2649.828613,-2021.847045,14.176628,M(5));
			AddHouseCar(houseid,2653.501464,-2032.165283,13.206430,86.517684);
	houseid = CreateHouse(2652.601074,-1989.648193,13.998847,M(5));
			AddHouseCar(houseid,2653.577148,-1998.539672,13.122156,268.488830);
	houseid = CreateHouse(2672.817626,-1990.093261,13.993547,M(5));
			AddHouseCar(houseid,2672.264160,-1999.155761,13.117692,268.431915);
	houseid = CreateHouse(2696.338378,-1990.691406,14.222853,M(5));
			AddHouseCar(houseid,2693.555175,-1998.552001,13.076301,271.963317);
	houseid = CreateHouse(2695.406738,-2020.287719,14.022284,M(5));
			AddHouseCar(houseid,2694.176513,-2008.852050,13.170578,91.394912);
	houseid = CreateHouse(2673.573486,-2019.720947,14.168166,M(5));
			AddHouseCar(houseid,2676.236083,-2009.191040,13.119003,91.375488);
	houseid = CreateHouse(2437.880126,-2020.659423,13.902541,M(5));
			AddHouseCar(houseid,2436.668457,-2014.638305,13.110208,268.583709);
	houseid = CreateHouse(2465.446289,-2020.267456,14.124163,M(5));
			AddHouseCar(houseid,2462.502929,-2014.733154,13.068416,269.699462);
	houseid = CreateHouse(2486.221435,-2021.155883,13.998847,M(5));
			AddHouseCar(houseid,2485.702880,-2014.927001,13.063286,268.654632);
	houseid = CreateHouse(2507.626464,-2020.586181,14.210101,M(5));
			AddHouseCar(houseid,2507.048339,-2015.146484,13.071597,269.509582);
	houseid = CreateHouse(2522.570800,-2018.897216,14.074416,M(5));
			AddHouseCar(houseid,2526.272949,-2012.144531,13.210595,92.582809);
	houseid = CreateHouse(2508.210449,-1998.604980,13.902541,M(5));
			AddHouseCar(houseid,2509.055419,-2004.199218,13.069309,86.003494);
	houseid = CreateHouse(2486.272705,-1996.123046,13.834323,M(5));
			AddHouseCar(houseid,2485.562988,-2004.739379,13.063317,87.280838);
	houseid = CreateHouse(2465.241943,-1996.403564,13.688860,M(5));
			AddHouseCar(houseid,2464.145507,-2004.687377,13.068239,89.653205);
	houseid = CreateHouse(2402.487304,-1715.613281,14.132812,M(5));
			AddHouseCar(houseid,2401.167724,-1727.967407,13.123323,88.813682);
	houseid = CreateHouse(2385.912353,-1712.445312,14.242187,M(5));
			AddHouseCar(houseid,2388.909179,-1727.855346,13.119585,86.647659);
	houseid = CreateHouse(2326.649169,-1716.947875,13.907408,M(5));
			AddHouseCar(houseid,2319.049560,-1712.565551,13.203392,180.806991);
	houseid = CreateHouse(2308.956298,-1715.001220,14.649595,M(5));
			AddHouseCar(houseid,2310.199462,-1727.322021,13.114499,92.463920);
	houseid = CreateHouse(2244.133789,-1637.967041,15.907407,M(5));
			AddHouseCar(houseid,2237.823974,-1634.467895,15.323104,161.431045);
	houseid = CreateHouse(2256.877685,-1644.279296,15.522283,M(5));
			AddHouseCar(houseid,2256.055175,-1653.150878,15.012721,264.926757);
	houseid = CreateHouse(2282.342041,-1641.301879,15.889788,M(5));
			AddHouseCar(houseid,2270.942871,-1640.065551,15.009318,181.301116);
	houseid = CreateHouse(2306.853027,-1678.757568,14.001157,M(5));
			AddHouseCar(houseid,2306.642822,-1663.665405,14.120486,88.159515);
	houseid = CreateHouse(2368.329345,-1675.026245,14.168166,M(5));
			AddHouseCar(houseid,2368.811035,-1663.709106,13.114804,267.657867);
	houseid = CreateHouse(2384.629882,-1675.216064,14.915221,M(5));
			AddHouseCar(houseid,2386.366699,-1664.841796,13.154904,267.393859);
	houseid = CreateHouse(2409.035400,-1674.160644,13.605060,M(5));
			AddHouseCar(houseid,2407.777343,-1664.622924,13.115859,272.019317);
	houseid = CreateHouse(2459.474853,-1690.969970,13.544997,M(5));
			AddHouseCar(houseid,2473.426513,-1696.584594,13.171182,0.436025);
	houseid = CreateHouse(2514.325439,-1691.596069,14.046038,M(5));
			AddHouseCar(houseid,2503.891845,-1680.859497,13.124568,316.390991);
	houseid = CreateHouse(2522.981933,-1679.301513,15.496999,M(5));
			AddHouseCar(houseid,2510.616943,-1671.883422,13.081736,340.780609);
	houseid = CreateHouse(2524.077148,-1658.787475,15.493547,M(5));
			AddHouseCar(houseid,2506.521728,-1662.317749,13.062086,39.756080);
	houseid = CreateHouse(2498.686767,-1643.020996,13.782609,M(5));
			AddHouseCar(houseid,2497.474609,-1655.761596,13.041274,81.670295);
	houseid = CreateHouse(2486.491699,-1645.808105,14.070312,M(5));
			AddHouseCar(houseid,2485.673339,-1653.040893,13.056315,88.530380);
	houseid = CreateHouse(2469.722656,-1646.360595,13.780097,M(5));
			AddHouseCar(houseid,2466.971191,-1653.983276,13.047669,93.959030);
	houseid = CreateHouse(2451.867431,-1641.861572,13.735734,M(5));
			AddHouseCar(houseid,2443.406738,-1645.084594,13.137219,181.034118);
	houseid = CreateHouse(2413.892333,-1647.198364,14.011916,M(5));
			AddHouseCar(houseid,2418.059082,-1654.418823,13.119025,92.729759);
	houseid = CreateHouse(2393.110107,-1646.231323,13.905097,M(5));
			AddHouseCar(houseid,2394.967285,-1654.570678,13.114275,92.663612);
	houseid = CreateHouse(2362.846923,-1643.981567,13.533258,M(5));
			AddHouseCar(houseid,2362.271728,-1654.882080,13.072597,273.633392);
	houseid = CreateHouse(2068.149902,-1628.961547,13.876157,M(5));
			AddHouseCar(houseid,2075.678466,-1628.632324,13.203680,180.306152);
	houseid = CreateHouse(2067.903564,-1643.725097,13.805846,M(5));
			AddHouseCar(houseid,2076.711669,-1645.421264,13.123124,179.516479);
	houseid = CreateHouse(2067.085693,-1656.584594,14.005367,M(5));
			AddHouseCar(houseid,2076.835449,-1657.314331,13.123721,181.743515);
	houseid = CreateHouse(2065.773681,-1703.323120,14.148437,M(5));
			AddHouseCar(houseid,2067.273193,-1695.092651,13.211559,268.496459);
	houseid = CreateHouse(2066.659667,-1716.994506,13.805846,M(5));
			AddHouseCar(houseid,2076.426269,-1718.200073,13.122632,171.581649);
	houseid = CreateHouse(2067.588134,-1731.662597,13.876157,M(5));
			AddHouseCar(houseid,2076.932861,-1733.280639,13.118687,182.534545);
	houseid = CreateHouse(2015.345825,-1732.510498,14.234375,M(5));
			AddHouseCar(houseid,2006.190185,-1731.232543,13.118296,0.170489);
	houseid = CreateHouse(2015.379394,-1716.969238,13.554683,M(5));
			AddHouseCar(houseid,2006.031738,-1718.568359,13.119072,0.857347);
	houseid = CreateHouse(2017.761474,-1703.228637,14.234375,M(5));
			AddHouseCar(houseid,2006.770751,-1700.084960,13.122470,5.993752);
	houseid = CreateHouse(2013.194213,-1656.424560,13.805846,M(5));
			AddHouseCar(houseid,2006.963867,-1655.831665,13.127247,2.661538);
	houseid = CreateHouse(2016.208740,-1641.724609,13.782407,M(5));
			AddHouseCar(houseid,2006.766845,-1639.679809,13.118791,359.443023);
	houseid = CreateHouse(2017.261596,-1630.163818,13.546875,M(5));
			AddHouseCar(houseid,2006.781250,-1630.014282,13.116109,359.908843);
	houseid = CreateHouse(1975.981567,-1634.031738,18.568988,M(5));
			AddHouseCar(houseid,1957.645263,-1633.078125,15.637654,176.182983);
	houseid = CreateHouse(1969.014648,-1654.807617,15.968750,M(5));
			AddHouseCar(houseid,1957.073120,-1659.298583,15.635902,178.723190);
	houseid = CreateHouse(1978.317504,-1671.670410,18.545551,M(5));
			AddHouseCar(houseid,1974.228637,-1674.468139,15.623493,268.291015);
	houseid = CreateHouse(1981.532958,-1682.888305,17.053792,M(5));
			AddHouseCar(houseid,1988.599975,-1682.756958,15.632675,359.567047);
	houseid = CreateHouse(1968.779663,-1706.169677,15.968750,M(5));
			AddHouseCar(houseid,1964.841308,-1717.040771,15.619912,359.428009);
	houseid = CreateHouse(1981.042724,-1718.913208,17.030290,M(5));
			AddHouseCar(houseid,1988.888305,-1719.062744,15.624183,1.400257);
	houseid = CreateHouse(1894.360351,-2133.422851,15.466326,M(5));
			AddHouseCar(houseid,1895.232910,-2146.652343,13.209606,90.346000);
	houseid = CreateHouse(1872.681884,-2132.901855,15.481951,M(5));
			AddHouseCar(houseid,1873.140869,-2146.784667,13.211767,90.446975);
	houseid = CreateHouse(1851.925292,-2134.845458,15.388201,M(5));
			AddHouseCar(houseid,1850.649658,-2146.958007,13.208693,90.520599);
	houseid = CreateHouse(1851.807373,-2069.641113,15.481237,M(5));
			AddHouseCar(houseid,1852.617187,-2057.461669,13.118870,270.702026);
	houseid = CreateHouse(1873.557739,-2070.287353,15.497086,M(5));
			AddHouseCar(houseid,1876.754028,-2056.743896,13.117842,273.126983);
	houseid = CreateHouse(1895.205688,-2068.046875,15.668893,M(5));
			AddHouseCar(houseid,1896.479980,-2057.462646,13.118417,268.297515);
	houseid = CreateHouse(1802.016479,-2099.566406,14.021014,M(5));
			AddHouseCar(houseid,1802.082519,-2107.693847,13.118787,89.363082);
	houseid = CreateHouse(1781.244018,-2101.592285,14.056648,M(5));
			AddHouseCar(houseid,1781.913574,-2107.717285,13.118659,95.203483);
	houseid = CreateHouse(1762.793334,-2102.638427,13.856951,M(5));
			AddHouseCar(houseid,1761.500732,-2107.842529,13.119274,89.813217);
	houseid = CreateHouse(1734.124511,-2098.290039,14.036639,M(5));
			AddHouseCar(houseid,1734.322143,-2108.057861,13.118530,90.484512);
	houseid = CreateHouse(1711.719970,-2102.081054,14.021014,M(5));
			AddHouseCar(houseid,1711.393066,-2107.867919,13.116122,88.728332);
	houseid = CreateHouse(1687.325317,-2099.106445,13.834323,M(5));
			AddHouseCar(houseid,1687.607177,-2107.100585,13.118753,96.093864);
	houseid = CreateHouse(1667.263427,-2107.686767,14.072273,M(5));
			AddHouseCar(houseid,1667.718017,-2110.957763,13.202408,272.439605);
	houseid = CreateHouse(1673.973144,-2121.992919,14.146014,M(5));
			AddHouseCar(houseid,1671.507934,-2116.186767,13.217964,266.426849);
	houseid = CreateHouse(1695.440795,-2124.926513,13.810076,M(5));
			AddHouseCar(houseid,1695.694091,-2117.670166,13.119395,266.920074);
	houseid = CreateHouse(1714.938598,-2124.738037,14.056648,M(5));
			AddHouseCar(houseid,1715.424194,-2118.608642,13.118610,267.170806);
	houseid = CreateHouse(1734.498657,-2130.098144,14.021014,M(5));
			AddHouseCar(houseid,1735.809082,-2117.776367,13.116152,269.475036);
	houseid = CreateHouse(1761.324951,-2124.920654,14.056648,M(5));
			AddHouseCar(houseid,1758.999389,-2117.856689,13.136428,268.737182);
	houseid = CreateHouse(1782.060791,-2125.795898,14.067889,M(5));
			AddHouseCar(houseid,1779.743041,-2117.938964,13.128717,270.548706);
	houseid = CreateHouse(1804.321289,-2124.429687,13.942373,M(5));
			AddHouseCar(houseid,1800.295410,-2117.462158,13.122174,271.486053);
	houseid = CreateHouse(2148.301025,-1484.836303,26.624118,M(5));
			AddHouseCar(houseid,2134.639160,-1477.181152,23.547689,2.930949);
	houseid = CreateHouse(2151.365478,-1446.560791,25.774595,M(5));
			AddHouseCar(houseid,2155.663818,-1454.306030,25.204753,91.352851);
	houseid = CreateHouse(2149.318603,-1433.844116,25.822286,M(5));
			AddHouseCar(houseid,2134.534179,-1431.711669,23.555610,352.627349);
	houseid = CreateHouse(2150.451416,-1418.861816,25.921875,M(5));
			AddHouseCar(houseid,2134.156005,-1416.659179,23.562936,359.135498);
	houseid = CreateHouse(2150.618896,-1400.633178,25.798032,M(5));
			AddHouseCar(houseid,2157.624755,-1408.226928,25.207214,92.312980);
	houseid = CreateHouse(2129.804199,-1362.425292,25.546340,M(5));
			AddHouseCar(houseid,2128.902587,-1368.035156,25.198570,267.569305);
	houseid = CreateHouse(2148.146484,-1366.909301,25.641782,M(5));
			AddHouseCar(houseid,2147.207763,-1370.279418,25.222803,87.955345);
	houseid = CreateHouse(2185.309082,-1363.859619,26.159753,M(5));
			AddHouseCar(houseid,2187.001220,-1370.246093,25.250558,268.856689);
	houseid = CreateHouse(2202.225585,-1364.345458,25.860534,M(5));
			AddHouseCar(houseid,2201.417724,-1369.297607,25.346963,91.902679);
	houseid = CreateHouse(2196.583007,-1404.374755,25.618345,M(5));
			AddHouseCar(houseid,2207.428222,-1406.683959,23.565702,177.716049);
	houseid = CreateHouse(2189.079345,-1419.241943,26.156250,M(5));
			AddHouseCar(houseid,2194.840820,-1419.703491,25.195007,356.551666);
	houseid = CreateHouse(2194.854492,-1442.733642,25.743347,M(5));
			AddHouseCar(houseid,2189.959716,-1434.653808,25.144367,272.021667);
	houseid = CreateHouse(2192.242431,-1455.856079,25.539062,M(5));
			AddHouseCar(houseid,2208.003662,-1459.288940,23.549581,177.574554);
	houseid = CreateHouse(2190.453369,-1470.750976,25.914062,M(5));
			AddHouseCar(houseid,2184.890869,-1466.103393,25.203126,270.066009);
	houseid = CreateHouse(2191.052978,-1487.558227,25.774595,M(5));
			AddHouseCar(houseid,2186.498779,-1480.459960,25.189056,270.702667);
	houseid = CreateHouse(2230.762695,-1408.686035,24.000000,M(5));
			AddHouseCar(houseid,2231.799072,-1414.774047,23.485532,280.850524);
	houseid = CreateHouse(2243.730712,-1408.374267,24.000000,M(5));
			AddHouseCar(houseid,2243.044921,-1412.880371,23.564617,277.162414);
	houseid = CreateHouse(2256.956542,-1407.685180,24.000000,M(5));
			AddHouseCar(houseid,2256.568359,-1412.561035,23.567852,270.269287);
	houseid = CreateHouse(2263.901367,-1458.930053,24.008522,M(5));
			AddHouseCar(houseid,2263.699218,-1454.251586,23.574724,102.040710);
	houseid = CreateHouse(2247.678710,-1458.876586,24.025247,M(5));
			AddHouseCar(houseid,2247.351806,-1454.453613,23.577392,84.734603);
	houseid = CreateHouse(2232.595703,-1458.885498,24.020341,M(5));
			AddHouseCar(houseid,2234.375732,-1454.836914,23.571414,91.050590);
	houseid = CreateHouse(2250.707275,-1280.405395,25.476562,M(5));
			AddHouseCar(houseid,2254.436767,-1273.358764,25.037923,179.037231);
	houseid = CreateHouse(2229.919921,-1280.506591,25.367187,M(5));
			AddHouseCar(houseid,2231.247802,-1296.086547,23.561077,86.936286);
	houseid = CreateHouse(2208.370849,-1280.819213,25.120691,M(5));
			AddHouseCar(houseid,2208.255859,-1295.111083,23.558393,89.418609);
	houseid = CreateHouse(2191.663085,-1276.048828,25.156250,M(5));
			AddHouseCar(houseid,2196.254150,-1277.490356,24.201515,179.307250);
	houseid = CreateHouse(2150.404785,-1286.560058,24.196470,M(5));
			AddHouseCar(houseid,2147.207519,-1296.603515,23.557880,95.587089);
	houseid = CreateHouse(2132.062500,-1280.296752,25.890625,M(5));
			AddHouseCar(houseid,2136.119628,-1274.901245,25.154865,178.930084);
	houseid = CreateHouse(2148.779541,-1319.718994,25.743345,M(5));
			AddHouseCar(houseid,2141.293701,-1322.945312,24.974332,359.213531);
	houseid = CreateHouse(2126.604980,-1320.592163,26.623979,M(5));
			AddHouseCar(houseid,2135.551757,-1324.797729,25.102630,359.382202);
	houseid = CreateHouse(2101.067138,-1321.676391,25.953125,M(5));
			AddHouseCar(houseid,2096.553222,-1323.827880,25.103723,1.279502);
    	houseid = CreateHouse(2109.278564,-1279.241333,25.687500,M(5));
			AddHouseCar(houseid,2102.258544,-1276.667358,25.146808,179.788772);
	houseid = CreateHouse(2091.134033,-1278.273071,26.179687,M(5));
			AddHouseCar(houseid,2095.487060,-1278.230957,25.159235,181.139968);
	houseid = CreateHouse(2090.655517,-1235.094238,26.019128,M(5));
			AddHouseCar(houseid,2091.838867,-1225.155883,23.548147,266.108184);
	houseid = CreateHouse(2110.933349,-1244.221557,25.851562,M(5));
			AddHouseCar(houseid,2106.286621,-1249.963378,25.150138,359.893432);
	houseid = CreateHouse(2133.456787,-1232.813598,24.421875,M(5));
			AddHouseCar(houseid,2135.653564,-1225.712890,23.551433,278.676757);
	houseid = CreateHouse(2153.858886,-1243.404785,25.367187,M(5));
			AddHouseCar(houseid,2149.900146,-1249.448486,24.657712,1.833980);
	houseid = CreateHouse(2191.866943,-1238.885375,24.157409,M(5));
			AddHouseCar(houseid,2198.089355,-1225.449096,23.542068,267.386901);
	houseid = CreateHouse(2209.708740,-1239.371459,24.149595,M(5));
			AddHouseCar(houseid,2210.104248,-1225.338500,23.542827,272.534667);
	houseid = CreateHouse(2229.667236,-1241.114257,25.656250,M(5));
			AddHouseCar(houseid,2224.397705,-1238.409301,24.578706,1.586100);
	houseid = CreateHouse(2250.018066,-1238.512573,25.898437,M(5));
			AddHouseCar(houseid,2245.163574,-1244.464721,25.091491,18.681781);
	houseid = CreateHouse(2383.379638,-1366.145385,24.491352,M(5));
			AddHouseCar(houseid,2376.736816,-1369.635986,23.568712,2.894590);
	houseid = CreateHouse(2389.552490,-1346.372192,25.076972,M(5));
			AddHouseCar(houseid,2376.476318,-1346.507080,23.568584,357.271697);
	houseid = CreateHouse(2387.578613,-1328.460205,25.124164,M(5));
			AddHouseCar(houseid,2375.875976,-1324.082763,23.568130,3.991189);
	houseid = CreateHouse(2388.066162,-1279.455810,25.129104,M(5));
			AddHouseCar(houseid,2375.966796,-1280.647705,23.569505,5.298601);
	houseid = CreateHouse(2433.731201,-1274.947021,24.756660,M(5));
			AddHouseCar(houseid,2446.253173,-1271.455078,23.567348,187.813247);
	houseid = CreateHouse(2434.809570,-1289.398437,25.347854,M(5));
			AddHouseCar(houseid,2445.241455,-1286.568603,23.575069,183.539794);
	houseid = CreateHouse(2434.373535,-1303.465332,24.962213,M(5));
			AddHouseCar(houseid,2445.920898,-1302.933471,23.563137,181.078903);
	houseid = CreateHouse(2434.710205,-1320.760009,24.900327,M(5));
			AddHouseCar(houseid,2445.870605,-1324.008056,23.563102,192.872436);
	houseid = CreateHouse(2470.096435,-1295.274536,30.233222,M(5));
			AddHouseCar(houseid,2456.265380,-1294.774780,23.574388,359.007446);
	houseid = CreateHouse(2468.966308,-1278.356445,30.366352,M(5));
			AddHouseCar(houseid,2456.332275,-1281.223266,23.571895,0.580062);
	houseid = CreateHouse(2472.773437,-1238.593994,32.569477,M(5));
			AddHouseCar(houseid,2478.167236,-1251.469116,28.251792,271.262695);
	houseid = CreateHouse(2491.932128,-1239.283935,37.905414,M(5));
			AddHouseCar(houseid,2501.073486,-1251.467407,34.335140,272.050201);
	houseid = CreateHouse(2091.481689,-1185.094116,27.057060,M(5));
			AddHouseCar(houseid,2075.694580,-1183.232299,23.316358,187.520980);
	houseid = CreateHouse(2092.019287,-1166.182617,26.585937,M(5));
			AddHouseCar(houseid,2089.115478,-1170.694091,25.155261,91.348854);
	houseid = CreateHouse(2095.357910,-1144.968505,26.592920,M(5));
			AddHouseCar(houseid,2090.812744,-1141.390747,25.251192,88.081100);
	houseid = CreateHouse(2093.844482,-1123.680908,27.689872,M(5));
			AddHouseCar(houseid,2076.049560,-1121.822143,23.669805,1.984069);
	houseid = CreateHouse(2045.290527,-1115.037719,26.361747,M(5));
			AddHouseCar(houseid,2051.176269,-1113.645629,25.053419,180.199142);
	houseid = CreateHouse(2022.761718,-1120.267578,26.421045,M(5));
			AddHouseCar(houseid,2031.545288,-1131.255004,24.191556,90.276016);
	houseid = CreateHouse(1999.823120,-1114.823486,27.131803,M(5));
			AddHouseCar(houseid,2011.084472,-1115.097900,25.918769,176.425613);
	houseid = CreateHouse(1956.019531,-1115.396850,27.830497,M(5));
			AddHouseCar(houseid,1950.290527,-1130.891357,25.311037,94.646568);
	houseid = CreateHouse(1939.239746,-1114.483276,27.452295,M(5));
			AddHouseCar(houseid,1934.671264,-1118.000732,26.126647,179.279296);
	houseid = CreateHouse(1922.114257,-1114.974243,27.088310,M(5));
			AddHouseCar(houseid,1919.531860,-1129.921997,24.582542,94.019721);
	houseid = CreateHouse(1905.747314,-1113.300048,26.664062,M(5));
			AddHouseCar(houseid,1910.685058,-1116.907592,25.329109,178.947875);
	houseid = CreateHouse(1886.667236,-1113.661621,26.275810,M(5));
			AddHouseCar(houseid,1888.068481,-1130.023925,23.758075,86.310020);

/*                   END LS HOUSES                  */
#endif
return 1;
}


stock CreateHouse(Float:HX,Float:HY,Float:HZ,CENA){
HouseCount++;

if(HouseCount > MAX_HOUSES){
print("MAX. PoËet domov bol prekroËen˝. Server bol vypnut˝ !");
SendRconCommand("exit");
}

HouseInfo[HouseCount][p_X] = HX;
HouseInfo[HouseCount][p_Y] = HY;
HouseInfo[HouseCount][p_Z] = HZ;
HouseInfo[HouseCount][Cena]= CENA;
HouseInfo[HouseCount][VW]  = HouseCount;
new s[100];
format(s,100,"Houses/House%d.txt",HouseCount);
if(!fexist(s)){
dini_Create(s);
dini_Set(s,"Owner","none");
dini_Set(s,"Pass","none");
dini_BoolSet(s,"Locked",false);
dini_IntSet(s,"Interior",3);
dini_IntSet(s,"Money",0);

dini_IntSet(s,"Camera",0);
dini_IntSet(s,"Dog",0);
dini_IntSet(s,"TermoSenzor",0);
dini_IntSet(s,"WalkSenzor",0);
dini_IntSet(s,"StrongDoors",0);

new asdf[15];
for(new i;i <= MAX_WEAPON_SLOT;i++){
format(asdf,10,"Weapon%d",i);
dini_IntSet(s,asdf,0);
format(asdf,15,"WeaponAmmo%d",i);
dini_IntSet(s,asdf,0);
}
for(new i;i <= MAX_SKIN_SLOT;i++){
format(asdf,10,"Skin%d",i);
dini_IntSet(s,asdf,-1);
}
dini_Write();
}
HouseInfo[HouseCount][IntTyp] = dini_Int(s,"Interior");
HouseInfo[HouseCount][HousePick] = CreatePickup(1277,1,HouseInterior[HouseInfo[HouseCount][IntTyp]][P_X],HouseInterior[HouseInfo[HouseCount][IntTyp]][P_Y],HouseInterior[HouseInfo[HouseCount][IntTyp]][P_Z],HouseInfo[HouseCount][VW]);
format(HouseInfo[HouseCount][Password],32,dini_Get(s,"Pass"));
new asdf[15];
for(new i;i < MAX_WEAPON_SLOT;i++){
format(asdf,10,"Weapon%d",i);
HouseInfo[HouseCount][Weapon][i] = dini_Int(s,asdf);
format(asdf,15,"WeaponAmmo%d",i);
HouseInfo[HouseCount][Ammo][i] = dini_Int(s,asdf);
}
for(new i;i < MAX_SKIN_SLOT;i++){
format(asdf,10,"Skin%d",i);
HouseInfo[HouseCount][Skins][i] = dini_Int(s,asdf);
}
new sx[200];
if(IsHouseForSale(HouseCount)){
format(HouseInfo[HouseCount][Owner],MAX_PLAYER_NAME,"Nikto");
HouseInfo[HouseCount][Zamek] = false;
HouseInfo[HouseCount][Pickup] = CreatePickup(1273,1,HX, HY, HZ);
format(sx,200,"{FFFFFF}Dom {0000FF}Ë.%d\r\n{FFFFFF}Majiteæ: {0000FF}Nikto\r\n{FFFFFF}Cena: {0000FF}%d",HouseCount,CENA);
HouseInfo[HouseCount][Text] = Create3DTextLabel(sx,0xFF0000FF,HX,HY,HZ+1,50,0);

}else{
if(dini_Int(s,"Locked")) HouseInfo[HouseCount][Zamek] = true;
else HouseInfo[HouseCount][Zamek]=false;
HouseInfo[HouseCount][Pickup] = CreatePickup(1272,1,HX, HY, HZ);
format(HouseInfo[HouseCount][Owner],MAX_PLAYER_NAME,"%s",dini_Get(s,"Owner"));
format(sx,200,"{FFFFFF}Dom {0000FF}\tË.%d\r\n{FFFFFF}Majiteæ: {0000FF}\t%s\r\n{FFFFFF}Park. miest: {0000FF}\t%d\r\n{FFFFFF}Locked: {0000FF}\t%s",HouseCount,HouseInfo[HouseCount][Owner],HouseInfo[HouseCount][CarSlots]+1,YesNo(HouseInfo[HouseCount][Zamek]));
HouseInfo[HouseCount][Text] = Create3DTextLabel(sx,0xFF0000FF,HX,HY,HZ+1,50,0);
}
return HouseCount;
}
stock AddHouseCar(houseid,Float:vX,Float:vY,Float:vZ,Float:vA){
new HC = HouseInfo[houseid][CarSlots];
if(HC > MAX_CARS) return 0;
VX[houseid][HC] = vX;
VY[houseid][HC] = vY;
VZ[houseid][HC] = vZ;
VA[houseid][HC] = vA;

new s[100];
format(s,100,"Houses/House%d.Car%d.txt",houseid,HC);
if(!fexist(s)){
dini_Create(s);
dini_IntSet(s,"Auto",0);
dini_IntSet(s,"Vehicle",0);
dini_IntSet(s,"Color1",0);
dini_IntSet(s,"Color2",0);
dini_IntSet(s,"Paintjob",-1);
dini_IntSet(s,"Tuning1",0);
dini_IntSet(s,"Tuning2",0);
dini_IntSet(s,"Tuning3",0);
dini_IntSet(s,"Tuning4",0);
dini_IntSet(s,"Tuning5",0);
dini_IntSet(s,"Tuning6",0);
dini_IntSet(s,"Tuning7",0);
dini_IntSet(s,"Tuning8",0);
dini_IntSet(s,"Tuning9",0);
dini_IntSet(s,"Tuning10",0);
dini_IntSet(s,"Tuning11",0);
dini_IntSet(s,"Tuning12",0);
dini_IntSet(s,"Tuning13",0);
dini_IntSet(s,"Tuning14",0);
dini_IntSet(s,"Tuning15",0);
dini_IntSet(s,"Tuning16",0);
dini_IntSet(s,"Tuning17",0);
dini_Write();
}
if(!IsHouseForSale(houseid)){
new sx[200];
format(sx,200,"{FFFFFF}Dom {0000FF}\tË.%d\r\n{FFFFFF}Majiteæ: {0000FF}\t%s\r\n{FFFFFF}Park. miest: {0000FF}\t%d\r\n{FFFFFF}Locked: {0000FF}\t%s\r\n{FFFFFF}Stav: {0000FF}\tPredan˝",houseid,HouseInfo[houseid][Owner],HouseInfo[houseid][CarSlots]+1,YesNo(HouseInfo[houseid][Zamek]));
Update3DTextLabelText(HouseInfo[houseid][Text],0xFF0000FF,sx);
}else{
new sx[200];
format(sx,200,"{FFFFFF}Dom {0000FF}\tË.%d\r\n{FFFFFF}Majiteæ: {0000FF}\tNikto\r\n{FFFFFF}Cena: {0000FF}\t%d\r\n{FFFFFF}Park. miest: {0000FF}\t%d\r\n{FFFFFF}Stav: {0000FF}\tNa predaj",houseid,HouseInfo[houseid][Cena],HouseInfo[houseid][CarSlots]+1);
Update3DTextLabelText(HouseInfo[houseid][Text],0xFF0000FF,sx);
}
if(dini_Int(s,"Auto") == 1){
Color1[houseid][HC]=dini_Int(s,"Color1");
Color2[houseid][HC]=dini_Int(s,"Color2");
Paintjob[houseid][HC]=dini_Int(s,"Paintjob");
Vmod[0][houseid][HC]=dini_Int(s,"Tuning1");
Vmod[1][houseid][HC]=dini_Int(s,"Tuning2");
Vmod[2][houseid][HC]=dini_Int(s,"Tuning3");
Vmod[3][houseid][HC]=dini_Int(s,"Tuning4");
Vmod[4][houseid][HC]=dini_Int(s,"Tuning5");
Vmod[5][houseid][HC]=dini_Int(s,"Tuning6");
Vmod[6][houseid][HC]=dini_Int(s,"Tuning7");
Vmod[7][houseid][HC]=dini_Int(s,"Tuning8");
Vmod[8][houseid][HC]=dini_Int(s,"Tuning9");
Vmod[9][houseid][HC]=dini_Int(s,"Tuning10");
Vmod[10][houseid][HC]=dini_Int(s,"Tuning11");
Vmod[11][houseid][HC]=dini_Int(s,"Tuning12");
Vmod[12][houseid][HC]=dini_Int(s,"Tuning13");
Vmod[13][houseid][HC]=dini_Int(s,"Tuning14");
Vmod[14][houseid][HC]=dini_Int(s,"Tuning15");
Vmod[15][houseid][HC]=dini_Int(s,"Tuning16");
Vmod[16][houseid][HC]=dini_Int(s,"Tuning17");
Vehicle[houseid][HC] = CreateVehicle(dini_Int(s,"Vehicle"),vX,vY,vZ,vA,Color1[houseid][HC],Color2[houseid][HC],-1);
TuneThisCar(houseid,HC,Vehicle[houseid][HC]);
}
HouseInfo[houseid][CarSlots]++;
return 0;
}


public OnPlayerStateChange(playerid,newstate,oldstate)
{
if(newstate == PLAYER_STATE_DRIVER){
new vehicleid = GetPlayerVehicleID(playerid);
for(new h; h < HouseCount+1;h++){
for(new vehicl; vehicl < MAX_CARS+1;vehicl++){

if(vehicleid == Vehicle[h][vehicl]){
if(!IsPlayerHouseOwner(playerid,h)){
RemovePlayerFromVehicle(playerid);
}
}
}
}
}
return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
if(newkeys == KEY_WALK){
new a = GetPlayerHouse(playerid);
if(a > -1){
SetPVarInt(playerid, "HouseID",a);
ShowedPlayerDialog[playerid] = false;
if(IsHouseForSale(a)){
ShowPlayerDialogEx(playerid,HOUSE_DIALOG,DIALOG_STYLE_LIST,"House","{00FF00}K˙più\n{FF0000}Predaù\n{FF0000}Zamkn˙ù\n{FF0000}Odomkn˙ù\n{FF0000}Aut·\n{00FF00}Vst˙più");
}else{
if(IsPlayerHouseOwner(playerid,a)){
ShowPlayerDialogEx(playerid,HOUSE_DIALOG,DIALOG_STYLE_LIST,"House","{00FF00}K˙più\n{00FF00}Predaù\n{00FF00}Zamkn˙ù\n{00FF00}Odomkn˙ù\n{00FF00}Aut·\n{00FF00}Vst˙più");
}else{
ShowPlayerDialogEx(playerid,HOUSE_DIALOG,DIALOG_STYLE_LIST,"House","{FF0000}K˙più\n{FF0000}Predaù\n{FF0000}Zamkn˙ù\n{FF0000}Odomkn˙ù\n{FF0000}Aut·\n{00FF00}Vst˙più\n{0000FF}Vl˙paù sa");
}
}
}
}

if(newkeys == 16)
{
if(InHouse[playerid] != -1 && !ShowedPlayerDialog[playerid]){
new HouseId = InHouse[playerid];
new TYPE = HouseInfo[HouseId][IntTyp];
if(IsPlayerInRangeOfPoint(playerid,10,HouseInterior[TYPE][I_X],HouseInterior[TYPE][I_Y],HouseInterior[TYPE][I_Z]))
{
SetPlayerPos(playerid,HouseInfo[HouseId][p_X],HouseInfo[HouseId][p_Y],HouseInfo[HouseId][p_Z]);
SetPlayerInterior(playerid,0);
SetPlayerVirtualWorld(playerid,0);
InHouse[playerid] = -1;
}
}
}
return 1;
}

public OnPlayerSpawn(playerid){

if(InHouse[playerid] != -1){
SetPlayerInterior(playerid, 0);
SetPlayerVirtualWorld(playerid,0);
InHouse[playerid] = -1;
}
if(SetSpawn[playerid] != -1){
new houseid = SetSpawn[playerid];
InHouse[playerid] = houseid;
new TYPE = HouseInfo[houseid][IntTyp];
SetPlayerPos(playerid, HouseInterior[TYPE][I_X],HouseInterior[TYPE][I_Y],HouseInterior[TYPE][I_Z]);
SetPlayerInterior(playerid, HouseInterior[TYPE][Int]);
SetPlayerVirtualWorld(playerid,HouseInfo[houseid][VW]);
}
}
public OnPlayerPickUpPickup(playerid, pickupid)
{

if(-1 > GetPlayerHouse(playerid)){
if(!ShowedPlayerDialog[playerid])SCM(playerid,-1,"StlaË {FF0000}æav˝ alt{FFFFFF} pre zobrazenie dialÛgu !");

}
if(InHouse[playerid] != -1){
if(HouseInfo[InHouse[playerid]][Break] && !IsPlayerHouseOwner(playerid,InHouse[playerid])){
ShowPlayerDialogEx(playerid,HOUSE_STEAL,DIALOG_STYLE_MSGBOX,"House Steal","Naozaj sa chceö pok˙siù ukradn˙ù peniaze z dom·ceho trezoru ?");
}
SetPVarInt(playerid, "HouseID", InHouse[playerid]);
ShowPlayerDialogEx(playerid,INVENTORY_MENU,DIALOG_STYLE_LIST,"House Inventory","UloûenÈ Peniaze\nObleËenie\nZbrane\nNastaviù/Zmeniù Heslo\nOchrannÈ prvky\nInteriÈr\nNastaviù spawn");
}
return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
new houseid = GetPVarInt(playerid,"HouseID");
ShowedPlayerDialog[playerid] = false;
new stri[128];
format(stri,128,"Dialogid %d | Houseid %d",dialogid,houseid);
SCM(playerid,-1,stri);
if(response){
if(dialogid == HOUSE_DIALOG){
switch(listitem){
case 0:{
if(!IsHouseForSale(houseid)) return SCM(playerid,0xFFFFFFFF,"Tento dom nieje na predaj !");
HaveNotMoney(playerid,HouseInfo[HouseCount][Cena]);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si nov˝ dom ! Heslo do domu je automaticky nastavenÈ na \"{FF0000}none{FFFFFF}\" Ak chceö heslo zmeniù, choÔ do domu a n·jdi pickup a zmeÚ heslo");

new s[128];
format(s,128,"Houses/House%d.txt",houseid);
dini_Set(s,"Owner",PlayerName(playerid));
dini_Write();
GiveMoney(playerid, -HouseInfo[houseid][Cena]);
format(HouseInfo[houseid][Owner],MAX_PLAYER_NAME,PlayerName(playerid));
new sx[200];
format(sx,200,"{FFFFFF}Dom {0000FF}\tË.%d\r\n{FFFFFF}Majiteæ: {0000FF}\t%s\r\n{FFFFFF}Park. miest: {0000FF}\t%d\r\n{FFFFFF}Locked: {0000FF}\t%s\r\n{FFFFFF}Stav: {0000FF}\tPredan˝",houseid,HouseInfo[houseid][Owner],HouseInfo[houseid][CarSlots],YesNo(HouseInfo[HouseCount][Zamek]));
Update3DTextLabelText(HouseInfo[houseid][Text],0xFF0000FF,sx);
DestroyPickup(HouseInfo[houseid][Pickup]);
HouseInfo[houseid][Pickup] = CreatePickup(1272,1,HouseInfo[houseid][p_X],HouseInfo[houseid][p_Y],HouseInfo[houseid][p_Z]);
}

case 1:{
if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");
new s[128];
format(s,128,"Houses/House%d.txt",houseid);
dini_Set(s,"Owner","none");
dini_Write();
GiveMoney(playerid, HouseInfo[houseid][Cena]/2);
SendClientMessage(playerid, 0xFFFFFFFF, "Predali ste svoj dom, bola v·m vr·ten· 1/2 ceny domu!");
new sx[200];
format(sx,200,"{FFFFFF}Dom {0000FF}\tË.%d\r\n{FFFFFF}Majiteæ: {0000FF}\tNikto\r\n{FFFFFF}Cena: {0000FF}\t%d\r\n{FFFFFF}Park. miest: {0000FF}\t%d\r\n{FFFFFF}Stav: {0000FF}\tNa Predaj",houseid,HouseInfo[houseid][Owner],HouseInfo[houseid][CarSlots]);
Update3DTextLabelText(HouseInfo[houseid][Text],0xFF0000FF,sx);
DestroyPickup(HouseInfo[houseid][Pickup]);
HouseInfo[houseid][Pickup] = CreatePickup(1273,1,HouseInfo[houseid][p_X],HouseInfo[houseid][p_Y],HouseInfo[houseid][p_Z]);
dini_IntSet(s,"Money",0);
dini_Set(s,"Pass","none");
dini_BoolSet(s,"Locked",false);
dini_IntSet(s,"Money",0);
dini_IntSet(s,"Camera",0);
dini_IntSet(s,"Dog",0);
dini_IntSet(s,"TermoSenzor",0);
dini_IntSet(s,"WalkSenzor",0);
dini_IntSet(s,"StrongDoors",0);

new asdf[10];
for(new i;i <= MAX_WEAPON_SLOT;i++){
format(asdf,10,"Weapon%d",i);
dini_IntSet(s,asdf,0);
}
for(new i;i <= MAX_SKIN_SLOT;i++){
format(asdf,10,"Skin%d",i);
dini_IntSet(s,asdf,-1);
}
dini_Write();
for(new i;i<HouseInfo[houseid][CarSlots];i++){
if(Vehicle[houseid][i]!=0){
format(s,100,"Houses/House%d.Car%d.txt",houseid,i);
DestroyVehicle(Vehicle[houseid][i]);
Vehicle[houseid][i] = 0;
dini_IntSet(s,"Auto",0);
dini_IntSet(s,"Vehicle",0);
dini_IntSet(s,"Color1",0);
dini_IntSet(s,"Color2",0);
dini_IntSet(s,"Paintjob",-1);
dini_IntSet(s,"Tuning1",0);
dini_IntSet(s,"Tuning2",0);
dini_IntSet(s,"Tuning3",0);
dini_IntSet(s,"Tuning4",0);
dini_IntSet(s,"Tuning5",0);
dini_IntSet(s,"Tuning6",0);
dini_IntSet(s,"Tuning7",0);
dini_IntSet(s,"Tuning8",0);
dini_IntSet(s,"Tuning9",0);
dini_IntSet(s,"Tuning10",0);
dini_IntSet(s,"Tuning11",0);
dini_IntSet(s,"Tuning12",0);
dini_IntSet(s,"Tuning13",0);
dini_IntSet(s,"Tuning14",0);
dini_IntSet(s,"Tuning15",0);
dini_IntSet(s,"Tuning16",0);
dini_IntSet(s,"Tuning17",0);
dini_Write();
}}
}
case 2:{
if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");
new s[128];
format(s,128,"Houses/House%d.txt",houseid);
dini_BoolSet(s,"Locked",true);
dini_Write();
HouseInfo[houseid][Zamek] = true;
new sx[200];
format(sx,200,"{FFFFFF}Dom {0000FF}\tË.%d\r\n{FFFFFF}Majiteæ: {0000FF}\t%s\r\n{FFFFFF}Park. miest: {0000FF}\t%d\r\n{FFFFFF}Locked: {0000FF}\t¡no\r\n{FFFFFF}Stav: {0000FF}\tPredan˝",houseid,HouseInfo[houseid][Owner],HouseInfo[houseid][CarSlots]);
Update3DTextLabelText(HouseInfo[houseid][Text],0xFF0000FF,sx);
HouseInfo[houseid][Break] = false;
SendClientMessage(playerid, 0xFFFFFFFF, "Dom ˙speöne zamknut˝ !");
}

case 3:{
if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");
new s[128];
format(s,128,"Houses/House%d.txt",houseid);
dini_BoolSet(s,"Locked",false);
dini_Write();
HouseInfo[houseid][Zamek] = false;
new sx[200];
format(sx,200,"{FFFFFF}Dom {0000FF}\tË.%d\r\n{FFFFFF}Majiteæ: {0000FF}\t%s\r\n{FFFFFF}Park. miest: {0000FF}\t%d\r\n{FFFFFF}Locked: {0000FF}\tNie\r\n{FFFFFF}Stav: {0000FF}\tPredan˝",houseid,HouseInfo[houseid][Owner],HouseInfo[houseid][CarSlots]);
Update3DTextLabelText(HouseInfo[houseid][Text],0xFF0000FF,sx);
HouseInfo[houseid][Break] = false;
SendClientMessage(playerid, 0xFFFFFFFF, "Dom ˙speöne odomknut˝ !");
}
case 4:{
if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");
new string1[256],string2[100];

for(new i;i<HouseInfo[houseid][CarSlots];i++){
if(Vehicle[houseid][i]==0){ format(string2,100,"- éiadne Vozidlo -\n");
}else format(string2,100,"%s\n",vehName[GetVehicleModel(Vehicle[houseid][i])-400]);
format(string1,256,"%s%s",string1,string2);
}
ShowPlayerDialogEx(playerid,CAR_DIALOG,DIALOG_STYLE_LIST,"Vehicles",string1);

}

case 5:{
if(!IsPlayerHouseOwner(playerid,houseid)){
if(HouseInfo[houseid][Zamek]){
ShowPlayerDialogEx(playerid,PASS_PRESS,1,"House Password","Dom je zamknut˝, pre vstup musÌö zadaù heslo !");
}else{
new TYPE = HouseInfo[houseid][IntTyp];
SetPlayerPos(playerid, HouseInterior[TYPE][I_X],HouseInterior[TYPE][I_Y],HouseInterior[TYPE][I_Z]);
SetPlayerInterior(playerid, HouseInterior[TYPE][Int]);
SetPlayerVirtualWorld(playerid,HouseInfo[houseid][VW]);
InHouse[playerid] = houseid;
SendClientMessage(playerid, 0xFFFFFFFF, "Dom opustÌö kl·vesou ENTER (alebo F) !");
}
}else{
new TYPE = HouseInfo[houseid][IntTyp];
SetPlayerPos(playerid, HouseInterior[TYPE][I_X],HouseInterior[TYPE][I_Y],HouseInterior[TYPE][I_Z]);
SetPlayerInterior(playerid, HouseInterior[TYPE][Int]);
SetPlayerVirtualWorld(playerid,HouseInfo[houseid][VW]);
InHouse[playerid] = houseid;
SendClientMessage(playerid, 0xFFFFFFFF, "Dom opustÌö kl·vesou ENTER (alebo F) !");
//PASS_PRESS
}
}
case 6:{
if(!HouseInfo[houseid][Zamek]) return SendClientMessage(playerid, 0xFFFFFFFF, "Dom nieje zamknut˝");
new s[128];
format(s,128,"Houses/House%d.txt",houseid);
new camera = dini_Int(s,"Camera");
new dog = dini_Int(s,"Dog");
new termo = dini_Int(s,"TermoSenzor");
new walk = dini_Int(s,"WalkSenzor");
new door = dini_Int(s,"StrongDoors");
new randomopen = camera+dog+termo+walk+door;

switch(random(randomopen+2)){
case 0:{
HouseInfo[houseid][Break] = true;
new TYPE = HouseInfo[houseid][IntTyp];
SetPlayerPos(playerid, HouseInterior[TYPE][I_X],HouseInterior[TYPE][I_Y],HouseInterior[TYPE][I_Z]);
SetPlayerInterior(playerid, HouseInterior[TYPE][Int]);
SetPlayerVirtualWorld(playerid,HouseInfo[houseid][VW]);
InHouse[playerid] = houseid;
SendClientMessage(playerid, 0xFFFFFFFF, "{00FF00}BravÛ{FFFFFF} Podarilo sa ti vyp·Ëiù dvere ! {0000FF}Ukradni Ëo mÙûeö {FFFFFF}!");
SendClientMessage(playerid, 0xFFFFFFFF, "Dom opustÌö kl·vesou ENTER (alebo F) !");
dini_BoolSet(s,"Locked",false);

}
default:{
switch(random(3)){
case 0:{
SendClientMessage(playerid, 0xFFFFFFFF, "Podarilo sa ti vyp·Ëiù dvere, ale za dverami bola nastraûen· piötoæ ktor· ùa zabila !");
GivePlayerHealth(playerid,-100);
}
case 1:{
SendClientMessage(playerid, 0xFFFFFFFF, "Nepodarilo sa ti vyp·Ëiù dvere, kusol ùa str·ûny pes!");
GivePlayerHealth(playerid,-GetHealth(playerid));
}
case 2:{
SendClientMessage(playerid, 0xFFFFFFFF, "Nepodarilo sa ti vyp·Ëiù dvere!");
}
}
}

}

}
}}

if(dialogid == HOUSE_STEAL){
new s[128];
format(s,128,"Houses/House%d.txt",houseid);
new Money = dini_Int(s,"Money");
switch(random(2)){
case 0:{
new thief = random(Money+Money/12);
GiveMoney(playerid,thief);
new str[128];
format(str,128,"Podarilo sa ti z domu ukradn˙ù ${FF0000}%d {FFFFFF}! R˝chlo utekaj k˝m neprÌde polÌcia !",thief);
SCM(playerid,0xFFFFFFFF,str);
dini_IntSet(s,"Money",Money-thief);
dini_Write();
HouseInfo[houseid][Break] = false;
}
default:{
SetPlayerHealth(playerid,0);
SCM(playerid,0xFFFFFFFF,"Trezor bol pod vysok˝m napetÌm a to ùa na mieste zabilo !");
}
}
}

if(dialogid == PASS_PRESS){
if(strcmp(inputtext,HouseInfo[houseid][Password],false)) return ShowPlayerDialogEx(playerid,PASS_PRESS,1,"House Password","ZlÈ heslo !");
new TYPE = HouseInfo[houseid][IntTyp];
SetPlayerPos(playerid, HouseInterior[TYPE][I_X],HouseInterior[TYPE][I_Y],HouseInterior[TYPE][I_Z]);
SetPlayerInterior(playerid, HouseInterior[TYPE][Int]);
SetPlayerVirtualWorld(playerid,HouseInfo[houseid][VW]);
InHouse[playerid] = houseid;
SendClientMessage(playerid, 0xFFFFFFFF, "Dom opustÌö kl·vesou ENTER (alebo F) !");
}

if(dialogid == CAR_DIALOG){
SetPVarInt(playerid, "CarID", listitem);
new s[100];
format(s,100,"Houses/House%d.Car%d.txt",houseid,listitem);
if(dini_Int(s,"Auto") == 1){
ShowPlayerDialogEx(playerid,VEHICLE_DIALOG,DIALOG_STYLE_LIST,"Vehicles","Opraviù\nRespawnovaù\nK˙più Tuning\nUloûiù Tuning\nPredaù");
}else{
ShowPlayerDialogEx(playerid,VEHLIST_DIALOG,DIALOG_STYLE_LIST,"Vehicles","Infernus\t1 000 000\nTurismo\t1 250 000\nNRG-500\t250 000\nPCJ-600\t100 000\nSultan\t\t750 000\nBlade\t\t800 000\nSavanna\t650 000\nRemington\t500 000\nClover\t\t450 000\nElegy\t\t900 000\nAlpha\t\t340 000\nBullet\t\t800 000\nEuros\t\t400 000\nHotring\t\t1 200 000\nJester\t\t850 000\nPhoenix\t600 000\nSuper GT\t900 000");
}
}

if(dialogid == VEHICLE_DIALOG){
new HC = GetPVarInt(playerid,"CarID");
switch(listitem){
case 0:{
HaveNotMoney(playerid,10000);
GiveMoney(playerid,-10000);
SendClientMessage(playerid, 0xFFFFFFFF, "Auto ˙speöne opravenÈ!");
RepairVehicle(Vehicle[houseid][HC]);
}

case 1:{
HaveNotMoney(playerid,5000);
GiveMoney(playerid,-5000);
new Float:health,pan,door,ligh,tire;
GetVehicleHealth(Vehicle[houseid][HC],health);
GetVehicleDamageStatus(Vehicle[houseid][HC],pan,door,ligh,tire);
SetVehicleToRespawn(Vehicle[houseid][HC]);
SetVehicleHealth(Vehicle[houseid][HC],health);
UpdateVehicleDamageStatus(Vehicle[houseid][HC],pan,door,ligh,tire);
SendClientMessage(playerid, 0xFFFFFFFF, "Auto ˙speöne respawnutÈ!");
}

case 2:{
HaveNotMoney(playerid,25000);
GiveMoney(playerid,-25000);
TuneCar(houseid,HC,Vehicle[houseid][HC]);
SendClientMessage(playerid, 0xFFFFFFFF, "Auto ˙speöne vytuningovanÈ!");
}

case 3:{
new s[100];
format(s,100,"Houses/House%d.Car%d.txt",houseid,HC);
dini_IntSet(s,"Color1",Color1[houseid][HC]);
dini_IntSet(s,"Color2",Color2[houseid][HC]);
dini_IntSet(s,"Paintjob",Paintjob[houseid][HC]);
dini_IntSet(s,"Tuning1",Vmod[0][houseid][HC]);
dini_IntSet(s,"Tuning2",Vmod[1][houseid][HC]);
dini_IntSet(s,"Tuning3",Vmod[2][houseid][HC]);
dini_IntSet(s,"Tuning4",Vmod[3][houseid][HC]);
dini_IntSet(s,"Tuning5",Vmod[4][houseid][HC]);
dini_IntSet(s,"Tuning6",Vmod[5][houseid][HC]);
dini_IntSet(s,"Tuning7",Vmod[6][houseid][HC]);
dini_IntSet(s,"Tuning8",Vmod[7][houseid][HC]);
dini_IntSet(s,"Tuning9",Vmod[8][houseid][HC]);
dini_IntSet(s,"Tuning10",Vmod[9][houseid][HC]);
dini_IntSet(s,"Tuning11",Vmod[10][houseid][HC]);
dini_IntSet(s,"Tuning12",Vmod[11][houseid][HC]);
dini_IntSet(s,"Tuning13",Vmod[12][houseid][HC]);
dini_IntSet(s,"Tuning14",Vmod[13][houseid][HC]);
dini_IntSet(s,"Tuning15",Vmod[14][houseid][HC]);
dini_IntSet(s,"Tuning16",Vmod[15][houseid][HC]);
dini_IntSet(s,"Tuning17",Vmod[16][houseid][HC]);
dini_Write();
SendClientMessage(playerid, 0xFFFFFFFF, "Tuning auta ˙speöne uloûen˝!");
}

case 4:{

new s[100];
format(s,100,"Houses/House%d.Car%d.txt",houseid,HC);
DestroyVehicle(Vehicle[houseid][HC]);
Vehicle[houseid][HC] = 0;
dini_IntSet(s,"Auto",0);
dini_IntSet(s,"Vehicle",0);
dini_IntSet(s,"Color1",0);
dini_IntSet(s,"Color2",0);
dini_IntSet(s,"Paintjob",-1);
dini_IntSet(s,"Tuning1",0);
dini_IntSet(s,"Tuning2",0);
dini_IntSet(s,"Tuning3",0);
dini_IntSet(s,"Tuning4",0);
dini_IntSet(s,"Tuning5",0);
dini_IntSet(s,"Tuning6",0);
dini_IntSet(s,"Tuning7",0);
dini_IntSet(s,"Tuning8",0);
dini_IntSet(s,"Tuning9",0);
dini_IntSet(s,"Tuning10",0);
dini_IntSet(s,"Tuning11",0);
dini_IntSet(s,"Tuning12",0);
dini_IntSet(s,"Tuning13",0);
dini_IntSet(s,"Tuning14",0);
dini_IntSet(s,"Tuning15",0);
dini_IntSet(s,"Tuning16",0);
dini_IntSet(s,"Tuning17",0);
dini_Write();
SendClientMessage(playerid, 0xFFFFFFFF, "Auto ˙speöne predanÈ!");
}
}}

if(dialogid == VEHLIST_DIALOG){
new HC = GetPVarInt(playerid,"CarID");
new s[128];
format(s,100,"Houses/House%d.Car%d.txt",houseid,HC);
if(listitem == 0){
HaveNotMoney(playerid,1000000);
Vehicle[houseid][HC] = CreateVehicle(411,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",411);
GiveMoney(playerid,-1000000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
dini_Write();
}
else if(listitem == 1){

HaveNotMoney(playerid,1250000);
Vehicle[houseid][HC] = CreateVehicle(451,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",451);
GiveMoney(playerid,-1250000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 2){
HaveNotMoney(playerid,250000);
Vehicle[houseid][HC] = CreateVehicle(522,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",522);
GiveMoney(playerid,-250000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si nov˙ motorku!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 3){
HaveNotMoney(playerid,100000);
Vehicle[houseid][HC] = CreateVehicle(461,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",461);
GiveMoney(playerid,-100000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si nov˙ motorku!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 4){
HaveNotMoney(playerid,750000);
Vehicle[houseid][HC] = CreateVehicle(560,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle", 560);
GiveMoney(playerid,-750000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 5){
HaveNotMoney(playerid,800000);
Vehicle[houseid][HC] = CreateVehicle(567,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",567);
GiveMoney(playerid,-800000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 6){
HaveNotMoney(playerid,650000);
Vehicle[houseid][HC] = CreateVehicle(534,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",534);
GiveMoney(playerid,-650000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 7){
HaveNotMoney(playerid,500000);
Vehicle[houseid][HC] = CreateVehicle(542,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",542);
GiveMoney(playerid,-500000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 8){
HaveNotMoney(playerid,450000);
Vehicle[houseid][HC] = CreateVehicle(562,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",562);
GiveMoney(playerid,-450000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 9){
HaveNotMoney(playerid,900000);
Vehicle[houseid][HC] = CreateVehicle(536,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",536);
GiveMoney(playerid,-900000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 10){
HaveNotMoney(playerid,340000);
Vehicle[houseid][HC] = CreateVehicle(602,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",602);
GiveMoney(playerid,-340000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 11){
HaveNotMoney(playerid,800000);
Vehicle[houseid][HC] = CreateVehicle(541,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",541);
GiveMoney(playerid,-800000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 12){
HaveNotMoney(playerid,400000);
Vehicle[houseid][HC] = CreateVehicle( 587,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle", 587);
GiveMoney(playerid,-400000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 13){
HaveNotMoney(playerid,1200000);
Vehicle[houseid][HC] = CreateVehicle(494,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",494);
GiveMoney(playerid,-1200000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 14){
HaveNotMoney(playerid,850000);
Vehicle[houseid][HC] = CreateVehicle(559,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle",559);
GiveMoney(playerid,-850000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 15){
HaveNotMoney(playerid,600000);
Vehicle[houseid][HC] = CreateVehicle(  603,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle", 603);
GiveMoney(playerid,-600000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
else if(listitem == 16){
HaveNotMoney(playerid,900000);
Vehicle[houseid][HC] = CreateVehicle( 506,VX[houseid][HC],VY[houseid][HC],VZ[houseid][HC],VA[houseid][HC],random(128),random(128),-1);
dini_IntSet(s,"Vehicle", 506);
GiveMoney(playerid,-900000);
SendClientMessage(playerid, 0xFFFFFFFF, "K˙pil si si novÈ auto!");
dini_IntSet(s,"Auto",1),dini_Write();
}
}

if(dialogid == INVENTORY_MENU){
if(listitem == 0){
if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");
ShowPlayerDialogEx(playerid,INVENTORY_BANK,DIALOG_STYLE_LIST,"House Bank","Vybraù Peniaze\nUloûiù Peniaze\nZostatok");
}else if(listitem == 1){

if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");
new String1[256],String2[100];
for(new i; i < MAX_SKIN_SLOT;i++){
if(HouseInfo[houseid][Skins][i] == -1){
format(String2,100,"- éiadny Skin -\n");
}else{
format(String2,100,"Skin {00FF00}%d{FFFFFF}\n",HouseInfo[houseid][Skins][i]);
}
format(String1,256,"{FFFFFF}%s%s",String1,String2);
}
ShowPlayerDialogEx(playerid,INVENTORY_SKINS,DIALOG_STYLE_LIST,"House Skins",String1);
}
else if(listitem == 2){
if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");
new String1[256],String2[100];
for(new i; i < MAX_WEAPON_SLOT;i++){
if(HouseInfo[houseid][Weapon][i] == 0){
format(String2,100,"- éiadna ZbraÚ -\n");
}else{
format(String2,100,"%s ({00FF00}%d{FFFFFF})\n",WeaponName(HouseInfo[houseid][Weapon][i]),HouseInfo[houseid][Ammo][i]);
}
format(String1,256,"{FFFFFF}%s%s",String1,String2);
}
ShowPlayerDialogEx(playerid,INVENTORY_WEAPONS,DIALOG_STYLE_LIST,"House Weapons",String1);

}else if(listitem == 3){
if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");

ShowPlayerDialogEx(playerid,PASS_SET,1,"House Password","Nastav heslo domu !");
}else if(listitem == 4){
if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");

ShowPlayerDialogEx(playerid,HOUSE_SECURITY,DIALOG_STYLE_LIST,"House Interior","{FFFFFF}Camera\t\t\t\t{FF0000}$25 000\n{FFFFFF}Pes\t\t\t\t{FF0000}$50 000\n{FFFFFF}Termo Senzory\t\t\t{FF0000}$100 000\n{FFFFFF}Senzory Pohybu\t\t{FF0000}$250 000\n{FFFFFF}Nepriestrelne dvere\t\t{FF0000}$500 000");
//HOUSE_SECURITY
//OchrannÈ prvky
}else if(listitem == 5){
if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");
ShowPlayerDialogEx(playerid,INTERIOR_SELECT,DIALOG_STYLE_LIST,"House Interior","{FFFFFF}1. Mal˝ \t\t\t$50 000\n2. Mal˝\t\t\t$100 000\n3. Mal˝\t\t\t$150 000\n4. Stredn˝\t\t$200 000\n5. Stredn˝\t\t$250 000\n6. Stredn˝\t\t$300 000\n7. Luxusn˝\t\t$450 000\n8. Luxusn˝\t\t$550 000\n9. Luxusn˝\t\t$750 000\n10. Luxusn˝\t\t$899 000\n11. Luxusn˝\t\t$950 000\n12. Luxusn˝\t\t$1 000 000");
//INTERIOR_SELECT
}else if(listitem == 6){
if(!IsPlayerHouseOwner(playerid,houseid)) return SendClientMessage(playerid, 0xFFFFFFFF, "Tento dom nieje tvoj!");
if(SetSpawn[playerid] == -1){
SetSpawn[playerid] = houseid;
SendClientMessage(playerid, 0xFFFFFFFF, "Odteraz sa budeö {0000FF}spawnovaù{FFFFFF} vo svojom {FF0000}dome{FFFFFF}!");
}else{
SetSpawn[playerid] = -1;
SendClientMessage(playerid, 0xFFFFFFFF, "Odteraz sa budeö {0000FF}nespawnovaù{FFFFFF} vo svojom {FF0000}dome{FFFFFF}!");
}
}
}


if(dialogid == HOUSE_SECURITY){

new s[100];
format(s,100,"Houses/House%d.txt",houseid);
if(listitem == 0){
HaveNotMoney(playerid,25000);
if(dini_Int(s,"Camera") == 1) return SCM(playerid,0xFFFFFFFF,"Uû m·ö kameru !");
SCM(playerid,0xFFFFFFFF,"K˙pil si si kameru !");
dini_IntSet(s,"Camera",1);
dini_Write();
GiveMoney(playerid,-25000);
}else if(listitem == 1){
HaveNotMoney(playerid,50000);
if(dini_Int(s,"Dog") == 1) return SCM(playerid,0xFFFFFFFF,"Uû m·ö psa !");
SCM(playerid,0xFFFFFFFF,"K˙pil si si psa !");
dini_IntSet(s,"Dog",1);dini_Write();
GiveMoney(playerid,-50000);
}else if(listitem == 2){
HaveNotMoney(playerid,100000);
if(dini_Int(s,"TermoSenzor") == 1) return SCM(playerid,0xFFFFFFFF,"Uû m·ö Termo Senzory !");
SCM(playerid,0xFFFFFFFF,"K˙pil si si Termo Senzory !");
dini_IntSet(s,"TermoSenzor",1);dini_Write();
GiveMoney(playerid,-100000);
}else if(listitem == 3){
HaveNotMoney(playerid,250000);
if(dini_Int(s,"WalkSenzor") == 1) return SCM(playerid,0xFFFFFFFF,"Uû m·ö Senzory Pohybu !");
SCM(playerid,0xFFFFFFFF,"K˙pil si si Senzory Pohybu !");
dini_IntSet(s,"WalkSenzor",1);dini_Write();
GiveMoney(playerid,-250000);
}else if(listitem == 4){
HaveNotMoney(playerid,500000);
if(dini_Int(s,"StrongDoors") == 1) return SCM(playerid,0xFFFFFFFF,"Uû m·ö Nepriestrelne dvere !");
SCM(playerid,0xFFFFFFFF,"K˙pil si si Nepriestrelne dvere !");
dini_IntSet(s,"StrongDoors",1);dini_Write();
GiveMoney(playerid,-500000);
}

}


if(dialogid == INTERIOR_SELECT){
switch(listitem){
//3 7 12 5 6 9(delete) 13 15 4 1 2 8 14 11    10
case 0: SellPlayerHouseInterior(playerid,houseid,3,50000);
case 1:SellPlayerHouseInterior(playerid,houseid,7,100000);
case 2:SellPlayerHouseInterior(playerid,houseid,11,150000);
case 3:SellPlayerHouseInterior(playerid,houseid,5,200000);
case 4:SellPlayerHouseInterior(playerid,houseid,6,250000);
case 5:SellPlayerHouseInterior(playerid,houseid,12,300000);
//case 6:SellPlayerHouseInterior(playerid,houseid,14,350000);
case 6:SellPlayerHouseInterior(playerid,houseid,4,450000);
case 7:SellPlayerHouseInterior(playerid,houseid,1,550000);
case 8:SellPlayerHouseInterior(playerid,houseid,2,665000);
//case 10:SellPlayerHouseInterior(playerid,houseid,8,750000);
case 9:SellPlayerHouseInterior(playerid,houseid,13,899000);
case 10:SellPlayerHouseInterior(playerid,houseid,10,950000);
case 11:SellPlayerHouseInterior(playerid,houseid,9,1000000);
}
}


if(dialogid == PASS_SET){
if(!inputtext[0]) return ShowPlayerDialogEx(playerid,PASS_SET,1,"House Password","Zabudol si napÌsaù heslo !");
if(strlen(inputtext) < 4 || strlen(inputtext) > 31) return ShowPlayerDialogEx(playerid,PASS_SET,1,"House Password","Heslo musÌ byù v rozmedzÌ od {FF0000}4{FFFFFF}-{00FF00}31");
format(HouseInfo[houseid][Password],32,"%s",inputtext);
new s[100];
format(s,100,"Houses/House%d.txt",houseid);
dini_Set(s,"Pass",inputtext);
dini_Write();
format(s,100,"Heslo domu ˙speöne nastavenÈ na \"{FF0000}%s{FFFFFF}\" Heslo {FF0000}Nezabudni {FFFFFF}!",inputtext);
SCM(playerid,0xFFFFFFFF,s);
SCM(playerid,0xFFFFFFFF,"Heslo si vyp˝ta aû keÔ bude dom {FF0000}Zamknut˝{FFFFFF} !");
}


if(dialogid == INVENTORY_BANK){
if(listitem == 0){
ShowPlayerDialogEx(playerid,INVENTORY_WITHDRAW,1,"House Bank","Koæko si prajete vybraù ?");
}else if(listitem == 1){
ShowPlayerDialogEx(playerid,INVENTORY_SAVE,1,"House Bank","Koæko si prajete uloûiù ?");
}else if(listitem == 2){
new BankMoney[128];
format(BankMoney,128,"V dome m·te ${FF0000}%d",HouseInfo[houseid][Bank]);
SCM(playerid,0xFFFFFF,BankMoney);
}
}

if(dialogid == INVENTORY_WITHDRAW){
if(!inputtext[0]) return ShowPlayerDialogEx(playerid,INVENTORY_WITHDRAW,1,"House Bank","Koæko si prajete vybraù ?\n{FF0000}MusÌö zadaù sumu !");
if(!isNumeric(inputtext)) return ShowPlayerDialogEx(playerid,INVENTORY_WITHDRAW,1,"House Bank","Koæko si prajete vybraù?\n{FF0000}MusÌö zadaù sumu{00FF00} v ËÌslach !");
new money = strval(inputtext);
if(money > HouseInfo[houseid][Bank]) return ShowPlayerDialogEx(playerid,INVENTORY_WITHDRAW,1,"House Bank","Koæko si prajete vybraù ?\n{FF0000}Nem·ö tam toæko peÚazÌ, koæko chceö vybraù !");
GiveMoney(playerid,money);
HouseInfo[houseid][Bank] -= money;
new s[100];
format(s,100,"Houses/House%d.txt",houseid);
dini_IntSet(s,"Money",HouseInfo[houseid][Bank]);
dini_Write();
new BankMoney[128];
format(BankMoney,128,"Pr·ve teraz m·te v dome ${FF0000}%d",HouseInfo[houseid][Bank]);
SCM(playerid,0xFFFFFF,BankMoney);
}


if(dialogid == INVENTORY_SAVE){
if(!inputtext[0]) return ShowPlayerDialogEx(playerid,INVENTORY_SAVE,1,"House Bank","Koæko si prajete uloûiù ?\n{FF0000}MusÌö zadaù sumu !");
if(!isNumeric(inputtext)) return ShowPlayerDialogEx(playerid,INVENTORY_SAVE,1,"House Bank","Koæko si prajete uloûiù ?\n{FF0000}MusÌö zadaù sumu{00FF00} v ËÌslach !");
new money = strval(inputtext);
if(GetPlayerMoney(playerid) < money) return ShowPlayerDialogEx(playerid,INVENTORY_SAVE,1,"House Bank","Koæko si prajete uloûiù ?\n{FF0000}Nem·ö toæko peÚazÌ, koæko chceö uloûiù !");
GiveMoney(playerid,-money);
HouseInfo[houseid][Bank] += money;
new s[100];
format(s,100,"Houses/House%d.txt",houseid);
dini_IntSet(s,"Money",HouseInfo[houseid][Bank]);
dini_Write();
new BankMoney[128];
format(BankMoney,128,"Pr·ve teraz m·te v dome ${FF0000}%d",HouseInfo[houseid][Bank]);
SCM(playerid,0xFFFFFF,BankMoney);
}

if(dialogid == INVENTORY_SKINS){
SetPVarInt(playerid, "SkinID", listitem);
if(HouseInfo[houseid][Skins][listitem] == -1){
new str[128];
format(str,100,"{FFFFFF}Prajete si uloûiù v·ö skin {FF0000}%d {FFFFFF}?",GetPlayerSkin(playerid));
ShowPlayerDialogEx(playerid,SKIN_SAVE,0,"House Skin",str);
}else{
new str[128];
format(str,100,"{FFFFFF}Obliecù skin\nUloûiù ({FF0000}%d{FFFFFF})",GetPlayerSkin(playerid));
ShowPlayerDialogEx(playerid,SKIN_LOAD,2,"House Skin",str);
}
}

if(dialogid == SKIN_SAVE){
new skinid = GetPVarInt(playerid,"SkinID");
HouseInfo[houseid][Skins][skinid] = GetPlayerSkin(playerid);
new Str[10];
new s[100];
format(s,100,"Houses/House%d.txt",houseid);
format(Str,10,"Skin%d",skinid);
dini_IntSet(s,Str,HouseInfo[houseid][Skins][skinid]);
dini_Write();
SCM(playerid,0xFFFFFFFF,"Skin ˙speöne uloûen˝ !");
}

if(dialogid == SKIN_LOAD){
new skinid = GetPVarInt(playerid,"SkinID");
if(listitem == 0){
SetPlayerSkin(playerid,HouseInfo[houseid][Skins][skinid]);
SCM(playerid,0xFFFFFFFF,"Skin obleËen˝ !");
}else{
HouseInfo[houseid][Skins][skinid] = GetPlayerSkin(playerid);
new Str[10];
new s[100];
format(s,100,"Houses/House%d.txt",houseid);
format(Str,10,"Skin%d",skinid);
dini_IntSet(s,Str,HouseInfo[houseid][Skins][skinid]);
dini_Write();
SCM(playerid,0xFFFFFFFF,"Skin ˙speöne uloûen˝ !");
}
}

if(dialogid == INVENTORY_WEAPONS){
SetPVarInt(playerid, "WeaponID", listitem);
if(HouseInfo[houseid][Weapon][listitem] == 0){ ShowPlayerDialogEx(playerid,INVENTORY_WEAP,2,"House Weapons","Uloûiù ZbraÚ");
}else{ ShowPlayerDialogEx(playerid,INVENTORY_WEAP,2,"House Weapons","Uloûiù ZbraÚ\nVybraù ZbraÚ");
}
}

if(dialogid == INVENTORY_WEAP){
if(listitem == 0){
ShowPlayerWeapons(playerid);
ShowPlayerDialogEx(playerid,WEAPON_SAVE,1,"House Weapons","{FFFFFF}Zadaj {FF0000}ID {FFFFFF}Zbrane!");
}else{
new s[100];
format(s,100,"{FFFFFF}NapÌö {FF0000}poËet {FFFFFF}n·bojov ({00FF00}M·ö uloûen˝ch {0000FF}%d{00FF00} n·bojov{FFFFFF})",HouseInfo[houseid][Ammo][GetPVarInt(playerid,"WeaponID")]);
ShowPlayerDialogEx(playerid,AMMO_LOAD,1,"House Weapons",s);
}
}

if(dialogid == AMMO_LOAD){
new weaponid = GetPVarInt(playerid,"WeaponID");
new s[100];
format(s,100,"{FFFFFF}NapÌö {FF0000}poËet {FFFFFF}n·bojov ({00FF00}M·ö uloûen˝ch {0000FF}%d{00FF00} n·bojov{FFFFFF})",HouseInfo[houseid][Ammo][weaponid]);
if(!inputtext[0]) return ShowPlayerDialogEx(playerid,AMMO_LOAD,1,"House Weapons",s);
if(!isNumeric(inputtext)) return ShowPlayerDialogEx(playerid,AMMO_LOAD,1,"House Weapons","{FFFFFF}NapÌö {FF0000}poËet {FFFFFF}n·bojov ({00FF00}V ËÌslach !{FFFFFF})");
new ammo = strval(inputtext);
if(HouseInfo[houseid][Ammo][weaponid] < ammo) return ShowPlayerDialogEx(playerid,AMMO_LOAD,1,"House Weapons","{FFFFFF}NapÌö {FF0000}poËet {FFFFFF}n·bojov ({00FF00}Nem·ö toæko n·bojov !{FFFFFF})");
GivePlayerWeapon(playerid,HouseInfo[houseid][Weapon][weaponid],ammo);
HouseInfo[houseid][Ammo][weaponid] -= ammo;
new Str[10];
format(s,100,"Houses/House%d.txt",houseid);
if(HouseInfo[houseid][Ammo][weaponid] > 0){
format(Str,10,"WeaponAmmo%d",weaponid);
dini_IntSet(s,Str,HouseInfo[houseid][Ammo][weaponid]);
}else{
format(Str,10,"WeaponAmmo%d",weaponid);
dini_IntSet(s,Str,0);
format(Str,10,"Weapon%d",weaponid);
dini_IntSet(s,Str,0);
}
dini_Write();
}

if(dialogid == WEAPON_SAVE){
new weaponid = GetPVarInt(playerid,"WeaponID");
if(!inputtext[0]) return ShowPlayerDialogEx(playerid,WEAPON_SAVE,1,"House Weapons","MusÌö zadaù {FF0000}ID {FFFFFF}Zbrane");
if(!isNumeric(inputtext)) return ShowPlayerDialogEx(playerid,WEAPON_SAVE,1,"House Weapons","MusÌö zadaù {FF0000}ID {FFFFFF}Zbrane ({FF0000}V ËÌslach !{FFFFFF})");
if(!GetPlayerWeaponEx(playerid,strval(inputtext),GetWeaponSlot(strval(inputtext) ) ) ){
ShowPlayerWeapons(playerid);
return ShowPlayerDialogEx(playerid,WEAPON_SAVE,1,"{FFFFFF}House Weapons","ZbraÚ s t˝mto {FF0000}ID {FFFFFF}nem·ö !");
}
HouseInfo[houseid][Weapon][weaponid] = strval(inputtext);
new ammostring[128],s[100],Str[15];
SCM(playerid,0xFFFFFFFF,"ZbraÚ ˙speöne uloûen· !");
format(s,100,"Houses/House%d.txt",houseid);
format(Str,15,"Weapon%d",weaponid);
dini_IntSet(s,Str,HouseInfo[houseid][Weapon][weaponid]);
dini_Write();
format(ammostring,128,"{FFFFFF}Zadaj {FF0000}PoËet {FFFFFF}N·bojov! Z vybranej zbrane m·ö {FF0000}%d {FFFFFF}n·bojov",GetPlayerWeaponAmmo(playerid,HouseInfo[houseid][Weapon][weaponid]));

ShowPlayerDialogEx(playerid,AMMO_SAVE,1,"House Weapons",ammostring);
}

if(dialogid == AMMO_SAVE){
new weaponid = GetPVarInt(playerid,"WeaponID");
new ammostring[128];

format(ammostring,128,"{FFFFFF}Zadaj {FF0000}PoËet {FFFFFF}N·bojov! Z vybranej zbrane m·ö {FF0000}%d {FFFFFF}n·bojov",GetPlayerWeaponAmmo(playerid,HouseInfo[houseid][Weapon][weaponid]));

if(!inputtext[0]){
format(ammostring,128,"{FFFFFF}Zadaj {FF0000}PoËet {FFFFFF}N·bojov! Z vybranej zbrane m·ö {FF0000}%d {FFFFFF}n·bojov ({FF0000}V ËÌslach !{FFFFFF})",GetPlayerWeaponAmmo(playerid,HouseInfo[houseid][Weapon][weaponid]));
return ShowPlayerDialogEx(playerid,AMMO_SAVE,1,"House Weapons",ammostring);
}
if(!isNumeric(inputtext)){
format(ammostring,128,"{FFFFFF}Zadaj {FF0000}PoËet {FFFFFF}N·bojov! Z vybranej zbrane m·ö {FF0000}%d {FFFFFF}n·bojov ({FF0000}V ËÌslach !{FFFFFF})",GetPlayerWeaponAmmo(playerid,HouseInfo[houseid][Weapon][weaponid]));
 return ShowPlayerDialogEx(playerid,AMMO_SAVE,1,"House Weapons",ammostring);
}
if(GetPlayerWeaponAmmo(playerid,HouseInfo[houseid][Weapon][weaponid]) < strval(inputtext)){
format(ammostring,128,"{FFFFFF}Zadaj {FF0000}PoËet {FFFFFF}N·bojov! Z vybranej zbrane m·ö {FF0000}%d {FFFFFF}n·bojov ({FF0000}Nem·ö toæko n·bojov, koæko chceö uloûiù ! !{FFFFFF})",GetPlayerWeaponAmmo(playerid,HouseInfo[houseid][Weapon][weaponid]));
return ShowPlayerDialogEx(playerid,AMMO_SAVE,1,"House Weapons",ammostring);
}
HouseInfo[houseid][Ammo][weaponid] = strval(inputtext);
RemovePlayerWeapon(playerid, HouseInfo[houseid][Weapon][weaponid],strval(inputtext));
new Str[15];
new s[100];
format(s,100,"Houses/House%d.txt",houseid);
format(Str,15,"Weapon%d",weaponid);
dini_IntSet(s,Str,HouseInfo[houseid][Weapon][weaponid]);
format(Str,15,"WeaponAmmo%d",weaponid);
dini_IntSet(s,Str,HouseInfo[houseid][Ammo][weaponid]);
dini_Write();
SCM(playerid,0xFFFFFFFF,"N·boje ˙speöne uloûenÈ !");
}
}
return 1;
}

public OnVehicleRespray(playerid,vehicleid, color1, color2)
{
for(new houseid;houseid<HouseCount+1;houseid++){
for(new i;i<HouseInfo[houseid][CarSlots];i++){
if(Vehicle[houseid][i]==vehicleid){
Color1[houseid][i] = color1;
Color2[houseid][i] = color2;
}}}
return 1;
}

public OnVehiclePaintjob(playerid,vehicleid, paintjobid)
{
for(new houseid;houseid<HouseCount+1;houseid++){
for(new i;i<HouseInfo[houseid][CarSlots];i++){
if(Vehicle[houseid][i]==vehicleid){
Paintjob[houseid][i] = paintjobid;
}}}
return 1;
}

public OnVehicleMod(playerid,vehicleid,componentid)
{
for(new houseid;houseid<HouseCount+1;houseid++){
for(new i;i<HouseInfo[houseid][CarSlots];i++){
if(Vehicle[houseid][i]==vehicleid){
new Varz=InitComponents(componentid);
switch (Varz)
{
case 0: { Vmod[0][houseid][i]=componentid; }
case 1: { Vmod[1][houseid][i]=componentid; }
case 2: { Vmod[2][houseid][i]=componentid; }
case 3: { Vmod[3][houseid][i]=componentid; }
case 4: { Vmod[4][houseid][i]=componentid; }
case 5: { Vmod[5][houseid][i]=componentid; }
case 6: { Vmod[6][houseid][i]=componentid; }
case 7: { Vmod[7][houseid][i]=componentid; }
case 8: { Vmod[8][houseid][i]=componentid; }
case 9: { Vmod[9][houseid][i]=componentid; }
case 10: { Vmod[10][houseid][i]=componentid; }
case 11: { Vmod[11][houseid][i]=componentid; }
case 12: { Vmod[12][houseid][i]=componentid; }
case 13: { Vmod[13][houseid][i]=componentid; }
case 14: { Vmod[14][houseid][i]=componentid; }
case 15: { Vmod[15][houseid][i]=componentid; }
case 16: { Vmod[16][houseid][i]=componentid; }
}
}}}

return 1;
}

public OnVehicleSpawn(vehicleid){
for(new houseid;houseid<HouseCount+1;houseid++){
for(new i;i<HouseInfo[houseid][CarSlots];i++){
if(Vehicle[houseid][i]==vehicleid){
SetTimerEx("TuneThisCar",2500,false,"iii",houseid,i,vehicleid);
}}}
}

stock SellPlayerHouseInterior(playerid,houseid,inter,suma){
HaveNotMoney(playerid,suma);
GiveMoney(playerid,-suma);
new s[100];
format(s,100,"Houses/House%d.txt",houseid);
dini_IntSet(s,"Interior",inter);
dini_Write();
HouseInfo[houseid][IntTyp] = inter;
DestroyPickup(HouseInfo[houseid][HousePick]);
HouseInfo[houseid][HousePick] = CreatePickup(1277,1,HouseInterior[inter][P_X],HouseInterior[inter][P_Y],HouseInterior[inter][P_Z],HouseInfo[houseid][VW]);
SetPlayerPos(playerid, HouseInterior[inter][I_X],HouseInterior[inter][I_Y],HouseInterior[inter][I_Z]);
SetPlayerInterior(playerid, HouseInterior[inter][Int]);
SetPlayerVirtualWorld(playerid,HouseInfo[houseid][VW]);

return true;
}

stock ShowPlayerDialogEx(playerid,id,style,a[],b[]){
if(ShowedPlayerDialog[playerid]) return false;
ShowPlayerDialog(playerid,id,style,a,b,"Vybrat","PreË");
ShowedPlayerDialog[playerid] = true;
return true;
}

stock RemovePlayerWeapon(playerid, weaponid,ammo) {
new wd[2][13];
for(new i; i<13; i++) GetPlayerWeaponData(playerid,i,wd[0][i],wd[1][i]);
ResetPlayerWeapons(playerid);
for(new i; i<13; i++){
if(wd[0][i] == weaponid){
if(wd[1][i] > ammo){
new newammo = wd[1][i]-ammo;
newammo = wd[1][i]-ammo;
GivePlayerWeapon ( playerid, wd[0][i], newammo);
continue;
}else{
continue;
}
}
GivePlayerWeapon ( playerid, wd[0][i], wd[1][i]);
}
}

stock GetPlayerWeaponAmmo(playerid,weaponid){
new wd[2][13];
for(new i; i<13; i++) GetPlayerWeaponData(playerid,i,wd[0][i],wd[1][i]);
for(new i; i<13; i++){
if(weaponid == wd[0][i]) return wd[1][i];
}
return false;
}

stock GetPlayerWeaponEx(playerid,weaponid,slot){
new wd[2];
GetPlayerWeaponData(playerid,slot,wd[0],wd[1]);
if(weaponid == wd[0] && wd[1] > 0) return true;
return false;
}
stock GivePlayerHealth(playerid,Float:Health){
new Float:Old;
GetPlayerHealth(playerid,Old);
SetPlayerHealth(playerid,Old+Health);
if(GetHealth(playerid) > 100) SetPlayerHealth(playerid,100);

}

stock GetWeaponSlot(weaponid)
{
   switch (weaponid)
   {
       case 0,1: return 0;
       case 2..9: return 1;
       case 10..15: return 10;
       case 16..18,39: return 8;
       case 22..24: return 2;
       case 25..27: return 3;
       case 28,29,32: return 4;
       case 33,34: return 6;
       case 35..38: return 7;
       case 41..43: return 9;
       case 44..46: return 11;
       default: return 12;
   }
   return 12;
}
stock PlayerName(playerid){
new name[MAX_PLAYER_NAME];
GetPlayerName(playerid,name,MAX_PLAYER_NAME);
return name;
}

stock ShowPlayerWeapons(playerid){
new weapons[13][2];
SCM(playerid,0xFFFFFFFF,"{0000FF}N·zov Zbrane{FFFFFF}({00FF00}N·boje{FFFFFF})   {FF0000}ID Zbrane");
for (new i = 0; i < 13; i++)
{
	new s[100];
	GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
	if(weapons[i][0] == 0 || weapons[i][1] == 0) continue;
	format(s,100,"{0000FF}%s{FFFFFF}({00FF00}%d{FFFFFF})   {FF0000}ID %d",WeaponName(weapons[i][0]),weapons[i][1],weapons[i][0]);
	SCM(playerid,0xFFFFFFFF,s);
}
SCM(playerid,0xFFFFFFFF,"{0000FF}N·zov Zbrane{FFFFFF}({00FF00}N·boje{FFFFFF})   {FF0000}ID {FFFFFF}Zbrane");
SCM(playerid,0xFFFFFFFF,"Ak m·ö zoznam {00FFFF}ne˙pln˝{FFFFFF}, stlaË \"{0000FF}Page up & Page down{FFFFFF}\"");
}

stock IsPlayerHouseOwner(playerid,houseid)
{
new cesta[50];
format(cesta,150,"Houses/House%d.txt",houseid);
if(strcmp(PlayerName(playerid),dini_Get(cesta,"Owner"), false) == 0) return true;
return false;
}

Float:GetHealth(playerid)
{
    new Float:h;
    GetPlayerHealth(playerid, h);
    return h;
}

stock IsHouseForSale(houseid)
{
new cesta[50];
format(cesta,150,"Houses/House%d.txt",houseid);
if(strcmp("none",dini_Get(cesta,"Owner"), false) == 0) return true;
return false;
}

stock GetPlayerHouse(playerid){
for(new h=0;h<HouseCount+1;h++)
{
if(IsPlayerInRangeOfPoint(playerid,2,HouseInfo[h][p_X],HouseInfo[h][p_Y],HouseInfo[h][p_Z]))
{
return h;
}
}
return -1;
}


stock isNumeric(const string[]) {
	new length=strlen(string);
	if (length==0) return false;
	for (new i = 0; i < length; i++) {
		if (
		(string[i] > '9' || string[i] < '0' && string[i]!='-' && string[i]!='+') // Not a number,'+' or '-'
		|| (string[i]=='-' && i!=0)                                             // A '-' but not at first.
		|| (string[i]=='+' && i!=0)                                             // A '+' but not at first.
		) return false;
	}
	if (length==1 && (string[0]=='-' || string[0]=='+')) return false;
	return true;
}

InitComponents(componentid)
{
new i;
for(i=0; i<20; i++)
{
if(spoiler[i][0]==componentid) return 0;
}
for(i=0; i<3; i++)
{
if(nitro[i][0]==componentid) { return 1; }
}
for(i=0; i<23; i++)
{
if(fbumper[i][0]==componentid) { return 2; }
}
for(i=0; i<22; i++)
{
if(rbumper[i][0]==componentid) { return 3; }
}
for(i=0; i<28; i++)
{
if(exhaust[i][0]==componentid) { return 4; }
}
for(i=0; i<2; i++)
{
if(bventr[i][0]==componentid) { return 5; }
}
for(i=0; i<2; i++)
{
if(bventl[i][0]==componentid) { return 6; }
}
for(i=0; i<4; i++)
{
if(bscoop[i][0]==componentid) { return 7; }
}
for(i=0; i<13; i++)
{
if(rscoop[i][0]==componentid) { return 8; }
}
for(i=0; i<21; i++)
{
if(lskirt[i][0]==componentid) { return 9; }
}
for(i=0; i<21; i++)
{
if(rskirt[i][0]==componentid) { return 10; }
}
if(hydraulics[0][0]==componentid) { return 11; }
if(base[0][0]==componentid) { return 12; }
for(i=0; i<2; i++)
{
if(rbbars[i][0]==componentid) { return 13; }
}
for(i=0; i<2; i++)
{
if(fbbars[i][0]==componentid) { return 14; }
}
for(i=0; i<17; i++)
{
if(wheels[i][0]==componentid) { return 15; }
}
for(i=0; i<2; i++)
{
if(lights[i][0]==componentid) { return 16; }
}
return 0;
}

public TuneThisCar(houseid,carslot,vehicleid)
{
if(Vmod[0][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[0][houseid][carslot]); }
if(Vmod[1][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[1][houseid][carslot]); }
if(Vmod[2][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[2][houseid][carslot]); }
if(Vmod[3][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[3][houseid][carslot]); }
if(Vmod[4][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[4][houseid][carslot]); }
if(Vmod[5][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[5][houseid][carslot]); }
if(Vmod[6][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[6][houseid][carslot]); }
if(Vmod[7][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[7][houseid][carslot]); }
if(Vmod[8][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[8][houseid][carslot]); }
if(Vmod[9][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[9][houseid][carslot]); }
if(Vmod[10][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[10][houseid][carslot]); }
if(Vmod[11][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[11][houseid][carslot]); }
if(Vmod[12][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[12][houseid][carslot]); }
if(Vmod[13][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[13][houseid][carslot]); }
if(Vmod[14][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[14][houseid][carslot]); }
if(Vmod[15][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[15][houseid][carslot]); }
if(Vmod[16][houseid][carslot]!=0) { AddVehicleComponent(vehicleid,Vmod[16][houseid][carslot]); }
if(Paintjob[houseid][carslot]!=-1) { ChangeVehiclePaintjob(vehicleid,Paintjob[houseid][carslot]); }
if(Color1[houseid][carslot]!=0 || Color2[houseid][carslot]!=0)
{
ChangeVehicleColor(vehicleid,Color1[houseid][carslot],Color2[houseid][carslot]);
}
return 1;
}

stock YesNo(func){
new yesno[4];
if(func == 0) format(yesno,4,"Nie");
else if(func == 1) format(yesno,4,"Ano");
return yesno;
}


stock WeaponName(weapon)
{
   new Nazev[50];

   if      (weapon ==  0) Nazev = "Nic";
   else if(weapon ==  1) Nazev = "Boxer";
   else if(weapon ==  2) Nazev = "Golfova hul";
   else if(weapon ==  3) Nazev = "Hul";
   else if(weapon ==  4) Nazev = "Nuz";
   else if(weapon ==  5) Nazev = "Baseballka";
   else if(weapon ==  6) Nazev = "Lopata";
   else if(weapon ==  7) Nazev = "Kulecnikova hul";
   else if(weapon ==  8) Nazev = "Katana";
   else if(weapon ==  9) Nazev = "Motorovka";
   else if(weapon == 10) Nazev = "Dildo";
   else if(weapon == 11) Nazev = "Dildo2";
   else if(weapon == 12) Nazev = "Vibrator";
   else if(weapon == 13) Nazev = "Vibrator2";
   else if(weapon == 14) Nazev = "Kvetiny";
   else if(weapon == 15) Nazev = "Cane";
   else if(weapon == 16) Nazev = "Granat";
   else if(weapon == 17) Nazev = "Slzny plyn";
   else if(weapon == 18) Nazev = "Molotovuv koktejl";
   else if(weapon == 22) Nazev = "Kolt45";
   else if(weapon == 23) Nazev = "Pistole s tlumicem";
   else if(weapon == 24) Nazev = "Desert Eagle";
   else if(weapon == 25) Nazev = "Shotgun";
   else if(weapon == 26) Nazev = "Sawn-off Shotgun";
   else if(weapon == 27) Nazev = "Combat Shotgun";
   else if(weapon == 28) Nazev = "Uzi";
   else if(weapon == 29) Nazev = "Mp5";
   else if(weapon == 30) Nazev = "AK47";
   else if(weapon == 31) Nazev = "M4";
   else if(weapon == 32) Nazev = "Tec9";
   else if(weapon == 33) Nazev = "Rifle";
   else if(weapon == 34) Nazev = "Sniperka";
   else if(weapon == 35) Nazev = "Raketomet";
   else if(weapon == 36) Nazev = "Teplonavadeci Raketomet";
   else if(weapon == 37) Nazev = "Plamenomet";
   else if(weapon == 38) Nazev = "Minigun";
   else if(weapon == 39) Nazev = "Satchel";
   else if(weapon == 40) Nazev = "Bomba";
   else if(weapon == 41) Nazev = "Spray";
   else if(weapon == 42) Nazev = "Hasicak";
   else if(weapon == 43) Nazev = "Fotak";
   else if(weapon == 44) Nazev = "Nocni videni";
   else if(weapon == 45) Nazev = "Infracervena vize";
   else if(weapon == 46) Nazev = "Padak";

   return Nazev;
}

stock TuneCar(houseid,carslot,carid)
{
	SetVehicleHealth(carid, 1000);
	switch( GetVehicleModel(carid))
	{
		case 400:
		{
		    AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] =1087 ;
		    AddVehicleComponent(carid,1018);//POT
			Vmod[InitComponents(1018)][houseid][carslot] = 1018;
		    AddVehicleComponent(carid,1013);//PHARE ROND
			Vmod[InitComponents(1013)][houseid][carslot] = 1013;
		    AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		    AddVehicleComponent(carid,1086);//STEREO
			Vmod[InitComponents(1086)][houseid][carslot] = 1086;
	    }
    	case 401:
		{
		    AddVehicleComponent(carid,1086);//STEREO
			Vmod[InitComponents(1086)][houseid][carslot] = 1086;
		    AddVehicleComponent(carid,1139);//SPOILER
			Vmod[InitComponents(1139)][houseid][carslot] = 1139;
		    AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		    AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1012);//CAPOT
			Vmod[InitComponents(1012)][houseid][carslot] = 1012;
		    AddVehicleComponent(carid,1013);//PHARE ROND
			Vmod[InitComponents(1013)][houseid][carslot] = 1013;
		    AddVehicleComponent(carid,1042);//CONDUITR
			Vmod[InitComponents(1042)][houseid][carslot] = 1042;
		    AddVehicleComponent(carid,1043);//CONDUITL
			Vmod[InitComponents(1043)][houseid][carslot] = 1043;
		    AddVehicleComponent(carid,1018);//POT
			Vmod[InitComponents(1018)][houseid][carslot] = 1018;
		    AddVehicleComponent(carid,1006);//TOIT
			Vmod[InitComponents(1006)][houseid][carslot] = 1006;
   		    AddVehicleComponent(carid,1007);//JUPE
			Vmod[InitComponents(1007)][houseid][carslot] = 1007;
		}
		//DUMPER
		case 406:
		{
	        AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		}
		case 444:
		{
	        AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
	        AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		}
		//FIRETRUCK
		case 407:
		{
		    AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		    AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		}
		case 578,579,580,582,583,584,585,587,588,589,596,597,
		598,599,600,601,602,603,604,605,609,568,572,574,402,
		403,404,405,408,409,410,411,412,413,414,415,416,418,
		419,421,422,423,424,426,427,428,429,431,432,433,434,
		436,437,438,439,440,441,442,443,445,451,455,456,
		457,458,459,466,467,470,474,475,477,478,479,480,482,
		483,485,486,489,492,494,495,496,498,499,500,502,503,
		504,505,506,507,508,514,515,516,517,518,524,525,526,
		527,528,529,530,531,532,533,540,541,542,543,566,544,
		545,546,547,549,550,551,552,554,555:
		{
			AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		}
		//TAXI
		case 420:
		{
			AddVehicleComponent(carid,1010);//NOS//nos
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		    AddVehicleComponent(carid,1139);//SPOILER//SPOILER//spoiler
			Vmod[InitComponents(1139)][houseid][carslot] = 1139;
		}
		//REMINGTON
		case 534:
		{
		    ChangeVehiclePaintjob(carid,2);
		    Paintjob[houseid][carslot] = 2;
		    AddVehicleComponent(carid,1180);
			Vmod[InitComponents(1180)][houseid][carslot] = 1180;
		    AddVehicleComponent(carid,1185);
			Vmod[InitComponents(1185)][houseid][carslot] = 1185;
		    AddVehicleComponent(carid,1100);
			Vmod[InitComponents(1100)][houseid][carslot] = 1100;
		    AddVehicleComponent(carid,1010);//NOS//nos
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1127);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1127)][houseid][carslot] = 1127;
		    AddVehicleComponent(carid,1101);//BAS DE CAISSE
			Vmod[InitComponents(1101)][houseid][carslot] = 1101;
		    AddVehicleComponent(carid,1122);//BAS DE CAISSE
			Vmod[InitComponents(1122)][houseid][carslot] = 1122;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		}
		//SLAMVAN
		case 535:
		{
		    ChangeVehiclePaintjob(carid,2);
		    Paintjob[houseid][carslot] = 2;
			AddVehicleComponent(carid,1109);
			Vmod[InitComponents(1109)][houseid][carslot] = 1109;
			AddVehicleComponent(carid,1115);
			Vmod[InitComponents(1115)][houseid][carslot] = 1115;
			AddVehicleComponent(carid,1117);
			Vmod[InitComponents(1117)][houseid][carslot] = 1117;
			AddVehicleComponent(carid,1010);//NOS//nos
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1114);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1114)][houseid][carslot] = 1114;
		    AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		    AddVehicleComponent(carid,1119);//BAS DE CAISSE
			Vmod[InitComponents(1119)][houseid][carslot] = 1119;
		    AddVehicleComponent(carid,1121);//BAS DE CAISSE
			Vmod[InitComponents(1121)][houseid][carslot] = 1121;
		}
		//BLADE
		case 536:
		{
		    AddVehicleComponent(carid,1010);//NOS//nos
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1183);
			Vmod[InitComponents(1183)][houseid][carslot] = 1183;
		    AddVehicleComponent(carid,1181);
			Vmod[InitComponents(1181)][houseid][carslot] = 1181;
		    AddVehicleComponent(carid,1107);//BAS DE CAISSE
			Vmod[InitComponents(1107)][houseid][carslot] = 1107;
		    AddVehicleComponent(carid,1104);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1104)][houseid][carslot] = 1104;
		    AddVehicleComponent(carid,1108);//BAS DE CAISSE
			Vmod[InitComponents(1108)][houseid][carslot] = 1108;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		}
		//MONSTERA
		case 556,557:
		{
			AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		}
		//URANUS
		case 558:
		{
		    AddVehicleComponent(carid,1092);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1092)][houseid][carslot] = 1092;
		    AddVehicleComponent(carid,1166);
			Vmod[InitComponents(1166)][houseid][carslot] = 1166;
		    AddVehicleComponent(carid,1165);
			Vmod[InitComponents(1165)][houseid][carslot] = 1165;
		    AddVehicleComponent(carid,1090);//BAS DE CAISSE
			Vmod[InitComponents(1090)][houseid][carslot] = 1090;
		    AddVehicleComponent(carid,1094);//BAS DE CAISSE
			Vmod[InitComponents(1094)][houseid][carslot] = 1094;
		    AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1163);//SPOILER
			Vmod[InitComponents(1163)][houseid][carslot] = 1163;
		    AddVehicleComponent(carid,1091);//ROOF
			Vmod[InitComponents(1091)][houseid][carslot] = 1091;
		    ChangeVehiclePaintjob(carid,2);
		    Paintjob[houseid][carslot] = 2;
		}
		//JESTER
		case 559:
		{
		    AddVehicleComponent(carid,1070);//BAS DE CAISSE
			Vmod[InitComponents(1070)][houseid][carslot] = 1070;
		    AddVehicleComponent(carid,1066);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1066)][houseid][carslot] = 1066;
		    AddVehicleComponent(carid,1072);//BAS DE CAISSE
			Vmod[InitComponents(1072)][houseid][carslot] = 1072;
			AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1147);//SPOILER
			Vmod[InitComponents(1147)][houseid][carslot] = 1147;
		    AddVehicleComponent(carid,1068);//ROOF
			Vmod[InitComponents(1068)][houseid][carslot] = 1068;
		    AddVehicleComponent(carid,1173);
			Vmod[InitComponents(1173)][houseid][carslot] = 1173;
		    AddVehicleComponent(carid,1161);
			Vmod[InitComponents(1161)][houseid][carslot] = 1161;
		    ChangeVehiclePaintjob(carid,1);
		    Paintjob[houseid][carslot] = 1;
		}
		//SULTAN
		case 560:
		{
		    AddVehicleComponent(carid,1028);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1028)][houseid][carslot] = 1028;
		    AddVehicleComponent(carid,1140);
			Vmod[InitComponents(1140)][houseid][carslot] = 1140;
		    AddVehicleComponent(carid,1170);
			Vmod[InitComponents(1170)][houseid][carslot] = 1170;
		    AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1139);//SPOILER
			Vmod[InitComponents(1139)][houseid][carslot] = 1139;
		    AddVehicleComponent(carid,1033);//ROOF
			Vmod[InitComponents(1033)][houseid][carslot] = 1033;
		    AddVehicleComponent(carid,1031);//BAS DE CAISSE
			Vmod[InitComponents(1031)][houseid][carslot] = 1031;
		    AddVehicleComponent(carid,1030);//BAS DE CAISSE
			Vmod[InitComponents(1030)][houseid][carslot] = 1030;
		    ChangeVehiclePaintjob(carid,1);
		    Paintjob[houseid][carslot] = 1;
		}
		//STRATUM
		case 561:
		{
		   	AddVehicleComponent(carid,1056);//BAS DE CAISSE
			Vmod[InitComponents(1056)][houseid][carslot] = 1056;
		   	AddVehicleComponent(carid,1157);
			Vmod[InitComponents(1157)][houseid][carslot] = 1157;
		    AddVehicleComponent(carid,1062);//BAS DE CAISSE
			Vmod[InitComponents(1062)][houseid][carslot] = 1062;
		    AddVehicleComponent(carid,1059);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1059)][houseid][carslot] = 1059;
			AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1146);//SPOILER
			Vmod[InitComponents(1146)][houseid][carslot] = 1146;
		    AddVehicleComponent(carid,1061);//ROOF
			Vmod[InitComponents(1061)][houseid][carslot] = 1061;
		    ChangeVehiclePaintjob(carid,2);
		    Paintjob[houseid][carslot] = 2;
		}
		//ELEGY
		case 562:
		{
		    ChangeVehiclePaintjob(carid,1);
		    Paintjob[houseid][carslot] = 1;
		    AddVehicleComponent(carid,1037);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1037)][houseid][carslot] = 1037;
		    AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1035);//ROOF
			Vmod[InitComponents(1035)][houseid][carslot] = 1035;
		    AddVehicleComponent(carid,1039);//BAS DE CAISSE
			Vmod[InitComponents(1039)][houseid][carslot] = 1039;
		    AddVehicleComponent(carid,1041);//BAS DE CAISSE
			Vmod[InitComponents(1041)][houseid][carslot] = 1041;
		    AddVehicleComponent(carid,1086);//STEREO
			Vmod[InitComponents(1086)][houseid][carslot] = 1086;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1147);//SPOILER
			Vmod[InitComponents(1147)][houseid][carslot] = 1147;
		    AddVehicleComponent(carid,1148);
			Vmod[InitComponents(1148)][houseid][carslot] = 1148;
		    AddVehicleComponent(carid,1172);
			Vmod[InitComponents(1172)][houseid][carslot] = 1172;
		}
		//FLASH
		case 565:
		{
		    ChangeVehiclePaintjob(carid,2);
		    Paintjob[houseid][carslot] = 2;
		    AddVehicleComponent(carid,1046);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1046)][houseid][carslot] = 1046;
		    AddVehicleComponent(carid,1151);
			Vmod[InitComponents(1151)][houseid][carslot] = 1151;
		    AddVehicleComponent(carid,1152);
			Vmod[InitComponents(1152)][houseid][carslot] = 1152;
		    AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1139);//SPOILER
			Vmod[InitComponents(1139)][houseid][carslot] = 1139;
		    AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		    AddVehicleComponent(carid,1053);//ROOF
			Vmod[InitComponents(1053)][houseid][carslot] = 1053;
		    AddVehicleComponent(carid,1047);//BAS DE CAISSE
			Vmod[InitComponents(1047)][houseid][carslot] = 1047;
		    AddVehicleComponent(carid,1051);//BAS DE CAISSE
			Vmod[InitComponents(1051)][houseid][carslot] = 1051;
		}
 		//SAVANNA
		case 567:
		{
		   	AddVehicleComponent(carid,1188);
			Vmod[InitComponents(1188)][houseid][carslot] = 1188;
		   	AddVehicleComponent(carid,1186);
			Vmod[InitComponents(1186)][houseid][carslot] = 1186;
		   	AddVehicleComponent(carid,1102);//BAS DE CAISSE
			Vmod[InitComponents(1102)][houseid][carslot] = 1102;
		   	AddVehicleComponent(carid,1133);//BAS DE CAISSE
			Vmod[InitComponents(1133)][houseid][carslot] = 1133;
		    AddVehicleComponent(carid,1018);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1018)][houseid][carslot] = 1018;
		    AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    ChangeVehiclePaintjob(carid,2);
		    Paintjob[houseid][carslot] = 2;
			AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
   		}
   		case 575:
   		{
		    ChangeVehiclePaintjob(carid,1);
		    Paintjob[houseid][carslot] = 1;
		    AddVehicleComponent(carid,1175);
			Vmod[InitComponents(1175)][houseid][carslot] = 1175;
		    AddVehicleComponent(carid,1177);
			Vmod[InitComponents(1177)][houseid][carslot] = 1177;
		    AddVehicleComponent(carid,1043);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1043)][houseid][carslot] = 1043;
		    AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		    AddVehicleComponent(carid,1042);//BAS DE CAISSE
			Vmod[InitComponents(1042)][houseid][carslot] = 1042;
		    AddVehicleComponent(carid,1099);//BAS DE CAISSE
			Vmod[InitComponents(1099)][houseid][carslot] = 1099;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		}
		//TORNADO
   		case 576:
		{
		    ChangeVehiclePaintjob(carid,2);
		    Paintjob[houseid][carslot] = 2;
		    AddVehicleComponent(carid,1191);
			Vmod[InitComponents(1191)][houseid][carslot] = 1191;
		    AddVehicleComponent(carid,1193);
			Vmod[InitComponents(1193)][houseid][carslot] = 1193;
		    AddVehicleComponent(carid,1010);//NOS
			Vmod[InitComponents(1010)][houseid][carslot] = 1010;
		    AddVehicleComponent(carid,1018);//POT D'ECHAPPEMMENT
			Vmod[InitComponents(1018)][houseid][carslot] = 1018;
		    AddVehicleComponent(carid,1081);//JANTE
			Vmod[InitComponents(1081)][houseid][carslot] = 1081;
		    AddVehicleComponent(carid,1087);//HYDROLIK
			Vmod[InitComponents(1087)][houseid][carslot] = 1087;
		    AddVehicleComponent(carid,1134);//BAS DE CAISSE
			Vmod[InitComponents(1134)][houseid][carslot] = 1134;
		    AddVehicleComponent(carid,1137);//BAS DE CAISSE
			Vmod[InitComponents(1137)][houseid][carslot] = 1137;
		}
	}
}

