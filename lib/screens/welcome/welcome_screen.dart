import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/screens/sign_in/sign_in_screen.dart';
import 'package:aswanna_application/screens/splash/splash_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../size_cofig.dart';

class WelcomeScreen extends StatefulWidget {
  static String routeName = "/welcomeScreen";
  const WelcomeScreen({Key? key}) : super(key: key);

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
      if (auth.currentUser !=null && AuthService().currentUserVerified){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      }
      
      if (auth.currentUser !=null && !AuthService().currentUserVerified){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false);
      }
    });
    return Scaffold(
    
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Center(
              child: CircularProgressIndicator(),

            
          )),
          SizedBox(height: SizeConfig.screenHeight!* 0.02,),
          Text(
            "Welcome!",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: Color(0xFF008b00),
            ),
          )
        ],
      ),
    );
  }
}
