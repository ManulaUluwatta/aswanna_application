import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.text2,
    this.image,
  }) : super(key: key);
  final String? text, text2, image;

  @override
  Widget build(BuildContext context) {
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
                image!,
                // width: 300.0,
                // height: 300.0,
              ),
            )),
        SizedBox(height: 30.0),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Text(
              text!,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
          width: double.infinity,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              text2!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white
              ),
              // textAlign: TextAlign.justify,
              ),
          ),
          width: double.infinity,
        ),

        
      ],
      
    );
    
    
  }
  
}
