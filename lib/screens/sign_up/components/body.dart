import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';

import 'sign_up_form.dart';
import '../../../components/social_card.dart';


class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              Text(
                "Register Account",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(60),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Complete your details or continue \nwith social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: SizeConfig.screenHeight * 0.06,
                ),
              SignUpForm(),
              SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
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
                Text(
                  "By continuing your confirm that you agree \nwhith our Term and Condition",
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

