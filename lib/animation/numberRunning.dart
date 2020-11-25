
import 'package:flutter/material.dart';

class ReportWithNumberRunning extends StatefulWidget {

  final int value;
  final String label;
  final Color color;
  
  ReportWithNumberRunning({
    @required this.value,
    @required this.label,
    @required this.color
  });

  @override
  _ReportWithNumberRunningState createState() => _ReportWithNumberRunningState();
}

class _ReportWithNumberRunningState extends State<ReportWithNumberRunning> with TickerProviderStateMixin {

  final int _heightCicle = 25;

  Animation<int> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500), 
      vsync: this
    );
  }

  @override
  void didUpdateWidget(covariant ReportWithNumberRunning oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null) return;
    _animation = IntTween(begin: 0, end: widget.value).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuart
    ))..
    addListener((){
      setState((){});
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: _heightCicle.toDouble(),
            width: _heightCicle.toDouble(),
            padding: EdgeInsets.all(_heightCicle / 3.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withOpacity(.3),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: widget.color
                )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Text((_animation == null ? 0 : _animation.value).toString(), style: Theme.of(context).textTheme.headline4.copyWith(
                  color: widget.color,
                  fontWeight: FontWeight.w500
                ));
              }
            ),
          ),
          Text(widget.label, style: Theme.of(context).textTheme.bodyText1.apply(
            color: Colors.black45
          ))
        ],
      ),
    );
  }
}