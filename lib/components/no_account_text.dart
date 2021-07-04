
import 'package:aswanna_application/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../size_cofig.dart';
import '../screens/sign_up/sign_up_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account ?",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(35),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            " Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(35),
                fontWeight: FontWeight.w500,
                color: Color(0xFF09af00)),
          ),
        ),
      ],
    );
  }
}
