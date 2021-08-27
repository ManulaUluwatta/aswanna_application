import 'package:flutter/material.dart';

import '../../../constrants.dart';

class RequestSectionTitle extends StatelessWidget {
  const RequestSectionTitle({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);
  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
            color: cTextColor, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
      ),
    );
  }
}