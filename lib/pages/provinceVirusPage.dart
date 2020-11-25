import 'dart:math';

import 'package:covid19/http/covid_http.dart';
import 'package:covid19/model/covid_model.dart';
import 'package:covid19/widget/errorWidget.dart';
import 'package:covid19/widget/headerWidget.dart';
import 'package:flutter/material.dart';

class ProvinceVirusPage extends StatefulWidget {
  @override
  _ProvinceVirusPageState createState() => _ProvinceVirusPageState();
}

class _ProvinceVirusPageState extends State<ProvinceVirusPage> {

  final colors = [
    Color(0xFFF4D06F), 
    Color(0xFFFF8811), 
    Color(0xFF9DD9D2),
    Color(0xFFFFF8F0),
    Color(0xFF392F5A)
  ];
  Future<CovidCaseSumData> _provinceData;

  @override
  void initState() {
    _provinceData = CovidHttp().getProvinceCovid();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 270),
                  Expanded(
                    child: FutureBuilder(
                      future: _provinceData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(
                            child: CircularProgressIndicator(),
                          ));
                        }
                        return snapshot.hasData ? _gridProvinceCovid(snapshot.data) : _error();
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                child: HeaderWidger(
                  offset: 40,
                  assetPath: 'assets/icon/coronadr.svg', 
                  word: 'Province covid-19\nIn thailand'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _gridProvinceCovid(CovidCaseSumData data) {
    return GridView.count(
      key: UniqueKey(),
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 3,
      shrinkWrap: true,
      children: data.province.entries.map((_item) {
        var _color = colors[Random().nextInt(5)];
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _color.withOpacity(.3),
                  shape: BoxShape.circle
                ),
                child: Text(_item.value.toString(), style: Theme.of(context).textTheme.headline6),
              ),
              Text(_item.key, textAlign: TextAlign.center)
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _error() {
    return Error500();
  }
}