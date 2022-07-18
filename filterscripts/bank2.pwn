#define FILTERSCRIPT

#include <a_samp>
#include <Dini2>
#include <zcmd>
#include <sscanf2>


#define crvena "{FF0000}"
#define plava "{0BE9F4}"
#define orange "{FF9900}"
#define bela "{FFFFFF}"
#define blue "{420690}"

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

//======================================================
//#define playerFile.txt			"Users/%s.ini"
//======================================================
#define DIALOG_PORT 1
//======================================================
#define SCM SendClientMessage
//======================================================
enum pInfo
{
    pAdmin,
	pBankmoney,
	pVaultpass
}
//=============VD FUELS============//
new PlayerInfo[MAX_PLAYERS][pInfo];

   //To Design team Vdfuels






//==============VD FUELS===========//
new
    DB:BANKS;

forward SaveBankAccount(playerid);
forward LoadBankAccount(playerid);
forward CreateBankAccount(playerid);

new vaultdoor;



//=====================
#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
	print("\n------------------------------------------");
	print(" Manjal Maanagaram's Bank System by: Aadhi");
	print("--------------------------------------------\n");

	BANKS = db_open("s7695_Bank.db");



    db_query(BANKS, "CREATE TABLE IF NOT EXISTS `BankAccounts` \
                    (`Name`, \
                    `Balance`)"
    );


	CreateObject(19324, 2020.18469, 1016.74817, 10.47292,   0.00000, 0.00000, 0.00000);     //ATM 1
	CreateObject(19324, 2237.02026, 1270.03088, 10.45269,   0.00000, 0.00000, 274.85358);   //ATM 2
	CreateObject(19324, 2173.86572, 1403.02820, 10.56485,   0.00000, 0.00000, 270.14719);   //ATM 3
	CreateObject(19324, 1931.21582, 1371.86511, 8.93102,   0.00000, 0.00000, 90.38221);     //ATM 4
	CreateObject(19324, 2294.05127, 1542.85168, 10.50197,   0.00000, 0.00000, 0.51010);     //ATM 5
	CreateObject(19324, 12154.78809, 442.86057, -2370.30957,   0.00000, 0.00000, 0.00000);  //ATM 6
	CreateObject(19324, 2493.21704, 1640.57593, 10.52260,   0.00000, 0.00000, 269.73959);   //ATM 7

	//Bank LV
	CreateObject(19324, 2020.18469, 1016.74817, 10.47292,   0.00000, 0.00000, 0.00000);
	CreateObject(19324, 2237.02026, 1270.03088, 10.45269,   0.00000, 0.00000, 274.85358);
	CreateObject(19324, 2173.86572, 1403.02820, 10.56485,   0.00000, 0.00000, 270.14719);
	CreateObject(19324, 1931.21582, 1371.86511, 8.93102,   0.00000, 0.00000, 90.38221);
	CreateObject(19324, 2294.05127, 1542.85168, 10.50197,   0.00000, 0.00000, 0.51010);
	CreateObject(19324, 12154.78809, 442.86057, -2370.30957,   0.00000, 0.00000, 0.00000);
	CreateObject(19324, 2493.21704, 1640.57593, 10.52260,   0.00000, 0.00000, 269.73959);
	CreateObject(8650, 2377.77002, 1507.97998, 10.83000,   0.00000, 0.00000, 0.00000);
	CreateObject(8650, 2377.76001, 1500.41003, 10.83000,   0.00000, 0.00000, 0.00000);
	CreateObject(8650, 2377.77002, 1498.48999, 10.83000,   0.00000, 0.00000, 0.00000);
	CreateObject(8650, 2393.42993, 1483.56995, 10.84000,   0.00000, 0.00000, 89.75000);
	CreateObject(8650, 2402.22998, 1483.53003, 10.84000,   0.00000, 0.00000, 89.75000);
	CreateObject(8650, 2394.15991, 1522.90002, 10.83000,   0.00000, 0.00000, 269.73001);
	CreateObject(7922, 2378.53003, 1522.34998, 11.13000,   0.00000, 0.00000, 0.00000);
	CreateObject(7922, 2378.37012, 1484.40002, 11.13000,   0.00000, 0.00000, 90.43000);
	CreateObject(7922, 2416.38989, 1522.06006, 11.13000,   0.00000, 0.00000, 270.26001);
	CreateObject(7922, 2416.32007, 1484.08997, 11.13000,   0.00000, 0.00000, 180.17000);
	CreateObject(8650, 2401.45996, 1522.87000, 10.83000,   0.00000, 0.00000, 269.73001);
	CreateObject(10060, 2389.57007, 1503.35999, -13.04000,   0.00000, 0.00000, 0.00000);
	CreateObject(6391, 2391.25146, 1504.32324, -21.87426,   0.00000, 0.00000, 10.07301);
	CreateObject(1557, 2419.13989, 1499.12000, 9.80000,   0.00000, 0.00000, 89.29000);
	CreateObject(1557, 2419.15991, 1499.45996, 9.80000,   0.00000, 0.00000, 89.29000);
	CreateObject(1557, 2419.18994, 1500.59998, 9.80000,   0.00000, 0.00000, 89.29000);
	CreateObject(1557, 2419.22998, 1504.70996, 9.80000,   0.00000, 0.00000, 269.79001);
	CreateObject(1557, 2419.18994, 1506.75000, 9.80000,   0.00000, 0.00000, 269.79001);
	CreateObject(1557, 2419.18994, 1507.16003, 9.80000,   0.00000, 0.00000, 269.79001);
	CreateObject(1557, 2419.20996, 1501.72998, 9.80000,   0.00000, 0.00000, 89.29000);
	CreateObject(1557, 2419.21997, 1505.77002, 9.80000,   0.00000, 0.00000, 269.79001);
	CreateObject(19379, 2413.89990, 1492.94995, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2403.45996, 1492.93994, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2393.18994, 1492.92004, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2384.38989, 1493.03003, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2384.37988, 1502.53003, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2394.82690, 1500.56506, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2404.16992, 1502.54004, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2413.89990, 1502.52002, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2413.79004, 1511.70996, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2413.78003, 1513.29004, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2403.42627, 1513.40051, 9.81000,   0.00000, 90.00000, 358.97760);
	CreateObject(19379, 2403.21606, 1510.04089, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2393.23999, 1513.54004, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2393.24487, 1510.08081, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2384.55005, 1513.78003, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19379, 2384.52930, 1512.16565, 9.81000,   0.00000, 90.00000, 0.00000);
	CreateObject(19462, 2409.40283, 1510.20166, 13.40858,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2409.41675, 1503.86304, 13.39767,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2409.41309, 1496.74329, 9.89631,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2409.43164, 1496.76465, 16.85030,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2409.41675, 1503.86304, 9.89631,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2409.41675, 1503.86304, 9.89631,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2409.40283, 1510.20166, 9.99631,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2409.43164, 1496.76465, 13.38790,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2409.43164, 1496.76465, 13.38790,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2409.41675, 1503.86304, 16.85324,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2409.40283, 1510.20166, 16.82213,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2404.65137, 1514.92041, 9.89454,   0.00000, 0.00000, 270.43890);
	CreateObject(19462, 2395.16284, 1514.83752, 9.89454,   0.00000, 0.00000, 270.43890);
	CreateObject(19462, 2390.42676, 1514.80603, 9.89454,   0.00000, 0.00000, 270.43890);
	CreateObject(19462, 2404.65137, 1514.92041, 13.36305,   0.00000, 0.00000, 270.43890);
	CreateObject(19462, 2404.65137, 1514.92041, 16.80808,   0.00000, 0.00000, 270.43890);
	CreateObject(19462, 2395.16284, 1514.83752, 13.31449,   0.00000, 0.00000, 270.43890);
	CreateObject(19462, 2395.16284, 1514.83752, 16.80810,   0.00000, 0.00000, 270.43890);
	CreateObject(19462, 2390.42676, 1514.80603, 13.31426,   0.00000, 0.00000, 270.43890);
	CreateObject(19462, 2390.42676, 1514.80603, 16.80810,   0.00000, 0.00000, 270.43890);
	CreateObject(19462, 2385.70361, 1510.04102, 9.89625,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2385.70361, 1510.04102, 13.34128,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2385.70361, 1510.04102, 16.80810,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2385.70044, 1500.44177, 9.89625,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2385.70044, 1500.44177, 13.32057,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2385.70044, 1500.44177, 16.80810,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2385.71289, 1496.83643, 9.89625,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2385.71289, 1496.83643, 13.35282,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2385.71289, 1496.83643, 16.79987,   0.00000, 0.00000, 0.00000);
	CreateObject(19462, 2390.51636, 1492.09351, 9.89411,   0.00000, 0.00000, 269.84207);
	CreateObject(19462, 2400.00000, 1492.06189, 16.80810,   0.00000, 0.00000, 269.84210);
	CreateObject(19462, 2404.57666, 1492.07751, 13.37800,   0.00000, 0.00000, 269.84207);
	CreateObject(19462, 2390.51636, 1492.09351, 13.34767,   0.00000, 0.00000, 269.84207);
	CreateObject(19462, 2390.51636, 1492.09351, 16.80810,   0.00000, 0.00000, 269.84210);
	CreateObject(19462, 2400.00000, 1492.06189, 9.89411,   0.00000, 0.00000, 269.84207);
	CreateObject(19462, 2400.00000, 1492.06189, 13.36709,   0.00000, 0.00000, 269.84207);
	CreateObject(19462, 2404.57666, 1492.07751, 9.89411,   0.00000, 0.00000, 269.84207);
	CreateObject(19462, 2404.57666, 1492.07751, 16.80810,   0.00000, 0.00000, 269.84210);
	CreateObject(1557, 2409.36133, 1505.07104, 9.89413,   0.00000, 0.00000, 270.49777);
	CreateObject(1557, 2409.39063, 1502.05249, 9.88610,   0.00000, 0.00000, 90.16382);
	CreateObject(19324, 2404.23657, 1514.48254, 10.51330,   0.00000, 0.00000, 0.00000);//bank atm
	CreateObject(19324, 2401.29907, 1514.47253, 10.51328,   0.00000, 0.00000, 0.00000);//bank atm
	CreateObject(19361, 2393.31567, 1505.36072, 11.62890,   0.00000, 0.00000, 271.65930);
	CreateObject(19361, 2397.91919, 1506.77722, 11.63720,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91553, 1509.96472, 14.92640,   0.00000, 0.00000, 0.00000);
	CreateObject(19407, 2397.92090, 1504.02722, 11.63056,   0.00000, 0.00000, 0.00000);
	CreateObject(19407, 2397.92090, 1504.02722, 11.63056,   0.00000, 0.00000, 0.00000);
	CreateObject(19407, 2397.92725, 1499.02539, 11.63056,   0.00000, 0.00000, 0.00000);
	CreateObject(19407, 2397.92725, 1501.52783, 11.63056,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.94312, 1496.50867, 11.64009,   0.00000, 0.00000, 0.00000);
	CreateObject(19390, 2397.94653, 1493.70142, 11.63727,   0.00000, 0.00000, 0.20100);
	CreateObject(19361, 2397.94312, 1496.50867, 11.64009,   0.00000, 0.00000, 0.00000);
	CreateObject(19453, 2388.92969, 1500.05957, 11.64010,   0.00000, 0.00000, 180.45250);
	CreateObject(19390, 2391.81592, 1503.89368, 11.63727,   0.00000, 0.00000, 0.64897);
	CreateObject(19453, 2393.18872, 1495.32434, 11.64010,   0.00000, 0.00000, 270.37476);
	CreateObject(19453, 2388.88745, 1506.72058, 11.64010,   0.00000, 0.00000, 180.45250);
	CreateObject(19390, 2387.37988, 1495.30212, 11.63727,   0.00000, 0.00000, 270.56537);
	CreateObject(19453, 2391.75854, 1510.04956, 11.64010,   0.00000, 0.00000, 180.45250);
	CreateObject(19361, 2397.91528, 1513.16956, 11.62890,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2396.26050, 1505.44849, 11.62890,   0.00000, 0.00000, 271.65930);
	CreateObject(19361, 2396.39844, 1500.23120, 11.62890,   0.00000, 0.00000, 270.42883);
	CreateObject(19361, 2393.42529, 1502.63391, 11.64890,   0.00000, 0.00000, 270.93793);
	CreateObject(19390, 2388.83179, 1513.13953, 11.63727,   0.00000, 0.00000, 0.64897);
	CreateObject(19390, 2391.83130, 1501.30762, 11.63727,   0.00000, 0.00000, 0.64897);
	CreateObject(19390, 2391.86060, 1498.81616, 11.63727,   0.00000, 0.00000, 0.64897);
	CreateObject(19361, 2396.31299, 1502.71179, 11.62890,   0.00000, 0.00000, 271.65930);
	CreateObject(19361, 2393.37012, 1500.19849, 11.62890,   0.00000, 0.00000, 270.42883);
	CreateObject(19361, 2388.82153, 1513.11841, 14.93400,   0.00000, 0.00000, 180.46410);
	CreateObject(19361, 2393.54980, 1497.48743, 11.62890,   0.00000, 0.00000, 270.42880);
	CreateObject(19361, 2396.35718, 1497.52148, 11.62890,   0.00000, 0.00000, 270.42880);
	CreateObject(1491, 2397.92969, 1494.47473, 9.89380,   0.00000, 0.00000, 270.35712);
	CreateObject(1491, 2388.15454, 1495.30261, 9.89380,   0.00000, 0.00000, 180.61307);
	CreateObject(1491, 2388.15454, 1495.30261, 9.89380,   0.00000, 0.00000, 180.61307);
	CreateObject(1491, 2388.85718, 1512.40393, 9.87380,   0.00000, 0.00000, 90.36890);
	CreateObject(1491, 2391.83276, 1503.15186, 9.87380,   0.00000, 0.00000, 90.36890);
	CreateObject(1491, 2391.82495, 1500.54822, 9.87380,   0.00000, 0.00000, 90.36890);
	CreateObject(1491, 2391.84741, 1498.09631, 9.87380,   0.00000, 0.00000, 90.36890);
	CreateObject(3109, 2387.98413, 1514.75073, 11.09620,   0.00000, 0.00000, 90.00000);
	CreateObject(2886, 2386.75732, 1514.73071, 11.01897,   0.00000, 0.00000, 0.00000);
	CreateObject(11711, 2409.33203, 1503.53650, 12.68430,   0.00000, 0.00000, 90.00100);
	CreateObject(19329, 2402.84009, 1514.80725, 12.92283,   0.00000, 0.00000, 0.00000);
	CreateObject(19607, 2420.03564, 1503.31250, 9.81781,   0.00000, 0.00000, 0.00000);//pickup enter
	CreateObject(19605, 2408.51440, 1503.53162, 9.89769,   0.00000, 0.00000, 0.00000);//pickup exit
	CreateObject(19361, 2397.91528, 1513.16956, 14.92924,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91553, 1509.96472, 11.62890,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91528, 1503.67615, 14.92570,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91919, 1506.77722, 14.92570,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91064, 1500.51550, 14.92570,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91162, 1497.33142, 14.92570,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91333, 1494.14038, 14.92570,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91797, 1493.75732, 14.92570,   0.00000, 0.00000, 0.00000);
	CreateObject(19453, 2393.18872, 1495.32434, 14.92570,   0.00000, 0.00000, 270.37479);
	CreateObject(19361, 2387.40991, 1495.28345, 14.92570,   0.00000, 0.00000, 90.51111);
	CreateObject(19453, 2388.92969, 1500.05957, 14.93400,   0.00000, 0.00000, 180.45250);
	CreateObject(19453, 2388.88745, 1506.72107, 14.93400,   0.00000, 0.00000, 180.45250);
	CreateObject(19453, 2391.75854, 1510.04956, 14.93400,   0.00000, 0.00000, 180.45250);
	CreateObject(19453, 2391.83057, 1500.45471, 14.93400,   0.00000, 0.00000, 180.45250);
	CreateObject(19453, 2391.83301, 1500.15869, 14.93400,   0.00000, 0.00000, 180.45250);
	CreateObject(19361, 2393.54980, 1497.48743, 14.93400,   0.00000, 0.00000, 270.42880);
	CreateObject(19361, 2396.35718, 1497.52148, 14.93400,   0.00000, 0.00000, 270.42880);
	CreateObject(19361, 2393.37012, 1500.19849, 14.93400,   0.00000, 0.00000, 270.42880);
	CreateObject(19361, 2396.39844, 1500.23120, 14.93400,   0.00000, 0.00000, 270.42880);
	CreateObject(19361, 2393.42529, 1502.63391, 14.93400,   0.00000, 0.00000, 270.93790);
	CreateObject(19361, 2396.31299, 1502.71179, 14.93400,   0.00000, 0.00000, 271.65930);
	CreateObject(19361, 2393.31567, 1505.36072, 14.93400,   0.00000, 0.00000, 271.65930);
	CreateObject(19361, 2396.26050, 1505.44849, 14.93400,   0.00000, 0.00000, 271.65930);
	CreateObject(19361, 2397.91797, 1493.75732, 16.80810,   0.00000, 0.00000, 0.00000);
	CreateObject(19453, 2393.18872, 1495.32434, 16.80810,   0.00000, 0.00000, 270.37479);
	CreateObject(19361, 2397.91333, 1494.14038, 16.80810,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91162, 1497.33142, 16.80810,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91064, 1500.51550, 16.80810,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91528, 1503.67615, 16.80810,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91919, 1506.77722, 16.80810,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91553, 1509.96472, 16.80810,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2397.91528, 1513.16956, 16.80810,   0.00000, 0.00000, 0.00000);
	CreateObject(19361, 2393.31567, 1505.36072, 16.80810,   0.00000, 0.00000, 271.65930);
	CreateObject(19361, 2396.26050, 1505.44849, 16.80810,   0.00000, 0.00000, 271.65930);
	CreateObject(19453, 2391.75854, 1510.04956, 16.80810,   0.00000, 0.00000, 180.45250);
	CreateObject(19361, 2388.82153, 1513.11841, 16.80810,   0.00000, 0.00000, 180.46410);
	CreateObject(19453, 2388.88745, 1506.72107, 16.80810,   0.00000, 0.00000, 180.45250);
	CreateObject(19453, 2391.84326, 1500.19446, 16.80810,   0.00000, 0.00000, 180.45250);
	CreateObject(19361, 2393.42529, 1502.63391, 16.80810,   0.00000, 0.00000, 270.93790);
	CreateObject(19361, 2396.31299, 1502.71179, 16.80810,   0.00000, 0.00000, 271.65930);
	CreateObject(19453, 2388.92969, 1500.05957, 16.80810,   0.00000, 0.00000, 180.45250);
	CreateObject(19361, 2387.40991, 1495.28345, 16.80810,   0.00000, 0.00000, 90.51110);
	CreateObject(19361, 2393.37012, 1500.19849, 16.80810,   0.00000, 0.00000, 270.42880);
	CreateObject(19361, 2396.39844, 1500.23120, 16.80810,   0.00000, 0.00000, 270.42880);
	CreateObject(19361, 2393.54980, 1497.48743, 16.80810,   0.00000, 0.00000, 270.42880);
	CreateObject(19361, 2396.35718, 1497.52148, 16.80810,   0.00000, 0.00000, 270.42880);
	CreateObject(19453, 2391.83057, 1500.45471, 16.80810,   0.00000, 0.00000, 180.45250);
	CreateObject(19458, 2399.59937, 1496.90027, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2403.06494, 1496.90027, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2406.49414, 1496.90027, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2406.49854, 1506.46851, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2399.66431, 1506.46851, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2403.04102, 1506.46851, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2407.56323, 1496.89148, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2407.56787, 1506.46851, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2407.58569, 1510.16626, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2406.46118, 1510.16626, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2403.04102, 1510.16626, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2399.66431, 1510.16626, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2396.15527, 1496.90027, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2392.72607, 1496.90027, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2389.31128, 1496.90027, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2387.37598, 1496.90027, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2396.15527, 1506.46851, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2392.72607, 1506.46851, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2389.31128, 1506.46851, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2387.37402, 1506.46851, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2396.15527, 1510.16626, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2392.72607, 1510.16626, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2389.31128, 1510.16626, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19458, 2387.37402, 1510.16626, 14.71820,   0.00000, 90.00000, 360.00000);
	CreateObject(19324, 2402.77905, 1514.47449, 10.51328,   0.00000, 0.00000, 0.00000);//bank atm
	CreateObject(2333, 2396.31372, 1504.64014, 9.76059,   0.00000, 0.00000, 270.15750);
	CreateObject(1514, 2397.45117, 1503.70691, 10.90900,   0.00000, 0.00000, 90.76280);
	CreateObject(2333, 2396.32764, 1502.02612, 9.76059,   0.00000, 0.00000, 270.15750);
	CreateObject(1514, 2397.49219, 1501.10767, 10.90900,   0.00000, 0.00000, 90.76280);
	CreateObject(2333, 2396.40771, 1499.43811, 9.76059,   0.00000, 0.00000, 270.15750);
	CreateObject(1514, 2397.43896, 1498.51819, 10.90900,   0.00000, 0.00000, 90.76280);
	CreateObject(2332, 2395.56689, 1499.76062, 10.48190,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2395.56689, 1499.76062, 11.31000,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2394.45117, 1499.76062, 10.48190,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2394.45117, 1499.76062, 11.31000,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2394.67139, 1502.15100, 10.27989,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2394.67139, 1502.15100, 11.10597,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2395.64917, 1502.16443, 10.27990,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2395.64917, 1502.16443, 11.10600,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2394.80615, 1505.06262, 10.27989,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2394.80615, 1505.06262, 11.10597,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2395.80713, 1505.06262, 11.10597,   0.00000, 0.00000, 0.00000);
	CreateObject(2332, 2395.80713, 1505.06262, 10.27989,   0.00000, 0.00000, 0.00000);
	CreateObject(1408, 2400.93359, 1497.74915, 10.45160,   0.00000, 0.00000, 0.00000);
	CreateObject(1408, 2400.93359, 1500.35425, 10.45160,   0.00000, 0.00000, 0.00000);
	CreateObject(1408, 2400.93359, 1502.77283, 10.45160,   0.00000, 0.00000, 0.00000);
	CreateObject(1408, 2400.93359, 1505.26941, 10.45160,   0.00000, 0.00000, 0.00000);
	CreateObject(1886, 2408.72070, 1492.79749, 14.76670,   18.00000, 0.00000, 220.00000);
	CreateObject(1886, 2408.81421, 1514.39490, 14.76670,   18.00000, 0.00000, 329.13556);
	CreateObject(8650, 2377.77002, 1498.48999, 10.83000,   0.00000, 0.00000, 0.00000);
	CreateObject(8650, 2416.96924, 1500.32043, 10.83000,   0.00000, 0.00000, 0.00000);
	CreateObject(8650, 2417.01245, 1505.68311, 10.83000,   0.00000, 0.00000, 0.00000);
	CreateObject(19437, 2149.90625, 1602.86072, 1002.06433,   0.00000, 0.00000, 0.00000);
	CreateObject(19437, 2148.24121, 1604.65747, 1001.95105,   0.00000, 0.00000, 89.22734);
	CreateObject(19437, 2146.21094, 1603.68140, 1002.68048,   0.00000, 0.00000, 0.00000);
	CreateObject(19437, 2146.21094, 1603.68140, 1006.17749,   0.00000, 0.00000, 0.00000);
	CreateObject(19437, 2147.79053, 1604.68579, 1006.27850,   0.00000, 0.00000, 269.43414);
	CreateObject(19437, 2146.21094, 1602.08142, 1002.68048,   0.00000, 0.00000, 0.00000);
	CreateObject(19437, 2146.21094, 1602.08142, 1006.17749,   0.00000, 0.00000, 0.00000);
	vaultdoor = CreateObject(19799, 2145.20166, 1626.94580, 994.25439,   0.00000, 180.00000, 180.00000);
	CreateObject(3109, 2149.02051, 1604.65723, 1002.16382,   0.00000, 0.00000, 88.93150);
	CreateObject(11711, 2148.26733, 1604.61987, 1003.52020,   0.00000, 0.00000, 359.29391);
	CreateObject(1537, 2149.03931, 1604.51770, 1000.97729,   0.00000, 0.00000, 0.00000);


    
	new tmpobjid;
	tmpobjid = CreateObject(19482, 2419.177734, 1503.214721, 15.071851, 0.000000, 0.000000, 0.000000, 300.00);
	SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetObjectMaterialText(tmpobjid, "{420690} MMRP BANK", 0, 120, "Ariel", 95, 1, 0x00000000, 0x00000000, 1);



	CreatePickup(1274, 1, 2398.56519, 1503.89453, 10.39840, -1);
    CreatePickup(1274, 1, 2398.58911, 1501.49072, 10.39840, -1);
    CreatePickup(1274, 1, 2398.61450, 1498.94348, 10.39840, -1);

    Create3DTextLabel("Swipe your Access Card to get access to the bank vault\n#SWIPE : Press N to swipe your access card", 0xFFFF00AA, 2386.75732, 1514.73071, 11.01897, 5.0, 0, 0);
    Create3DTextLabel("Press F to get out of the Bank Vault", 0xFFFF00AA, 2148.30103, 1604.30713, 1002.20624, 5.0, 0, 0);
	new playerid[MAX_PLAYERS];
	SetTimerEx("vdpaydaytimer", 300000,true, "i", playerid);
	return 1;
}


