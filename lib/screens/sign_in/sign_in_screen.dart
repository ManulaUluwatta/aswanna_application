
import 'package:flutter/material.dart';

import '../../size_cofig.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  const SignInScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In'
          ),
      ),
      body: Body(),
    );
  }
}