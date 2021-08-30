import 'package:flutter/material.dart';

import '../../../size_cofig.dart';
import 'edit_profile_form.dart';

class Body extends StatelessWidget {
  const Body({Key key,}) : super(key: key);

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
              SizedBox(height: SizeConfig.screenHeight * 0.02,),
              Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(60),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04,),
              EditProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
