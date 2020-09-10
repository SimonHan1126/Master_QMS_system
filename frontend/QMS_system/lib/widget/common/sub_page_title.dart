import 'package:flutter/material.dart';

class SubPageTitle extends StatelessWidget{
  final String title;

  SubPageTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.normal,
                color: Color(0xFF50AFC0)),
            textAlign: TextAlign.left,
          ),
        )
    );
  }
}