public OnFilterScriptExit()
{

    return 1;
}


#endif

public OnPlayerConnect(playerid)
{
    LoadBankAccount(playerid);

	RemoveBuildingForPlayer(playerid, 8956, 2397.3906, 1503.0234, 14.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 8954, 2397.3906, 1503.0234, 14.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 8955, 2393.7656, 1490.5469, 13.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 8957, 2393.7656, 1483.6875, 12.7109, 0.25);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	SaveBankAccount(playerid);
	return 1;
}


public LoadBankAccount(playerid)
{
    new
        szQuery[128],
        DBResult:result,
        rows,
        field[30];

    format(szQuery, sizeof(szQuery), "SELECT Balance FROM BankAccounts WHERE `Name` = '%s' LIMIT 1", getPlayerNameEx(playerid));

    //printf("[debug] %s", szQuery);

    result = db_query(BANKS, szQuery);
    rows = db_num_rows(result);

    if(rows)
    {
        db_get_field_assoc(result, "Balance", field, sizeof(field));            PlayerInfo[playerid][pBankmoney] = strval(field);

    }
    else {
       // PlayerBank[playerid][pBalance] = NOOB_SPAWN_CASH;

        CreateBankAccount(playerid);
    }
    db_free_result(result);
    return 1;
}

public SaveBankAccount(playerid)
{
    new
        szQuery[128];

    format(szQuery, sizeof(szQuery), "UPDATE `BankAccounts` SET Balance = %d WHERE `Name` = '%s'",
    PlayerInfo[playerid][pBankmoney],
    getPlayerNameEx(playerid)

    );

    //printf("[debug] %s", szQuery);

    db_query(BANKS, szQuery);
    return 1;
}

