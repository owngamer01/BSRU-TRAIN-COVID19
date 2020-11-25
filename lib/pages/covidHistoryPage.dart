import 'package:covid19/http/covid_http.dart';
import 'package:covid19/model/covid_model.dart';
import 'package:covid19/utils/shadow_utils.dart';
import 'package:covid19/widget/errorWidget.dart';
import 'package:covid19/widget/headerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CovidHistoryPage extends StatefulWidget {
  @override
  _CovidHistoryPageState createState() => _CovidHistoryPageState();
}

class _CovidHistoryPageState extends State<CovidHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            flexibleSpace: HeaderWidger(
              offset: 20,
              assetPath: 'assets/icon/Drcorona.svg', 
              word: 'Get to know\nAbount Covid-19',
              isClip: false,
            ),
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 14)),
                    Text("History", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 14))
                  ],
                ),
              )
            ]),
          ),
          FutureBuilder(
            initialData: [],
            future: CovidHttp().getCovidHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _loading();
              }
              return snapshot.hasData ? _covidHistory(snapshot.data) : _errorSilver();
            }
          )
        ]
      )
    );
  }

  Widget _loading() {
    return SliverList(
      delegate: SliverChildListDelegate([Error500()])
    ); 
  }

  Widget _covidHistory(List<CovidSummaryData> data) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(data.length, (index) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _circleNumber(Color(0xFFF98E4C),  data[index].hospitalized),
                    _circleNumber(Color(0xFFDE5259),  data[index].deaths),
                    _circleNumber(Color(0xFF33C32A),  data[index].recovered),
                  ],
                ),
                Text(data[index].date.toString())
              ],
            ),
          );
        })
      ),
    );
  }

  Widget _circleNumber(Color color, int value) {
    return value > 0 ? Container(
      width: 48,
      height: 48,
      margin: EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withOpacity(.3),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [ shadowDefault ]
      ),
      child: Text(value.toString(), style: TextStyle(
        fontSize: 14,
        color: color,
        fontWeight: FontWeight.bold
      )),
    ) : Container();
  }

  Widget _errorSilver() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          child: Center(child: Image.asset('assets/image/error.jpg'))
        )
      ]),
    );
  }
}