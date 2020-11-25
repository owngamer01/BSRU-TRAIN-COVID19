import 'package:covid19/animation/numberRunning.dart';
import 'package:covid19/enum/route_enum.dart';
import 'package:covid19/http/covid_http.dart';
import 'package:covid19/model/covid_model.dart';
import 'package:covid19/pages/preventionPage.dart';
import 'package:covid19/utils/shadow_utils.dart';
import 'package:covid19/widget/headerWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CovidSummaryData covidSummary = CovidSummaryData(
    deaths: 0,
    hospitalized: 0,
    recovered: 0
  );

  void _loadData() async {
    var response = await CovidHttp().getCovidSummary();
    if (response == null) return;

    setState(() {
      covidSummary = response;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderWidger(
                assetPath: 'assets/icon/Drcorona.svg', 
                word: 'All you need\nis stay at home'
              ),
              _contentCard(),
            ]
          )
        ),
      )
    );
  }

  Widget _contentCard() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          _caseUpdateCard(),
          _myVirus(),
          _provinceVirus(),
        ],
      )
    );
  }

  Widget _caseUpdateCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Case Update', style: Theme.of(context).textTheme.headline6.copyWith(
          fontSize: 18
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Newest update march 28", style: Theme.of(context).textTheme.caption.copyWith(
              color: Colors.black45
            )),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteApp.covidHistory.toString());
              },
              child: Text("See detail", style: TextStyle(
                fontSize: 10,
                color: Colors.blue[600],
                fontWeight: FontWeight.bold,
              )),
            )
          ]
        ),
        Container(
          height: 150,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [ shadowDefault ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ReportWithNumberRunning(
                color: Color(0xFFF98E4C),
                label: 'Hopitalized',
                value: covidSummary.hospitalized
              ),
              ReportWithNumberRunning(
                color: Color(0xFFDE5259),
                label: 'Deaths',
                value: covidSummary.deaths
              ),
              ReportWithNumberRunning(
                color: Color(0xFF33C32A),
                label: 'Recovered',
                value: covidSummary.recovered
              )
            ],
          )
        )
      ]
    );
  }

  Widget _myVirus() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Video protection', style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 18
              )),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => PreventionPage())
                  );
                },
                child: Text("See detail", style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold,
                )),
              )
            ]
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset('assets/image/protection.jpg'),
          )
        ]
      ),
    );
  }

  Widget _provinceVirus() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Province', style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 18
              )),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteApp.provinceVirus.toString());
                },
                child: Text("See detail", style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold,
                )),
              )
            ]
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset('assets/image/map.png'),
          )
        ]
      ),
    );
  }
}