public CreateBankAccount(playerid)
{
    new
        szQuery[128];

    format(szQuery, sizeof(szQuery), "INSERT INTO `BankAccounts` (`Name`, `Balance`) VALUES ('%s', %d)",

    getPlayerNameEx(playerid),
    PlayerInfo[playerid][pBankmoney]


    );

    //printf("[debug] %s", szQuery);

    db_query(BANKS, szQuery);
    return 1;
}



	





public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (newkeys & KEY_SECONDARY_ATTACK)
    {
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2420.03564, 1503.31250, 9.81781))
 		{
  			SetPlayerInterior(playerid,0);
    		SetPlayerPos(playerid,2408.51440, 1503.53162, 9.89769);
     		SetCameraBehindPlayer(playerid);
      		SendClientMessage(playerid,-1,"[Bank]: Welcome!");
   		}
    	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 2408.51440, 1503.53162, 9.89769))
    	{
    		SetPlayerInterior(playerid, 0);
     		SetPlayerPos(playerid, 2420.03564, 1503.31250, 9.81781);
      		SetCameraBehindPlayer(playerid);
       		SendClientMessage(playerid,-1,"[Bank]: Good bye!");
  		}
  		else if(IsPlayerInRangeOfPoint(playerid, 3.0,2149.02051, 1604.65723, 1002.16382))
  		{
  		    SetPlayerInterior(playerid, 0);
     		SetPlayerPos(playerid, 2387.13794, 1514.00500, 11.01897);
      		SetCameraBehindPlayer(playerid);
		}
	}
    if(newkeys & KEY_NO^(2))
	
	{
   		if (IsPlayerInRangeOfPoint(playerid, 3.0, 2387.98413, 1514.75073, 11.09620))
   		{
   			if(PlayerInfo[playerid][pVaultpass] == 1)
    		{
				SendClientMessage(playerid, COLOR_GREEN, "Access Granted");
				SendClientMessage(playerid, COLOR_GREEN, "Enter the gate password");
			}
			else
			{
			 	SCM(playerid, COLOR_RED, "You Don't Have The Access Card");
			}
		}
	}
 	return 1;
}
forward vdpaydaytimer(playerid);
public vdpaydaytimer(playerid)
{
	new playername[64];
	GetPlayerName(playerid,playername,64);
	if(!strcmp(playername,"Vakil_Vandumurugan",true))
	{
	    PlayerInfo[playerid][pBankmoney] += 7000;
		SendClientMessage(playerid, COLOR_ORANGE, "PAYDAY : You recived 7000 $ to your bank");
		new string[128];
		format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
		SendClientMessage(playerid,-1,string);
	}
	else if(!strcmp(playername,"KAA_LA",true))
	{
	    PlayerInfo[playerid][pBankmoney] += 12000;
		SendClientMessage(playerid, COLOR_ORANGE, "PAYDAY : You recived 12000 $ to your bank");
		new string[128];
		format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
		SendClientMessage(playerid,-1,string);
	}
	else if(!strcmp(playername,"Mr_BLAZA",true))
	{
	    PlayerInfo[playerid][pBankmoney] += 5000;
		SendClientMessage(playerid, COLOR_ORANGE, "PAYDAY : You recived 5000 $ to your bank");
		new string[128];
		format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
		SendClientMessage(playerid,-1,string);
	}
	return 1;
}


