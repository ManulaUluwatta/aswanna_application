import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.text2,
    this.image,
  }) : super(key: key);
  final String text, text2, image;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: <Widget>[
        // Text(
        //   "ASWANNA",
        //   style: TextStyle(
        //     fontSize: getProportionateScreenWidth(80),
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        Container(
          width: getProportionateScreenWidth(500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Image(
              image: AssetImage("assets/images/as.png"),
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenHeight(100),
            ),
          ),
        ),

        // Spacer(
        //   flex: 2,
        // ),
        Container(
            width: getProportionateScreenWidth(450),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                width: getProportionateScreenWidth(220),
                height: getProportionateScreenHeight(220),
              ),
            )),
        SizedBox(height: SizeConfig.screenWidth * 0.05),
        Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(50),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: <Shadow>[
                 Shadow(
                    offset: Offset(5.0, 4.0),
                    blurRadius: 8.0,
                    color: Color(0xFF008b00)
                  ),
                ],
              ),
            ),
          ),
          width: double.infinity,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              text2,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(35),
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
              // textAlign: TextAlign.justify,
            ),
          ),
          width: double.infinity,
        ),
      ],
    );
  }
}
