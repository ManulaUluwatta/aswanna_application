import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(30),
        vertical: getProportionateScreenWidth(20),
        ),
      width: double.infinity,
      //height: 90,
      decoration: BoxDecoration(
        color: Color(0xFF09af00),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text.rich(
         TextSpan(text:"seasonal Offer\n",
         style: TextStyle(
           color: Colors.white,
           fontSize: 16
           ),
         children: [
           TextSpan(
             text: "25% discount on Credit cards",
             style: TextStyle(fontSize: 25,
             fontWeight: FontWeight.bold,
             ),
           ),
         ],
         ),
      ),
    );
  }
}
