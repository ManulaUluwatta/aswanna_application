import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Complete Profile",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(60),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Complete your details",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
