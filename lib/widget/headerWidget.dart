import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWidger extends StatelessWidget {

  final String assetPath;
  final String word;
  final double offset;
  final bool isClip;

  HeaderWidger({
    @required this.assetPath,
    @required this.word,
    this.isClip = true,
    this.offset = 0
  }) : assert(assetPath != null && assetPath.trim().isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(isClip),
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.3, 1],
            colors: [
              Color(0xff1126A5),
              Color(0xff2A78CE)
            ]
          ),
          image: DecorationImage(
            image: AssetImage('assets/image/virus.png')
          )
        ),
        child: Container(
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: (25 - this.offset).toDouble(),
                child: SvgPicture.asset(this.assetPath, 
                  width: 230,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter
                )
              ),
              Positioned(
                top: 80,
                left: (180 - this.offset).toDouble(),
                child: Text(this.word ?? '', style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Color(0xFFC8EBFA),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {

  final bool isClip;

  MyClipper(this.isClip);

  @override
  Path getClip(Size size) {
    var path = Path();
    var _height = isClip ? 40 : 0;
    path.lineTo(0, size.height - _height);
    path.quadraticBezierTo(
      size.width / 2, size.height + _height, 
      size.width, size.height - _height
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
