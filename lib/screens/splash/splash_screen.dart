import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static int currentPageSplash = 0;

  updateCurrentPage(int i) {
    currentPageSplash = i;
    build(context);
  }

  // state, updateCurrentPage

  @override
  Widget build(BuildContext context) {
    
    print('Test$currentPageSplash');
    // Body body = Body();
    // updateCurrentPage(currentPageSplash);
    SizeConfig().init(context);

    if (currentPageSplash == 2) {
      return Scaffold(
        backgroundColor: Color(0xFF41c300),
        body: Body(currentPageSplash, updateCurrentPage),
        // bottomSheet: currentPageSplash == 2
        //     ? Container(
        //         height: 80.0,
        //         color: Colors.white,
        //       )
        //     : Text("data"),
      );
    } else {
      return Scaffold(
          backgroundColor: Color(0xFF41c300),
          body: Body(currentPageSplash, updateCurrentPage));
    }
  }
}


