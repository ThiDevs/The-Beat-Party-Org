import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp();
  @override
  Widget build(BuildContext context) {
    return (Padding(
        padding: const EdgeInsets.only(
          top: 130.0,
        ),
        child: new TextButton(
          onPressed: null,
          child: new Text(
            "",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: new TextStyle(
                fontWeight: FontWeight.w300,
                letterSpacing: 0.5,
                color: Colors.red,
                fontSize: 12.0),
          ),
        )));
  }
}
