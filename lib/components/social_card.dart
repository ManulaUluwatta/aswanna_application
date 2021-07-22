import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_cofig.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String icon;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        height: getProportionateScreenHeight(80),
        width: getProportionateScreenWidth(80),
        decoration:
            BoxDecoration(color: Color(0xFFEEEEEE), shape: BoxShape.circle),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
