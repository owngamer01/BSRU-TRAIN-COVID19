import 'package:flutter/material.dart';

class Error500 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 300,
      child: Center(child: CircularProgressIndicator())
    );
  }
}