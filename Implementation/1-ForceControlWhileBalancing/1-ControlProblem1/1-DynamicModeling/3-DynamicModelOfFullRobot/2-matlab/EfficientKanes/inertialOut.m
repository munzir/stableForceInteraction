maG1 = [Z623*ddpsi+Z624;
    Z625*ddx+Z626*ddpsi+Z627*ddq_imu+Z628;
    Z629*ddx+Z630*ddpsi+Z631*ddq_imu+Z632];

dHnew1 = [Z633*ddx+Z634*ddpsi+Z635*ddq_imu+Z636;
    Z637*ddx+Z638*ddpsi+Z639*ddq_imu+Z640;
    Z641*ddx+Z642*ddpsi+Z643*ddq_imu+Z644];

maG2 = [Z645*ddpsi+Z646;
    Z647*ddx+Z648*ddpsi+Z649*ddq_imu+Z650*ddq_w+Z651;
    Z652*ddx+Z653*ddpsi+Z654*ddq_imu+Z655*ddq_w+Z656];

dHnew2 = [Z657*ddx+Z658*ddpsi+Z659*ddq_imu+Z660*ddq_w+Z661;
    Z662*ddx+Z663*ddpsi+Z664*ddq_imu+Z665*ddq_w+Z666;
    Z667*ddx+Z668*ddpsi+Z669*ddq_imu+Z670*ddq_w+Z671];

maG3 = [Z672*ddx+Z673*ddpsi+Z674*ddq_imu+Z675*ddq_w+Z676*ddq_torso+Z677;
    Z678*ddx+Z679*ddpsi+Z680*ddq_imu+Z681*ddq_w+Z682;
    Z683*ddx+Z684*ddpsi+Z685*ddq_imu+Z686*ddq_w+Z687*ddq_torso+Z688];

dHnew3 = [Z689*ddx+Z690*ddpsi+Z691*ddq_imu+Z692*ddq_w+Z693*ddq_torso+Z694;
    Z695*ddx+Z696*ddpsi+Z697*ddq_imu+Z698*ddq_w+Z699*ddq_torso+Z700;
    Z701*ddx+Z702*ddpsi+Z703*ddq_imu+Z704*ddq_w+Z705*ddq_torso+Z706];

maG4l = [Z707*ddx+Z708*ddpsi+Z709*ddq_imu+Z710*ddq_w+Z711*ddq_torso+Z712*ddq_1l+Z713;
    Z714*ddx+Z715*ddpsi+Z716*ddq_imu+Z717*ddq_w+Z718*ddq_torso+Z719;
    Z720*ddx+Z721*ddpsi+Z722*ddq_imu+Z723*ddq_w+Z724*ddq_torso+Z725*ddq_1l+Z726];

dHnew4l = [Z727*ddx+Z728*ddpsi+Z729*ddq_imu+Z730*ddq_w+Z731*ddq_torso+Z732*ddq_1l+Z733;
    Z734*ddx+Z735*ddpsi+Z736*ddq_imu+Z737*ddq_w+Z738*ddq_torso+Z739*ddq_1l+Z740;
    Z741*ddx+Z742*ddpsi+Z743*ddq_imu+Z744*ddq_w+Z745*ddq_torso+Z746*ddq_1l+Z747];

maG5l = [Z748*ddx+Z749*ddpsi+Z750*ddq_imu+Z751*ddq_w+Z752*ddq_torso+Z753*ddq_1l+Z754;
    Z755*ddx+Z756*ddpsi+Z757*ddq_imu+Z758*ddq_w+Z759*ddq_torso+Z760*ddq_1l+Z761*ddq_2l+Z762;
    Z763*ddx+Z764*ddpsi+Z765*ddq_imu+Z766*ddq_w+Z767*ddq_torso+Z768*ddq_1l+Z769*ddq_2l+Z770];

