import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Body body = Body();
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFF41c300),
      body: Body(),
      // bottomSheet: body.getSheet(),
    );
  }
}
