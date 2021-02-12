import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  SignIn();
  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: 180.0,
      height: 40.0,
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: Colors.red,
        borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
      ),
      child: new Text(
        "Entrar",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
    ));
  }
}