dHnew5l = [Z771*ddx+Z772*ddpsi+Z773*ddq_imu+Z774*ddq_w+Z775*ddq_torso+Z776*ddq_1l+Z777*ddq_2l+Z778;
    Z779*ddx+Z780*ddpsi+Z781*ddq_imu+Z782*ddq_w+Z783*ddq_torso+Z784*ddq_1l+Z785*ddq_2l+Z786;
    Z787*ddx+Z788*ddpsi+Z789*ddq_imu+Z790*ddq_w+Z791*ddq_torso+Z792*ddq_1l+Z793*ddq_2l+Z794];

maG6l = [Z795*ddx+Z796*ddpsi+Z797*ddq_imu+Z798*ddq_w+Z799*ddq_torso+Z800*ddq_1l+Z801*ddq_2l+Z802*ddq_3l+Z803;
    Z804*ddx+Z805*ddpsi+Z806*ddq_imu+Z807*ddq_w+Z808*ddq_torso+Z809*ddq_1l+Z810*ddq_2l+Z811;
    Z812*ddx+Z813*ddpsi+Z814*ddq_imu+Z815*ddq_w+Z816*ddq_torso+Z817*ddq_1l+Z818*ddq_2l+Z819*ddq_3l+Z820];

dHnew6l = [Z821*ddx+Z822*ddpsi+Z823*ddq_imu+Z824*ddq_w+Z825*ddq_torso+Z826*ddq_1l+Z827*ddq_2l+Z828*ddq_3l+Z829;
    Z830*ddx+Z831*ddpsi+Z832*ddq_imu+Z833*ddq_w+Z834*ddq_torso+Z835*ddq_1l+Z836*ddq_2l+Z837*ddq_3l+Z838;
    Z839*ddx+Z840*ddpsi+Z841*ddq_imu+Z842*ddq_w+Z843*ddq_torso+Z844*ddq_1l+Z845*ddq_2l+Z846*ddq_3l+Z847];

maG7l = [Z848*ddx+Z849*ddpsi+Z850*ddq_imu+Z851*ddq_w+Z852*ddq_torso+Z853*ddq_1l+Z854*ddq_2l+Z855*ddq_3l+Z856;
    Z857*ddx+Z858*ddpsi+Z859*ddq_imu+Z860*ddq_w+Z861*ddq_torso+Z862*ddq_1l+Z863*ddq_2l+Z864*ddq_3l+Z865*ddq_4l+Z866;
    Z867*ddx+Z868*ddpsi+Z869*ddq_imu+Z870*ddq_w+Z871*ddq_torso+Z872*ddq_1l+Z873*ddq_2l+Z874*ddq_3l+Z875*ddq_4l+Z876];

dHnew7l = [Z877*ddx+Z878*ddpsi+Z879*ddq_imu+Z880*ddq_w+Z881*ddq_torso+Z882*ddq_1l+Z883*ddq_2l+Z884*ddq_3l+Z885*ddq_4l+Z886;
    Z887*ddx+Z888*ddpsi+Z889*ddq_imu+Z890*ddq_w+Z891*ddq_torso+Z892*ddq_1l+Z893*ddq_2l+Z894*ddq_3l+Z895*ddq_4l+Z896;
    Z897*ddx+Z898*ddpsi+Z899*ddq_imu+Z900*ddq_w+Z901*ddq_torso+Z902*ddq_1l+Z903*ddq_2l+Z904*ddq_3l+Z905*ddq_4l+Z906];

maG8l = [Z907*ddx+Z908*ddpsi+Z909*ddq_imu+Z910*ddq_w+Z911*ddq_torso+Z912*ddq_1l+Z913*ddq_2l+Z914*ddq_3l+Z915*ddq_4l+Z916*ddq_5l+Z917;
    Z918*ddx+Z919*ddpsi+Z920*ddq_imu+Z921*ddq_w+Z922*ddq_torso+Z923*ddq_1l+Z924*ddq_2l+Z925*ddq_3l+Z926*ddq_4l+Z927;
    Z928*ddx+Z929*ddpsi+Z930*ddq_imu+Z931*ddq_w+Z932*ddq_torso+Z933*ddq_1l+Z934*ddq_2l+Z935*ddq_3l+Z936*ddq_4l+Z937*ddq_5l+Z938];

