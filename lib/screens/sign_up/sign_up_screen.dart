import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/signUpScreen";
  const SignUpScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sing Up",
        ),
      ),
      body: Body(),
    );
  }
}