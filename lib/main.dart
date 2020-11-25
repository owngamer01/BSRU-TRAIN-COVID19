import 'package:covid19/enum/route_enum.dart';
import 'package:covid19/home.dart';
import 'package:covid19/pages/covidHistoryPage.dart';
import 'package:covid19/pages/provinceVirusPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() {
  runApp(MyApp());
}

/* ยอดผู้ป่วย รายวัน / ประวัติ covid19.th-stat.com/api/open/today && covid19.th-stat.com/api/open/timeline
  - Hospitalized รักษาอยู่
  - Recovered : หายแล้ว
  - Confirmed : กลับบ้านแล้ว
  - Deaths : ตาย
  - NewConfirmed : กลับบ้านแล้วรายใหม่
  - NewRecovered : หายใหม่
  - NewHospitalized : เพิ่งเข้ารักษา
  - NewDeaths : ตายใหม่
  - UpdateDate : วันที่รักษา
*/

/*
  ผลรวมเคสทั้งหมด https://covid19.th-stat.com/api/open/cases/sum
  แบ่งตาม Province, male, female
*/

/*
  ประวัติคนไข้ https://covid19.th-stat.com/api/open/cases
  - ConfirmDate : วันที่ลงข้อมูล
  - Age : อายุ
  - Gender : เพศ
  - Province, Distict, 
  - Detail : รายละเอียด
*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF1126A5),
        accentColor: Color(0xFF1126A5),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontWeight: FontWeight.w700
          )
        ),
        fontFamily: 'customFont',
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: '/',

      routes: {
        '/': (_) => HomePage(),
        RouteApp.covidHistory.toString(): (_) => CovidHistoryPage(),
        RouteApp.provinceVirus.toString(): (_) => ProvinceVirusPage(),
      },

    );
  }
}