//================================
CMD:deposit(playerid,params[])
{
    new money,string[128];
    new money1 = money;
	if(IsPlayerInRangeOfPoint(playerid,2.0,2398.56519, 1503.89453, 10.39840)) //return
	{
	    if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"{FF0000}#BANK: {FFFFFF}/deposit [Amount]");
	    if(GetPlayerMoney(playerid) < money) return SCM(playerid,-1,""crvena"#BANK: {FFFFFF}You don't have that much money!");
     //	if(money > 50000) return SendClientMessage(playerid,-1,""crvena"#ERROR:The maximum amount of money you can put in is $ 50,000! ");
	    PlayerInfo[playerid][pBankmoney] += money;
	    format(string,sizeof(string),"{FF0000}#BANK INFO: {FFFFFF}You have %s$ Money left in your Account, Your new balance is %d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,-money);
	}
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2398.58911, 1501.49072, 10.39840))
	{
	    if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"{FF0000}#BANK: {FFFFFF}/deposit [Amount]");
	    if(GetPlayerMoney(playerid) < money) return SCM(playerid,-1,""crvena"#BANK: {FFFFFF}You don't have that much money!");
     //	if(money > 50000) return SendClientMessage(playerid,-1,""crvena"#ERROR:The maximum amount of money you can put in is $ 50,000! ");
	    PlayerInfo[playerid][pBankmoney] += money;
	    format(string,sizeof(string),"{FF0000}#BANK INFO: {FFFFFF}You have %s$ Money left in your Account, Your new balance is %d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,-money);
	}
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2398.61450, 1498.94348, 10.39840))
	{
	    if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"{FF0000}#BANK: {FFFFFF}/deposit [Amount]");
	    if(GetPlayerMoney(playerid) < money) return SCM(playerid,-1,""crvena"#BANK: {FFFFFF}You don't have that much money!");
     //	if(money > 100000) return SendClientMessage(playerid,-1,""crvena"#ERROR:The maximum amount of money you can put in is $ 50,000! ");
	    PlayerInfo[playerid][pBankmoney] += money;
	    format(string,sizeof(string),"{FF0000}#BANK INFO: {FFFFFF}You have %s$ Money left in your Account, Your new balance is %d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,-money);
 	}
 	else
 	{
 	    SCM(playerid,-1,"{FF0000}#ERROR: {FFFFFF}Go to bank counter to deposit your cash! ");
	}


	return 1;
}
//======================================================
CMD:withdraw(playerid,params[])
{
    new money,string[128];
    new money1 = money;
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 2309.1948, -8.5399, 26.7422))// return SCM(playerid,-1,"Get to the bank or atm");
	{
     	if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
     	PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//ATM 1
 	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 2020.18469, 1016.74817, 10.47292))
    {
     	if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//ATM 2
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2237.02026, 1270.03088, 10.45269))// return SCM(playerid,-1,"Get to the bank or atm");
 	{

	    if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//ATM 3
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2173.86572, 1403.02820, 10.56485))// return SCM(playerid,-1,"Get to the bank or atm");
	{
 	   	if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//ATM 4
	else if(IsPlayerInRangeOfPoint(playerid,2.0,1931.21582, 1371.86511, 8.93102))
	{
        if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//ATM 5
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2294.05127, 1542.85168, 10.50197))
	{
        if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//ATM 6
	else if(IsPlayerInRangeOfPoint(playerid,2.0,12154.78809, 442.86057, -2370.30957))
	{
	    if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//ATM 7
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2493.21704, 1640.57593, 10.52260))
	{
	    if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//bank ATM 1
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2404.23657, 1514.48254, 10.51330))
	{
	    if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#BANK ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//bank ATM 2
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2401.29907, 1514.47253, 10.51328))
	{
	    if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#BANK ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//bank ATM 3
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2402.77905, 1514.47449, 10.51328))
 	{
  		if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#BANK ATM: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//bank c 1
    else if(IsPlayerInRangeOfPoint(playerid,2.0,2398.56519, 1503.89453, 10.39840))
	{
	    if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#BANK: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
	//bank c 2
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2398.58911, 1501.49072, 10.39840))
	{
	    if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#BANK: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
	}
 	//bank c 3
 	else if(IsPlayerInRangeOfPoint(playerid,2.0,2398.61450, 1498.94348, 10.39840))
 	{
        if(sscanf(params,"d",money)) return SCM(playerid,-1,""crvena"#BANK: {FFFFFF}/withdraw [Amount]");
	    if(PlayerInfo[playerid][pBankmoney] < money) return SCM(playerid,-1,""crvena"#ERROR: {FFFFFF}You don't have that much money! ");
	    PlayerInfo[playerid][pBankmoney] -= money;
	    format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}You have taken $%d from your account !, your new balance is  $%d",money1,PlayerInfo[playerid][pBankmoney]);
	    SendClientMessage(playerid,-1,string);
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 2.5, 0, 0, 0, 0, 0);
	    GivePlayerMoney(playerid,money);
 	}
 	else
	{
	    SendClientMessage(playerid,-1,"Head to the BANK or ATM to withdraw your money");
	}


	return 1;
}
//======================================================
CMD:bankbalance(playerid,params[])
{
    if(IsPlayerInRangeOfPoint(playerid,2.0,2309.1948,-8.5399,26.7422))
	{
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//ATM 1
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 2020.18469, 1016.74817, 10.47292))
    {
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//ATM 2
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2237.02026, 1270.03088, 10.45269))
 	{
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//ATM 3
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2173.86572, 1403.02820, 10.56485))
	{
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//ATM 4
	else if(IsPlayerInRangeOfPoint(playerid,2.0,1931.21582, 1371.86511, 8.93102))
	{
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//ATM 5
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2294.05127, 1542.85168, 10.50197))
	{
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//ATM 6
	else if(IsPlayerInRangeOfPoint(playerid,2.0,12154.78809, 442.86057, -2370.30957))
    {
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//ATM 7
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2493.21704, 1640.57593, 10.52260))
	{
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//bank ATM 1
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2404.23657, 1514.48254, 10.51330))
	{
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//bank ATM 2
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2401.29907, 1514.47253, 10.51328))
	{
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//bank ATM 3
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2402.77905, 1514.47449, 10.51328))
	{
 	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//bank c 1
    else if(IsPlayerInRangeOfPoint(playerid,2.0,2398.56519, 1503.89453, 10.39840))
    {
    new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
    }
    //bank c 2
	else if(IsPlayerInRangeOfPoint(playerid,2.0,2398.58911, 1501.49072, 10.39840))
	{
	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
	}
	//bank c 3
 	else if(IsPlayerInRangeOfPoint(playerid,2.0,2398.61450, 1498.94348, 10.39840))
 	{
 	new string[128];
	format(string,sizeof(string),"{FF0000}#INFO: {FFFFFF}Your account balance is $%d.",PlayerInfo[playerid][pBankmoney]);
	SendClientMessage(playerid,-1,string);
 	}



	else
	{
	SCM(playerid,-1,"{FF0000}#ERROR: {FFFFFF}You're out of place! ");
	}

	return 1;

}
//==========
CMD:port(playerid,params[])
{

    ShowPlayerDialog(playerid,DIALOG_PORT,DIALOG_STYLE_LIST,"{FF0000}Port","1. Bank\n2. Municipality "," Select "," Cancel " );
    return 1;
}