dHnew8l = [Z939*ddx+Z940*ddpsi+Z941*ddq_imu+Z942*ddq_w+Z943*ddq_torso+Z944*ddq_1l+Z945*ddq_2l+Z946*ddq_3l+Z947*ddq_4l+Z948*ddq_5l+Z949;
    Z950*ddx+Z951*ddpsi+Z952*ddq_imu+Z953*ddq_w+Z954*ddq_torso+Z955*ddq_1l+Z956*ddq_2l+Z957*ddq_3l+Z958*ddq_4l+Z959*ddq_5l+Z960;
    Z961*ddx+Z962*ddpsi+Z963*ddq_imu+Z964*ddq_w+Z965*ddq_torso+Z966*ddq_1l+Z967*ddq_2l+Z968*ddq_3l+Z969*ddq_4l+Z970*ddq_5l+Z971];

maG9l = [Z972*ddx+Z973*ddpsi+Z974*ddq_imu+Z975*ddq_w+Z976*ddq_torso+Z977*ddq_1l+Z978*ddq_2l+Z979*ddq_3l+Z980*ddq_4l+Z981*ddq_5l+Z982;
    Z983*ddx+Z984*ddpsi+Z985*ddq_imu+Z986*ddq_w+Z987*ddq_torso+Z988*ddq_1l+Z989*ddq_2l+Z990*ddq_3l+Z991*ddq_4l+Z992*ddq_5l+Z993*ddq_6l+Z994;
    Z995*ddx+Z996*ddpsi+Z997*ddq_imu+Z998*ddq_w+Z999*ddq_torso+Z1000*ddq_1l+Z1001*ddq_2l+Z1002*ddq_3l+Z1003*ddq_4l+Z1004*ddq_5l+Z1005*ddq_6l+Z1006];

dHnew9l = [Z1007*ddx+Z1008*ddpsi+Z1009*ddq_imu+Z1010*ddq_w+Z1011*ddq_torso+Z1012*ddq_1l+Z1013*ddq_2l+Z1014*ddq_3l+Z1015*ddq_4l+Z1016*ddq_5l+Z1017*ddq_6l+Z1018;
    Z1019*ddx+Z1020*ddpsi+Z1021*ddq_imu+Z1022*ddq_w+Z1023*ddq_torso+Z1024*ddq_1l+Z1025*ddq_2l+Z1026*ddq_3l+Z1027*ddq_4l+Z1028*ddq_5l+Z1029*ddq_6l+Z1030;
    Z1031*ddx+Z1032*ddpsi+Z1033*ddq_imu+Z1034*ddq_w+Z1035*ddq_torso+Z1036*ddq_1l+Z1037*ddq_2l+Z1038*ddq_3l+Z1039*ddq_4l+Z1040*ddq_5l+Z1041*ddq_6l+Z1042];

maG10l = [Z1043*ddx+Z1044*ddpsi+Z1045*ddq_imu+Z1046*ddq_w+Z1047*ddq_torso+Z1048*ddq_1l+Z1049*ddq_2l+Z1050*ddq_3l+Z1051*ddq_4l+Z1052*ddq_5l+Z1053*ddq_6l+Z1054*ddq_7l+Z1055;
    Z1056*ddx+Z1057*ddpsi+Z1058*ddq_imu+Z1059*ddq_w+Z1060*ddq_torso+Z1061*ddq_1l+Z1062*ddq_2l+Z1063*ddq_3l+Z1064*ddq_4l+Z1065*ddq_5l+Z1066*ddq_6l+Z1067*ddq_7l+Z1068;
    Z1069*ddx+Z1070*ddpsi+Z1071*ddq_imu+Z1072*ddq_w+Z1073*ddq_torso+Z1074*ddq_1l+Z1075*ddq_2l+Z1076*ddq_3l+Z1077*ddq_4l+Z1078*ddq_5l+Z1079*ddq_6l+Z1080];

