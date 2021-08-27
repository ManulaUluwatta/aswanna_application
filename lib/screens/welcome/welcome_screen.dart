import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/screens/sign_in/sign_in_screen.dart';
import 'package:aswanna_application/screens/splash/splash_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../size_cofig.dart';

class WelcomeScreen extends StatefulWidget {
  static String routeName = "/welcomeScreen";
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Future.delayed(const Duration(seconds: 3), () {
      if (auth.currentUser == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
            (route) => false);
      }
      if (auth.currentUser != null && AuthService().currentUserVerified) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      }

      if (auth.currentUser != null && !AuthService().currentUserVerified) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false);
      }
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor:Color(0xFF09af00),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF61d800),
                Color(0xFF41c300),
                Color(0xFF09af00),
                Color(0xFF008b00),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  Text(
                //   "Welcome To",
                //   style: TextStyle(
                //     fontSize: getProportionateScreenWidth(45),
                //     fontWeight: FontWeight.w500,
                //     color: Colors.white,
                //   ),
                // ),
                Image(
                  image: AssetImage("assets/images/as.png"),
                  width: getProportionateScreenWidth(500),
                  height: getProportionateScreenHeight(200)
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                // ),
                // Text(
                //   "Welcome!",
                //   style: TextStyle(
                //     fontSize: getProportionateScreenWidth(30),
                //     fontWeight: FontWeight.w500,
                //     color: Colors.white,
                //   ),
                // ),
                // SizedBox(
                //   height: SizeConfig.screenHeight * 0.02,
                // ),
                // Center(
                //   child: Center(
                //     child: CircularProgressIndicator(
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
