import 'package:aswanna_application/screens/sign_in/components/sign_form.dart';
import 'package:flutter/material.dart';

import '../../../size_cofig.dart';
import '../../../components/social_card.dart';
import '../../../components/no_account_text.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(30.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                Text(
                  "Welocome",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(60),
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Sign in with your email and password \nor continue with google",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                SignForm(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
