
import 'package:flutter/material.dart';

import 'components/body.dart';

class FogotPasswodScreen extends StatelessWidget {
  const FogotPasswodScreen({ Key key }) : super(key: key);
  static String routeName = "/forgot_password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Body(),
    );
  }
}