dHnew10l = [Z1081*ddx+Z1082*ddpsi+Z1083*ddq_imu+Z1084*ddq_w+Z1085*ddq_torso+Z1086*ddq_1l+Z1087*ddq_2l+Z1088*ddq_3l+Z1089*ddq_4l+Z1090*ddq_5l+Z1091*ddq_6l+Z1092*ddq_7l+Z1093;
    Z1094*ddx+Z1095*ddpsi+Z1096*ddq_imu+Z1097*ddq_w+Z1098*ddq_torso+Z1099*ddq_1l+Z1100*ddq_2l+Z1101*ddq_3l+Z1102*ddq_4l+Z1103*ddq_5l+Z1104*ddq_6l+Z1105*ddq_7l+Z1106;
    Z1107*ddx+Z1108*ddpsi+Z1109*ddq_imu+Z1110*ddq_w+Z1111*ddq_torso+Z1112*ddq_1l+Z1113*ddq_2l+Z1114*ddq_3l+Z1115*ddq_4l+Z1116*ddq_5l+Z1117*ddq_6l+Z1118*ddq_7l+Z1119];

maG4r = [Z1120*ddx+Z1121*ddpsi+Z1122*ddq_imu+Z1123*ddq_w+Z1124*ddq_torso+Z1125*ddq_1r+Z1126;
    Z1127*ddx+Z1128*ddpsi+Z1129*ddq_imu+Z1130*ddq_w+Z1131*ddq_torso+Z1132;
    Z1133*ddx+Z1134*ddpsi+Z1135*ddq_imu+Z1136*ddq_w+Z1137*ddq_torso+Z1138*ddq_1r+Z1139];

dHnew4r = [Z1140*ddx+Z1141*ddpsi+Z1142*ddq_imu+Z1143*ddq_w+Z1144*ddq_torso+Z1145*ddq_1r+Z1146;
    Z1147*ddx+Z1148*ddpsi+Z1149*ddq_imu+Z1150*ddq_w+Z1151*ddq_torso+Z1152*ddq_1r+Z1153;
    Z1154*ddx+Z1155*ddpsi+Z1156*ddq_imu+Z1157*ddq_w+Z1158*ddq_torso+Z1159*ddq_1r+Z1160];

maG5r = [Z1161*ddx+Z1162*ddpsi+Z1163*ddq_imu+Z1164*ddq_w+Z1165*ddq_torso+Z1166;
    Z1167*ddx+Z1168*ddpsi+Z1169*ddq_imu+Z1170*ddq_w+Z1171*ddq_torso+Z1172;
    Z1173*ddx+Z1174*ddpsi+Z1175*ddq_imu+Z1176*ddq_w+Z1177*ddq_torso+Z1178];

dHnew5r = [Z1179*ddx+Z1180*ddpsi+Z1181*ddq_imu+Z1182*ddq_w+Z1183*ddq_torso+Z1184;
    Z1185*ddx+Z1186*ddpsi+Z1187*ddq_imu+Z1188*ddq_w+Z1189*ddq_torso+Z1190;
    Z1191*ddx+Z1192*ddpsi+Z1193*ddq_imu+Z1194*ddq_w+Z1195*ddq_torso+Z1196];

maG6r = [Z1197*ddx+Z1198*ddpsi+Z1199*ddq_imu+Z1200*ddq_w+Z1201*ddq_torso+Z1202*ddq_1r+Z1203*ddq_2r+Z1204*ddq_3r+Z1205;
    Z1206*ddx+Z1207*ddpsi+Z1208*ddq_imu+Z1209*ddq_w+Z1210*ddq_torso+Z1211*ddq_1r+Z1212*ddq_2r+Z1213;
    Z1214*ddx+Z1215*ddpsi+Z1216*ddq_imu+Z1217*ddq_w+Z1218*ddq_torso+Z1219*ddq_1r+Z1220*ddq_2r+Z1221*ddq_3r+Z1222];

