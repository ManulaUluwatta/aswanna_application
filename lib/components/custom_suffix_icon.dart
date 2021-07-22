import 'package:flutter/material.dart';

import '../size_cofig.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key key,
    this.icons,
  }) : super(key: key);
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(30.0),
        getProportionateScreenWidth(30.0),
        getProportionateScreenWidth(30.0),
      ),
      child: Icon(
        icons,
        color: Color(0xFF09af00),
        size: getProportionateScreenWidth(50.0),
      ),
    );
  }
}