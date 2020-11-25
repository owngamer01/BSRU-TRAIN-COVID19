import 'package:covid19/enum/symptoms_enum.dart';
import 'package:covid19/utils/shadow_utils.dart';
import 'package:covid19/utils/symtoms_utils.dart';
import 'package:covid19/widget/headerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoObjectData {
  final String videoUrl;
  final String title;
  final String description;
  final String assetPath;
  
  VideoObjectData({
    @required this.description,
    @required this.title,
    @required this.videoUrl,
    @required this.assetPath
  });
}

class PreventionPage extends StatefulWidget {

  @override
  _PreventionPageState createState() => _PreventionPageState();
}

class _PreventionPageState extends State<PreventionPage> {

  final _videoObject = [
    VideoObjectData(
      videoUrl: 'https://www.youtube.com/watch?v=lv8nlY2R848',
      title: 'Wear face mask',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
      assetPath: 'assets/image/wash_hands.png'
    ), 
    VideoObjectData(
      videoUrl: 'https://www.youtube.com/watch?v=lv8nlY2R848',
      title: 'Wash your hands',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
      assetPath: 'assets/image/wear_mask.png'
    )
  ];

  void _openVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                offset: 40,
                assetPath: 'assets/icon/coronadr.svg', 
                word: 'Get to know\nAbount Covid-19'
              ),
              _contentCard()
            ]
          )
        ),
      )
    );
  }

  Widget _contentCard() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        children: [
          _symptoms(),
          _prevention(),
        ],
      )
    );
  }

  Widget _symptoms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Symptoms', style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 18
            )),
            Text("See detail", style: TextStyle(
              fontSize: 10,
              color: Colors.blue[600],
              fontWeight: FontWeight.bold,
            ))
          ]
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _symptomsCard(SymptomsType.headache),
              SizedBox(width: 10),
              _symptomsCard(SymptomsType.caugh),
              SizedBox(width: 10),
              _symptomsCard(SymptomsType.fever),
            ],
          ),
        ),
      ]
    );
  }

  Widget _symptomsCard(SymptomsType type) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              offset: Offset(0, 4),
              spreadRadius: -4,
              blurRadius: 24
            )
          ]
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: .11,
                  child: SvgPicture.asset('assets/icon/shape_small.svg')
                ),
                Positioned(
                  child: SymtomsUtils.getSymtomsIcon(type)
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(SymtomsUtils.getSymtomsText(type), style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget _prevention() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Prevension", style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: 18
          )),
          for (var videoData in _videoObject) _preventionList(videoData)
        ],
      )
    );
  }

  Widget _preventionList(VideoObjectData data) {
    return InkWell(
      onTap: () {
        _openVideo(data.videoUrl);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [ shadowDefault ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(data.assetPath, fit: BoxFit.cover),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.title, style: Theme.of(context).textTheme.bodyText1),
                    Text(data.description, 
                      style: Theme.of(context).textTheme.caption,
                    )
                  ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}