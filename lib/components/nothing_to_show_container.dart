import 'package:aswanna_application/constrants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_cofig.dart';

class NothingToShowContainer extends StatelessWidget {
  const NothingToShowContainer(
      {Key key,
      this.iconPath,
      this.primaryMessage = "Nothing to Show",
      this.secondaryMessage})
      : super(key: key);

  final String iconPath;
  final String primaryMessage;
  final String secondaryMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.75,
      height: SizeConfig.screenHeight * 0.2,
      child: Column(
        children: [
          SvgPicture.asset(
            iconPath,
            color: cTextColor,
            width: getProportionateScreenWidth(75),
          ),
          SizedBox(height: 16),
          Text(
            "$primaryMessage",
            style: TextStyle(
              color: cTextColor,
              fontSize: 15,
            ),
          ),
          Text(
            "$secondaryMessage",
            style: TextStyle(
              color: cTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