CMD:bankbuddy(playerid,params[])
{
	if(PlayerInfo[playerid][pVaultpass] == 1)
	{
	    SetPlayerPos(playerid, 2148.15649, 1603.46252, 1001.95892);
	    SetPlayerInterior(playerid,1);
        SetCameraBehindPlayer(playerid);
 	}
 	return 1;
}

CMD:givevaultpass(playerid,params[])
{
	    new string[128], targetid, target[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
        GetPlayerName(playerid, name, sizeof(name));
        GetPlayerName(targetid, target, sizeof(target));
        if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_LIGHTGREEN, "USAGE: /givevaultpass [ID]");
        if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_RED, "Player Does Not Exist!!!");
        format(string, sizeof(string), "You have recived bank vault pass from%s", name);
        PlayerInfo[playerid][pVaultpass] = 1;
		return 1;
}
/*CMD:catm(playerid, params[])
{
	new Float:x, Float:y, Float:z, Float:az;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, az);
	CreateObject(19324, x, y, z, az, -1, -1, 19324);
	return 1;
}*/
//==
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_PORT)
    {
        if(!response) return 1;
        switch(listitem)
        {
            case 0:
            {
                SetPlayerPos(playerid,1461.3051,-1025.6864,23.8281);
                SendClientMessage(playerid,-1,""plava"You are teleported to the Bank !");
            }
            case 1:
            {
                SetPlayerPos(playerid,1479.8196,-1741.0970,13.5469);
                SendClientMessage(playerid,-1,""plava"You have been teleported to the Municipality! ");
            }
        }
    }
    return 1;
}

