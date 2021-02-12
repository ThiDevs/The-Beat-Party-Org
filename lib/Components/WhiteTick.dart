import 'package:flutter/material.dart';

class Tick extends StatelessWidget {
  final DecorationImage image;
  Tick({this.image});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 80),
      // padding: const EdgeInsets.all(100.0),
      height: 150,

      alignment: Alignment.bottomCenter,
      decoration: new BoxDecoration(
        image: image,
      ),
    ));
  }
}