dHnew6r = [Z1223*ddx+Z1224*ddpsi+Z1225*ddq_imu+Z1226*ddq_w+Z1227*ddq_torso+Z1228*ddq_1r+Z1229*ddq_2r+Z1230*ddq_3r+Z1231;
    Z1232*ddx+Z1233*ddpsi+Z1234*ddq_imu+Z1235*ddq_w+Z1236*ddq_torso+Z1237*ddq_1r+Z1238*ddq_2r+Z1239*ddq_3r+Z1240;
    Z1241*ddx+Z1242*ddpsi+Z1243*ddq_imu+Z1244*ddq_w+Z1245*ddq_torso+Z1246*ddq_1r+Z1247*ddq_2r+Z1248*ddq_3r+Z1249];

maG7r = [Z1250*ddx+Z1251*ddpsi+Z1252*ddq_imu+Z1253*ddq_w+Z1254*ddq_torso+Z1255*ddq_1r+Z1256*ddq_2r+Z1257*ddq_3r+Z1258;
    Z1259*ddx+Z1260*ddpsi+Z1261*ddq_imu+Z1262*ddq_w+Z1263*ddq_torso+Z1264*ddq_1r+Z1265*ddq_2r+Z1266*ddq_3r+Z1267*ddq_4r+Z1268;
    Z1269*ddx+Z1270*ddpsi+Z1271*ddq_imu+Z1272*ddq_w+Z1273*ddq_torso+Z1274*ddq_1r+Z1275*ddq_2r+Z1276*ddq_3r+Z1277*ddq_4r+Z1278];

dHnew7r = [Z1279*ddx+Z1280*ddpsi+Z1281*ddq_imu+Z1282*ddq_w+Z1283*ddq_torso+Z1284*ddq_1r+Z1285*ddq_2r+Z1286*ddq_3r+Z1287*ddq_4r+Z1288;
    Z1289*ddx+Z1290*ddpsi+Z1291*ddq_imu+Z1292*ddq_w+Z1293*ddq_torso+Z1294*ddq_1r+Z1295*ddq_2r+Z1296*ddq_3r+Z1297*ddq_4r+Z1298;
    Z1299*ddx+Z1300*ddpsi+Z1301*ddq_imu+Z1302*ddq_w+Z1303*ddq_torso+Z1304*ddq_1r+Z1305*ddq_2r+Z1306*ddq_3r+Z1307*ddq_4r+Z1308];

maG8r = [Z1309*ddx+Z1310*ddpsi+Z1311*ddq_imu+Z1312*ddq_w+Z1313*ddq_torso+Z1314*ddq_1r+Z1315*ddq_2r+Z1316*ddq_3r+Z1317*ddq_4r+Z1318*ddq_5r+Z1319;
    Z1320*ddx+Z1321*ddpsi+Z1322*ddq_imu+Z1323*ddq_w+Z1324*ddq_torso+Z1325*ddq_1r+Z1326*ddq_2r+Z1327*ddq_3r+Z1328*ddq_4r+Z1329;
    Z1330*ddx+Z1331*ddpsi+Z1332*ddq_imu+Z1333*ddq_w+Z1334*ddq_torso+Z1335*ddq_1r+Z1336*ddq_2r+Z1337*ddq_3r+Z1338*ddq_4r+Z1339*ddq_5r+Z1340];

dHnew8r = [Z1341*ddx+Z1342*ddpsi+Z1343*ddq_imu+Z1344*ddq_w+Z1345*ddq_torso+Z1346*ddq_1r+Z1347*ddq_2r+Z1348*ddq_3r+Z1349*ddq_4r+Z1350*ddq_5r+Z1351;
    Z1352*ddx+Z1353*ddpsi+Z1354*ddq_imu+Z1355*ddq_w+Z1356*ddq_torso+Z1357*ddq_1r+Z1358*ddq_2r+Z1359*ddq_3r+Z1360*ddq_4r+Z1361*ddq_5r+Z1362;
    Z1363*ddx+Z1364*ddpsi+Z1365*ddq_imu+Z1366*ddq_w+Z1367*ddq_torso+Z1368*ddq_1r+Z1369*ddq_2r+Z1370*ddq_3r+Z1371*ddq_4r+Z1372*ddq_5r+Z1373];