stock getPlayerNameEx(playerid)
{
    new
        szName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, szName, sizeof(szName));
    return szName;
}

CMD:open(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 10.0, 2145.20166, 1626.94580, 994.25439))
	{

	    MoveObject(vaultdoor, 2143.17407, 1626.62854, 994.27441, 1);
	    SetTimer("vaultdoors", 5000,0);
	}
	return 1;
}



CMD:close(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 10.0, 2143.17407, 1626.62854, 994.27441))
	{
	    MoveObject(vaultdoor, 2145.20166, 1626.94580, 994.25439, 1);
        SetTimer("vaultdoors", 5000,0);
	}
	return 1;
}

CMD:givecash(playerid, params[])
{
    new
		giveplayerid,
		amount;
	if (sscanf(params, "ud", giveplayerid, amount)) SendClientMessage(playerid, 0xFF0000AA, "Usage: /givecash [playerid/partname] [amount]");
	else if (giveplayerid == INVALID_PLAYER_ID) SendClientMessage(playerid, 0xFF0000AA, "Player not found");
	else if (amount > GetPlayerMoney(playerid)) SendClientMessage(playerid, 0xFF0000AA, "Insufficient Funds");
	else
	{
		GivePlayerMoney(giveplayerid, amount);
		GivePlayerMoney(playerid, 0 - amount);
		SendClientMessage(playerid, 0x00FF00AA, "Money sent");
		SendClientMessage(giveplayerid, 0x00FF00AA, "Money received");
	}
	return 1;
}