maG9r = [Z1374*ddx+Z1375*ddpsi+Z1376*ddq_imu+Z1377*ddq_w+Z1378*ddq_torso+Z1379*ddq_1r+Z1380*ddq_2r+Z1381*ddq_3r+Z1382*ddq_4r+Z1383*ddq_5r+Z1384;
    Z1385*ddx+Z1386*ddpsi+Z1387*ddq_imu+Z1388*ddq_w+Z1389*ddq_torso+Z1390*ddq_1r+Z1391*ddq_2r+Z1392*ddq_3r+Z1393*ddq_4r+Z1394*ddq_5r+Z1395*ddq_6r+Z1396;
    Z1397*ddx+Z1398*ddpsi+Z1399*ddq_imu+Z1400*ddq_w+Z1401*ddq_torso+Z1402*ddq_1r+Z1403*ddq_2r+Z1404*ddq_3r+Z1405*ddq_4r+Z1406*ddq_5r+Z1407*ddq_6r+Z1408];

dHnew9r = [Z1409*ddx+Z1410*ddpsi+Z1411*ddq_imu+Z1412*ddq_w+Z1413*ddq_torso+Z1414*ddq_1r+Z1415*ddq_2r+Z1416*ddq_3r+Z1417*ddq_4r+Z1418*ddq_5r+Z1419*ddq_6r+Z1420;
    Z1421*ddx+Z1422*ddpsi+Z1423*ddq_imu+Z1424*ddq_w+Z1425*ddq_torso+Z1426*ddq_1r+Z1427*ddq_2r+Z1428*ddq_3r+Z1429*ddq_4r+Z1430*ddq_5r+Z1431*ddq_6r+Z1432;
    Z1433*ddx+Z1434*ddpsi+Z1435*ddq_imu+Z1436*ddq_w+Z1437*ddq_torso+Z1438*ddq_1r+Z1439*ddq_2r+Z1440*ddq_3r+Z1441*ddq_4r+Z1442*ddq_5r+Z1443*ddq_6r+Z1444];

maG10r = [Z1445*ddx+Z1446*ddpsi+Z1447*ddq_imu+Z1448*ddq_w+Z1449*ddq_torso+Z1450*ddq_1r+Z1451*ddq_2r+Z1452*ddq_3r+Z1453*ddq_4r+Z1454*ddq_5r+Z1455*ddq_6r+Z1456*ddq_7r+Z1457;
    Z1458*ddx+Z1459*ddpsi+Z1460*ddq_imu+Z1461*ddq_w+Z1462*ddq_torso+Z1463*ddq_1r+Z1464*ddq_2r+Z1465*ddq_3r+Z1466*ddq_4r+Z1467*ddq_5r+Z1468*ddq_6r+Z1469*ddq_7r+Z1470;
    Z1471*ddx+Z1472*ddpsi+Z1473*ddq_imu+Z1474*ddq_w+Z1475*ddq_torso+Z1476*ddq_1r+Z1477*ddq_2r+Z1478*ddq_3r+Z1479*ddq_4r+Z1480*ddq_5r+Z1481*ddq_6r+Z1482];

dHnew10r = [Z1483*ddx+Z1484*ddpsi+Z1485*ddq_imu+Z1486*ddq_w+Z1487*ddq_torso+Z1488*ddq_1r+Z1489*ddq_2r+Z1490*ddq_3r+Z1491*ddq_4r+Z1492*ddq_5r+Z1493*ddq_6r+Z1494*ddq_7r+Z1495;
    Z1496*ddx+Z1497*ddpsi+Z1498*ddq_imu+Z1499*ddq_w+Z1500*ddq_torso+Z1501*ddq_1r+Z1502*ddq_2r+Z1503*ddq_3r+Z1504*ddq_4r+Z1505*ddq_5r+Z1506*ddq_6r+Z1507*ddq_7r+Z1508;
    Z1509*ddx+Z1510*ddpsi+Z1511*ddq_imu+Z1512*ddq_w+Z1513*ddq_torso+Z1514*ddq_1r+Z1515*ddq_2r+Z1516*ddq_3r+Z1517*ddq_4r+Z1518*ddq_5r+Z1519*ddq_6r+Z1520*ddq_7r+Z1521];

